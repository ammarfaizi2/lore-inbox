Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318337AbSG3Qi7>; Tue, 30 Jul 2002 12:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318345AbSG3Qi6>; Tue, 30 Jul 2002 12:38:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25684 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318337AbSG3Qix>; Tue, 30 Jul 2002 12:38:53 -0400
Date: Tue, 30 Jul 2002 18:43:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020730164320.GH1181@dualathlon.random>
References: <20020730054111.GA1159@dualathlon.random> <20020730091140.A6726@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730091140.A6726@infradead.org>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 09:11:40AM +0100, Christoph Hellwig wrote:
> On Tue, Jul 30, 2002 at 07:41:11AM +0200, Andrea Arcangeli wrote:
> > I find the dynamic syscall approch in some vendor kernel out there
> > that implements a /proc/libredhat unacceptable since it's not forward
> > compatible with 2.5:
> 
> What is /proc/libredhat supposed to be?  It hasn't ever been part of the
> AIO patches.

you should read the code then (from the latest aio-20020619.diff).

diff -urN v2.4.19-pre5/Makefile linux.diff/Makefile
--- v2.4.19-pre5/Makefile	Wed Apr  3 21:04:25 2002
+++ linux.diff/Makefile	Fri Apr 19 20:57:16 2002
@@ -226,7 +226,7 @@
 	drivers/sound/pndsperm.c \
 	drivers/sound/pndspini.c \
 	drivers/atm/fore200e_*_fw.c drivers/atm/.fore200e_*.fw \
-	.version .config* config.in config.old \
+	.uniquebytes .version .config* config.in config.old \
 	scripts/tkparse scripts/kconfig.tk scripts/kconfig.tmp \
 	scripts/lxdialog/*.o scripts/lxdialog/lxdialog \
 	.menuconfig.log \
@@ -268,6 +268,7 @@
 		--end-group \
 		-o vmlinux
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw]
\)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
+	@$(MAKE) -C ulib

 symlinks:
 	rm -f include/asm
@@ -296,7 +297,7 @@

 linuxsubdirs: $(patsubst %, _dir_%, $(SUBDIRS))

-$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/version.h
include/config/MARKER
+$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/compile.h
include/config/MARKER
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" -C $(patsubst
_dir_%, %, $@)

 $(TOPDIR)/include/linux/version.h: include/linux/version.h
@@ -322,6 +323,11 @@
 	   echo \#define LINUX_COMPILE_DOMAIN ; \
 	 fi >> .ver
 	@echo \#define LINUX_COMPILER \"`$(CC) $(CFLAGS) -v 2>&1 | tail
-1`\" >> .ver
+	@rm -f .uniquebytes
+	@dd if=/dev/urandom of=.uniquebytes bs=1 count=16
+	@echo -n \#"define LINUX_UNIQUE_BYTES " >>.ver
+	@hexdump -v -e '1/1 "0x%02x, "' .uniquebytes | sed -e 's/,
$$//g' >>.ver
+	@echo "" >>.ver
 	@mv -f .ver $@

 include/linux/version.h: ./Makefile
@@@ -404,6 +410,8 @@
 .PHONY: $(patsubst %, _modinst_%, $(SUBDIRS))
 $(patsubst %, _modinst_%, $(SUBDIRS)) :
 	$(MAKE) -C $(patsubst _modinst_%, %, $@) modules_install
+	mkdir -p  $(INSTALL_MOD_PATH)/lib/kernel/$(KERNELRELEASE)/
+	install -m 755 ulib/libredhat-kernel.so.1.0.1 $(INSTALL_MOD_PATH)/lib/kernel/$(KERNELRELEASE)/

 # modules disabled....

diff -urN v2.4.19-pre5/ulib/Makefile linux.diff/ulib/Makefile
--- v2.4.19-pre5/ulib/Makefile	Wed Dec 31 19:00:00 1969
+++ linux.diff/ulib/Makefile	Fri Apr 19 20:58:01 2002
@@ -0,0 +1,50 @@
+#  Makefile - libredhat-kernel.so build code.
+#
+#    Copyright 2002 Red Hat, Inc.  All Rights Reserved.
+#
+#    This library is free software; you can redistribute it and/or
+#    modify it under the terms of the GNU Lesser General Public
+#    License as published by the Free Software Foundation; either
+#    version 2 of the License, or (at your option) any later version.
+#
+#    This library is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#    Lesser General Public License for more details.
+#
+#    You should have received a copy of the GNU Lesser General Public
+#    License along with this library; if not, write to the Free
Software
+#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307  USA
+#
+#
+all: libredhat-kernel.so
+
+ASFLAGS=-D__KERNEL__ -D__ASSEMBLY__ -I../include -nostdlib -nostartfiles
+CFLAGS=-D__KERNEL__ -I../include -nostdlib -nostartfiles
+
+so_objs=vsysaddr.o kso_init.o
+
+vsysaddr.S: ../System.map stub.S Makefile
+	rm -f vsysaddr.S
+	echo '#include "stub.S"' >vsysaddr.S
+	awk -- "/^00000000bfff.* vsys_/ { print \"dynamic_syscall(\"\$$3 \",0x\" \$$1 \")\"; }" <../System.map >>vsysaddr.S
+	awk -- "/^bfff.* vsys_/ { print \"dynamic_syscall(\"\$$3 \",0x\" \$$1 \")\"; }" <../System.map >>vsysaddr.S
+
+vsysaddr.o: vsysaddr.S
+
+kso_init.o: ../include/linux/compile.h
+
+libredhat-kernel.so.1.0.1: $(so_objs) libredhat-kernel.map
+	gcc -nostdlib -nostartfiles -shared
-Wl,--version-script=libredhat-kernel.map
-Wl,-soname=libredhat-kernel.so.1 -o $@  $(so_objs)
+	cp $@ $@.save
+	strip $@
+
+libredhat-kernel.so: libredhat-kernel.so.1.0.1
+	ln -sf $< $@
+
+clean:
+	rm -f *.o libredhat-kernel.so myln libredhat-kernel.so.1*
vsysaddr.S
+
+# test app
+myln: myln.c libredhat-kernel.so Makefile
+	cc -g -o myln myln.c -L. -lredhat-kernel
diff -urN v2.4.19-pre5/ulib/README linux.diff/ulib/README
--- v2.4.19-pre5/ulib/README	Wed Dec 31 19:00:00 1969
+++ linux.diff/ulib/README	Fri Apr 19 20:54:05 2002
@@ -0,0 +1,2 @@
+The libredhat-kernel code is provided under the terms of the LGPL.
+See the file COPYING for details.
diff -urN v2.4.19-pre5/ulib/kso_init.c linux.diff/ulib/kso_init.c
--- v2.4.19-pre5/ulib/kso_init.c	Wed Dec 31 19:00:00 1969
+++ linux.diff/ulib/kso_init.c	Fri Apr 19 20:54:05 2002
@@ -0,0 +1,67 @@
+/* kso_init.c - libredhat-kernel.so startup code.
+
+    Copyright 2002 Red Hat, Inc.  All Rights Reserved.
+
+    This library is free software; you can redistribute it and/or
+    modify it under the terms of the GNU Lesser General Public
+    License as published by the Free Software Foundation; either
+    version 2 of the License, or (at your option) any later version.
+
+    This library is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+    Lesser General Public License for more details.
+
+    You should have received a copy of the GNU Lesser General Public
+    License along with this library; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
USA
+
+ */
+#include <linux/compile.h>
+#include <linux/types.h>
+#include <asm/unistd.h>
+#include <asm/fcntl.h>
+#include <asm/mman.h>
+#include <asm/a.out.h>
+
+char libredhat_kernel_enosys = 1;	/* the asm in stub.S depends on
this */
+
+long _init(void)
+{
+	static char unique[] = { LINUX_UNIQUE_BYTES };
+	int errno;
+	long addr;
+	int fd;
+	int i;
+
+	_syscall6(int, mmap2, unsigned long, addr, unsigned long, len,
+        	  unsigned long, prot, unsigned long, flags,
+        	  unsigned long, fd, unsigned long, pgoff)
+	_syscall2(long, munmap, unsigned long, addr, size_t, len)
+	_syscall2(int, open, const char *, name, int, flags)
+	_syscall1(int, close, int, fd)
+
+	if (sizeof(unique) != 16)
+		return -1;
+
+	fd = open("/dev/vsys", O_RDONLY);
+	if (-1 == fd)
+		return -1;
+
+	addr = mmap2(0, VSYSCALL_SIZE, PROT_READ | PROT_EXEC,
MAP_SHARED, fd, 0);
+	if (-1 == addr)
+		return -1;
+
+	close(fd);
+
+	for (i=0; i<sizeof(unique); i++)
+		if (unique[i] != ((char *)addr)[i]) {
+			munmap(addr, VSYSCALL_SIZE);
+			return -1;
+		}
+
+	/* okay, all the syscalls we provide are now good */
+	libredhat_kernel_enosys = 0;
+	return 0;
+}
+
diff -urN v2.4.19-pre5/ulib/libredhat-kernel.map
linux.diff/ulib/libredhat-kernel.map
--- v2.4.19-pre5/ulib/libredhat-kernel.map	Wed Dec 31 19:00:00 1969
+++ linux.diff/ulib/libredhat-kernel.map	Tue Apr  2 18:56:58 2002
@@ -0,0 +1,11 @@
+REDHAT_0.90 {
+	global:
+		vsys_io_setup;
+		vsys_io_destroy;
+		vsys_io_submit;
+		vsys_io_cancel;
+		vsys_io_wait;
+		vsys_io_getevents;
+	local:
+		*;
+};
diff -urN v2.4.19-pre5/ulib/myln.c linux.diff/ulib/myln.c
--- v2.4.19-pre5/ulib/myln.c	Wed Dec 31 19:00:00 1969
+++ linux.diff/ulib/myln.c	Tue Apr  2 18:56:58 2002
@@ -0,0 +1,25 @@
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+int main ()
+{
+	long ctx = 0;
+	extern long vsys_io_setup(long, long *);
+	unsigned char *bob = (void*)&vsys_io_setup;
+	long ret;
+	int i;
+	printf("%p\n", bob);
+	//printf("%p\n", mmap(0, 65536, PROT_READ | PROT_EXEC,
MAP_SHARED,
+	//	open("/dev/vsys", O_RDONLY), 0));
+	//for (i=0; i<16; i++)
+	//	printf(" %02x\n", bob[i]);
+	//printf("\n");
+
+	ret = vsys_io_setup(100, &ctx);
+
+	printf("ret=%ld, ctx=0x%lx\n", ret, ctx);
+	return 0;
+}
diff -urN v2.4.19-pre5/ulib/stub.S linux.diff/ulib/stub.S
--- v2.4.19-pre5/ulib/stub.S	Wed Dec 31 19:00:00 1969
+++ linux.diff/ulib/stub.S	Fri Apr 19 20:54:05 2002
@@ -0,0 +1,38 @@
+/* stub.S - libredhat-kernel.so jump code.
+
+    Copyright 2002 Red Hat, Inc.  All Rights Reserved.
+
+    This library is free software; you can redistribute it and/or
+    modify it under the terms of the GNU Lesser General Public
+    License as published by the Free Software Foundation; either
+    version 2 of the License, or (at your option) any later version.
+
+    This library is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+    Lesser General Public License for more details.
+
+    You should have received a copy of the GNU Lesser General Public
+    License along with this library; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
USA
+
+ */
+/* stub.S */
+#include <asm/segment.h>
+#include <asm/errno.h>
+
+	.text
+
+#define dynamic_syscall(x,a) \
+	.globl	x				;\
+	.type	x, @function			;\
+	.align 16				;\
+	x:					;\
+		cmpb $0,libredhat_kernel_enosys	;\
+		jne 1f				;\
+		ljmp $__USER_CS, $a		;\
+	1:					;\
+		movl	$-ENOSYS,%eax		;\
+		ret				;\
+	.size	 x,.-x
+


and the other funny parts:

+long sys_dynamic_syscall(struct pt_regs regs)
+{
+	struct dummy_args dummy_args;
+	struct vsyscall_entry *ent = (void *)regs.edx;
+	void *args = (void *)regs.ecx;
+	long ret;
+
+	pr_debug("ent = %p  args = %p\n", ent, args);
+	pr_debug("eip = 0x%08lx\n", regs.eip);
+
+	if (unlikely(!current->mm->vsys_mapped))
+		goto err;
@ -231,6 +232,10 @@

 	/* Architecture-specific MM context */
 	mm_context_t context;
+
+	struct kioctx	*ioctx_list;
+	unsigned long	new_ioctx_id;
+	int		vsys_mapped;
 };
 @ -243,6 +248,7 @@
 	mm_count:	ATOMIC_INIT(1), 		\
 	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
 	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
+    	vsys_mapped:	0,				\
 	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
 }


etc... (oh yeah, it may not be in /proc but the location of this
bytecode doesn't change what it does)

> > ). So I would ask if you could merge the below interface into 2.5 so we can
> > ship a real async-io with real syscalls in 2.4, there's not much time to
> > change it given this is just used in production userspace today. I
> > prepared a patch against 2.5.29. Ben, I would appreciate if you could
> > review and confirm you're fine with it too.
> 
> Please don't.  First Ben has indicated on kernel summit that the abi might
> change and I think it's a bad idea to lock him into the old ABI just because

What I heard and that I remeber crystal clear is that Ben indicated that
the API isn't changing for a long time, and that's been stable so far,
I could imagine why.

> suse doesn't want to have something called libredhat.so* in /lib.

I don't mind about the libredhatname it's the above nosense overhead
code that isn't going to be included into my tree. It's just pure
overhead and complication that will only make it worse.

> Alternate suggestion: rename it to libunited.so.

That's not the problem sorry.

> And even if there is a syscall reservation the way to do it is not to add
> the real syscall names to entry.S and implement stubs but to use
> sys_ni_syscall.

If there is a sysacll reservation the way to do it is the way I did as
far I can tell, I don't see what you mean with using sys_ni_syscall or
whatever. Of course right now we miss the syscall reservation and that's
why I'm trying to register the API.

> 
> > BTW, I'm not the author of the API, and personally I dislike the
> > sys_io_sumbit approch, the worst part is the multiplexing of course:
> 
> Okay.  So you think the API is stupid but want it to get in without
> discussion??

I didn't say it's stupid, you said it not me. I only said I would have
preferred it to be sys_aio_read sys_aio_write sys_aio_fsync etc...
rather than a sys_io_sumbit that takes read/write/fsync as parameter.
But I don't mind, it's a minor difference that's not going to hurt
performance too much, what I'm trying to do is to have an API registered
before one/two months, what kind of API is the last of my interests as
far as it's not stupid (and the current one isn't stupid unlike you
said), I can live with sys_io_sumbit or sys_aio_read/write/fsync, and
since everybody is using this current API at the moment I pushed for it
because I assume people is just used to it (userspace does), and because
it would been an additional crusade to try to also submit a different
API (as expected Ben is advocating for his API showing the good points
of it) and as said it's not too bad (and after all it's not us supposed
to deal with this API in the first place, we almost never use async-io
anyways and I don't see it changing tomorrow).

If it would been stupid I would had rewrote it like I did with part of
the internals that gave you root shell etc.., I'm not completely blind :).

> If you really want to ship the old-style AIO (of which I remember ben
> saying it it broken for everything post-2.4.9) please stick to the patch
> Ben has around, otherwise wait for the proper 2.5 solution.  I have my
> doubts that it is backportable, though.

I'm trying to do my best to avoid having to merge the code I quoted
above, that's disgusting and since the api isn't gonna change anwyays
like Ben said I'm trying to do the right thing to avoid clashes with
syscall 250 as well.

Hope this clears my point.

One more thing: I will be completely fine if my patch goes to /dev/null
because Ben wants to make some change or because he wants to submit it
with a full blown implementation too, or even better because we change
the API after a collective thought. I just wanted to raise the
discussion and to have people focused on the API. If it takes a few
weeks or one month to get an API registered that's of course fine. If
it takes more I'll be forced to merge the code I quoted above and as
said I'm trying to avoid it. As far as I'm concerned only the API
matters to me, because the 2.4 internals that I merged aren't going to
be the right thing to do long term anyways, as Ben pointed out this
async-io isn't even asynchronous in submit_bh, so you cannot even use it
to fill multiple request queues when dealing with multiple spindle,
maybe that's fixed in the 2.5 version, just grep for changes in
ll_rw_block if there's some change there's a chance that such issue is
addressed. Blocking in VM is perfectly fine, I don't think we shouldn't
change that, we have to as Linus said, what we shouldn't do is to block
in submit_bh because that prevents users to use async-io to fill
multiple queues.

Really last thing: one of the major reasons I don't like the above code
besides the overhead and complexity it introduces is that it doesn't
guarantee 100% that it will be forward compatible with 2.5 applications
(the syscall 250 looks not to check even for the payload, I guess they
changed it because it was too slow to be forward compatible in most
cases), the /dev/urandom payload may match the user arguments if you're
unlucky and since we can guarantee correct operations by doing a syscall
registration, I don't see why we should make it work by luck.

Andrea
