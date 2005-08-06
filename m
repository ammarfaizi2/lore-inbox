Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVHFNhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVHFNhO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 09:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVHFNhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 09:37:14 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:37392 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S262044AbVHFNhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 09:37:12 -0400
Message-ID: <42F4BD87.80300@sw.ru>
Date: Sat, 06 Aug 2005 17:39:19 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: i387 oops and 
Content-Type: multipart/mixed;
 boundary="------------060904000604030908080701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060904000604030908080701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

we recently obtained the oops below in restore_fpu() which makes us 
believe that there was lost correct masking of the hardcoded constant:
0x1f80 with mxcsr_feature_mask in init_fpu().
Can someone check that patch attached?

general protection fault: 0000 [#1]
SMP
Modules linked in: e100 mii ipt_length ipt_ttl ipt_tcpmss ipt_TCPMSS 
iptable_mangle iptable_filter ipt_multiport ipt_limit ipt_tos ipt_REJECT 
ip_tables
CPU:    1
EIP:    0060:[<c010cc80>]    Tainted:  P
EFLAGS: 00010206   (2.6.8-dev-smp)
EIP is at restore_fpu+0x10/0x20
eax: 0383fbff   ebx: c34178ec   ecx: 00000000   edx: c34178ec
esi: ce163000   edi: 00000067   ebp: bffffcd8   esp: ce163fb0
ds: 007b   es: 007b   ss: 0068
Process cp (pid: 821, threadinfo=ce163000 task=c34178ec)
Stack: c0107298 c34178ec 08055038 08052ce4 c039ed70 08055038 00000031 
08055038
        08052ce4 00000067 bffffcd8 00000000 0000007b 0000007b ffffffff 
0804df06
        00000073 00010246 bffffcd8 0000007b
Call Trace:
  [<c0107298>] math_state_restore+0x28/0x50
  [<c039ed70>] device_not_available+0x24/0x29
Code: 0f ae 8a e0 02 00 00 c3 dd a2 e0 02 00 00 c3 90 a1 4c fb 3f


--------------060904000604030908080701
Content-Type: text/plain;
 name="diff-fpu-mxcsr-20050804"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-fpu-mxcsr-20050804"

--- linux-2.6.8.1-t028/arch/i386/kernel/i387.c.xxx	2005-08-01 11:20:06.000000000 +0400
+++ linux-2.6.8.1-t028/arch/i386/kernel/i387.c	2005-08-04 14:12:19.000000000 +0400
@@ -52,7 +52,8 @@ void init_fpu(struct task_struct *tsk)
 		memset(&tsk->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
 		tsk->thread.i387.fxsave.cwd = 0x37f;
 		if (cpu_has_xmm)
-			tsk->thread.i387.fxsave.mxcsr = 0x1f80;
+			tsk->thread.i387.fxsave.mxcsr =
+				(0x1f80 & mxcsr_feature_mask);
 	} else {
 		memset(&tsk->thread.i387.fsave, 0, sizeof(struct i387_fsave_struct));
 		tsk->thread.i387.fsave.cwd = 0xffff037fu;

--------------060904000604030908080701--

