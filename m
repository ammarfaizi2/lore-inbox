Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVCZWAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVCZWAy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 17:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCZWAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 17:00:53 -0500
Received: from isilmar.linta.de ([213.239.214.66]:59315 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261331AbVCZWAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 17:00:31 -0500
Date: Sat, 26 Mar 2005 23:00:30 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: sneakums@zork.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PCMCIA Oops (was Re: 2.6.12-rc1-mm3)
Message-ID: <20050326220030.GA32415@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	sneakums@zork.net, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050325002154.335c6b0b.akpm@osdl.org> <6uu0myyz66.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <6uu0myyz66.fsf@zork.zork.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 26, 2005 at 07:39:29PM +0000, Sean Neakums wrote:
> On a PowerBook5.4 I get the below when I insert the PCMCIA card or
> boot with it inserted; however, if I boot with no card inserted,
> sleep-resume and insert the card it works fine.  Similar with
> 2.6.12-rc1-mm1; not sure why I didn't notice until now, since I
> happily used it for six days or so, PCMCIA and all, although there was
> *some* PCMCIA-related issue I failed to note and cannot now recall.

If you revert the patch named
pcmcia-mark-parent-bridge-windows-as-resources-available-for-pcmcia-devices.patch
the oops should disappear. However, I had no chance yet to fully debug
what's going on here. So I'd prefer it if you first applied the attached test
patch and sent me (off-list) the dmesg output. Also, it is very strange that
it doesn't trigger if you did a sleep-resume cycle before... Ben, any idea?

	Dominik

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=test

Index: 2.6.12-rc1/drivers/pcmcia/cistpl.c
===================================================================
--- 2.6.12-rc1.orig/drivers/pcmcia/cistpl.c	2005-03-25 13:49:21.000000000 +0100
+++ 2.6.12-rc1/drivers/pcmcia/cistpl.c	2005-03-25 13:50:26.000000000 +0100
@@ -89,6 +89,7 @@
 set_cis_map(struct pcmcia_socket *s, unsigned int card_offset, unsigned int flags)
 {
     pccard_mem_map *mem = &s->cis_mem;
+    int ret;
     if (!(s->features & SS_CAP_STATIC_MAP) && mem->res == NULL) {
 	mem->res = pcmcia_find_mem_region(0, s->map_size, s->map_size, 0, s);
 	if (mem->res == NULL) {
@@ -99,7 +100,9 @@
     }
     mem->card_start = card_offset;
     mem->flags = flags;
-    s->ops->set_mem_map(s, mem);
+    printk(KERN_DEBUG "set_cis_map: %x %u %lx %lx %p\n", card_offset, flags, mem->res->start, mem->res->end, s->cis_virt);
+    ret = s->ops->set_mem_map(s, mem);
+    printk(KERN_DEBUG "ret is %i\n", ret);
     if (s->features & SS_CAP_STATIC_MAP) {
 	if (s->cis_virt)
 	    iounmap(s->cis_virt);
Index: 2.6.12-rc1/drivers/pcmcia/rsrc_nonstatic.c
===================================================================
--- 2.6.12-rc1.orig/drivers/pcmcia/rsrc_nonstatic.c	2005-03-25 13:49:21.000000000 +0100
+++ 2.6.12-rc1/drivers/pcmcia/rsrc_nonstatic.c	2005-03-25 13:54:10.000000000 +0100
@@ -93,6 +93,8 @@
 {
 	struct resource *res, *parent;
 
+	printk(KERN_DEBUG "claim_region: %lx, %lx\n", base, size);
+
 	parent = type & IORESOURCE_MEM ? &iomem_resource : &ioport_resource;
 	res = make_resource(base, size, type | IORESOURCE_BUSY, name);
 
@@ -106,6 +108,9 @@
 			res = NULL;
 		}
 	}
+
+	printk(KERN_DEBUG "claim_region: result %p\n", res);
+
 	return res;
 }
 
@@ -267,8 +272,12 @@
 {
 	int ret = -1;
 
+	printk(KERN_DEBUG "readable: %lx %x\n", res->start, s->map_size);
+
 	s->cis_mem.res = res;
 	s->cis_virt = ioremap(res->start, s->map_size);
+
+	printk(KERN_DEBUG "readable: remapped to %p\n", s->cis_virt);
 	if (s->cis_virt) {
 		ret = pccard_validate_cis(s, BIND_FN_ALL, info);
 		/* invalidate mapping and CIS cache */
@@ -290,6 +299,7 @@
 	void __iomem *virt;
 
 	virt = ioremap(res->start, s->map_size);
+	printk("checksum: %lx, %x remapped to %p\n", res->start, s->map_size, virt);
 	if (virt) {
 		map.map = 0;
 		map.flags = MAP_ACTIVE;
@@ -324,6 +334,8 @@
 	res1 = claim_region(s, base, size/2, IORESOURCE_MEM, "cs memory probe");
 	res2 = claim_region(s, base + size/2, size/2, IORESOURCE_MEM, "cs memory probe");
 
+	printk(KERN_DEBUG "cis_readable: %lx (%lx) - %p, %lx (%lx) - %p\n", base, (size/2), res1, (base + size/2), (size/2), res2);
+
 	if (res1 && res2) {
 		ret = readable(s, res1, &info1);
 		ret += readable(s, res2, &info2);
@@ -375,6 +387,7 @@
     /* cis_readable wants to map 2x map_size */
     if (step < 2 * s->map_size)
 	step = 2 * s->map_size;
+    printk(KERN_DEBUG "do_mem_probe %lx %lx %lx\n", base, num, step);
     for (i = j = base; i < base+num; i = j + step) {
 	if (!fail) {
 	    for (j = i; j < base+num; j += step) {

--zhXaljGHf11kAtnf--
