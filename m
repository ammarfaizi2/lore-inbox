Return-Path: <linux-kernel-owner+w=401wt.eu-S1423015AbWLUSgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423015AbWLUSgy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423014AbWLUSgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:36:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:52568 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423015AbWLUSgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:36:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=TKIp8ftDzIr6EKp2hUpBumu3pA53FhgGyij6THpv5qYBMgRoGfUIZEf28FSdwPONJhGV2I9Hm3tIE1yjg6UlKu2yg3e5gXU/8dRBIGL9LrQ6boVryqk8D2/io8p2bR411AkPobs8T6FbkXlyGi2iM3AOxVOZKxB/JCpDLkJ04kc=
Date: Thu, 21 Dec 2006 18:35:18 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jeremy@goop.org
Subject: [-mm patch] ptrace: make {put,get}reg work again for gs and fs
Message-ID: <20061221183518.GA18827@slug>
References: <20061214225913.3338f677.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 10:59:13PM -0800, Andrew Morton wrote:
> 	http://userweb.kernel.org/~akpm/2.6.20-rc1-mm1/
> 
Hi all,

Following the i386 pda patches, it's not possible to set gs or fs value
from gdb anymore. The following patch restores the old behaviour of
getting and setting thread.gs of thread.fs respectively.
Here's a gdb session *before* the patch:
(gdb) info reg
[...]
fs             0x33     51
gs             0x33     51
(gdb) set $fs=0xffff
(gdb) info reg
[...]
fs             0x33     51
gs             0x33     51
(gdb) set $gs=0xffffffff
(gdb) info reg
[...]
fs             0xffff   65535
gs             0x33     51

Another one *after* the patch:
(gdb) info reg
[...]
fs             0xd8     216
gs             0x33     51
(gdb) set $fs=0xffff
(gdb) info reg
[...]
fs             0xffff   65535
gs             0x33     51
(gdb) set $gs=0xffff
(gdb) info reg
[...]
fs             0xffff   65535
gs             0xffff   65535

Andrew, this goes on top of ptrace-fix-efl_offset-value-according-to-i386-pda-changes.patch
sent by Jeremy yesterday.

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
index a803a49..7af494e 100644
--- a/arch/i386/kernel/ptrace.c
+++ b/arch/i386/kernel/ptrace.c
@@ -94,9 +94,13 @@ static int putreg(struct task_struct *child,
 				return -EIO;
 			child->thread.fs = value;
 			return 0;
+		case GS:
+			if (value && (value & 3) != 3)
+				return -EIO;
+			child->thread.gs = value;
+			return 0;
 		case DS:
 		case ES:
-		case GS:
 			if (value && (value & 3) != 3)
 				return -EIO;
 			value &= 0xffff;
@@ -124,12 +128,14 @@ static unsigned long getreg(struct task_struct *child,
 	unsigned long retval = ~0UL;
 
 	switch (regno >> 2) {
+		case FS:
+			retval = child->thread.fs;
+			break;
 		case GS:
 			retval = child->thread.gs;
 			break;
 		case DS:
 		case ES:
-		case FS:
 		case SS:
 		case CS:
 			retval = 0xffff;
