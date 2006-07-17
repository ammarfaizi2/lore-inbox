Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWGQQcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWGQQcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWGQQc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:43194 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750941AbWGQQcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:13 -0400
Date: Mon, 17 Jul 2006 09:28:41 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 34/45] ALSA: hda-intel - Fix race in remove
Message-ID: <20060717162841.GI4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-hda-intel-fix-race-in-remove.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: hda-intel - Fix race in remove

Call iounmap after free_irq to avoid invalid accesses in the
shared irq.  The patch is taken from
	https://bugzilla.novell.com/show_bug.cgi?id=167869

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/hda/hda_intel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17.6.orig/sound/pci/hda/hda_intel.c
+++ linux-2.6.17.6/sound/pci/hda/hda_intel.c
@@ -1393,10 +1393,10 @@ static int azx_free(struct azx *chip)
 		msleep(1);
 	}
 
-	if (chip->remap_addr)
-		iounmap(chip->remap_addr);
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void*)chip);
+	if (chip->remap_addr)
+		iounmap(chip->remap_addr);
 
 	if (chip->bdl.area)
 		snd_dma_free_pages(&chip->bdl);

--
