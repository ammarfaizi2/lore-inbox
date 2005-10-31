Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVJaVSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVJaVSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVJaVSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:18:16 -0500
Received: from fmr19.intel.com ([134.134.136.18]:9385 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751094AbVJaVSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:18:15 -0500
Date: Mon, 31 Oct 2005 13:20:02 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: perex@suse.cz, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] sound/hda: rate-limit timeout message
Message-Id: <20051031132002.14b7aedb.randy_d_dunlap@linux.intel.com>
X-Mailer: Sylpheed version 2.0.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Rate-limit the azx_get_response timeout message.
A continuous 2 per second is too much.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---

 sound/pci/hda/hda_intel.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -Naurp linux-2614-work/sound/pci/hda/hda_intel.c~hda_rate_limit linux-2614-work/sound/pci/hda/hda_intel.c
--- linux-2614-work/sound/pci/hda/hda_intel.c~hda_rate_limit	2005-10-27 17:02:08.000000000 -0700
+++ linux-2614-work/sound/pci/hda/hda_intel.c	2005-10-31 13:11:33.000000000 -0800
@@ -37,6 +37,7 @@
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -508,7 +509,9 @@ static unsigned int azx_get_response(str
 
 	while (chip->rirb.cmds) {
 		if (! --timeout) {
-			snd_printk(KERN_ERR "azx_get_response timeout\n");
+			if (printk_ratelimit())
+				snd_printk(KERN_ERR
+					"azx_get_response timeout\n");
 			chip->rirb.rp = azx_readb(chip, RIRBWP);
 			chip->rirb.cmds = 0;
 			return -1;


---
