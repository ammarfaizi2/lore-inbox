Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVDKRPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVDKRPI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 13:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVDKRPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 13:15:08 -0400
Received: from mail.aknet.ru ([217.67.122.194]:527 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261830AbVDKROu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 13:14:50 -0400
Message-ID: <425AB094.6060807@aknet.ru>
Date: Mon, 11 Apr 2005 21:15:00 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       VANDROVE@vc.cvut.cz
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
References: <20050405065544.GA21360@elte.hu>	<4252E2C9.9040809@aknet.ru>	<Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org>	<4252EA01.7000805@aknet.ru>	<Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org>	<425403F6.409@aknet.ru>	<20050407080004.GA27252@elte.hu>	<42555BBF.6090704@aknet.ru>	<Pine.LNX.4.58.0504070930190.28951@ppc970.osdl.org>	<425563D6.30108@aknet.ru>	<Pine.LNX.4.58.0504070951570.28951@ppc970.osdl.org>	<42592813.5020005@aknet.ru> <20050410153228.1452365a.akpm@osdl.org>
In-Reply-To: <20050410153228.1452365a.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070508050908040803070601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070508050908040803070601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Andrew Morton wrote:
> This is utterly obscure - it needs a comment so that readers know what that
> "- 8" is doing there.
Yes, that was only an RFC thing.
And now since there were not too much
of an FC, I prepared the "polished"
version. But apparently you already
released -mm3:)

Well, at least you can still apply the
comments if you feel like that. Here
they are.

Signed-off-by: Stas Sergeev <stsp@aknet.ru> 


--------------070508050908040803070601
Content-Type: text/x-patch;
 name="esp0fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="esp0fix.diff"

--- linux-2.6.12-rc2/arch/i386/kernel/entry.S	2005-04-06 09:34:35.000000000 +0400
+++ linux/arch/i386/kernel/entry.S	2005-04-11 10:49:28.000000000 +0400
@@ -245,6 +245,9 @@
 
 restore_all:
 	movl EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
+	# Warning: OLDSS(%esp) contains the wrong/random values if we
+	# are returning to the kernel.
+	# See comments in process.c:copy_thread() for details.
 	movb OLDSS(%esp), %ah
 	movb CS(%esp), %al
 	andl $(VM_MASK | (4 << 8) | 3), %eax
--- linux-2.6.12-rc2/arch/i386/kernel/process.c	2005-04-06 09:34:35.000000000 +0400
+++ linux/arch/i386/kernel/process.c	2005-04-11 10:30:39.000000000 +0400
@@ -394,6 +394,16 @@
 	childregs->esp = esp;
 
 	p->thread.esp = (unsigned long) childregs;
+	/*
+	 * The below -8 is to reserve 8 bytes on top of the ring0 stack.
+	 * This is necessary to guarantee that the entire "struct pt_regs"
+	 * is accessable even if the CPU haven't stored the SS/ESP registers
+	 * on the stack (interrupt gate does not save these registers
+	 * when switching to the same priv ring).
+	 * Therefore beware: accessing the xss/esp fields of the
+	 * "struct pt_regs" is possible, but they may contain the
+	 * completely wrong values.
+	 */
 	p->thread.esp0 = (unsigned long) (childregs+1) - 8;
 
 	p->thread.eip = (unsigned long) ret_from_fork;

--------------070508050908040803070601--
