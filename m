Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbSJ0Cmk>; Sat, 26 Oct 2002 22:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262248AbSJ0Cmj>; Sat, 26 Oct 2002 22:42:39 -0400
Received: from ppp-217-133-217-175.dialup.tiscali.it ([217.133.217.175]:2729
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262243AbSJ0CmH>; Sat, 26 Oct 2002 22:42:07 -0400
Subject: [PATCH][RFC] x86 multiple user-mode privilege rings
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-5CIh2s5zCzzNyZ4Fh2F+"
X-Mailer: Ximian Evolution 1.0.8 
Date: 27 Oct 2002 03:48:13 +0100
Message-Id: <1035686893.2272.20.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5CIh2s5zCzzNyZ4Fh2F+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Short explaination:=20
This patch implements a feature called "x86 multiring", which is a
shorthand for x86 multiple user-mode privilege rings support.=20
It allows user-mode programs to create DPL 1 and 2 segments and get a
modifiable per-process copy of IDT.=20

User Mode Linux can use these features to implement a syscall mechanism
identical to the one used by the kernel-mode kernel, and thus much
faster than the current one, with free memory protection and with zero
context switches.=20

Wine could also use it to achieve fast syscall-level emulation of
Windows NT (and, to a lesser extent, Windows 3.1 and 9x).=20

Obviously there is some risk of the patch creating security holes.=20


System calls:
All operations are performed using the new sys_multiring syscall. The
API is documented in include/asm-i386/multiring.h, that multiring
applications should include.=20


Supervisor problems:=20
The most serious issue caused by the use of ring 1 and 2 is that they
are intended for kernel code, which means that they count as supervisor
wherever a "user/supervisor" bit is present.=20

This results in:=20
- Unavailaibility of multiring on 386 processors since they don't
support supervisor WP.=20

- Page protection no longer working=20
While this may seem catastrophic, it isn't because segment-level
protection can be used instead.=20
To enforce it, the patch modifies the GDT so that the default CS and DS
have a limit at __PAGE_OFFSET - 1.=20
LDT and TLS interfaces are also changed to alter segment limits to avoid
overlap with the kernel area. If this is impossible, multiring mode is
inhibited using bad_segments mm_context_t field; if the process is
already in multiring mode the operation fails.
vsyscalls will need to be put before the rest of the kernel with this
scheme.

- Supervisor bit in error code in page faults not reliable (regs->xcs is
used instead, with the only problem of not being able to tell f00f
invalid opcodes from page faults)=20

- Potential minor problems for profilers since to get DPL 1/2 events,
DPL 0 events also have to be enabled.=20

Based on my reading of Intel manuals, there should not be any other
problem, but I might have missed something.


IDT functionality:=20
When multiring mode is entered, the default IDT is copied to a new
allocated page and a pointer to the new one is stored in mm_context_t.=20
The initial multiring IDT is identical to the default one, with the
exception of the SYSCALL_VECTOR DPL which is set to 1.=20
The code includes a config option to put IDTs in high memory, that is
however untested and not very useful anyway.=20

IDTs are loaded in two different ways: if CONFIG_X86_HIGHIDT is set or
the processor is f00f-buggy, each CPU gets a fixmap entry that is
remapped to load another IDT; otherwise, a simple lidt instruction is
used.=20

sys_multiring allows to read, copy and set gates in the IDT.=20
The vectors that are settable are currently 0x20-0x2f (because DOS and
Windows are here), 0x80 and 0xf1-0xfa.=20
Set operations will fail if the user tries to set a gate to a kernel
mode address which isn't the syscall one or a task or interrupt gate.=20
The i8259 is remapped to 0x30-0x3f to accomodate this.=20

The multiring_mode filed is added to the thread structure, and is 1 if
the thread has entered multiring mode (i.e. selectors are RPL 1-ed).


GDT functionality:=20
When switching to a multiring mm, the DPL in the default user CS and DS
is set to 1, to prevent ring 2 and 3 to load them and thus bypass any
security that the DPL 1 code might be enforcing.=20


LDT/TLS functionality:=20
When in multiring mode, LDT/TLS functions honor the new dpl field in
struct user_desc that of course allows to set a custom dpl in the
descriptors.=20
They are also changed to support segment-level protection as outlined
above.=20


TSS functionality:=20
sys_multiring allows to modify the ring 1 and 2 TSS ESP and SS that are
loaded on inter-privilege call.=20
The values are kept in the thread structure and are loaded on task
switch.=20


clone functionality:=20
The CLONE_IDT flag is added, and does the obvious thing. Note that if
the task is not in multiring mode, it is silently ignored.=20
The CLONE_CLEAR_IDT flag is also added and also does the obvious thing
and takes precedence over CLONE_IDT.


Entering multiring mode:=20
Multiring mode can be entered using sys_multiring(MULTIRING_ELEVATE).=20
This will allocate a new IDT, fix the GDT and put RPL 1 selectors in
cs/ds/es/ss/fs/gs. Note that all other threads will also get RPL 1
selectors.
RPL 1 selectors are loaded only if the selector points to the default CS
or DS.


Limitations:=20
- Since there are only 4 privilege rings only up to 2 UMLs can be nested
- Doesn't work on 386=20


Potential improvements:=20
- Copy on write IDTs=20
- Reduction of IDT allocation size from 4 KB to 2 KB=20
- x86-64?=20


Diffstat:
 arch/i386/Config.help                |    7=20
 arch/i386/config.in                  |    1=20
 arch/i386/kernel/Makefile            |    2=20
 arch/i386/kernel/cpu/common.c        |    9=20
 arch/i386/kernel/cpu/intel.c         |    8=20
 arch/i386/kernel/entry.S             |    1=20
 arch/i386/kernel/i8259.c             |    6=20
 arch/i386/kernel/ldt.c               |   88 +++++++++
 arch/i386/kernel/multiring.c         |  316 ++++++++++++++++++++++++++++++=
+++++
 arch/i386/kernel/process.c           |   52 ++++-
 arch/i386/kernel/ptrace.c            |    8=20
 arch/i386/kernel/signal.c            |   24 +-
 arch/i386/kernel/traps.c             |   44 +++-
 arch/i386/mach-generic/irq_vectors.h |   24 +-
 arch/i386/mach-visws/irq_vectors.h   |   22 +-
 arch/i386/math-emu/fpu_entry.c       |    2=20
 arch/i386/mm/fault.c                 |    5=20
 fs/exec.c                            |    4=20
 include/asm-i386/desc.h              |   48 +++++
 include/asm-i386/fixmap.h            |   14 +
 include/asm-i386/idt.h               |  236 ++++++++++++++++++++++++++
 include/asm-i386/ldt.h               |    3=20
 include/asm-i386/mmu.h               |   10 +
 include/asm-i386/mmu_context.h       |    8=20
 include/asm-i386/multiring.h         |  194 +++++++++++++++++++++
 include/asm-i386/processor.h         |   26 +-
 include/asm-i386/segment.h           |   12 +
 include/asm-i386/system.h            |    6=20
 include/asm-i386/unistd.h            |    1=20
 include/linux/sched.h                |    8=20
 kernel/fork.c                        |    6=20
 31 files changed, 1103 insertions(+), 92 deletions(-)










Test program (apologies for the horrible coding style):

/*
  multiring-test.c: example program for Linux multiring support
 =20
  Copyright (C) 2002 Luca Barbieri <ldb@ldb.ods.org>

  This program is free software; you can redistribute it and/or modify it u=
nder
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2, or (at your option) any later
  version.

  This program is distributed in the hope that it will be useful, but WITHO=
UT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
  for more details.

  You should have received a copy of the GNU General Public License
  along with this program; see the file COPYING.  If not, write to the Free
  Software Foundation, 59 Temple Place - Suite 330, Boston, MA
  02111-1307, USA.
*/

#include <errno.h>
#include "/home/ldb/src/linux-2.5.44_multiring/include/asm-i386/unistd.h"
#include "/home/ldb/src/linux-2.5.44_multiring/include/asm-i386/multiring.h=
"
#include "/home/ldb/src/linux-2.5.44_multiring/include/asm-i386/ldt.h"
#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <sched.h>
#define CLONE_IDT	0x00800000

unsigned ring;
unsigned xcs;

typedef char intbuf_t[4];

intbuf_t test_entry_intbuf;
typedef int (*test_entry_int_t)(unsigned param) __attribute__((regparm(3)))=
;
#define test_entry_int ((test_entry_int_t)test_entry_intbuf)

intbuf_t kernel_syscall_intbuf;

char lower_ring_msg[] =3D "from lower ring! [should be XXXm...]\n";

void make_int(intbuf_t p, unsigned vec)
{
	p[0] =3D 0xcd;
	p[1] =3D vec;
	p[2] =3D 0xc3;
}

void test_entry();
void test_entry2();
void syscall_entry();

int kernel_syscall(unsigned num, unsigned arg1, unsigned arg2, unsigned arg=
3)
{
	unsigned ret;
	__asm__ __volatile__ (
	"pushl %%ebx\n\t"
	"movl %2, %%ebx\n\t"
	"call kernel_syscall_intbuf\n\t"
	"popl %%ebx" : "=3Da" (ret) : "0" (num), "r" (arg1), "c" (arg2), "d" (arg3=
));
	return ret;
}

int do_test_entry(unsigned param)
{
	printf("test_entry called with: %u\n", param);
	if(param =3D=3D 99)
	{
		unsigned vec;
		int ret;	=09
		int testvec;
		vec =3D multiring_copy_free(0x80);
		printf("copy_free(0x80) ret: %i errno: %i\n", vec, errno);

		printf("alloc_all ");
		for(;;)
		{
			ret =3D multiring_copy_free(0x80);
			if(ret >=3D 0)
				printf("%x ", testvec =3D ret);
			else
			{
				printf("\nret: %i errno: %i [should be -1/28]\n", ret, errno);
				break;
			}
		}
		ret =3D multiring_free(testvec);
		printf("free testvec: %i ret: %i errno: %i\n", testvec, ret, errno);
		ret =3D multiring_copy_free(0x80);
		printf("copy_free ret: %i errno: %i\n", ret, errno);
	=09
		printf("about to multiring_set %x %x\n", (xcs << 16) | ((unsigned long)te=
st_entry2 & 0xffff), ((unsigned long)test_entry2 & 0xffff0000) | 0x8f00 | (=
(ring + 1) << 13));
		multiring_set(0x80, (xcs << 16) | ((unsigned long)syscall_entry & 0xffff)=
, ((unsigned long)syscall_entry & 0xffff0000) | 0x8f00 | ((ring + 1) << 13)=
);
		make_int(kernel_syscall_intbuf, vec);	=09
	}
	return param * 2;
}

int do_syscall_entry(unsigned num, unsigned arg1, unsigned arg2, unsigned a=
rg3)
{
	if((num =3D=3D __NR_write) && (arg1 =3D=3D 1))
	{
		char* ptr =3D (char*)arg2;
		ptr[0] =3D 'X';
		ptr[1] =3D 'X';
		ptr[2] =3D 'X';
		return kernel_syscall(num, 1, arg2, arg3);
	}
	else if(num =3D=3D __NR_exit)
	{
		kernel_syscall(__NR_write, 1, (unsigned long)"quitting\n", strlen("quitti=
ng\n"));
		return kernel_syscall(__NR_exit, 0, 0, 0);
	}
	else
	{
		kernel_syscall(__NR_write, 1, (unsigned long)"syscall not allowed\n", str=
len("syscall not allowed\n"));
		return -ENOSYS;
	}
}

asm("
test_entry:
pushl %eax
call do_test_entry
addl $4, %esp
iret

test_entry2:
cld
pushl %es
pushl %ds
pushl %eax
movw %ss, %ax
movw %ax, %ds
movw %ax, %es
call do_test_entry
addl $4, %esp
popl %ds
popl %es
iret

syscall_entry:
cld
pushl %es
pushl %ds
pushl %ebp
pushl %edi
pushl %esi
pushl %edx
pushl %ecx
pushl %ebx
pushl %eax
movw %ss, %ax
movw %ax, %ds
movw %ax, %es

call do_syscall_entry

addl $4, %esp
popl %ebx
popl %ecx
popl %edx
popl %esi
popl %edi
popl %ebp
popl %ds
popl %es
iret

");

char* entry_stack;
char* lower_stack;
char* clone_stack;

#define ldt_sel(num, ring) (((num) << 3) | (1 << 2) | (ring))

static void interprivilege_jump(unsigned ss, unsigned esp, unsigned cs, uns=
igned eip) __attribute__((noreturn));

static void interprivilege_jump(unsigned ss, unsigned esp, unsigned cs, uns=
igned eip)
{
	__asm__ __volatile__(
	"movl %0, %%ds\n\t"
	"movl %0, %%es\n\t"=09
	"pushl %0\n\t"
	"pushl %1\n\t"
	"pushfl\n\t"
	"pushl %2\n\t"
	"pushl %3\n\t"
	"iret" : : "r" (ss), "r" (esp), "r" (cs), "r" (eip));
	abort();
}

void lower_ring_start()
{
	test_entry_int(10);
#ifdef CRASH_INT
	/* int 0x80 has DPL 1, so this should crash */
	write(1, lower_ring_msg, strlen(lower_ring_msg));
#endif
	test_entry_int(99);
	write(1, lower_ring_msg, strlen(lower_ring_msg));
#ifdef CRASH_SEGV
	*(unsigned long*)0 =3D 0;
#endif
	_exit(0);
}

/* this should reboot the processor if we have access to kernel mode memory=
 */
void triple_fault(void)
{
	struct
	{
		unsigned short a;
		struct
		{
			unsigned short lim;
			unsigned long addr;
		} m48;
	} desc;
	/* find the IDT address */
	__asm__ __volatile__("sidt %0" : "=3Dm" (desc.m48));

	/* clear the IDT (or crash, if the kernel works properly) */
	memset((void*)desc.m48.addr, 0, desc.m48.lim + 1);

	/* triple fault */
	*(unsigned long*)0 =3D 0;
}

#define idt_gate(sel, addr, ring) (((sel) << 16) | ((unsigned long)addr & 0=
xffff)), (((unsigned long)addr & 0xffff0000) | 0x8f00 | ((ring) << 13))
static inline pid_t syscall_clone(unsigned long flags)
{
	pid_t pid;
	asm volatile("pushl %%ebx\n\tmovl %1, %%ebx\n\tmovl %%esp, %%ecx\n\tint $0=
x80\n\tpopl %%ebx" : "=3Da" (pid) : "r" (flags | SIGCHLD), "0" (__NR_clone)=
 : "edx", "memory");
	return pid;
}

unsigned test_vec;

void clone_vm_child(void)
{
	int ret;
	unsigned ccs;
	unsigned css;
	unsigned cring;
	struct multiring_gate gate;=09
	ret =3D multiring_check();
	printf("vm check ret: %i errno: %i\n", ret, errno);
=09
	__asm__ __volatile__("movl %%cs, %0" : "=3Dr" (ccs));
	__asm__ __volatile__("movl %%ss, %0" : "=3Dr" (css));
	printf("vm cs: %x ss: %x\n", ccs, css);
	cring =3D xcs & 3;

	ret =3D multiring_set(test_vec, idt_gate(ccs, 0x33333333, cring));
	printf("vm set 33333333 ret: %i errno: %i\n", ret, errno);
	ret =3D multiring_get(test_vec, &gate);
	printf("vm get ret: %i errno: %i a: %x b: %x\n", ret, errno, gate.a, gate.=
b);
	=09
	_exit(0);
}

int main(int argc, char** argv)
{
	int ret;
	unsigned xss;
	unsigned test_entry_vec;
	struct multiring_gate gate;
	pid_t pid;
	struct user_desc ldt;
	ret =3D multiring_elevate();
	printf("elevate ret: %i errno: %i\n", ret, errno);
#ifdef ELEVATE
	return 0;
#endif
	__asm__ __volatile__("movl %%cs, %0" : "=3Dr" (xcs));

	ret =3D multiring_check();
	printf("check ret: %i errno: %i\n", ret, errno);
=09
	printf("cs: %x\n", xcs);
	__asm__ __volatile__("movl %%ss, %0" : "=3Dr" (xss));
	printf("ss: %x\n", xss);
	ring =3D xcs & 3;
	if(ring =3D=3D 3)
	{
		printf("we are still at ring 3 :( - exiting\n");
		return 0;
	}

	test_vec =3D multiring_set_free(idt_gate(xcs, 0x11111111, ring));
	printf("set_free 11111111 ret: %i errno: %i\n", test_vec, errno);
	ret =3D multiring_get(test_vec, &gate);
	printf("get ret: %i errno: %i a: %x b: %x\n", ret, errno, gate.a, gate.b);
	pid =3D fork();
	printf("fork pid: %i errno: %i\n", pid, errno);
	if(!pid)
	{
		//for(;;) {}
		ret =3D multiring_check();
		printf("fork check ret: %i errno: %i\n", ret, errno);

		__asm__ __volatile__("movl %%cs, %0" : "=3Dr" (xcs));
		__asm__ __volatile__("movl %%ss, %0" : "=3Dr" (xss));
		printf("fork cs: %x ss: %x\n", xcs, xss);
		ring =3D xcs & 3;

		ret =3D multiring_set(test_vec, idt_gate(xcs, 0x22222222, ring));
		printf("fork set 22222222 ret: %i errno: %i\n", ret, errno);
		ret =3D multiring_get(test_vec, &gate);
		printf("fork get ret: %i errno: %i a: %x b: %x\n", ret, errno, gate.a, ga=
te.b);
	=09
		_exit(0);
	}
	else
	{
		int status;
		waitpid(pid, &status, 0);
		printf("status: %x\n", status);
	}
=09
	ret =3D multiring_get(test_vec, &gate);
	printf("get ret: %i errno: %i a: %x b: %x [should be desc for 11111111]\n"=
, ret, errno, gate.a, gate.b);

	pid =3D clone(clone_vm_child, (char*)malloc(65536) + 65536, CLONE_VM|SIGCH=
LD, 0);
	printf("CLONE_VM pid: %i errno: %i\n", pid, errno);
	{
		int status;
		waitpid(pid, &status, 0);
		printf("status: %x\n", status);
	}
=09
	ret =3D multiring_get(test_vec, &gate);
	printf("get ret: %i errno: %i a: %x b: %x [should be desc for 33333333]\n"=
, ret, errno, gate.a, gate.b);

	pid =3D syscall_clone(CLONE_IDT);
	printf("CLONE_IDT pid: %i errno: %i\n", pid, errno);
	if(!pid)
	{
		//for(;;) {}
		ret =3D multiring_check();
		printf("idt check ret: %i errno: %i\n", ret, errno);
=09
		__asm__ __volatile__("movl %%cs, %0" : "=3Dr" (xcs));
		__asm__ __volatile__("movl %%ss, %0" : "=3Dr" (xss));
		printf("idt cs: %x ss: %x\n", xcs, xss);
		ring =3D xcs & 3;

		ret =3D multiring_set(test_vec, idt_gate(xcs, 0x44444444, ring));
		printf("idt set 44444444 ret: %i errno: %i\n", ret, errno);
		ret =3D multiring_get(test_vec, &gate);
		printf("idt get ret: %i errno: %i a: %x b: %x\n", ret, errno, gate.a, gat=
e.b);
	=09
		_exit(0);
	}
	else
	{
		int status;
		waitpid(pid, &status, 0);
		printf("status: %x\n", status);
	}

	ret =3D multiring_get(test_vec, &gate);
	printf("get ret: %i errno: %i a: %x b: %x [should be desc for 44444444]\n"=
, ret, errno, gate.a, gate.b);

#ifdef DO_EXEC
	execlp("ls", "ls", 0);
#endif
=09
#ifdef EXPLOIT_GDT
	printf("about to exploit with sel =3D %x\n", xss);
	triple_fault();
#endif

	multiring_set_free(idt_gate(xcs, 0xeeeeeeee, 0));
	printf("multiring_set(gate_to_kernel) ret: %i errno: %i\n", ret, errno);

#ifdef EXPLOIT_IDT
	test_entry_vec =3D multiring_set_free(idt_gate(xcs, 0xeeeeeeee, 1));
	printf("set_free(to_karea) ret: %i errno: %i\n", test_entry_vec, errno);
#else
	test_entry_vec =3D multiring_set_free(idt_gate(xcs, test_entry, ring));
	printf("set_free ret: %i errno: %i\n", test_entry_vec, errno);
#endif=09

	make_int(test_entry_intbuf, test_entry_vec);
	ret =3D test_entry_int(42);
	printf("test_entry_int: %u\n", ret);

	/* we could use the initial stack, but it's more difficult */
	entry_stack =3D malloc(65536);

	ret =3D multiring_set_espss(ring, (unsigned long)(entry_stack + 65536), xs=
s);
	printf("set_espss ret: %i errno %i esp: %x ss: %x\n", ret, errno, (unsigne=
d long)(entry_stack + 65536), xss);
	{
		unsigned tesp, tss;
		ret =3D multiring_get_espss(ring, &tesp, &tss);
		printf("get_espss ret: %i errno %i esp: %x ss: %x\n", ret, errno, tesp, t=
ss);
	}
	ret =3D multiring_set(test_entry_vec, idt_gate(xcs, test_entry2, ring + 1)=
);
	printf("multiring_set(test_entry_vec) ret: %i errno: %i\n", ret, errno);

	/* addresses should not be hardcoded in real programs */
=09
	ldt.entry_number =3D 1;
	ldt.base_addr =3D 0;
	ldt.limit =3D 0xaffff;
	ldt.seg_32bit =3D 1;
	ldt.contents =3D MODIFY_LDT_CONTENTS_DATA;
	ldt.read_exec_only =3D 0;
	ldt.limit_in_pages =3D 1;
	ldt.seg_not_present =3D 0;
	ldt.useable =3D 0;
#ifdef EXPLOIT_LDT
	ldt.dpl =3D ring;
	ldt.limit =3D 0xfffff;
	ret =3D modify_ldt(0x11, &ldt, sizeof(struct user_desc));
	printf("modify_ldt(exploit) ret: %i errno: %i\n", test_entry_vec, errno);

	__asm__ __volatile__("movl %0, %%ds\n\tmovl %0, %%es" : : "r" (ldt_sel(1, =
ring)));
	printf("about to exploit with sel =3D %x\n", ldt_sel(1, ring));

	triple_fault();
#endif
	ldt.dpl =3D ring + 1;
	ret =3D modify_ldt(0x11, &ldt, sizeof(struct user_desc));
	printf("modify_ldt(data) ret: %i errno: %i\n", test_entry_vec, errno);=09

	ldt.entry_number =3D 2;
	ldt.contents =3D MODIFY_LDT_CONTENTS_CODE;
	modify_ldt(0x11, &ldt, sizeof(struct user_desc));
	printf("modify_ldt(code) ret: %i errno: %i\n", test_entry_vec, errno);	=09

	lower_stack =3D malloc(65536);

	interprivilege_jump(ldt_sel(1, ring + 1), (unsigned long)(lower_stack + 65=
536), ldt_sel(2, ring + 1), (unsigned long)lower_ring_start);
	return 0;
}










Patch:

diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/Config.help linux-2.5.44_multiring/arch/i386/Config.help
--- linux-2.5.44/arch/i386/Config.help	2002-10-27 02:38:39.000000000 +0100
+++ linux-2.5.44_multiring/arch/i386/Config.help	2002-10-27 00:44:02.000000=
000 +0200
@@ -165,6 +165,13 @@ CONFIG_HIGHPTE
   low memory.  Setting this option will put user-space page table
   entries in high memory.
=20
+CONFIG_HIGHIDT
+  The kernel uses 4KB for each multiring process (e.g. User Mode Linux).
+  Say Y to allocate those 4KB in high memory. This is only useful if you
+  plan to run hundreds of thousands of multiring processes.
+
+  If unsure, say N.
+
 CONFIG_HIGHMEM4G
   Select this if you have a 32-bit processor and between 1 and 4
   gigabytes of physical RAM.
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/config.in linux-2.5.44_multiring/arch/i386/config.in
--- linux-2.5.44/arch/i386/config.in	2002-10-27 02:38:39.000000000 +0100
+++ linux-2.5.44_multiring/arch/i386/config.in	2002-10-27 00:44:02.00000000=
0 +0200
@@ -236,6 +236,7 @@ fi
=20
 if [ "$CONFIG_HIGHMEM4G" =3D "y" -o "$CONFIG_HIGHMEM64G" =3D "y" ]; then
    bool 'Allocate 3rd-level pagetables from highmem' CONFIG_HIGHPTE
+   bool 'Allocate multiring IDTs from highmem (EXPERIMENTAL)' CONFIG_X86_H=
IGHIDT
 fi
=20
 bool 'Math emulation' CONFIG_MATH_EMULATION
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/kernel/cpu/common.c linux-2.5.44_multiring/arch/i386/kernel/cpu/common=
.c
--- linux-2.5.44/arch/i386/kernel/cpu/common.c	2002-10-27 02:38:39.00000000=
0 +0100
+++ linux-2.5.44_multiring/arch/i386/kernel/cpu/common.c	2002-10-27 00:44:0=
2.000000000 +0200
@@ -243,6 +243,8 @@ void __init generic_identify(struct cpui
 	}
 }
=20
+extern void load_idt_table_init(unsigned cpu, pgprot_t prot);
+
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -257,6 +259,7 @@ void __init identify_cpu(struct cpuinfo_
 	c->x86_model =3D c->x86_mask =3D 0;	/* So far unknown... */
 	c->x86_vendor_id[0] =3D '\0'; /* Unset */
 	c->x86_model_id[0] =3D '\0';  /* Unset */
+	c->f00f_bug =3D 0;
 	memset(&c->x86_capability, 0, sizeof c->x86_capability);
=20
 	if (!have_cpuid_p()) {
@@ -348,6 +351,9 @@ void __init identify_cpu(struct cpuinfo_
 		/* AND the already accumulated flags with these */
 		for ( i =3D 0 ; i < NCAPINTS ; i++ )
 			boot_cpu_data.x86_capability[i] &=3D c->x86_capability[i];
+
+		if(c->f00f_bug)
+			boot_cpu_data.f00f_bug =3D 1;
 	}
=20
 	printk(KERN_DEBUG "CPU:             Common caps: %08lx %08lx %08lx %08lx\=
n",
@@ -355,6 +361,9 @@ void __init identify_cpu(struct cpuinfo_
 	       boot_cpu_data.x86_capability[1],
 	       boot_cpu_data.x86_capability[2],
 	       boot_cpu_data.x86_capability[3]);
+
+	/* load the IDT */
+	load_idt_table_init((c =3D=3D &boot_cpu_data) ? 0 : (c - cpu_data), boot_=
cpu_data.f00f_bug ? PAGE_KERNEL_RO : PAGE_KERNEL);=09
 }
 /*
  *	Perform early boot up checks for a valid TSC. See arch/i386/kernel/time=
.c
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/kernel/cpu/intel.c linux-2.5.44_multiring/arch/i386/kernel/cpu/intel.c
--- linux-2.5.44/arch/i386/kernel/cpu/intel.c	2002-10-27 02:38:39.000000000=
 +0100
+++ linux-2.5.44_multiring/arch/i386/kernel/cpu/intel.c	2002-10-27 00:44:02=
.000000000 +0200
@@ -169,15 +169,13 @@ static void __init init_intel(struct cpu
 	 * have the F0 0F bug, which lets nonpriviledged users lock up the system=
.
 	 * Note that the workaround only should be initialized once...
 	 */
-	c->f00f_bug =3D 0;
 	if ( c->x86 =3D=3D 5 ) {
-		static int f00f_workaround_enabled =3D 0;
+		static int f00f_workaround_message =3D 0;
=20
 		c->f00f_bug =3D 1;
-		if ( !f00f_workaround_enabled ) {
-			trap_init_f00f_bug();
+		if ( !f00f_workaround_message ) {
 			printk(KERN_NOTICE "Intel Pentium with F0 0F bug - workaround enabled.\=
n");
-			f00f_workaround_enabled =3D 1;
+			f00f_workaround_message =3D 1;
 		}
 	}
 #endif
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/kernel/entry.S linux-2.5.44_multiring/arch/i386/kernel/entry.S
--- linux-2.5.44/arch/i386/kernel/entry.S	2002-10-27 02:38:39.000000000 +01=
00
+++ linux-2.5.44_multiring/arch/i386/kernel/entry.S	2002-10-27 00:44:02.000=
000000 +0200
@@ -737,6 +737,7 @@ ENTRY(sys_call_table)
 	.long sys_free_hugepages
 	.long sys_exit_group
 	.long sys_lookup_dcookie
+	.long sys_multiring
=20
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/kernel/i8259.c linux-2.5.44_multiring/arch/i386/kernel/i8259.c
--- linux-2.5.44/arch/i386/kernel/i8259.c	2002-10-27 02:38:39.000000000 +01=
00
+++ linux-2.5.44_multiring/arch/i386/kernel/i8259.c	2002-10-27 00:44:02.000=
000000 +0200
@@ -282,7 +282,8 @@ void init_8259A(int auto_eoi)
 	 * outb_p - this has to work on a wide range of PC hardware.
 	 */
 	outb_p(0x11, 0x20);	/* ICW1: select 8259A-1 init */
-	outb_p(0x20 + 0, 0x21);	/* ICW2: 8259A-1 IR0-7 mapped to 0x20-0x27 */
+	/* ICW2: 8259A-1 IR0-7 mapped to FIRST_EXTERNAL_VECTOR-FIRST_EXTERNAL_VEC=
TOR+7 */
+	outb_p(FIRST_EXTERNAL_VECTOR + 0, 0x21);
 	outb_p(0x04, 0x21);	/* 8259A-1 (the master) has a slave on IR2 */
 	if (auto_eoi)
 		outb_p(0x03, 0x21);	/* master does Auto EOI */
@@ -290,7 +291,8 @@ void init_8259A(int auto_eoi)
 		outb_p(0x01, 0x21);	/* master expects normal EOI */
=20
 	outb_p(0x11, 0xA0);	/* ICW1: select 8259A-2 init */
-	outb_p(0x20 + 8, 0xA1);	/* ICW2: 8259A-2 IR0-7 mapped to 0x28-0x2f */
+	/* ICW2: 8259A-2 IR0-7 mapped to FIRST_EXTERNAL_VECTOR+8-FIRST_EXTERNAL_V=
ECTOR+f */
+	outb_p(FIRST_EXTERNAL_VECTOR + 8, 0xA1);
 	outb_p(0x02, 0xA1);	/* 8259A-2 is a slave on master's IR2 */
 	outb_p(0x01, 0xA1);	/* (slave's support for AEOI in flat mode
 				    is to be investigated) */
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/kernel/ldt.c linux-2.5.44_multiring/arch/i386/kernel/ldt.c
--- linux-2.5.44/arch/i386/kernel/ldt.c	2002-10-27 02:38:39.000000000 +0100
+++ linux-2.5.44_multiring/arch/i386/kernel/ldt.c	2002-10-27 02:18:48.00000=
0000 +0200
@@ -18,6 +18,7 @@
 #include <asm/system.h>
 #include <asm/ldt.h>
 #include <asm/desc.h>
+#include <asm/idt.h>
=20
 #ifdef CONFIG_SMP /* avoids "defined but not used" warnig */
 static void flush_ldt(void *null)
@@ -81,22 +82,62 @@ static inline int copy_ldt(mm_context_t=20
 	return 0;
 }
=20
+static inline int copy_idt(mm_context_t* new, mm_context_t* old, unsigned =
flags)
+{
+	struct desc_struct* oldidt;
+	if(flags & (CLONE_VM | CLONE_IDT))
+	{
+		oldidt =3D kmap_idt(old);
+		atomic_inc(idt_refcnt(oldidt));
+		kunmap_idt(old, oldidt);
+		new->idt =3D old->idt;
+	}
+	else
+	{
+		struct desc_struct* newidt;
+		union idt idtu;
+	=09
+		newidt =3D alloc_idt(&idtu);
+		if(!newidt)
+			return -ENOMEM;
+		oldidt =3D kmap_read_idt(old);
+		memcpy(newidt, oldidt, IDT_SIZE);
+		kunmap_read_idt(old, oldidt);
+		kunmap_new_idt(&idtu, newidt);
+		wmb();
+		new->idt =3D idtu;
+	}
+	return 0;
+}
+
 /*
  * we do not have to muck with descriptors here, that is
  * done in switch_mm() as needed.
  */
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+int init_new_context_flags(struct task_struct *tsk, struct mm_struct *mm, =
unsigned flags)
 {
 	struct mm_struct * old_mm;
 	int retval =3D 0;
=20
 	init_MUTEX(&mm->context.sem);
 	mm->context.size =3D 0;
+	mm->context.idt.opaque =3D 0;
+	mm->context.bad_segments =3D 0;=09
 	old_mm =3D current->mm;
-	if (old_mm && old_mm->context.size > 0) {
-		down(&old_mm->context.sem);
-		retval =3D copy_ldt(&mm->context, &old_mm->context);
-		up(&old_mm->context.sem);
+	if (old_mm)
+	{
+		mm->context.bad_segments =3D old_mm->context.bad_segments;
+		if(old_mm->context.size > 0 || (old_mm->context.idt.opaque && !(flags & =
CLONE_CLEAR_IDT)))
+		{
+			down(&old_mm->context.sem);
+			mm->context.bad_segments =3D old_mm->context.bad_segments;		=09
+			retval =3D 0;
+			if(old_mm->context.size > 0)
+				retval =3D copy_ldt(&mm->context, &old_mm->context);
+			if(!retval && old_mm->context.idt.opaque && !(flags & CLONE_CLEAR_IDT))
+				retval =3D copy_idt(&mm->context, &old_mm->context, flags);
+			up(&old_mm->context.sem);
+		}
 	}
 	return retval;
 }
@@ -115,6 +156,8 @@ void release_segments(struct mm_struct *
 			kfree(mm->context.ldt);
 		mm->context.size =3D 0;
 	}
+	if(mm->context.idt.opaque)
+		free_idt(&mm->context);
 }
=20
 static int read_ldt(void * ptr, unsigned long bytecount)
@@ -189,6 +232,10 @@ static int write_ldt(void * ptr, unsigne
 			goto out;
 	}
=20
+	error =3D LDT_handle_perm(&ldt_info, &mm->context);
+	if(error)
+		goto out;
+
 	down(&mm->context.sem);
 	if (ldt_info.entry_number >=3D mm->context.size) {
 		error =3D alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1);
@@ -211,10 +258,22 @@ static int write_ldt(void * ptr, unsigne
 	entry_2 =3D LDT_entry_b(&ldt_info);
 	if (oldmode)
 		entry_2 &=3D ~(1 << 20);
+	if(mm->context.idt.opaque)
+	{
+		error =3D -EINVAL;
+		if(ldt_info.dpl =3D=3D 0)
+			goto out_unlock;
+		entry_2 =3D (entry_2 & ~(3 << 13)) | (ldt_info.dpl << 13);	=09
+	}
=20
 	/* Install the new entry ...  */
 install:
+	*(lp+1) =3D 0;
+	wmb();
+=09
 	*lp	=3D entry_1;
+	wmb();
+
 	*(lp+1)	=3D entry_2;
 	error =3D 0;
=20
@@ -244,3 +303,22 @@ asmlinkage int sys_modify_ldt(int func,=20
 	}
 	return ret;
 }
+
+int LDT_handle_over_page_offset(mm_context_t* ctx)
+{
+	if(ctx->idt.opaque)
+		return -EPERM;
+	else if(ctx->bad_segments)
+		return 0;
+	else
+	{
+		int ret =3D 0;
+		down(&ctx->sem);
+		if(ctx->idt.opaque)
+			ret =3D -EPERM;
+		else
+			ctx->bad_segments =3D 1;
+		up(&ctx->sem);
+		return ret;
+	}
+}
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/kernel/Makefile linux-2.5.44_multiring/arch/i386/kernel/Makefile
--- linux-2.5.44/arch/i386/kernel/Makefile	2002-10-27 02:38:39.000000000 +0=
100
+++ linux-2.5.44_multiring/arch/i386/kernel/Makefile	2002-10-27 00:44:03.00=
0000000 +0200
@@ -9,7 +9,7 @@ export-objs     :=3D mca.o i386_ksyms.o ti
 obj-y	:=3D process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
-		bootflag.o
+		bootflag.o multiring.o
=20
 obj-y				+=3D cpu/
 obj-y				+=3D timers/
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/kernel/multiring.c linux-2.5.44_multiring/arch/i386/kernel/multiring.c
--- linux-2.5.44/arch/i386/kernel/multiring.c	1970-01-01 01:00:00.000000000=
 +0100
+++ linux-2.5.44_multiring/arch/i386/kernel/multiring.c	2002-10-27 03:18:02=
.000000000 +0100
@@ -0,0 +1,316 @@
+/*
+ * linux/kernel/multiring.c: support for multiple privilege rings
+ *
+ * Copyright (C) 2002 Luca Barbieri <ldb@ldb.ods.org>
+ */
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+
+#include <asm/uaccess.h>
+#include <asm/idt.h>
+#include <asm/irq.h>
+#include <asm/multiring.h>
+
+#define MULTIRING_NR_VECTORS ((MULTIRING_AUTO_LAST_VECTOR - MULTIRING_AUTO=
_FIRST_VECTOR + 1) + (MULTIRING_SPECIAL_LAST_VECTOR - MULTIRING_SPECIAL_FIR=
ST_VECTOR + 1) + 1)
+
+static unsigned char vec2idx[256];
+static unsigned char idx2vec[MULTIRING_NR_VECTORS];
+
+#ifdef CONFIG_SMP /* avoids "defined but not used" warning */
+static void flush_idt(void *null)
+{
+	if (current->active_mm)
+		load_IDT(&current->active_mm->context);
+}
+#endif
+
+static inline unsigned multiring_fix_selector(unsigned sel)
+{
+	unsigned tsel =3D sel | 3;
+	if(tsel =3D=3D USER_DS_RPL(3))
+		return USER_DS_RPL(MULTIRING_USER_RING);
+	else if(tsel =3D=3D USER_CS_RPL(3))
+		return USER_CS_RPL(MULTIRING_USER_RING);
+	else
+		return sel;
+}
+
+static inline void multiring_fix_selector_ptr(unsigned* sel)
+{
+	*sel =3D multiring_fix_selector(*sel);
+}
+
+static inline struct pt_regs* get_pt_regs(task_t* tsk)
+{
+	return (struct pt_regs*)tsk->thread.esp0 - 1;
+}
+
+void multiring_init_task(task_t* tsk)
+{	=09
+		/* One-time initialization for multiring mode */
+		unsigned oldsel, newsel;
+		struct pt_regs* regs;
+	=09
+		regs =3D get_pt_regs(tsk);
+
+#define multiring_fix_loaded_selector(selname) \
+		savesegment(selname, oldsel); \
+		newsel =3D multiring_fix_selector(oldsel); \
+		if(oldsel !=3D newsel) \
+			loadsegment(selname, oldsel);
+	=09
+		multiring_fix_selector_ptr((unsigned*)&regs->xds);
+		multiring_fix_selector_ptr((unsigned*)&regs->xes);
+		multiring_fix_selector_ptr((unsigned*)&regs->xcs);
+		multiring_fix_selector_ptr((unsigned*)&regs->xss);
+		if(tsk !=3D current)
+		{
+			multiring_fix_selector_ptr((unsigned*)&tsk->thread.fs);
+			multiring_fix_selector_ptr((unsigned*)&tsk->thread.gs);
+		}
+		else
+		{
+			multiring_fix_loaded_selector(fs);
+			multiring_fix_loaded_selector(gs);
+		}
+#undef multiring_fix_loaded_selector
+}
+
+void load_IDT_nolock(mm_context_t* ctx, unsigned cpu)
+{
+	load_IDT_nolock_inline(current, ctx, cpu);
+}
+
+asmlinkage int sys_multiring(unsigned op, unsigned arg1, unsigned arg2, un=
signed arg3)
+{
+	mm_context_t* ctx =3D &current->mm->context;
+	int ret;
+	unsigned i;
+	int cpu;
+	struct desc_struct gate;
+	struct desc_struct* idt;
+
+	/* Without WP, DPL 1 and 2 will bypass copy-on-write */
+	if(!boot_cpu_data.wp_works_ok)
+		return -ENOSYS;
+	=09
+	if(op > MULTIRING_LAST_OP)
+		return -EOPNOTSUPP;
+
+	switch(op)
+	{
+	case MULTIRING_CHECK:
+		return current->thread.multiring_mode ? 0 : (ctx->bad_segments ? -EPERM =
: 1);
+
+	case MULTIRING_SET_ESPSS:
+	{
+		struct tss_struct *tss;
+		unsigned ring =3D arg1;
+		unsigned esp =3D arg2;
+		unsigned ss =3D arg3;
+		if(ring =3D=3D 0)
+			return -EPERM;
+		if(ring >=3D 3 || ring !=3D (ss & 3))
+			return -EINVAL;
+
+		current->thread.espss12[ring - 1].esp =3D esp;
+		current->thread.espss12[ring - 1].ss  =3D ss;
+
+		cpu =3D get_cpu();
+		tss =3D init_tss + cpu;
+		tss->espss12[ring - 1].esp =3D esp;
+		tss->espss12[ring - 1].ss  =3D ss;
+		put_cpu();
+
+		return 0;
+	}
+=09
+	case MULTIRING_GET_ESPSS:
+	{
+		unsigned ring =3D arg1;
+		unsigned* esp =3D (unsigned*)arg2;
+		unsigned* ss =3D (unsigned*)arg3;	=09
+		if(ring =3D=3D 0)
+			return -EPERM;
+		if(ring >=3D 3)
+			return -EINVAL;
+	=09
+		if(put_user(current->thread.espss12[ring - 1].esp, esp)
+		   || put_user(current->thread.espss12[ring - 1].ss, ss))
+			return -EFAULT;
+		return 0;
+	}
+
+	case MULTIRING_GET_RANGE:
+	{
+		unsigned first, last;
+		char* ptr =3D (char*)arg3;
+		if(arg1 <=3D arg2)
+		{
+			first =3D arg1;
+			last =3D arg2;
+		}
+		else
+		{
+			first =3D arg2;
+			last =3D arg1;
+		}
+
+		ret =3D (last - first + 1) * 8;
+		idt =3D kmap_read_idt_or_table(ctx);
+		if(copy_to_user(ptr, &idt[first], ret))
+			ret =3D -EFAULT;
+		kunmap_read_idt_or_table(ctx, idt);
+		return ret;
+	}
+
+	case MULTIRING_GET:
+	{
+		unsigned vec =3D arg1;
+		unsigned* ptr =3D (unsigned*)arg2;
+		ret =3D 0;
+		idt =3D kmap_read_idt_or_table(ctx);
+		if(copy_to_user(ptr, &idt[vec], 8))
+			ret =3D -EFAULT;
+		kunmap_read_idt_or_table(ctx, idt);
+		return ret;=09
+	}
+	}
+=09
+	if(!current->thread.multiring_mode)
+	{
+		if(op !=3D MULTIRING_ELEVATE)
+			return -ENXIO;
+	=09
+		if(ctx->bad_segments)
+			return -EPERM;
+
+		down(&ctx->sem);
+		ret =3D -EPERM;
+		if(ctx->bad_segments)
+			goto out_up;
+
+		if(!ctx->idt.opaque)
+		{
+			union idt idtu;
+			idt =3D alloc_idt(&idtu);
+			ret =3D -ENOMEM;
+			if(!idt)
+				goto out_up;
+			memcpy(idt, idt_table, IDT_SIZE);
+			idt[SYSCALL_VECTOR].b =3D (idt[SYSCALL_VECTOR].b &~ 0x6000) | (MULTIRIN=
G_USER_RING << 13);
+			kunmap_new_idt(&idtu, idt);
+
+			wmb();
+			ctx->idt =3D idtu;
+			wmb();
+
+#ifdef CONFIG_SMP
+			cpu =3D get_cpu();
+			if (current->mm->cpu_vm_mask !=3D (1 << cpu))
+				smp_call_function(flush_idt, 0, 1, 1);
+			put_cpu();
+#endif
+		}
+		up(&ctx->sem);
+
+		cpu =3D get_cpu();
+		if(!current->thread.multiring_mode)
+			load_IDT_nolock(ctx, cpu);
+		put_cpu();
+		return 0;
+
+	  out_up:
+		up(&ctx->sem);
+		return ret;
+	}
+=09
+	/* MULTIRING_SET or MULTIRING_COPY */
+	{
+		unsigned vec =3D arg1;
+		idt =3D kmap_write_idt(ctx);
+		if(vec =3D=3D MULTIRING_VEC_FREE)
+		{
+			for(i =3D 0; i < MULTIRING_NR_VECTORS; ++i)
+			{
+				vec =3D idx2vec[i];
+				if(!idt[vec].a && !idt[vec].b)
+					goto found_free;
+			}
+			ret =3D -ENOSPC;
+			goto out_put_idt;
+		  found_free:
+		}
+		else
+		{
+			ret =3D -EPERM;
+			if(vec2idx[vec] =3D=3D (unsigned char)~0)
+				goto out_put_idt;
+		}
+
+		if(op =3D=3D MULTIRING_COPY)
+		{
+			unsigned from =3D arg2;
+			ret =3D -EPERM;
+			if(vec2idx[from] =3D=3D (unsigned char)~0)
+				goto out_put_idt;
+			gate =3D idt[from];
+		}
+		else
+		{
+			gate.a =3D arg2;
+			gate.b =3D arg3;
+			if(gate.b & 0x8000)
+			{
+				ret =3D -EINVAL;
+				if((gate.b & 0x10ff) || (~gate.b & 0x700) || !(gate.b & 0x6000)) /* re=
served_is_bad || !trap_gate || dpl0 */
+					goto out_put_idt;
+				ret =3D -EPERM;
+				if(!(gate.a & 0x30000) && (gate.a >> 16) && (gate.a !=3D idt_table[SYS=
CALL_VECTOR].a || (gate.b | 0xe000) !=3D idt_table[SYSCALL_VECTOR].b)) /* s=
eg_RPL =3D=3D 0 && not_int80_syscall */
+					goto out_put_idt;
+			}
+		}
+
+		idt[vec].b =3D 0;
+		wmb();
+		idt[vec].a =3D gate.a;
+		wmb();
+		idt[vec].b =3D gate.b;
+		ret =3D vec;
+	}
+  out_put_idt:
+	kunmap_write_idt(ctx, idt);
+	return ret;
+}
+
+int __init init_multiring(void)
+{
+	unsigned idx;
+	unsigned vec;
+
+	memset(vec2idx, 0xff, sizeof(vec2idx));
+	idx =3D 0;
+	for(vec =3D MULTIRING_AUTO_FIRST_VECTOR; vec <=3D MULTIRING_AUTO_LAST_VEC=
TOR; ++vec, ++idx)
+		idx2vec[idx] =3D vec;
+	for(vec =3D MULTIRING_SPECIAL_FIRST_VECTOR; vec <=3D MULTIRING_SPECIAL_LA=
ST_VECTOR; ++vec, ++idx)
+		idx2vec[idx] =3D vec;
+	idx2vec[idx] =3D SYSCALL_VECTOR;
+	vec2idx[SYSCALL_VECTOR] =3D idx;
+
+	for(idx =3D 0; idx < (MULTIRING_NR_VECTORS - 1); ++idx)
+	{
+		vec =3D idx2vec[idx];
+		vec2idx[vec] =3D idx;
+		idt_table[vec].a =3D 0;
+		idt_table[vec].b =3D 0;
+	}
+	return 0;
+}
+
+__initcall(init_multiring);
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/kernel/process.c linux-2.5.44_multiring/arch/i386/kernel/process.c
--- linux-2.5.44/arch/i386/kernel/process.c	2002-10-27 02:38:39.000000000 +=
0100
+++ linux-2.5.44_multiring/arch/i386/kernel/process.c	2002-10-27 02:34:41.0=
00000000 +0200
@@ -40,6 +40,7 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/ldt.h>
+#include <asm/idt.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/desc.h>
@@ -252,6 +253,8 @@ void flush_thread(void)
 	 */
 	clear_fpu(tsk);
 	tsk->used_math =3D 0;
+	tsk->thread.multiring_mode =3D 0;
+	load_IDT(&tsk->mm->context);
 }
=20
 void release_thread(struct task_struct *dead_task)
@@ -268,18 +271,13 @@ void release_thread(struct task_struct *
 	}
 }
=20
-/*
- * Save a segment.
- */
-#define savesegment(seg,value) \
-	asm volatile("movl %%" #seg ",%0":"=3Dm" (*(int *)&(value)))
-
 int copy_thread(int nr, unsigned long clone_flags, unsigned long esp,
 	unsigned long unused,
 	struct task_struct * p, struct pt_regs * regs)
 {
 	struct pt_regs * childregs;
 	struct task_struct *tsk;
+	tsk =3D current;
=20
 	childregs =3D ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->threa=
d_info)) - 1;
 	struct_cpy(childregs, regs);
@@ -289,13 +287,14 @@ int copy_thread(int nr, unsigned long cl
=20
 	p->thread.esp =3D (unsigned long) childregs;
 	p->thread.esp0 =3D (unsigned long) (childregs+1);
+	p->thread.espss12[0] =3D tsk->thread.espss12[0];
+	p->thread.espss12[1] =3D tsk->thread.espss12[1];
=20
 	p->thread.eip =3D (unsigned long) ret_from_fork;
=20
 	savesegment(fs,p->thread.fs);
 	savesegment(gs,p->thread.gs);
=20
-	tsk =3D current;
 	unlazy_fpu(tsk);
 	struct_cpy(&p->thread.i387, &tsk->thread.i387);
=20
@@ -307,6 +306,8 @@ int copy_thread(int nr, unsigned long cl
 			IO_BITMAP_BYTES);
 	}
=20
+	p->thread.multiring_mode =3D (tsk->thread.multiring_mode && p->mm->contex=
t.idt.opaque) ? 1 : 0;
+=09
 	/*
 	 * Set a new TLS for the child thread?
 	 */
@@ -319,6 +320,8 @@ int copy_thread(int nr, unsigned long cl
 			return -EFAULT;
 		if (LDT_empty(&info))
 			return -EINVAL;
+		if (LDT_handle_perm(&info, &p->mm->context))
+			return -EPERM;
=20
 		idx =3D info.entry_number;
 		if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
@@ -327,6 +330,12 @@ int copy_thread(int nr, unsigned long cl
 		desc =3D p->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
 		desc->a =3D LDT_entry_a(&info);
 		desc->b =3D LDT_entry_b(&info);
+		if(unlikely(current->mm->context.idt.opaque))
+		{
+			if(unlikely(info.dpl =3D=3D 0))
+				return -EINVAL;
+			desc->b =3D (desc->b & ~(3 << 13)) | (info.dpl << 13);
+		}
 	}
 	return 0;
 }
@@ -420,6 +429,10 @@ void __switch_to(struct task_struct *pre
 	 */
 	tss->esp0 =3D next->esp0;
=20
+	/* multiring */
+	tss->espss12[0] =3D next->espss12[0];
+	tss->espss12[1] =3D next->espss12[1];=09
+=09
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
 	 */
@@ -599,8 +612,12 @@ asmlinkage int sys_set_thread_area(struc
=20
 	if (copy_from_user(&info, u_info, sizeof(info)))
 		return -EFAULT;
-	idx =3D info.entry_number;
=20
+	if (LDT_handle_perm(&info, &current->mm->context))
+		return -EPERM;
+=09
+	idx =3D info.entry_number;
+=09
 	/*
 	 * index -1 means the kernel should try to find and
 	 * allocate an empty descriptor:
@@ -618,20 +635,25 @@ asmlinkage int sys_set_thread_area(struc
=20
 	desc =3D t->tls_array + idx - GDT_ENTRY_TLS_MIN;
=20
-	/*
-	 * We must not get preempted while modifying the TLS.
-	 */
-	cpu =3D get_cpu();
-
 	if (LDT_empty(&info)) {
 		desc->a =3D 0;
 		desc->b =3D 0;
 	} else {
 		desc->a =3D LDT_entry_a(&info);
 		desc->b =3D LDT_entry_b(&info);
+		if(unlikely(current->mm->context.idt.opaque))
+		{
+			if(unlikely(info.dpl =3D=3D 0))
+				return -EINVAL;
+			desc->b =3D (desc->b & ~(3 << 13)) | (info.dpl << 13);
+		}
 	}
-	load_TLS(t, cpu);
=20
+	/*
+	 * We must not get preempted while modifying the TLS.
+	 */=09
+	cpu =3D get_cpu();=09
+	load_TLS(t, cpu);
 	put_cpu();
=20
 	return 0;
@@ -656,6 +678,7 @@ asmlinkage int sys_set_thread_area(struc
 #define GET_LIMIT_PAGES(desc)	(((desc)->b >> 23) & 1)
 #define GET_PRESENT(desc)	(((desc)->b >> 15) & 1)
 #define GET_USEABLE(desc)	(((desc)->b >> 20) & 1)
+#define GET_DPL(desc)		(((desc)->b >> 13) & 3)
=20
 asmlinkage int sys_get_thread_area(struct user_desc *u_info)
 {
@@ -679,6 +702,7 @@ asmlinkage int sys_get_thread_area(struc
 	info.limit_in_pages =3D GET_LIMIT_PAGES(desc);
 	info.seg_not_present =3D !GET_PRESENT(desc);
 	info.useable =3D GET_USEABLE(desc);
+	info.dpl =3D GET_DPL(desc);
=20
 	if (copy_to_user(u_info, &info, sizeof(info)))
 		return -EFAULT;
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/kernel/ptrace.c linux-2.5.44_multiring/arch/i386/kernel/ptrace.c
--- linux-2.5.44/arch/i386/kernel/ptrace.c	2002-10-27 02:38:39.000000000 +0=
100
+++ linux-2.5.44_multiring/arch/i386/kernel/ptrace.c	2002-10-27 00:44:03.00=
0000000 +0200
@@ -76,24 +76,24 @@ static int putreg(struct task_struct *ch
 {
 	switch (regno >> 2) {
 		case FS:
-			if (value && (value & 3) !=3D 3)
+			if (value && !(value & 3))
 				return -EIO;
 			child->thread.fs =3D value;
 			return 0;
 		case GS:
-			if (value && (value & 3) !=3D 3)
+			if (value && !(value & 3))
 				return -EIO;
 			child->thread.gs =3D value;
 			return 0;
 		case DS:
 		case ES:
-			if (value && (value & 3) !=3D 3)
+			if (value && !(value & 3))
 				return -EIO;
 			value &=3D 0xffff;
 			break;
 		case SS:
 		case CS:
-			if ((value & 3) !=3D 3)
+			if (!(value & 3))
 				return -EIO;
 			value &=3D 0xffff;
 			break;
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/kernel/signal.c linux-2.5.44_multiring/arch/i386/kernel/signal.c
--- linux-2.5.44/arch/i386/kernel/signal.c	2002-10-27 02:38:39.000000000 +0=
100
+++ linux-2.5.44_multiring/arch/i386/kernel/signal.c	2002-10-27 00:44:03.00=
0000000 +0200
@@ -162,7 +162,7 @@ restore_sigcontext(struct pt_regs *regs,
 #define COPY_SEG_STRICT(seg)						\
 	{ unsigned short tmp;						\
 	  err |=3D __get_user(tmp, &sc->seg);				\
-	  regs->x##seg =3D tmp|3; }
+	  regs->x##seg =3D (tmp & 3) ? tmp : (tmp | USER_RING); }
=20
 #define GET_SEG(seg)							\
 	{ unsigned short tmp;						\
@@ -338,7 +338,7 @@ get_sigframe(struct k_sigaction *ka, str
 	}
=20
 	/* This is the legacy signal stack switching. */
-	else if ((regs->xss & 0xffff) !=3D __USER_DS &&
+	else if ((regs->xss & 0xfffc) !=3D USER_DS_RPL(0) &&
 		 !(ka->sa.sa_flags & SA_RESTORER) &&
 		 ka->sa.sa_restorer) {
 		esp =3D (unsigned long) ka->sa.sa_restorer;
@@ -350,6 +350,7 @@ get_sigframe(struct k_sigaction *ka, str
 static void setup_frame(int sig, struct k_sigaction *ka,
 			sigset_t *set, struct pt_regs * regs)
 {
+	unsigned ring;
 	struct sigframe *frame;
 	int err =3D 0;
=20
@@ -398,10 +399,10 @@ static void setup_frame(int sig, struct=20
 	regs->eip =3D (unsigned long) ka->sa.sa_handler;
=20
 	set_fs(USER_DS);
-	regs->xds =3D __USER_DS;
-	regs->xes =3D __USER_DS;
-	regs->xss =3D __USER_DS;
-	regs->xcs =3D __USER_CS;
+	ring =3D get_user_ring();
+	regs->xds =3D regs->xes =3D regs->xss =3D USER_DS_RPL(ring);
+	regs->xcs =3D USER_CS_RPL(ring);
+	put_user_ring();
 	regs->eflags &=3D ~TF_MASK;
=20
 #if DEBUG_SIG
@@ -422,6 +423,7 @@ static void setup_rt_frame(int sig, stru
 {
 	struct rt_sigframe *frame;
 	int err =3D 0;
+	unsigned ring;
=20
 	frame =3D get_sigframe(ka, regs, sizeof(*frame));
=20
@@ -473,10 +475,10 @@ static void setup_rt_frame(int sig, stru
 	regs->eip =3D (unsigned long) ka->sa.sa_handler;
=20
 	set_fs(USER_DS);
-	regs->xds =3D __USER_DS;
-	regs->xes =3D __USER_DS;
-	regs->xss =3D __USER_DS;
-	regs->xcs =3D __USER_CS;
+	ring =3D get_user_ring();
+	regs->xds =3D regs->xes =3D regs->xss =3D USER_DS_RPL(ring);
+	regs->xcs =3D USER_CS_RPL(ring);
+	put_user_ring();
 	regs->eflags &=3D ~TF_MASK;
=20
 #if DEBUG_SIG
@@ -556,7 +558,7 @@ int do_signal(struct pt_regs *regs, sigs
 	 * kernel mode. Just return without doing anything
 	 * if so.
 	 */
-	if ((regs->xcs & 3) !=3D 3)
+	if (!(regs->xcs & 3))
 		return 1;
=20
 	if (current->flags & PF_FREEZE) {
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/kernel/traps.c linux-2.5.44_multiring/arch/i386/kernel/traps.c
--- linux-2.5.44/arch/i386/kernel/traps.c	2002-10-27 02:38:39.000000000 +01=
00
+++ linux-2.5.44_multiring/arch/i386/kernel/traps.c	2002-10-27 00:44:03.000=
000000 +0200
@@ -49,6 +49,8 @@
 #include <linux/irq.h>
 #include <linux/module.h>
=20
+#include <asm/idt.h>
+
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
@@ -62,6 +64,10 @@ struct desc_struct default_ldt[] =3D { { 0
  * for this.
  */
 struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))=
) =3D { {0, 0}, };
+#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_F00F_BUG)
+pte_t* idt_pte;
+pte_t idt_table_pte;
+#endif
=20
 asmlinkage void divide_error(void);
 asmlinkage void debug(void);
@@ -249,6 +255,30 @@ bad:
 	printk("\n");
 }=09
=20
+void __init load_idt_table_init(unsigned cpu, pgprot_t prot)
+{
+	struct Xgt_desc_struct map_idt_descr;
+=09
+	if(use_highidt
+#ifdef CONFIG_X86_F00F_BUG
+	   || (pgprot_val(prot) =3D=3D __PAGE_KERNEL_RO)
+#endif	  =20
+	)
+	{
+		unsigned idt_vstart;
+		idt_vstart =3D __fix_to_virt(FIX_IDT_BEGIN);
+		idt_pte =3D pte_offset_kernel(pmd_offset(pgd_offset_k(idt_vstart), (idt_=
vstart)), (idt_vstart));
+	=09
+		idt_table_pte =3D pfn_pte(__pa(idt_table) >> PAGE_SHIFT, prot);
+		set_pte(idt_pte - cpu, idt_table_pte);
+		map_idt_descr.size =3D IDT_SIZE - 1;
+		map_idt_descr.address =3D __fix_to_virt(FIX_IDT_BEGIN + cpu);
+		__asm__ __volatile__("lidt %0": "=3Dm" (map_idt_descr));
+	}
+	else
+		__asm__ __volatile__("lidt %0": "=3Dm" (idt_descr));
+}
+
 static void handle_BUG(struct pt_regs *regs)
 {
 	unsigned short ud2;
@@ -814,20 +844,6 @@ asmlinkage void math_emulate(long arg)
=20
 #endif /* CONFIG_MATH_EMULATION */
=20
-#ifdef CONFIG_X86_F00F_BUG
-void __init trap_init_f00f_bug(void)
-{
-	__set_fixmap(FIX_F00F_IDT, __pa(&idt_table), PAGE_KERNEL_RO);
-
-	/*
-	 * Update the IDT descriptor and reload the IDT so that
-	 * it uses the read-only mapped virtual address.
-	 */
-	idt_descr.address =3D fix_to_virt(FIX_F00F_IDT);
-	__asm__ __volatile__("lidt %0": "=3Dm" (idt_descr));
-}
-#endif
-
 #define _set_gate(gate_addr,type,dpl,addr) \
 do { \
   int __d0, __d1; \
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/mach-generic/irq_vectors.h linux-2.5.44_multiring/arch/i386/mach-gener=
ic/irq_vectors.h
--- linux-2.5.44/arch/i386/mach-generic/irq_vectors.h	2002-10-27 02:38:39.0=
00000000 +0100
+++ linux-2.5.44_multiring/arch/i386/mach-generic/irq_vectors.h	2002-10-27 =
00:44:03.000000000 +0200
@@ -22,16 +22,19 @@
 #ifndef _ASM_IRQ_VECTORS_H
 #define _ASM_IRQ_VECTORS_H
=20
+#define MULTIRING_SPECIAL_FIRST_VECTOR	0x20
+#define MULTIRING_SPECIAL_LAST_VECTOR	0x2f
+
 /*
  * IDT vectors usable for external interrupt sources start
- * at 0x20:
+ * at 0x30:
  */
-#define FIRST_EXTERNAL_VECTOR	0x20
+#define FIRST_EXTERNAL_VECTOR	0x30
=20
 #define SYSCALL_VECTOR		0x80
=20
 /*
- * Vectors 0x20-0x2f are used for ISA interrupts.
+ * Vectors 0x30-0x3f are used for ISA interrupts.
  */
=20
 /*
@@ -49,6 +52,9 @@
 #define RESCHEDULE_VECTOR	0xfc
 #define CALL_FUNCTION_VECTOR	0xfb
=20
+#define MULTIRING_AUTO_LAST_VECTOR	0xfa
+#define MULTIRING_AUTO_FIRST_VECTOR	0xf1
+
 #define THERMAL_APIC_VECTOR	0xf0
 /*
  * Local APIC timer IRQ vector is on a different priority level,
@@ -58,26 +64,26 @@
 #define LOCAL_TIMER_VECTOR	0xef
=20
 /*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
- * we start at 0x31 to spread out vectors evenly between priority
+ * First APIC vector available to drivers: (vectors 0x41-0xee)
+ * we start at 0x41 to spread out vectors evenly between priority
  * levels. (0x80 is the syscall vector)
  */
-#define FIRST_DEVICE_VECTOR	0x31
+#define FIRST_DEVICE_VECTOR	0x41
 #define FIRST_SYSTEM_VECTOR	0xef
=20
 #define TIMER_IRQ 0
=20
 /*
- * 16 8259A IRQ's, 208 potential APIC interrupt sources.
+ * 16 8259A IRQ's, 192 potential APIC interrupt sources.
  * Right now the APIC is mostly only used for SMP.
  * 256 vectors is an architectural limit. (we can have
  * more than 256 devices theoretically, but they will
  * have to use shared interrupts)
  * Since vectors 0x00-0x1f are used/reserved for the CPU,
- * the usable vector space is 0x20-0xff (224 vectors)
+ * the usable vector space is 0x30-0xff (208 vectors)
  */
 #ifdef CONFIG_X86_IO_APIC
-#define NR_IRQS 224
+#define NR_IRQS 208
 #else
 #define NR_IRQS 16
 #endif
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/mach-visws/irq_vectors.h linux-2.5.44_multiring/arch/i386/mach-visws/i=
rq_vectors.h
--- linux-2.5.44/arch/i386/mach-visws/irq_vectors.h	2002-10-27 02:38:39.000=
000000 +0100
+++ linux-2.5.44_multiring/arch/i386/mach-visws/irq_vectors.h	2002-10-27 00=
:44:03.000000000 +0200
@@ -1,11 +1,14 @@
 #ifndef _ASM_IRQ_VECTORS_H
 #define _ASM_IRQ_VECTORS_H
=20
+#define MULTIRING_SPECIAL_FIRST_VECTOR	0x20
+#define MULTIRING_SPECIAL_LAST_VECTOR	0x2f
+
 /*
  * IDT vectors usable for external interrupt sources start
- * at 0x20:
+ * at 0x30:
  */
-#define FIRST_EXTERNAL_VECTOR	0x20
+#define FIRST_EXTERNAL_VECTOR	0x30
=20
 #define SYSCALL_VECTOR		0x80
=20
@@ -28,6 +31,9 @@
 #define RESCHEDULE_VECTOR	0xfc
 #define CALL_FUNCTION_VECTOR	0xfb
=20
+#define MULTIRING_AUTO_LAST_VECTOR	0xfa
+#define MULTIRING_AUTO_FIRST_VECTOR	0xf1
+
 #define THERMAL_APIC_VECTOR	0xf0
 /*
  * Local APIC timer IRQ vector is on a different priority level,
@@ -37,26 +43,26 @@
 #define LOCAL_TIMER_VECTOR	0xef
=20
 /*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
- * we start at 0x31 to spread out vectors evenly between priority
+ * First APIC vector available to drivers: (vectors 0x41-0xee)
+ * we start at 0x41 to spread out vectors evenly between priority
  * levels. (0x80 is the syscall vector)
  */
-#define FIRST_DEVICE_VECTOR	0x31
+#define FIRST_DEVICE_VECTOR	0x41
 #define FIRST_SYSTEM_VECTOR	0xef
=20
 #define TIMER_IRQ 0
=20
 /*
- * 16 8259A IRQ's, 208 potential APIC interrupt sources.
+ * 16 8259A IRQ's, 192 potential APIC interrupt sources.
  * Right now the APIC is mostly only used for SMP.
  * 256 vectors is an architectural limit. (we can have
  * more than 256 devices theoretically, but they will
  * have to use shared interrupts)
  * Since vectors 0x00-0x1f are used/reserved for the CPU,
- * the usable vector space is 0x20-0xff (224 vectors)
+ * the usable vector space is 0x30-0xff (208 vectors)
  */
 #ifdef CONFIG_X86_IO_APIC
-#define NR_IRQS 224
+#define NR_IRQS 208
 #else
 #define NR_IRQS 16
 #endif
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/math-emu/fpu_entry.c linux-2.5.44_multiring/arch/i386/math-emu/fpu_ent=
ry.c
--- linux-2.5.44/arch/i386/math-emu/fpu_entry.c	2002-10-27 02:38:39.0000000=
00 +0100
+++ linux-2.5.44_multiring/arch/i386/math-emu/fpu_entry.c	2002-10-27 00:44:=
03.000000000 +0200
@@ -171,7 +171,7 @@ asmlinkage void math_emulate(long arg)
       FPU_EIP +=3D code_base =3D FPU_CS << 4;
       code_limit =3D code_base + 0xffff;  /* Assumes code_base <=3D 0xffff=
0000 */
     }
-  else if ( FPU_CS =3D=3D __USER_CS && FPU_DS =3D=3D __USER_DS )
+  else if ( (FPU_CS | 3) =3D=3D USER_CS_RPL(3) && (FPU_DS | 3) =3D=3D USER=
_DS_RPL(3) )
     {
       addr_modes.default_mode =3D 0;
     }
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/arch/=
i386/mm/fault.c linux-2.5.44_multiring/arch/i386/mm/fault.c
--- linux-2.5.44/arch/i386/mm/fault.c	2002-10-27 02:38:39.000000000 +0100
+++ linux-2.5.44_multiring/arch/i386/mm/fault.c	2002-10-27 00:44:03.0000000=
00 +0200
@@ -157,6 +157,10 @@ asmlinkage void do_page_fault(struct pt_
=20
 	tsk =3D current;
=20
+	/* User code at DPL 1 and 2 will also cause the U/S bit to be unset */
+	if(current->thread.multiring_mode && (regs->xcs & 3))
+		error_code |=3D 4;
+=09
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
@@ -270,6 +274,7 @@ bad_area:
 	up_read(&mm->mmap_sem);
=20
 	/* User mode accesses just cause a SIGSEGV */
+	/* Note: F0 0F C7 C8 in DPL 1 or 2 will cause the if body to be executed =
(seems unavoidable) */
 	if (error_code & 4) {
 		tsk->thread.cr2 =3D address;
 		tsk->thread.error_code =3D error_code;
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/fs/ex=
ec.c linux-2.5.44_multiring/fs/exec.c
--- linux-2.5.44/fs/exec.c	2002-10-27 02:38:39.000000000 +0100
+++ linux-2.5.44_multiring/fs/exec.c	2002-10-27 02:14:07.000000000 +0200
@@ -1021,7 +1021,11 @@ int do_execve(char * filename, char ** a
 	if (!bprm.mm)
 		goto out_file;
=20
+#ifdef init_new_context_flags
+	retval =3D init_new_context_flags(current, bprm.mm, CLONE_EXEC);
+#else
 	retval =3D init_new_context(current, bprm.mm);
+#endif
 	if (retval < 0)
 		goto out_mm;
=20
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/asm-i386/desc.h linux-2.5.44_multiring/include/asm-i386/desc.h
--- linux-2.5.44/include/asm-i386/desc.h	2002-10-27 02:38:39.000000000 +010=
0
+++ linux-2.5.44_multiring/include/asm-i386/desc.h	2002-10-27 00:44:03.0000=
00000 +0200
@@ -3,12 +3,16 @@
=20
 #include <asm/ldt.h>
 #include <asm/segment.h>
+#include <asm/page.h>
+
+#define USER_CSDS_A (((__PAGE_OFFSET - 1) >> PAGE_SHIFT) & 0xffff)
+#define USER_CSDS_B(data, ring) (0x00c09200 | (((__PAGE_OFFSET - 1) >> PAG=
E_SHIFT) & 0xf0000) | ((!(data)) << 11) | ((ring) << 13))
=20
 #ifndef __ASSEMBLY__
=20
 #include <asm/mmu.h>
=20
-extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];
+extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES], idt_table[I=
DT_ENTRIES];
=20
 struct Xgt_desc_struct {
 	unsigned short size;
@@ -61,7 +65,7 @@ static inline void set_ldt_desc(unsigned
 	((info)->seg_32bit << 22) | \
 	((info)->limit_in_pages << 23) | \
 	((info)->useable << 20) | \
-	0x7000)
+	0x1000 | (USER_RING << 13))
=20
 #define LDT_empty(info) (\
 	(info)->base_addr	=3D=3D 0	&& \
@@ -73,6 +77,35 @@ static inline void set_ldt_desc(unsigned
 	(info)->seg_not_present	=3D=3D 1	&& \
 	(info)->useable		=3D=3D 0	)
=20
+extern int LDT_handle_over_page_offset(mm_context_t* ctx);
+
+static inline int LDT_handle_perm(struct user_desc* info, mm_context_t* ct=
x)
+{
+	unsigned limit;
+	unsigned maxlim;
+	if(info->base_addr >=3D __PAGE_OFFSET)
+		return LDT_handle_over_page_offset(ctx);
+=09
+	limit =3D info->limit & 0xfffff;
+	if(info->limit_in_pages)
+		limit =3D (limit << PAGE_SHIFT) + (PAGE_SIZE - 1);
+
+	maxlim =3D (__PAGE_OFFSET - 1) - info->base_addr;
+	if(limit > maxlim)
+	{
+		if(maxlim <=3D 0xfffff)
+		{
+			info->limit =3D maxlim;
+			info->limit_in_pages =3D 0;		=09
+		}
+		else if(!(info->base_addr & ~PAGE_MASK))
+			info->limit =3D maxlim >> PAGE_SHIFT;
+		else
+			return LDT_handle_over_page_offset(ctx);
+	}
+	return 0;
+}
+
 #if TLS_SIZE !=3D 24
 # error update this code.
 #endif
@@ -117,6 +150,17 @@ static inline void load_LDT(mm_context_t
 	put_cpu();
 }
=20
+static inline unsigned get_user_ring(void)
+{
+	preempt_disable();
+	return unlikely(current->thread.multiring_mode) ? MULTIRING_USER_RING : U=
SER_RING;
+}
+
+static inline void put_user_ring(void)
+{
+	preempt_enable();
+}
+
 #endif /* !__ASSEMBLY__ */
=20
 #endif
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/asm-i386/fixmap.h linux-2.5.44_multiring/include/asm-i386/fixmap.h
--- linux-2.5.44/include/asm-i386/fixmap.h	2002-10-27 02:38:39.000000000 +0=
100
+++ linux-2.5.44_multiring/include/asm-i386/fixmap.h	2002-10-27 00:44:03.00=
0000000 +0200
@@ -48,6 +48,10 @@
  * future, say framebuffers for the console driver(s) could be
  * fix-mapped?
  */
+
+extern int __fix_idt_begin_should_have_been_optimized_away(void);
+extern int __fix_idt_end_should_have_been_optimized_away(void);
+
 enum fixed_addresses {
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
@@ -62,9 +66,15 @@ enum fixed_addresses {
 	FIX_LI_PCIA,	/* Lithium PCI Bridge A */
 	FIX_LI_PCIB,	/* Lithium PCI Bridge B */
 #endif
-#ifdef CONFIG_X86_F00F_BUG
-	FIX_F00F_IDT,	/* Virtual mapping for IDT */
+
+#if defined(CONFIG_X86_F00F_BUG) || defined(CONFIG_X86_HIGHIDT)
+	FIX_IDT_BEGIN, /* Virtual mapping for IDT */
+	FIX_IDT_END =3D FIX_IDT_BEGIN + NR_CPUS - 1,
+#else
+#define FIX_IDT_BEGIN __fix_idt_begin_should_have_been_optimized_away()
+#define FIX_IDT_END __fix_idt_end_should_have_been_optimized_away()=09
 #endif
+
 #ifdef CONFIG_X86_CYCLONE
 	FIX_CYCLONE_TIMER, /*cyclone timer register*/
 #endif=20
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/asm-i386/idt.h linux-2.5.44_multiring/include/asm-i386/idt.h
--- linux-2.5.44/include/asm-i386/idt.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.44_multiring/include/asm-i386/idt.h	2002-10-27 03:18:13.00000=
0000 +0100
@@ -0,0 +1,236 @@
+/*
+ * linux/include/asm-i386/multiring.h: multiring IDT inline functions
+ *
+ * Copyright (C) 2002 Luca Barbieri <ldb@ldb.ods.org>
+ */
+
+#ifndef __i386_IDT_H
+#define __i386_IDT_H
+
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/gfp.h>
+#include <linux/smp.h>
+#include <linux/highmem.h>
+#include <asm/atomic.h>
+#include <linux/spinlock.h>
+
+#include <asm/desc.h>
+#include <asm/segment.h>
+#include <asm/mmu.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/tlb.h>
+
+#ifdef CONFIG_X86_HIGHIDT
+#define use_highidt 1
+#else
+#define use_highidt 0
+#endif
+
+#ifdef CONFIG_X86_F00F_BUG
+#define cpu_has_f00f_bug boot_cpu_data.f00f_bug
+#else
+#define cpu_has_f00f_bug 0
+#endif
+
+extern pte_t* idt_pte;
+extern unsigned idt_prot;
+extern pte_t idt_table_pte;
+
+/* access to idt_refcnt */
+static inline struct desc_struct* kmap_idt(mm_context_t* ctx)
+{
+	if(use_highidt)
+	{
+		if(!cpu_has_f00f_bug)
+		{
+			unsigned cpu =3D get_cpu();
+			return (struct desc_struct*)__fix_to_virt(FIX_IDT_BEGIN + cpu);
+		}
+		else
+		{
+			/* we need to kmap because the window is read-only */
+			return kmap(ctx->idt.page);
+		}
+	}
+	return ctx->idt.addr;=09
+}
+
+static inline rwlock_t* idt_lock(struct desc_struct* idt)
+{
+	return (rwlock_t*)((char*)idt + IDT_SIZE);
+}
+
+/* read access */
+static inline struct desc_struct* kmap_read_idt(mm_context_t* ctx)
+{
+	struct desc_struct* idt =3D kmap_idt(ctx);
+	read_lock(idt_lock(idt));
+	return idt;
+}
+
+/* write access */
+static inline struct desc_struct* kmap_write_idt(mm_context_t* ctx)
+{
+	struct desc_struct* idt =3D kmap_idt(ctx);
+	write_lock(idt_lock(idt));
+	return idt;=09
+}
+
+static inline struct desc_struct* kmap_read_idt_or_table(mm_context_t* ctx=
)
+{
+	if(current->thread.multiring_mode)
+		return kmap_read_idt(ctx);
+	else
+		return idt_table;
+}
+
+static inline void kunmap_idt(mm_context_t* ctx, struct desc_struct* idt)
+{
+	if(use_highidt)
+	{
+		if(!cpu_has_f00f_bug)
+			put_cpu();
+		else
+			kunmap(ctx->idt.page);
+	}
+}
+
+static inline void kunmap_read_idt(mm_context_t* ctx, struct desc_struct* =
idt)
+{
+	read_unlock(idt_lock(idt));
+	kunmap_idt(ctx, idt);
+}
+
+static inline void kunmap_write_idt(mm_context_t* ctx, struct desc_struct*=
 idt)
+{
+	write_unlock(idt_lock(idt));
+	kunmap_idt(ctx, idt);
+}
+
+static inline void kunmap_read_idt_or_table(mm_context_t* ctx, struct desc=
_struct* idt)
+{
+	if(idt !=3D idt_table)
+		return kunmap_read_idt(ctx, idt);
+}
+
+static inline void load_idt_table(unsigned cpu)
+{
+	if(use_highidt || cpu_has_f00f_bug)
+	{
+		set_pte(idt_pte - cpu, idt_table_pte);
+		__flush_tlb_one(__fix_to_virt(FIX_IDT_BEGIN + cpu));
+	}
+	else
+		__asm__ __volatile__("lidt %0": "=3Dm" (idt_descr));
+}
+
+static inline void change_gdt_ring(unsigned cpu, unsigned ring)
+{
+	cpu_gdt_table[cpu][GDT_ENTRY_DEFAULT_USER_CS].b =3D USER_CSDS_B(0, ring);
+	cpu_gdt_table[cpu][GDT_ENTRY_DEFAULT_USER_DS].b =3D USER_CSDS_B(1, ring);
+}
+
+extern void multiring_init_task(task_t* tsk);
+
+static inline void load_IDT_nolock_inline(task_t* tsk, mm_context_t* ctx, =
unsigned cpu)
+{
+	if(!ctx->idt.opaque)
+	{
+		load_idt_table(cpu);
+		change_gdt_ring(cpu, 3);
+		return;
+	}
+
+	change_gdt_ring(cpu, MULTIRING_USER_RING);
+	if(use_highidt || cpu_has_f00f_bug)
+	{
+		set_pte(idt_pte - cpu, cpu_has_f00f_bug ? pfn_pte(__pa(ctx->idt.addr) >>=
 PAGE_SHIFT, PAGE_KERNEL_RO) : mk_pte(ctx->idt.page, PAGE_KERNEL));
+		__flush_tlb_one(__fix_to_virt(FIX_IDT_BEGIN + cpu));
+	}
+	else
+	{
+		struct Xgt_desc_struct map_idt_descr;
+		map_idt_descr.size =3D IDT_SIZE - 1;
+		map_idt_descr.address =3D (unsigned long)ctx->idt.addr;
+		__asm__ __volatile__("lidt %0": "=3Dm" (map_idt_descr));
+	}
+	if(unlikely(!tsk->thread.multiring_mode))
+	{
+		multiring_init_task(tsk);
+		tsk->thread.multiring_mode =3D 1;
+	}
+}
+
+static inline void load_IDT_inline(task_t* tsk, mm_context_t* ctx)
+{
+	unsigned cpu =3D get_cpu();
+	load_IDT_nolock_inline(tsk, ctx, cpu);
+	put_cpu();
+}
+
+extern void load_IDT_nolock(mm_context_t* ctx, unsigned cpu);
+
+static inline void load_IDT(mm_context_t* ctx)
+{
+	unsigned cpu =3D get_cpu();
+	load_IDT_nolock(ctx, cpu);
+	put_cpu();
+}
+
+static inline atomic_t* idt_refcnt(struct desc_struct* idt)
+{
+	return (atomic_t*)((char*)idt + IDT_SIZE + sizeof(spinlock_t));
+}
+
+static inline struct desc_struct* __alloc_idt(union idt* idtu)
+{
+	if(use_highidt)
+	{
+		/* Use high memory */
+		idtu->page =3D alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
+		return (struct desc_struct*)kmap(idtu->page);
+	}
+	else
+	{
+		/* TODO: use an aligned 2KB allocator instead */
+		return idtu->addr =3D (struct desc_struct*)__get_free_page(GFP_KERNEL);
+	}
+}
+
+static inline struct desc_struct* alloc_idt(union idt* idtu)
+{
+	struct desc_struct* idt =3D __alloc_idt(idtu);
+	if(idt)
+	{
+		*idt_lock(idt) =3D RW_LOCK_UNLOCKED;
+		atomic_set(idt_refcnt(idt), 1);
+	}
+	return idt;
+}
+
+static inline void kunmap_new_idt(union idt* idtu, struct desc_struct* idt=
)
+{
+	if(use_highidt)
+		kunmap(idtu->page);
+}
+
+static inline void __free_idt(mm_context_t* ctx)
+{
+	if(use_highidt)
+		__free_page(ctx->idt.page);
+	else
+		free_page((unsigned long)ctx->idt.addr);
+}
+
+static inline void free_idt(mm_context_t* ctx)
+{
+	struct desc_struct* idt =3D kmap_idt(ctx);
+	int free =3D atomic_dec_and_test(idt_refcnt(idt));
+	kunmap_idt(ctx, idt);
+	if(free)
+		__free_idt(ctx);
+}
+
+#endif
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/asm-i386/ldt.h linux-2.5.44_multiring/include/asm-i386/ldt.h
--- linux-2.5.44/include/asm-i386/ldt.h	2002-10-27 02:38:39.000000000 +0100
+++ linux-2.5.44_multiring/include/asm-i386/ldt.h	2002-10-27 00:44:03.00000=
0000 +0200
@@ -22,6 +22,9 @@ struct user_desc {
 	unsigned int  limit_in_pages:1;
 	unsigned int  seg_not_present:1;
 	unsigned int  useable:1;
+
+	/* has effect only in multiring mode, but is returned in any mode */
+	unsigned int  dpl:2;=20
 };
=20
 #define MODIFY_LDT_CONTENTS_DATA	0
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/asm-i386/mmu_context.h linux-2.5.44_multiring/include/asm-i386/mmu_conte=
xt.h
--- linux-2.5.44/include/asm-i386/mmu_context.h	2002-10-27 02:38:39.0000000=
00 +0100
+++ linux-2.5.44_multiring/include/asm-i386/mmu_context.h	2002-10-27 03:13:=
34.000000000 +0100
@@ -6,12 +6,15 @@
 #include <asm/atomic.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <asm/idt.h>
=20
 /*
  * possibly do the LDT unload here?
  */
 #define destroy_context(mm)		do { } while(0)
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+int init_new_context_flags(struct task_struct *tsk, struct mm_struct *mm, =
unsigned flags);
+#define init_new_context_flags init_new_context_flags
+#define init_new_context(tsk, mm) init_new_context_flags(tsk, mm, 0)
=20
 #ifdef CONFIG_SMP
=20
@@ -45,6 +48,9 @@ static inline void switch_mm(struct mm_s
 		 */
 		if (unlikely(prev->context.ldt !=3D next->context.ldt))
 			load_LDT_nolock(&next->context, cpu);
+
+		if (unlikely(prev->context.idt.opaque !=3D next->context.idt.opaque))
+			load_IDT_nolock_inline(tsk, &next->context, cpu);
 	}
 #ifdef CONFIG_SMP
 	else {
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/asm-i386/mmu.h linux-2.5.44_multiring/include/asm-i386/mmu.h
--- linux-2.5.44/include/asm-i386/mmu.h	2002-10-27 02:38:39.000000000 +0100
+++ linux-2.5.44_multiring/include/asm-i386/mmu.h	2002-10-27 00:44:03.00000=
0000 +0200
@@ -7,10 +7,20 @@
  *
  * cpu_vm_mask is used to optimize ldt flushing.
  */
+
+union idt
+{
+	struct desc_struct* addr;
+	struct page* page;
+	unsigned long opaque;
+};
+
 typedef struct {=20
 	int size;
 	struct semaphore sem;
 	void *ldt;
+	union idt idt;
+	unsigned char bad_segments;
 } mm_context_t;
=20
 #endif
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/asm-i386/multiring.h linux-2.5.44_multiring/include/asm-i386/multiring.h
--- linux-2.5.44/include/asm-i386/multiring.h	1970-01-01 01:00:00.000000000=
 +0100
+++ linux-2.5.44_multiring/include/asm-i386/multiring.h	2002-10-27 00:44:03=
.000000000 +0200
@@ -0,0 +1,194 @@
+/*
+ * linux/include/asm-i386/multiring.h: header for multiple privilege rings=
 support (available to user-mode)
+ *
+ * Copyright (C) 2002 Luca Barbieri <ldb@ldb.ods.org>
+ */
+
+#ifndef __i386_MULTIRING_H
+#define __i386_MULTIRING_H
+
+#define MULTIRING_CHECK    0
+
+#define MULTIRING_GET_ESPSS 1
+#define MULTIRING_SET_ESPSS 2
+
+#define MULTIRING_GET      3
+#define MULTIRING_GET_RANGE 4
+
+#define MULTIRING_ELEVATE  5
+#define MULTIRING_SET      6
+#define MULTIRING_COPY     7
+#define MULTIRING_LAST_OP  7
+
+#define MULTIRING_VEC_FREE ((unsigned char)~0)
+
+#ifdef __KERNEL__
+#define multiring_gate desc_struct
+#else
+struct multiring_gate
+{
+	unsigned long a;
+	unsigned long b;=09
+};
+#endif
+
+#ifndef __KERNEL__
+#ifndef MULTIRING_NO_SYSCALLS
+#ifndef _syscall1
+#include <asm/unistd.h>
+#endif
+
+#define __NR_multiring0 __NR_multiring
+#define __NR_multiring1 __NR_multiring
+#define __NR_multiring2 __NR_multiring
+#define __NR_multiring3 __NR_multiring
+
+_syscall1(int, multiring0, unsigned, op);
+_syscall2(int, multiring1, unsigned, op, unsigned long, arg1);
+_syscall3(int, multiring2, unsigned, op, unsigned long, arg1, unsigned lon=
g, arg2);
+_syscall4(int, multiring3, unsigned, op, unsigned long, arg1, unsigned lon=
g, arg2, unsigned long, arg3);
+#endif
+
+#ifndef MULTIRING_NO_HELPERS
+/*
+  Check whether the program is in multiring mode.
+
+  Return value:
+  0: multiring mode
+  1: normal mode
+  -1/EPERM: normal mode; can't enter multiring mode due to a bad segment
+*/
+static inline int multiring_check()
+{
+	return multiring0(MULTIRING_CHECK);
+}
+
+/* Enters multiring mode.
+   This fails if you have previously set up a "bad segment" with modify_ld=
t, set_thread_area or CLONE_SETTLS.
+   A bad segment is a segment that either starts in the kernel memory regi=
on or has a limit expressed in pages, with a value that causes it to contai=
n the kernel region and with a non-page-aligned base address.
+
+   This will cause the process to get a private IDT that starts as a copy =
of the global one, but with the SYSCALL_VECTOR DPL set to 1.
+   Multiring processes also have the DPL on the GDT CS and DS descriptors =
set to 1.
+   Upon return, in all threads, cs/ds/es/ss/fs/gs selectors pointing to th=
e default CS/DS will be changed to have RPL=3D1.
+
+   Return value:
+   0: success
+   -1/EPERM: can't enter multiring mode due to a bad segment
+   -1/ENOMEM: couldn't allocate the IDT
+*/
+static inline int multiring_elevate()
+{
+	return multiring0(MULTIRING_ELEVATE);
+}
+
+/*
+  Return TSS ESP/SS value for a privilege ring
+ =20
+  Parameters:
+  ring: privilege ring whose tss esp/ss you want to get
+  esp: pointer to returned tss esp value
+  ss: pointer to returned tss ss value
+*/
+static inline int multiring_get_espss(unsigned ring, unsigned* esp, unsign=
ed* ss)
+{
+	return multiring3(MULTIRING_GET_ESPSS, ring, (unsigned long)esp, (unsigne=
d long)ss);
+}
+
+/*
+  Set TSS ESP/SS value for a privilege ring
+  Note: while multiring mode is currently not needed to do this, you shoul=
dn't rely on this.
+ =20
+  Parameters:
+  ring: privilege ring whose tss esp/ss you want to set
+  esp: new tss esp value
+  ss: new tss ss value - must have RPL =3D=3D ring
+*/
+static inline int multiring_set_espss(unsigned ring, unsigned esp, unsigne=
d ss)
+{
+	return multiring3(MULTIRING_SET_ESPSS, ring, esp, ss);
+}
+
+/*
+  Get a single interrupt gate.
+
+  Parameters:
+  vec: vector number
+  gate: pointer to returned multiring_gate
+*/
+static inline int multiring_get(unsigned vec, struct multiring_gate* gate)
+{
+	return multiring2(MULTIRING_GET, vec, (unsigned long)gate);
+}
+
+/*
+  Get a range of interrupt gates.
+
+  Parameters:
+  first: first vector number
+  last: last vector numer
+  gates: pointer to returned multiring_gate structs (size must be >=3D (la=
st - first + 1) * sizeof(struct multiring_gate))
+*/
+static inline int multiring_get_range(unsigned first, unsigned last, struc=
t multiring_gate* gates)
+{
+	return multiring3(MULTIRING_GET_RANGE, first, last, (unsigned long)gates)=
;
+}
+
+/*
+  Set an interrupt gate.
+
+  Parameters:
+  vec: vector number or MULTIRING_VEC_FREE to get a free one (or ENOSPC if=
 none found)
+  a: first 32-bit word of interrupt gate
+  b: second 32-bit word of interrupt gate
+
+  Return value:
+  >=3D 0: success, return value is vector number
+  -1/EPERM: you tried to set an unmodifiable vector or to create a gate to=
 a non-syscall RPL 0 address or there was an another permission denied erro=
r
+  -1/ENXIO: you weren't in multiring mode =20
+  -1/EINVAL: you tried to create a task/interrupt gate, a DPL 0 gate, a ga=
te with reserved regions with wrong value, or something else considered inv=
alid/not supported
+  -1/ENOSPC: you specified MULTIRING_VEC_FREE but there was no available f=
ree vector
+*/
+static inline int multiring_set(unsigned vec, unsigned long a, unsigned lo=
ng b)
+{
+	return multiring3(MULTIRING_SET, vec, a, b);
+}
+
+/* like multiring_set with vec=3DMULTIRING_VEC_FREE */
+static inline int multiring_set_free(unsigned long a, unsigned long b)
+{
+	return multiring_set(MULTIRING_VEC_FREE, a, b);
+}
+
+/* like multiring_set with a=3D0 b=3D0 */
+static inline int multiring_free(unsigned vec)
+{
+	return multiring_set(vec, 0, 0);
+}
+
+/*
+  Set an interrupt gate based on another one
+ =20
+  Parameters:
+  vec: vector number or MULTIRING_VEC_FREE to get a free one (or ENOSPC if=
 none found)
+  from: vector number to copy from
+
+  Return value:
+  >=3D 0: success, return value is vector number
+  -1/ENXIO: you weren't in multiring mode =20
+  -1/EPERM: you tried to set an unmodifiable vector or to create a gate to=
 a non-syscall RPL 0 address or there was an another permission denied erro=
r
+  -1/ENOSPC: you specified MULTIRING_VEC_FREE but there was no available f=
ree vector
+*/
+static inline int multiring_copy(unsigned vec, unsigned from)
+{
+	return multiring2(MULTIRING_COPY, vec, from);
+}
+
+/* like multiring_copy with vec=3DMULTIRING_VEC_FREE */
+static inline int multiring_copy_free(unsigned from)
+{
+	return multiring_copy(MULTIRING_VEC_FREE, from);
+}
+
+#endif
+#endif
+#endif
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/asm-i386/processor.h linux-2.5.44_multiring/include/asm-i386/processor.h
--- linux-2.5.44/include/asm-i386/processor.h	2002-10-27 02:38:39.000000000=
 +0100
+++ linux-2.5.44_multiring/include/asm-i386/processor.h	2002-10-27 00:44:04=
.000000000 +0200
@@ -332,14 +332,17 @@ typedef struct {
 	unsigned long seg;
 } mm_segment_t;
=20
+struct espss
+{
+	unsigned long esp;
+	unsigned long ss;
+};
+
 struct tss_struct {
 	unsigned short	back_link,__blh;
 	unsigned long	esp0;
 	unsigned short	ss0,__ss0h;
-	unsigned long	esp1;
-	unsigned short	ss1,__ss1h;
-	unsigned long	esp2;
-	unsigned short	ss2,__ss2h;
+	struct espss espss12[2];
 	unsigned long	__cr3;
 	unsigned long	eip;
 	unsigned long	eflags;
@@ -367,10 +370,12 @@ struct thread_struct {
 /* cached TLS descriptors. */
 	struct desc_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
 	unsigned long	esp0;
+	struct espss espss12[2];
 	unsigned long	eip;
 	unsigned long	esp;
 	unsigned long	fs;
 	unsigned long	gs;
+	unsigned char	multiring_mode;=09
 /* Hardware debugging registers */
 	unsigned long	debugreg[8];  /* %%db0-7 debug registers */
 /* fault info */
@@ -388,7 +393,8 @@ struct thread_struct {
 #define INIT_THREAD  {						\
 	{ { 0, 0 } , },						\
 	0,							\
-	0, 0, 0, 0, 						\
+	{ {0, 0}, {0, 0} },					\
+	0, 0, 0, 0, 0, 						\
 	{ [0 ... 7] =3D 0 },	/* debugging registers */	\
 	0, 0, 0,						\
 	{ { 0, }, },		/* 387 state */			\
@@ -400,7 +406,7 @@ struct thread_struct {
 	0,0, /* back_link, __blh */				\
 	sizeof(init_stack) + (long) &init_stack, /* esp0 */	\
 	__KERNEL_DS, 0, /* ss0 */				\
-	0,0,0,0,0,0, /* stack1, stack2 */			\
+	{ {0, 0}, {0, 0} }, /* stack1, stack2 */			\
 	0, /* cr3 */						\
 	0,0, /* eip,eflags */					\
 	0,0,0,0, /* eax,ecx,edx,ebx */				\
@@ -415,10 +421,10 @@ struct thread_struct {
 #define start_thread(regs, new_eip, new_esp) do {		\
 	__asm__("movl %0,%%fs ; movl %0,%%gs": :"r" (0));	\
 	set_fs(USER_DS);					\
-	regs->xds =3D __USER_DS;					\
-	regs->xes =3D __USER_DS;					\
-	regs->xss =3D __USER_DS;					\
-	regs->xcs =3D __USER_CS;					\
+	regs->xds =3D USER_DS_RPL(USER_RING);					\
+	regs->xes =3D USER_DS_RPL(USER_RING);					\
+	regs->xss =3D USER_DS_RPL(USER_RING);					\
+	regs->xcs =3D USER_CS_RPL(USER_RING);					\
 	regs->eip =3D new_eip;					\
 	regs->esp =3D new_esp;					\
 } while (0)
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/asm-i386/segment.h linux-2.5.44_multiring/include/asm-i386/segment.h
--- linux-2.5.44/include/asm-i386/segment.h	2002-10-27 02:38:39.000000000 +=
0100
+++ linux-2.5.44_multiring/include/asm-i386/segment.h	2002-10-27 00:44:04.0=
00000000 +0200
@@ -1,6 +1,12 @@
 #ifndef _ASM_SEGMENT_H
 #define _ASM_SEGMENT_H
=20
+/* The default user privilege level */
+#define USER_RING 3
+
+/* The multiring most privileged user level */
+#define MULTIRING_USER_RING 1
+
 /*
  * The layout of the per-CPU GDT under Linux:
  *
@@ -43,10 +49,10 @@
 #define TLS_SIZE (GDT_ENTRY_TLS_ENTRIES * 8)
=20
 #define GDT_ENTRY_DEFAULT_USER_CS	4
-#define __USER_CS (GDT_ENTRY_DEFAULT_USER_CS * 8 + 3)
+#define USER_CS_RPL(ring) (GDT_ENTRY_DEFAULT_USER_CS * 8 + (ring))
=20
 #define GDT_ENTRY_DEFAULT_USER_DS	5
-#define __USER_DS (GDT_ENTRY_DEFAULT_USER_DS * 8 + 3)
+#define USER_DS_RPL(ring) (GDT_ENTRY_DEFAULT_USER_DS * 8 + (ring))
=20
 #define GDT_ENTRY_KERNEL_BASE	12
=20
@@ -76,4 +82,6 @@
  */
 #define IDT_ENTRIES 256
=20
+#define IDT_SIZE (IDT_ENTRIES * 8)
+
 #endif
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/asm-i386/system.h linux-2.5.44_multiring/include/asm-i386/system.h
--- linux-2.5.44/include/asm-i386/system.h	2002-10-27 02:38:39.000000000 +0=
100
+++ linux-2.5.44_multiring/include/asm-i386/system.h	2002-10-27 00:44:04.00=
0000000 +0200
@@ -95,6 +95,12 @@ static inline unsigned long _get_base(ch
 		: :"m" (*(unsigned int *)&(value)))
=20
 /*
+ * Save a segment.
+ */
+#define savesegment(seg,value) \
+	asm volatile("movl %%" #seg ",%0":"=3Dm" (*(int *)&(value)))
+
+/*
  * Clear and set 'TS' bit respectively
  */
 #define clts() __asm__ __volatile__ ("clts")
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/asm-i386/unistd.h linux-2.5.44_multiring/include/asm-i386/unistd.h
--- linux-2.5.44/include/asm-i386/unistd.h	2002-10-27 02:38:39.000000000 +0=
100
+++ linux-2.5.44_multiring/include/asm-i386/unistd.h	2002-10-27 00:44:04.00=
0000000 +0200
@@ -258,6 +258,7 @@
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
+#define __NR_multiring		254
  =20
=20
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/er=
rno.h> */
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/inclu=
de/linux/sched.h linux-2.5.44_multiring/include/linux/sched.h
--- linux-2.5.44/include/linux/sched.h	2002-10-27 02:38:39.000000000 +0100
+++ linux-2.5.44_multiring/include/linux/sched.h	2002-10-27 02:36:47.000000=
000 +0200
@@ -51,6 +51,14 @@ struct exec_domain;
 #define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
 #define CLONE_CLEARTID	0x00200000	/* clear the userspace TID */
 #define CLONE_DETACHED	0x00400000	/* parent wants no child-exit signal */
+#ifdef __i386__
+#define CLONE_IDT	0x00800000	/* set if IDT is shared between processes (no=
te: CLONE_VM implies CLONE_IDT) */
+#define CLONE_CLEAR_IDT	0x01000000	/* set to clear the IDT */
+#define CLONE_EXEC CLONE_CLEAR_IDT
+#else
+#define CLONE_EXEC 0
+#endif
+
=20
 /*
  * List of flags we want to share for kernel threads,
diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.44/kerne=
l/fork.c linux-2.5.44_multiring/kernel/fork.c
--- linux-2.5.44/kernel/fork.c	2002-10-27 02:38:39.000000000 +0100
+++ linux-2.5.44_multiring/kernel/fork.c	2002-10-27 00:44:04.000000000 +020=
0
@@ -435,7 +435,11 @@ static int copy_mm(unsigned long clone_f
 	if (!mm_init(mm))
 		goto fail_nomem;
=20
-	if (init_new_context(tsk,mm))
+#ifdef init_new_context_flags
+	if (init_new_context_flags(tsk, mm, clone_flags))
+#else
+	if (init_new_context(tsk, mm))
+#endif	=09
 		goto free_pt;
=20
 	down_write(&oldmm->mmap_sem);


--=-5CIh2s5zCzzNyZ4Fh2F+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA9u1Ptdjkty3ft5+cRAvl5AJ9WyR1KPICG3x1nxhD8vsZliHyh7wCdHhnj
FBriHOu32Gsl0l54GL/4ZPQ=
=U9je
-----END PGP SIGNATURE-----

--=-5CIh2s5zCzzNyZ4Fh2F+--
