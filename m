Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293635AbSCXQBX>; Sun, 24 Mar 2002 11:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293646AbSCXQBN>; Sun, 24 Mar 2002 11:01:13 -0500
Received: from ohiper1-222.apex.net ([209.250.47.237]:35851 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S293635AbSCXQBA>; Sun, 24 Mar 2002 11:01:00 -0500
Date: Sun, 24 Mar 2002 09:59:30 -0600
From: Steven Walter <srwalter@yahoo.com>
To: alan@lxorguk.ukuu.org.uk, davej@suse.de, torvalds@transmeta.com,
        marcelo@conective.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Screen corruption in 2.4.18
Message-ID: <20020324155930.GA20926@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	alan@lxorguk.ukuu.org.uk, davej@suse.de, torvalds@transmeta.com,
	marcelo@conective.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au> <20020324071604.GA15618@hapablap.dyn.dhs.org> <200203241231.g2OCV5X18426@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uptime: 08:14:53 up 3 days,  7:12,  0 users,  load average: 1.60, 1.23, 1.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a screen corruption bug seen on VIA KM133 mainboards.
As it stands, we disable bits 5, 6, and 7 of register offset 55 in order
to disable the memory write queue, which was causing us trouble before.
However, the clearing of bits 5 and 6 is causing us trouble now.  Whenever 
they're cleared, the screen gets static across it, roughly corresponding 
to IDE/PCI activity.  I spoke to one of the developers involved in the 
original fix, and he suggested that we go ahead and not clear bits 5 and 6 
on these boards, and that he was aware of several instances where clearing 
them causes trouble.

Here is a patch which should apply cleanly to everyone's tree, which
only clears bit 7 on all chips except the KT266.  No problems have been
reported there, so I'm leaving well enough alone.  Please apply.

Thanks
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns

--- linux/arch/i386/kernel/pci-pc.c~	Sun Mar 24 09:43:14 2002
+++ linux/arch/i386/kernel/pci-pc.c	Sun Mar 24 09:43:23 2002
@@ -1197,16 +1197,19 @@
 {
 	u8 v;
 	int where = 0x55;
+	int mask = 0x7f; /* Clearing bits 5 and 6 on the ProSavage KM133 
+			  * causes strange screen corruption, so we don't */
 
 	if (d->device == PCI_DEVICE_ID_VIA_8367_0) {
 		where = 0x95; /* the memory write queue timer register is 
 				 different for the kt266x's: 0x95 not 0x55 */
+		mask = 0x1f; /* clear bits 5, 6, 7 */
 	}
 
 	pci_read_config_byte(d, where, &v);
 	if (v & 0xe0) {
-		printk("Disabling VIA memory write queue: [%02x] %02x->%02x\n", where, v, v & 0x1f);
-		v &= 0x1f; /* clear bits 5, 6, 7 */
+		printk("Disabling VIA memory write queue: [%02x] %02x->%02x\n", where, v, v & mask);
+		v &= mask;
 		pci_write_config_byte(d, where, v);
 	}
 }
