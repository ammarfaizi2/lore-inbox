Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUELVqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUELVqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUELVqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:46:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:18663 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261711AbUELVlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:41:19 -0400
Date: Wed, 12 May 2004 14:32:33 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: drepper@redhat.com, fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm <akpm@osdl.org>
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
Message-Id: <20040512143233.0ee0405a.rddunlap@osdl.org>
In-Reply-To: <m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
References: <20040511212625.28ac33ef.rddunlap@osdl.org>
	<40A1AF53.3010407@redhat.com>
	<m13c66qicb.fsf@ebiederm.dsl.xmission.com>
	<40A243C8.401@redhat.com>
	<m1brktod3f.fsf@ebiederm.dsl.xmission.com>
	<40A2517C.4040903@redhat.com>
	<m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 May 2004 10:57:27 -0600 Eric W. Biederman wrote:

| Ulrich Drepper <drepper@redhat.com> writes:
| 
| > Eric W. Biederman wrote:
| > 
| > > As a first draft we should be able to use the standard ELF mechanisms
| > > for this.  It is not like PIC shared libraries were new.   Or is
| > > there some specific problem you are thinking of with respect to
| > > randomization?
| > 
| > The official kernel does not have vdso randomization.  Ingo has a patch
| > for the Red Hat kernel which is used in the FC2 kernel.  The patch
| > effectively only changes the location at which the vdso is mapped.  It
| > does not change the vdso content.  So the __kernel_vsyscall symbol in
| > the vdso's symbol table is not changed.

[1:]
| > AT_SYSINFO is the right way to go forward but it is not directly
| > accessible to userlevel code.  And it is no pointer which will make
| > architectures with function descriptors unhappy.
| 
| It sounds like the vdso just needs to be treated as a prelinked
| vdso.  You can find everything you need with AT_SYSINFO_EHDR.
| 
| In the case of function descriptors they should be in a data segment
| that can get copied to another page, and corrected.  Leaving the code
| segment at it's randomized location.

Andrew tells me that he is OK with reserving a syscall number for
kexec, which is easy & quick.  I don't know when vdso will be available
(for non-x86[2]) or when the AT_SYSINFO data will work for userlevel
code[1. above].

So is there any reason not to reserve the syscall number for kexec
for now?  (patch is below)

--
~Randy


[2] kexec is currently only available for x86, but there is interest
in it for ia64 and ppc64 at least.



diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/arch/i386/kernel/entry.S linux-266-kexec/arch/i386/kernel/entry.S
--- linux-266-pv/arch/i386/kernel/entry.S	2004-05-09 19:32:26.000000000 -0700
+++ linux-266-kexec/arch/i386/kernel/entry.S	2004-05-11 16:46:27.000000000 -0700
@@ -891,5 +891,6 @@ ENTRY(sys_call_table)
 	.long sys_mq_timedreceive	/* 280 */
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
+	.long sys_ni_syscall		/* reserved for kexec */
 
 syscall_table_size=(.-sys_call_table)
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/include/asm-i386/unistd.h linux-266-kexec/include/asm-i386/unistd.h
--- linux-266-pv/include/asm-i386/unistd.h	2004-05-09 19:32:52.000000000 -0700
+++ linux-266-kexec/include/asm-i386/unistd.h	2004-05-11 16:45:32.000000000 -0700
@@ -288,8 +288,9 @@
 #define __NR_mq_timedreceive	(__NR_mq_open+3)
 #define __NR_mq_notify		(__NR_mq_open+4)
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
+#define __NR_sys_kexec_load	283
 
-#define NR_syscalls 283
+#define NR_syscalls 284
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
