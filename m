Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbTGLDLa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 23:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267477AbTGLDLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 23:11:30 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:29488 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S267475AbTGLDLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 23:11:24 -0400
Message-ID: <3F0F97DC.5090500@enib.fr>
Date: Sat, 12 Jul 2003 05:08:44 +0000
From: xi <xizard@enib.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AMD760MPX: bogus chispset ? (was PROBLEM: sound is	stutter,
 sizzle with lasts kernel releases)
References: <3F0EED9B.4080502@enib.fr>	 <1057943291.20629.30.camel@dhcp22.swansea.linux.org.uk>	 <3F0F2667.7090103@enib.fr> <1057959456.20637.45.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1057959456.20637.45.camel@dhcp22.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------070106010702040300090900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070106010702040300090900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> On Gwe, 2003-07-11 at 22:04, xi wrote:
> 
>>And one interesting thing:
>>in the AMD762 datasheet (24462.pdf) page 231 (Recommanded BIOS 
>>settings), I can see this: "Numerical Values shown with h or b are 
>>preferred settings." ; and AMD recommand this:
>>-> set bits 2 and 1 of register 0x4C to "0b"
>>-> set bits 23 and 3 respectively to "0b" and "1b"
>>
>>I can confirm that these settings works much more better, even if they 
>>don't exactly follow PCI specs. And I don't think this is specific to my 
>>  cards since I have tested others.
>>Furthermore, my AMD762 is revision B1 (just before the last one: C0), 
>>and my AMD768 revision is B2, the last one.
>>
>>Would you accept I make a patch which doesn't make any change in these 
>>registers at least up to AMD762 revision B1 (ie keeping recommanded 
>>values from AMD) ?
> 
> 
> Lets try the AMD recommended settings. My old doc doesnt seem to have
> those. I'll by happy to trial the patch in -ac and see if it plays up
> the usual suspects for PCI spec violations (tg3 and i2o)
> 

Ok, I provide two patchs with different behaviour:

* patch_AMD762_PCI_compliance_set_by_bios.diff : lets the BIOS decide 
about PCI configuration

* patch_AMD762_PCI_default_AMD_settings.diff : follow AMD 
recommendations but not PCI specs.

Patch are against drivers/pci/quirks.c from 2.4.22-pre4

Regards,
				Xavier

-- 
E-mail:
ctrl.alt.sup@free.fr xizard@chez.com
Please no longer use xizard@enib.fr, this e-mail will be removed soon.

Homepage:
http://xizard.free.fr
http://www.chez.com/xizard/

--------------070106010702040300090900
Content-Type: text/plain;
 name="patch_AMD762_PCI_compliance_set_by_bios.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_AMD762_PCI_compliance_set_by_bios.diff"

--- quirks_original.c	2003-07-12 01:58:17.000000000 +0000
+++ quirks.c	2003-07-12 04:40:57.000000000 +0000
@@ -464,22 +464,23 @@
  * Following the PCI ordering rules is optional on the AMD762. I'm not
  * sure what the designers were smoking but let's not inhale...
  *
- * To be fair to AMD, it follows the spec by default, its BIOS people
- * who turn it off!
+ * In fact, AMD even recommends to don't follow PCI standards
+ * in the section "Recommended BIOS settings" of the datasheet
  */
  
 static void __init quirk_amd_ordering(struct pci_dev *dev)
 {
-	u32 pcic;
-	pci_read_config_dword(dev, 0x4C, &pcic);
-	if((pcic&6)!=6)
+	u32 pcic1,pcic2;
+
+	pci_read_config_dword(dev, 0x4C, &pcic1);
+	pci_read_config_dword(dev, 0x84, &pcic2);
+
+	if((pcic1&6)!=6 || (pcic2&(1<<23))!=(1<<23))
 	{
-		pcic |= 6;
-		printk(KERN_WARNING "BIOS failed to enable PCI standards compliance, fixing this error.\n");
-		pci_write_config_dword(dev, 0x4C, pcic);
-		pci_read_config_dword(dev, 0x84, &pcic);
-		pcic |= (1<<23);	/* Required in this mode */
-		pci_write_config_dword(dev, 0x84, pcic);
+		/* The AMD762 doesn't follow PCI standards, but it seems to work better in this mode !
+		   In order to be fully PCI standards compliant, we should :
+		   set bit 1 and 2 of register 0x4C ; set bit 23 and clear bit 3 of register 0x84 */
+		printk(KERN_WARNING "BIOS didn't enabled PCI standards compliance.\n");
 	}
 }
 

--------------070106010702040300090900
Content-Type: text/plain;
 name="patch_AMD762_PCI_default_AMD_settings.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_AMD762_PCI_default_AMD_settings.diff"

--- quirks_original.c	2003-07-12 01:58:17.000000000 +0000
+++ quirks.c	2003-07-12 04:44:02.000000000 +0000
@@ -464,23 +464,24 @@
  * Following the PCI ordering rules is optional on the AMD762. I'm not
  * sure what the designers were smoking but let's not inhale...
  *
- * To be fair to AMD, it follows the spec by default, its BIOS people
- * who turn it off!
+ * In fact, AMD even recommends to don't follow PCI standards
+ * in the section "Recommended BIOS settings" of the datasheet
  */
  
 static void __init quirk_amd_ordering(struct pci_dev *dev)
 {
 	u32 pcic;
+
+	printk(KERN_WARNING "Setting AMD recommended values for PCI bus. It isn't fully PCI standards compliant\n");
+
 	pci_read_config_dword(dev, 0x4C, &pcic);
-	if((pcic&6)!=6)
-	{
-		pcic |= 6;
-		printk(KERN_WARNING "BIOS failed to enable PCI standards compliance, fixing this error.\n");
+	pcic &= ~((u32)6);
 		pci_write_config_dword(dev, 0x4C, pcic);
+
 		pci_read_config_dword(dev, 0x84, &pcic);
-		pcic |= (1<<23);	/* Required in this mode */
+	pcic &= ~((u32)(1<<23));
+	pcic |= (1<<3);
 		pci_write_config_dword(dev, 0x84, pcic);
-	}
 }
 
 #ifdef CONFIG_X86_IO_APIC

--------------070106010702040300090900--


