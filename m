Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVC2Uyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVC2Uyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVC2Uxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:53:30 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:53735 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261421AbVC2Uwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:52:53 -0500
Subject: Re: [Alsa-devel] Re: 2.6.12-rc1-mm3, sound card lost id
From: Lee Revell <rlrevell@joe-job.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <20050329224630.069cda56.khali@linux-fr.org>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	 <20050326111945.5eb58343.khali@linux-fr.org> <s5hr7hyiqra.wl@alsa2.suse.de>
	 <20050329195721.385717aa.khali@linux-fr.org>
	 <1112127424.5141.7.camel@mindpipe>
	 <20050329224630.069cda56.khali@linux-fr.org>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 15:52:51 -0500
Message-Id: <1112129571.5141.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 22:46 +0200, Jean Delvare wrote:
> Hi Lee,
> 
> > I think we just have to add this PCI id to the table.  I got the same
> > result before James added the SBLive! platinum detection.
> > 
> > What is the output of 'lspci -v | grep -1 EMU10k1'?
> 
> 00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
>         Subsystem: Creative Labs CT4832 SBLive! Value
> 
> and the one you didn't ask for:
> 
> 00:0d.0 Class 0401: 1102:0002 (rev 06)
>         Subsystem: 1102:8027
> 
> This made me realize that I could still try to hack it myself. The
> following patch somehow helped:
> 
> --- linux-2.6.12-rc1-mm3/sound/pci/emu10k1/emu10k1_main.c.orig	2005-03-29 20:38:12.000000000 +0200
> +++ linux-2.6.12-rc1-mm3/sound/pci/emu10k1/emu10k1_main.c	2005-03-29 22:32:23.000000000 +0200
> @@ -680,6 +680,10 @@
>  	 .driver = "EMU10K1", .name = "E-mu APS [4001]", 
>  	 .emu10k1_chip = 1,
>  	 .ecard = 1} ,
> +	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
> +	 .driver = "EMU10K1", .name = "SB Live Player 1024", 
> +	 .emu10k1_chip = 1,
> +	 .ac97_chip = 1} ,
>  	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
>  	 .driver = "EMU10K1", .name = "SB Live 5.1", 
>  	 .emu10k1_chip = 1,
> 
> 
> Now the card will be listed as "S1024" instead of "Unknown" so that's a
> change. Looks like the short name is auto-generated? Unfortunately
> that's still not "Live" as before so my mixer settings are not back yet.
> And I believe that "Live" was a much better name than "S1024" too.
> 

Here is the patch (against ALSA CVS) in its preferred format.  You will
probably have to apply it by hand.  If the mixer settings can't be
restored you'll have to do it manually or edit asound.state by hand.

Lee

Index: alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.49
diff -u -r1.49 emu10k1_main.c
--- alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	27 Mar 2005 14:00:54 -0000	1.49
+++ alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	29 Mar 2005 20:51:44 -0000
@@ -693,6 +693,10 @@
 	 .driver = "EMU10K1", .name = "SBLive! Platinum [CT4760P]", 
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]", 
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0002,
 	 .driver = "EMU10K1", .name = "SB Live [Unknown]", 
 	 .emu10k1_chip = 1,

Lee

