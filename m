Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263982AbUDQPoq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 11:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbUDQPoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 11:44:46 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:32698 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263982AbUDQPol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 11:44:41 -0400
From: oschoett@t-online.de (Oliver Schoett)
To: linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
References: <1HPrP-5sW-3@gated-at.bofh.it> <1I53J-1k7-57@gated-at.bofh.it>
	<1I5wD-1Gx-15@gated-at.bofh.it> <1I5wH-1Gx-35@gated-at.bofh.it>
	<1I5Q0-1Vt-7@gated-at.bofh.it> <1obEA-82t-11@gated-at.bofh.it>
Date: 17 Apr 2004 17:44:31 +0200
In-Reply-To: <1I5Q0-1Vt-7@gated-at.bofh.it>
Message-ID: <s23k70eehi8.fsf@oschoett.dialin.t-online.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Seen: false
X-ID: ESv56wZvYe5XjDv4BE4BAO3L5P2Pah3TnIMek44nCADGiIP8ZJN+8+
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

 > Ok, so your system is fully AGP v3 compliant, (both host and gfx card).
 > The missing check highlighted in your diff means that we only do
 > AGPv3 stuff if we have an AGP 3.5 host bridge. You have a 3.0 bridge,
 > so it was falling back to AGP v2.  My suspicion now is that the 648 and
 > 746 chipsets vary too much for them to both use the generic routines,
 > so I'll reinstate the check.  It'll still report that it finds an
 > AGP v3.0 device, but until someone comes forward with chipset docs,
 > it looks like it'll be limited to AGP v2. (I'm amazed that it works
 > at all, really).

Here is some information about the AGP mode checks I learned from
Oliver Heilmann: The two chipsets SiS 648 and SiS 648FX both have the
chipset ID 0x0648, but need different initalisation code.  The way to
distinguish them is that the 648FX reports itself as AGP v3.5 capable,
while the 648 reports itself as AGP v3.0 capable.  This is handled
correctly in Heilmann's patch in his Article
<1obEA-82t-11@gated-at.bofh.it> Date: Thu, 12 Feb 2004 00:10:08 +0100:

+static void __devinit sis_get_driver(struct agp_bridge_data *bridge)
+{
+	if(bridge->dev->device==PCI_DEVICE_ID_SI_648)
+	{
+		if(agp_bridge->major_version==3 && agp_bridge->minor_version < 5)
+		{
+			sis_driver.agp_enable=sis_648_enable;
+		}
+		else
+		{
+			sis_driver.agp_enable         = sis_648_enable;
+			sis_driver.aperture_sizes     = agp3_generic_sizes;
+			sis_driver.size_type	      = U16_APER_SIZE;
+			sis_driver.num_aperture_sizes = AGP_GENERIC_SIZES_ENTRIES;
+			sis_driver.configure	      = agp3_generic_configure;
+			sis_driver.fetch_size	      = agp3_generic_fetch_size;
+			sis_driver.cleanup	      = agp3_generic_cleanup;
+			sis_driver.tlb_flush	      = agp3_generic_tlbflush;
+		}
+	}
+	bridge->driver=&sis_driver;
+}
+

Please preserve this distinction in your patch and don't degrade the
SiS 648 chipset to AGP 2.0 (currently, 2.6.5 runs fine with AGP 3.0 on
my SiS 648 chipset).

By the way, I noticed an oddity in the changeset
http://linux.bkbits.net:8080/linux-2.5/patch@1.1643.35.7: the line

-		set_current_state(TASK_INTERRUPTIBLE);

becomes

+			set_current_state(TASK_UNINTERRUPTIBLE);

Which of the two settings is correct?

Regards,

Oliver Schoett

