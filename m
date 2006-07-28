Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWG1I4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWG1I4h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWG1I4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:56:37 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:58338 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932600AbWG1I4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:56:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: swsusp hangs on headless resume-from-ram
Date: Fri, 28 Jul 2006 10:55:47 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607262206.48801.a1426z@gawab.com> <200607262207.46773.rjw@sisk.pl> <200607270034.47532.a1426z@gawab.com>
In-Reply-To: <200607270034.47532.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281055.47526.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 23:34, Al Boldi wrote:
> Rafael J. Wysocki wrote:
> > On Wednesday 26 July 2006 21:06, Al Boldi wrote:
> > > swsusp is really great, most of the time.  But sometimes it hangs after
> > > coming out of STR.  I suspect it's got something to do with display
> > > access, as this problem seems hw related.  So I removed the display
> > > card, and it positively does not resume from ram on 2.6.16+.
> > >
> > > Any easy fix for this?
> >
> > I have one idea, but you'll need a patch to test.  I'll try to prepare it
> > tomorrow.
> >
> > I guess your box is an i386?
> 
> That should be assumed by default :)

I had hoped I would be able to test it somewhere, but I couldn't.  I hope
it will compile. :-)

If it does, please send me the output of dmesg after a fresh boot.

Rafael


--
 arch/i386/kernel/setup.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

Index: linux-2.6.18-rc2/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.18-rc2.orig/arch/i386/kernel/setup.c	2006-07-28 10:27:44.000000000 +0200
+++ linux-2.6.18-rc2/arch/i386/kernel/setup.c	2006-07-28 10:51:33.000000000 +0200
@@ -1301,14 +1301,33 @@ void __init remapped_pgdat_init(void)
 	}
 }
 
+/* Mark pages corresponding to given address range as nosave */
+static void __init
+e820_mark_nosave_range(unsigned long start, unsigned long end)
+{
+	unsigned long pfn, max_pfn;
+
+	if (start >= end)
+		return;
+
+	printk("Nosave address range: %016lx - %016lx\n", start, end);
+	max_pfn = end >> PAGE_SHIFT;
+	for (pfn = start >> PAGE_SHIFT; pfn < max_pfn; pfn++)
+		if(pfn_valid(pfn))
+			SetPageNosave(pfn_to_page(pfn));
+}
+
 /*
  * Request address space for all standard RAM and ROM resources
  * and also for regions reported as reserved by the e820.
+ *
+ * Mark memory gaps and the reserved regions as nosave.
  */
 static void __init
 legacy_init_iomem_resources(struct resource *code_resource, struct resource *data_resource)
 {
 	int i;
+	unsigned long paddr;
 
 	probe_roms();
 	for (i = 0; i < e820.nr_map; i++) {
@@ -1344,6 +1363,21 @@ legacy_init_iomem_resources(struct resou
 #endif
 		}
 	}
+
+	paddr = (e820.map[0].addr + e820.map[0].size) & ~(PAGE_SIZE - 1);
+	for (i = 1; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		unsigned long base;
+
+		/* Check if we have any nosave pages here */
+		base = (ei->addr + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1);
+		if (paddr < ei->addr)
+			e820_mark_nosave_range(paddr, base);
+
+		paddr = (ei->addr + ei->size) & ~(PAGE_SIZE - 1);
+		if (ei->type != E820_RAM)
+			e820_mark_nosave_range(base, paddr);
+	}
 }
 
 /*
