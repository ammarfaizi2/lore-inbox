Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbULDHwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbULDHwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 02:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbULDHwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 02:52:25 -0500
Received: from main.gmane.org ([80.91.229.2]:17057 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262484AbULDHwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 02:52:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [2.6.10-rc2] In-kernel swsusp broken
Date: Fri, 03 Dec 2004 23:52:14 -0800
Message-ID: <41B16CAE.9010300@triplehelix.org>
References: <419DC24C.9000902@triplehelix.org>	<20041129164112.3d51be93.akpm@osdl.org>	<41B1296C.8060804@triplehelix.org>	<20041203195245.29e7ce03.akpm@osdl.org>	<41B14A53.2070905@triplehelix.org> <20041203222057.6334668d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090800080201040809030704"
X-Complaints-To: usenet@sea.gmane.org
Cc: pavel@ucw.cz, perex@suse.cz
X-Gmane-NNTP-Posting-Host: adsl-68-126-237-170.dsl.pltn13.pacbell.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
In-Reply-To: <20041203222057.6334668d.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090800080201040809030704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[CC:ing Jaroslav, solution involving ALSA code is attached.]

Andrew Morton wrote:
> Yes, if you could apply something like the below and see if we can see
> which driver is causing the problem?  Make sure that CONFIG_PCI_NAMES is
> set...

Yeah, did that (didn't use yours), and apparently all the suspend 
functions return 0 but it died after pcibios_set_master on several 
devices - the last call succeeded (it was my intel8x0 sound card) and 
thereafter the hang occurred.

I noticed a recent -mm patch added

pci_disable_device(chip->pci);

in sound/pci/intel8x0.c -> intel8x0_suspend. Looks like that didn't 
help; I also had to add a pci_save_state(chip->pci) above that for 
suspend to work, mimicking the way USB seemed to handle suspending, and 
that worked! Had to do that for intel8x0m.c as well. I looked for other 
instances of disable_device in sound/pci and saw many 
pci_set_power_state(pdev, 3). Would that have a similar effect to saving 
the state? Should I have used that instead? Well, you be the judge...

I'm not really sure what to send a diff against, but I figure -rc3 is 
best so that other people can take advantage of the fix without having 
to patch to -mm first.

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

-- 
Joshua Kwan

--------------090800080201040809030704
Content-Type: text/x-patch;
 name="intel8x0-save-pci-state.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intel8x0-save-pci-state.patch"

--- linux-2.6.9/sound/pci/intel8x0.c~	2004-12-03 23:44:28.000000000 -0800
+++ linux-2.6.9/sound/pci/intel8x0.c	2004-12-03 23:44:36.000000000 -0800
@@ -2279,6 +2279,8 @@
 	for (i = 0; i < 3; i++)
 		if (chip->ac97[i])
 			snd_ac97_suspend(chip->ac97[i]);
+	pci_save_state(chip->pci);
+	pci_disable_device(chip->pci);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	return 0;
 }
--- linux-2.6.9/sound/pci/intel8x0m.c~	2004-12-03 23:44:42.000000000 -0800
+++ linux-2.6.9/sound/pci/intel8x0m.c	2004-12-03 23:44:57.000000000 -0800
@@ -1091,6 +1091,8 @@
 		snd_pcm_suspend_all(chip->pcm[i]);
 	if (chip->ac97)
 		snd_ac97_suspend(chip->ac97);
+	pci_save_state(chip->pci);
+	pci_disable_device(chip->pci);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	return 0;
 }

--------------090800080201040809030704--

