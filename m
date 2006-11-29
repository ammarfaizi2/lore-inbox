Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966222AbWK2Ion@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966222AbWK2Ion (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966257AbWK2Ion
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:44:43 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:43462
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S966222AbWK2Iom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:44:42 -0500
Message-Id: <456D56E7.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 29 Nov 2006 08:46:15 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Dave Jones" <davej@redhat.com>
Cc: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Michael Buesch" <mb@bu3sch.de>,
       "Metathronius Galabant" <m.galabant@googlemail.com>,
       <stable@kernel.org>, "Michael Krufky" <mkrufky@linuxtv.org>,
       "Justin Forbes" <jmforbes@linuxtx.org>, <alan@lxorguk.ukuu.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>,
       "Chris Wedgwood" <reviews@ml.cw.f00f.org>, <akpm@osdl.org>,
       <torvalds@osdl.org>, "Chuck Wolber" <chuckw@quantumlinux.com>,
       "Chris Wright" <chrisw@sous-sol.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [stable] [PATCH 46/61] fix Intel RNG detection
References: <20061101053340.305569000@sous-sol.org>
 <20061101054343.623157000@sous-sol.org>
 <20061120234535.GD17736@redhat.com>
 <20061121022109.GF1397@sequoia.sous-sol.org>
 <4562D5DA.76E4.0078.0@novell.com>
 <20061122015046.GI1397@sequoia.sous-sol.org>
 <45640FF4.76E4.0078.0@novell.com> <20061124202729.GC29264@redhat.com>
In-Reply-To: <20061124202729.GC29264@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Dave Jones <davej@redhat.com> 24.11.06 21:27 >>>
>On Wed, Nov 22, 2006 at 08:53:08AM +0100, Jan Beulich wrote:
> > >It does appear to work w/out the patch.  I've asked for a small bit
> > >of diagnostics (below), perhaps you've got something you'd rather see?
> > >I expect this to be a 24C0 LPC Bridge.
> > 
> > Yes, that's what I'd have asked for. If it works, I expect the device
> > code to be different, or both manufacturer and device code to be
> > invalid. Depending on the outcome, perhaps we'll need an override
> > option so that this test can be partially (i.e. just the device code
> > part) or entirely (all the FWH detection) skipped.
> > The base problem is the vague documentation of the whole
> > detection mechanism - a lot of this I had to read between the lines.
>
>The bug report I referenced came back with this from that debug patch..
>
>intel_rng: no version for "struct_module" found: kernel tainted.
>intel_rng: pci vendor:device 8086:24c0 fwh_dec_en1 80 bios_cntl_val 2 mfc cb dvc 88
>intel_rng: FWH not detected

Any chance you could have them test below patch (perhaps before I
actually submit it)? They should see the warning message added when
not using any options, and they should then be able to use the
no_fwh_detect option to get the thing to work again.

I'll meanwhile ask Intel about how they suppose to follow the RNG
detection sequence when the BIOS locks out write access to the
FWH interface.

Jan

Index: head-2006-11-21/drivers/char/hw_random/intel-rng.c
===================================================================
--- head-2006-11-21.orig/drivers/char/hw_random/intel-rng.c	2006-11-21 10:36:15.000000000 +0100
+++ head-2006-11-21/drivers/char/hw_random/intel-rng.c	2006-11-29 09:09:21.000000000 +0100
@@ -143,6 +143,8 @@ static const struct pci_device_id pci_tb
 };
 MODULE_DEVICE_TABLE(pci, pci_tbl);
 
+static __initdata int no_fwh_detect;
+module_param(no_fwh_detect, int, 0);
 
 static inline u8 hwstatus_get(void __iomem *mem)
 {
@@ -240,6 +242,11 @@ static int __init mod_init(void)
 	if (!dev)
 		goto out; /* Device not found. */
 
+	if (no_fwh_detect < 0) {
+		pci_dev_put(dev);
+		goto fwh_done;
+	}
+
 	/* Check for Intel 82802 */
 	if (dev->device < 0x2640) {
 		fwh_dec_en1_off = FWH_DEC_EN1_REG_OLD;
@@ -252,6 +259,23 @@ static int __init mod_init(void)
 	pci_read_config_byte(dev, fwh_dec_en1_off, &fwh_dec_en1_val);
 	pci_read_config_byte(dev, bios_cntl_off, &bios_cntl_val);
 
+	if ((bios_cntl_val &
+	     (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK))
+	    == BIOS_CNTL_LOCK_ENABLE_MASK) {
+		static __initdata /*const*/ char warning[] =
+			KERN_WARNING PFX "Firmware space is locked read-only. If you can't or\n"
+			KERN_WARNING PFX "don't want to disable this in firmware setup, and if\n"
+			KERN_WARNING PFX "you are certain that your system has a functional\n"
+			KERN_WARNING PFX "RNG, try using the 'no_fwh_detect' option.\n";
+
+		pci_dev_put(dev);
+		if (no_fwh_detect)
+			goto fwh_done;
+		printk(warning);
+		err = -EBUSY;
+		goto out;
+	}
+
 	mem = ioremap_nocache(INTEL_FWH_ADDR, INTEL_FWH_ADDR_LEN);
 	if (mem == NULL) {
 		pci_dev_put(dev);
@@ -280,8 +304,7 @@ static int __init mod_init(void)
 		pci_write_config_byte(dev,
 		                      fwh_dec_en1_off,
 		                      fwh_dec_en1_val | FWH_F8_EN_MASK);
-	if (!(bios_cntl_val &
-	      (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK)))
+	if (!(bios_cntl_val & BIOS_CNTL_WRITE_ENABLE_MASK))
 		pci_write_config_byte(dev,
 		                      bios_cntl_off,
 		                      bios_cntl_val | BIOS_CNTL_WRITE_ENABLE_MASK);
@@ -315,6 +338,8 @@ static int __init mod_init(void)
 		goto out;
 	}
 
+fwh_done:
+
 	err = -ENOMEM;
 	mem = ioremap(INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
 	if (!mem)

