Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVCVD5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVCVD5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVCVDyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:54:46 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:737 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262351AbVCVDvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 22:51:32 -0500
Subject: ALSA bugs in list [was Re: 2.6.12-rc1-mm1]
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       apatard@mandrakesoft.com
In-Reply-To: <20050321124159.0fbf1bef.akpm@osdl.org>
References: <20050321025159.1cabd62e.akpm@osdl.org>
	 <20050321202022.B16069@flint.arm.linux.org.uk>
	 <20050321124159.0fbf1bef.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 22:51:30 -0500
Message-Id: <1111463491.3058.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 12:41 -0800, Andrew Morton wrote:
> From: bugme-daemon@osdl.org
> Subject: [Bug 4282] ALSA driver in Linux 2.6.11 causes a kernel panic when loading the EMU10K1 driver
> 

This one is a real mystery.  No one can reproduce it.

> From: bugme-daemon@osdl.org
> Subject: [Bugme-new] [Bug 4348] New: snd_emu10k1 oops'es with Audigy 2 and
> 

This one is fixed in ALSA CVS.  Here is the patch.

Lee

Summary: fix oopses in emu10k1 mixer

Signed-Off-By: Arnaud Patard <apatard@mandrakesoft.com>

Index: emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.32
diff -u -r1.32 emumixer.c
--- emumixer.c	13 Mar 2005 12:17:09 -0000	1.32
+++ emumixer.c	16 Mar 2005 17:10:10 -0000
@@ -482,9 +482,13 @@
 			change = 1;
 		}
 	}	
-	if (change && mix->epcm->voices[ch])
-		update_emu10k1_fxrt(emu, mix->epcm->voices[ch]->number,
-				    &mix->send_routing[0][0]);
+
+	if (change && mix->epcm) {
+		if (mix->epcm->voices[ch]) {
+			update_emu10k1_fxrt(emu, mix->epcm->voices[ch]->number,
+					&mix->send_routing[0][0]);
+		}
+	}
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
 	return change;
 }
@@ -544,9 +548,12 @@
 			change = 1;
 		}
 	}
-	if (change && mix->epcm->voices[ch])
-		update_emu10k1_send_volume(emu, mix->epcm->voices[ch]->number,
-					   &mix->send_volume[0][0]);
+	if (change && mix->epcm) {
+		if (mix->epcm->voices[ch]) {
+			update_emu10k1_send_volume(emu, mix->epcm->voices[ch]->number,
+						   &mix->send_volume[0][0]);
+		}
+	}
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
 	return change;
 }
@@ -600,8 +607,11 @@
 		mix->attn[0] = val;
 		change = 1;
 	}
-	if (change && mix->epcm->voices[ch])
-		snd_emu10k1_ptr_write(emu, VTFT_VOLUMETARGET, mix->epcm->voices[ch]->number, mix->attn[0]);
+	if (change && mix->epcm) {
+		if (mix->epcm->voices[ch]) {
+			snd_emu10k1_ptr_write(emu, VTFT_VOLUMETARGET, mix->epcm->voices[ch]->number, mix->attn[0]);
+		}
+	}
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
 	return change;
 }




