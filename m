Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSGDHGx>; Thu, 4 Jul 2002 03:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317348AbSGDHGw>; Thu, 4 Jul 2002 03:06:52 -0400
Received: from h-64-105-34-244.SNVACAID.covad.net ([64.105.34.244]:56706 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317347AbSGDHGv>; Thu, 4 Jul 2002 03:06:51 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 4 Jul 2002 00:09:17 -0700
Message-Id: <200207040709.AAA05891@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: __ex_table vs. init sections bug in most architectures
Cc: kaos@ocs.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	It looks like all architectures except {sparc,ppc}{,64} rely on
the __ex_table section already being sorted by the address of the
instruction that caused the memory access violation that is to be fixed
up.  However, __ex_table will not be constructed in sorted order if it
includes any references made from an __init or __exit routine, because
these routines are loaded into the kernel image after all of the other
routines, rather than being loaded in the order in which they appear in
each source file.

	This problem could cause the binary search of __ex_table in
search_one_table in arch/*/mm/extable.c to fail, even when search
for entries that are not in an __init or __exit routine.

	I wrote a small kernel module to test for this problem on
x86, and verified that it did not occur on the linux-2.5.24 kernel
that I tested, but that kernel was compiled only with romfs, ramfs
and binfmt_elf compiled in.  Everything else was a module, and modules
currently ignore __init and __exit, so will not manifest the problem.

	However, I was able to verify that putting a __copy_from_user in
an __init routine in file compiled into the core kernel did indeed
produce a misordered __ex_table.  In practice, __ex_table on x86
might not be used for anything that __init or __exit routines do, but
__ex_table seems to be used for a lot more on mips, s390 and x86-64.

	We probably should not rely on the compiler emitting
the subroutines and lines within subroutines in the order in
which they are written, as there are plenty of optimiation reasons
a compiler might have for reordering them.  So, I think that
a correct solution would be to sort the kernel's __ex_table at
boot time, as is one on ppc{,64}, and also at module load time,
which is not currently done by any architecture.  One refinement of this
approach would be have some bfd tool sort __ex_table in vmlinux
when the kernel is linked, and to do something similar for
modules, to keep the sort out of the kernel and save a few
microseconds of run time.

	sparc{,64} is immune to this problem only because it does
a linear search of each __ex_table rather than a binary search.

	I have attached my test module below, in caes anyone wants
to check their kerenls for this problem.  It should compile for
all architectuers other than alpha (replace start->insn with
start->addr for alpha).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

#include <linux/module.h>
#include <linux/init.h>
#include <linux/errno.h>
#include <asm/uaccess.h>
#include <asm/spinlock.h>


static void
check_one_table(const char *name,
		const struct exception_table_entry *start,
		const struct exception_table_entry *end) {
	printk ("AJR check_one_table(%s, %p, %p) called.\n", name, start, end);
	if (start == end)
		return;
	start++;
	while (start != end) {
		if ((start-1)->insn > start->insn) {
		  printk ("%s: 0x%x > 0x%x.\n", name,
			  (start-1)->insn, (start->insn));
		}
		start++;
	}
	
}


/* Copied from linux-2.5.24/arch/i386/mm/extable.c, which has no
   authorship or copyright statement on it. */
int check_tables(void)
{
	unsigned long flags;
	struct exception_table_entry *ent;
	struct module *mp;

	for (mp = THIS_MODULE; mp != NULL; mp = mp->next) {
		if (mp->ex_table_start == NULL || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
			continue;
		check_one_table(mp->name, mp->ex_table_start,mp->ex_table_end);
	}
	return -ENOMEM;
}

module_init(check_tables);
