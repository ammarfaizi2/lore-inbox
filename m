Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936685AbWLCIuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936685AbWLCIuP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 03:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936686AbWLCIuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 03:50:15 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:29842 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S936685AbWLCIuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 03:50:13 -0500
Date: Sun, 3 Dec 2006 03:43:23 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: kernel NULL pointer deref in pipe() - hotplug in
  initramfs
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200612030346_MC3-1-D3B9-C8E8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <45721258.1070802@tls.msk.ru>

On Sun, 03 Dec 2006 02:55:04 +0300, Michael Tokarev wrote:

> When /sbin/hotplug is present in initramfs, and it's a shell
> script, kernel OOPSes on every hotplug invocation.

Does this mean that if it's _not_ a shell script everything
is fine?

----------------------
<4> <1>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000014
<1> printing eip:
<4>c015c80a
<1>*pde = 00000000
<0>Oops: 0000 [#2]
<4>Modules linked in:
<0>CPU:    0
<0>EIP:    0060:[<c015c80a>]    Not tainted VLI
<0>EFLAGS: 00010282   (2.6.19-c3 #2.6.19.0)
<0>EIP is at create_write_pipe+0x1a/0x1c0
<0>eax: 00000000   ebx: bfb07cfc   ecx: 00000000   edx: c13915a0
<0>esi: cf739820   edi: ffffffff   ebp: c13a2fa8   esp: c13a2f40
<0>ds: 007b   es: 007b   ss: 0068
<0>Process hotplug (pid: 34, ti=c13a2000 task=c13915a0 task.ti=c13a2000)
<0>Stack: 00001fff c1382da0 c137fba0 c1387b7c 00000000 c12b2ce0 080dfd04 080dfd04
<0>       00000003 c015a27f 00000000 c1382da0 b7f64d30 00000004 c011412a 00000000
<0>       bfb07cfc 00000004 ffffffff c015cfde c137fba0 bfb07cfc 00000004 ffffffff
<0>Call Trace:
<0> [<c015cfde>] do_pipe+0xe/0xa0
<0> [<c0107cac>] sys_pipe+0xc/0x40
<0> [<c0102eb7>] syscall_call+0x7/0xb
<0> [<b7f6607d>] 0xb7f6607d
<0> =======================
<0>Code: 00 00 00 89 b3 74 01 00 00 89 d8 5b 5e c3 8d 76 00 57 56 53 83 ec 40 e8 35 bb ff ff 89 c6 85 c0 0f 84 7b 01 00 00 a1 c0 85 2d c0 <8b> 40 14 e8 de d0 00 00 89 c3 85 c0 0f 84 44 01 00 00 e8 8f ff
<0>EIP: [<c015c80a>] create_write_pipe+0x1a/0x1c0 SS:ESP 0068:c13a2f40
<4> <1>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000014
<1> printing eip:
----------------------

> (note also the formatting is a bit wrong here -- that <4> prefix in front of <1>BUG..)

Yeah, that's from the previous oops.  I don't know why bust_spinlocks() leaves
that hanging space, but it's been that way for a long time.

BTW did you hand-edit the kernel .version file? "(2.6.19-c3 #2.6.19.0)"
should not print unless you put that 2.6.19.0 there yourself.

> Are pipes disallowed in hotplug fired off initramfs?

AFAICT the pipe filesystem isn't registered yet, so probably not.

> (Even if they are, kernel probably still should not OOPS like that ;)

Either (a) pipefs should be registered early, or (b) the call should just
fail instead of oopsing. Untested patch for (b) below, can you test it?
(I'm not messing with the init sequence.)

> The error seems to be harmful however.  That is, hotplug script does not
> run, but the kernel continues running.

You mean harmless, right?


Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.19.0.2-32.orig/fs/pipe.c
+++ 2.6.19.0.2-32/fs/pipe.c
@@ -839,9 +839,11 @@ static struct dentry_operations pipefs_d
 
 static struct inode * get_pipe_inode(void)
 {
-	struct inode *inode = new_inode(pipe_mnt->mnt_sb);
+	struct inode *inode = NULL;
 	struct pipe_inode_info *pipe;
 
+	if (pipe_mnt)
+		inode = new_inode(pipe_mnt->mnt_sb);
 	if (!inode)
 		goto fail_inode;
 
-- 
Chuck
"Even supernovas have their duller moments."
