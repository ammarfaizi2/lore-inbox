Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267087AbTGGPrm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267091AbTGGPrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:47:42 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:51684 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S267087AbTGGPrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:47:23 -0400
Subject: [2.4][TRIVIAL] Use of uninitialized vars in
	arch/i386/kernel/process.c
From: Disconnect <lkml@sigkill.net>
To: Riley@Williams.Name, davej@suse.de, hpa@zytor.com
Cc: trivial@rustcorp.com.au, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-FbL66UJ2oE1i/yPmNPnd"
Message-Id: <1057593701.4081.87.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 07 Jul 2003 12:01:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FbL66UJ2oE1i/yPmNPnd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry for the longish To list, not sure who's responsible for this
particular piece. (And if I got it wrong even after all that, please let
me know..)

This is for 2.4; in 2.5 reboot.c has identical code with an identical
problem. (I'll send a separate patch after getting feedback on this
one.)

If you don't pass reboot=, reboot_mode and reboot_thru_bios are used
uninitialized and (in the case of reboot_mode) written directly to
memory for the bios.

This patch sets reboot_mode to 0x1234 by default, and reboot_thru_bios
(used in "if(!reboot_thru_bios)") to 1.

void machine_restart(char * __unused)
{
..[smp shutdown]..
  if(!reboot_thru_bios) {
        /* rebooting needs to touch the page at absolute addr 0 */
        *((unsigned short *)__va(0x472)) = reboot_mode;
...
        machine_real_restart(jump_to_bios, sizeof(jump_to_bios));
}

void machine_real_restart(unsigned char *code, int length)
{
.....
  /* Write 0x1234 to absolute memory location 0x472.  The BIOS reads
     this on booting to tell it to "Bypass memory test (also warm
     boot)".  This seems like a fairly standard thing that gets set by
     REBOOT.COM programs, and the previous reset routine did this
     too. */

  *((unsigned short *)0x472) = reboot_mode;
...
}


-- 
Disconnect <lkml@sigkill.net>

--=-FbL66UJ2oE1i/yPmNPnd
Content-Description: 
Content-Disposition: inline; filename=process.c.diff
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1042  -> 1.1043 
#	arch/i386/kernel/process.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/07	dis@slappy.(none)	1.1043
# Initialize reboot_mode to defaults (according to comments) even if reboot= is lacking.  Ditto for reboot_thru_bios. 
# (Warm boot, use bios.) 
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Mon Jul  7 11:42:50 2003
+++ b/arch/i386/kernel/process.c	Mon Jul  7 11:42:50 2003
@@ -152,8 +152,8 @@
 __setup("idle=", idle_setup);
 
 static long no_idt[2];
-static int reboot_mode;
-int reboot_thru_bios;
+static int reboot_mode=0x1234;
+int reboot_thru_bios=1;
 
 #ifdef CONFIG_SMP
 int reboot_smp = 0;

--=-FbL66UJ2oE1i/yPmNPnd--

