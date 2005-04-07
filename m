Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVDGLKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVDGLKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 07:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVDGLKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 07:10:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:46780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262409AbVDGLKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 07:10:22 -0400
Date: Thu, 7 Apr 2005 04:10:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: stsp@aknet.ru, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       VANDROVE@vc.cvut.cz
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-Id: <20050407041006.4c9db8b2.akpm@osdl.org>
In-Reply-To: <20050407080004.GA27252@elte.hu>
References: <20050405065544.GA21360@elte.hu>
	<4252E2C9.9040809@aknet.ru>
	<Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org>
	<4252EA01.7000805@aknet.ru>
	<Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org>
	<425403F6.409@aknet.ru>
	<20050407080004.GA27252@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> --- linux/arch/i386/kernel/entry.S.orig
>  +++ linux/arch/i386/kernel/entry.S
>  @@ -179,12 +179,17 @@ need_resched:
>   ENTRY(sysenter_entry)
>   	movl TSS_sysenter_esp0(%esp),%esp
>   sysenter_past_esp:
>  -	sti
>  +	#
>  +	# irqs are disabled: set up an entry stackframe without
>  +	# allowing irqs to potentially preempt us with an
>  +	# incomplete entry frame!
>  +	#
>   	pushl $(__USER_DS)
>   	pushl %ebp
>   	pushfl
>   	pushl $(__USER_CS)
>   	pushl $SYSENTER_RETURN
>  +	sti
>   

Well that bites the big one.


Program received signal SIGTRAP, Trace/breakpoint trap.
0xc015c4ba in __find_get_block (bdev=0xc18cd988, block=2818614, size=4096) at fs/buffer.c:1371
1371            BUG_ON(irqs_disabled());
(gdb) t
[Current thread is 0 (Thread 32768)]
(gdb) bt
#0  0xc015c4ba in __find_get_block (bdev=0xc18cd988, block=2818614, size=4096) at fs/buffer.c:1371
#1  0xc015c57b in __getblk (bdev=0xc18cd988, block=2818614, size=4096) at fs/buffer.c:1487
#2  0xc0199978 in ext3_getblk (handle=0x0, inode=0xcff2a2b4, block=1, create=0, errp=0xcdf61dbc) at include/linux/buffer_head.h:260
#3  0xc019d5a6 in ext3_find_entry (dentry=0xcdaef8d4, res_dir=0xcdf61dfc) at fs/ext3/namei.c:868
#4  0xc019d9ca in ext3_lookup (dir=0x1, dentry=0xcdaef8d4, nd=0xcdf61f58) at fs/ext3/namei.c:988
#5  0xc0166b2d in real_lookup (parent=0xcdaef8d4, name=0xcdf61e8c, nd=0xcdf61f58) at fs/namei.c:416
#6  0xc0166df3 in do_lookup (nd=0xcdf61f58, name=0xcdf61e8c, path=0xcdf61e84) at fs/namei.c:670
#7  0xc0167667 in __link_path_walk (name=0xcdd24011 "", nd=0xcdf61f58) at fs/namei.c:833
#8  0xc0167c28 in link_path_walk (name=0xcdd24000 "/lib/libpcre.so.0", nd=0xcdf61f58) at fs/namei.c:911
#9  0xc0168056 in path_lookup (name=0xcdd24000 "/lib/libpcre.so.0", flags=0, nd=0xcdf61f58) at fs/namei.c:1026
#10 0xc016877d in open_namei (pathname=0xcdd24000 "/lib/libpcre.so.0", flag=1, mode=-1208907480, nd=0xcdf61f58) at fs/namei.c:1420
#11 0xc0159256 in filp_open (filename=0xcdd24000 "/lib/libpcre.so.0", flags=0, mode=-1208907480) at fs/open.c:764
#12 0xc01595e6 in sys_open (filename=0x1 <Address 0x1 out of bounds>, flags=1, mode=1) at fs/open.c:946
#13 0xc0102e91 in syscall_call () at arch/i386/kernel/semaphore.c:177
#14 0xb7f22c8a in ?? ()

Is someone doing a syscall with irqs disabled, or what?

This fixes it...



--- 25/arch/i386/kernel/entry.S~sysenter-irq-atomicity-fix-fix	2005-04-07 04:03:07.000000000 -0700
+++ 25-akpm/arch/i386/kernel/entry.S	2005-04-07 04:05:47.000000000 -0700
@@ -187,6 +187,7 @@ sysenter_past_esp:
 	pushl $(__USER_DS)
 	pushl %ebp
 	pushfl
+	orl   $0x200,0(%esp)
 	pushl $(__USER_CS)
 	pushl $SYSENTER_RETURN
 	sti
_

