Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVGPW12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVGPW12 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 18:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVGPW12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 18:27:28 -0400
Received: from isilmar.linta.de ([213.239.214.66]:59015 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261762AbVGPW11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 18:27:27 -0400
Date: Sun, 17 Jul 2005 00:25:26 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Vincent C Jones <vcjones@networkingunlimited.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.13-rc3][PCMCIA] - iounmap: bad address f1d62000
Message-ID: <20050716222526.GA14172@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Vincent C Jones <vcjones@networkingunlimited.com>,
	linux-kernel@vger.kernel.org
References: <4qGHl-3Hm-11@gated-at.bofh.it> <20050716144024.14C8E1F3DC@X31.networkingunlimited.com> <20050716151258.GA7819@isilmar.linta.de> <20050716162144.A1650@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050716162144.A1650@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2005 at 04:21:44PM +0100, Russell King wrote:
> On Sat, Jul 16, 2005 at 05:12:58PM +0200, Dominik Brodowski wrote:
> > Could you send me the output of /proc/iomem on both a working kernel and on
> > 2.6.13-rc3-APM, please?
> 
> Dominik, I'd suggest looking elsewhere.  The memory regions must be
> free to be able to call into readable(), and therefore pccard_validate_cis().
> 
> What seems to be happening is that s->ops->set_mem_map in set_cis_map
> is returning an error, causing it to free the ioremapped region
> multiple times.  Maybe the card has an invalid CIS causing an out
> of range card_start to be requested?

Could you check whether this patch helps, please?

Index: 2.6.13-rc3-git2/drivers/pcmcia/cistpl.c
===================================================================
--- 2.6.13-rc3-git2.orig/drivers/pcmcia/cistpl.c
+++ 2.6.13-rc3-git2/drivers/pcmcia/cistpl.c
@@ -88,31 +88,38 @@ EXPORT_SYMBOL(release_cis_mem);
 static void __iomem *
 set_cis_map(struct pcmcia_socket *s, unsigned int card_offset, unsigned int flags)
 {
-    pccard_mem_map *mem = &s->cis_mem;
-    int ret;
+	pccard_mem_map *mem = &s->cis_mem;
+	int ret;
 
-    if (!(s->features & SS_CAP_STATIC_MAP) && mem->res == NULL) {
-	mem->res = pcmcia_find_mem_region(0, s->map_size, s->map_size, 0, s);
-	if (mem->res == NULL) {
-	    printk(KERN_NOTICE "cs: unable to map card memory!\n");
-	    return NULL;
-	}
-	s->cis_virt = ioremap(mem->res->start, s->map_size);
-    }
-    mem->card_start = card_offset;
-    mem->flags = flags;
-    ret = s->ops->set_mem_map(s, mem);
-    if (ret) {
-	iounmap(s->cis_virt);
-	return NULL;
-    }
-
-    if (s->features & SS_CAP_STATIC_MAP) {
-	if (s->cis_virt)
-	    iounmap(s->cis_virt);
-	s->cis_virt = ioremap(mem->static_start, s->map_size);
-    }
-    return s->cis_virt;
+	if (!(s->features & SS_CAP_STATIC_MAP) && (mem->res == NULL)) {
+		mem->res = pcmcia_find_mem_region(0, s->map_size, s->map_size, 0, s);
+		if (mem->res == NULL) {
+			printk(KERN_NOTICE "cs: unable to map card memory!\n");
+			return NULL;
+		}
+		s->cis_virt = NULL;
+	}
+
+	if (!(s->features & SS_CAP_STATIC_MAP) && (!s->cis_virt))
+		s->cis_virt = ioremap(mem->res->start, s->map_size);
+
+	mem->card_start = card_offset;
+	mem->flags = flags;
+
+	ret = s->ops->set_mem_map(s, mem);
+	if (ret) {
+		iounmap(s->cis_virt);
+		s->cis_virt = NULL;
+		return NULL;
+	}
+
+	if (s->features & SS_CAP_STATIC_MAP) {
+		if (s->cis_virt)
+			iounmap(s->cis_virt);
+		s->cis_virt = ioremap(mem->static_start, s->map_size);
+	}
+
+	return s->cis_virt;
 }
 
 /*======================================================================
