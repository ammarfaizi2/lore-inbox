Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSE0LLL>; Mon, 27 May 2002 07:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSE0LLK>; Mon, 27 May 2002 07:11:10 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:3851 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S316578AbSE0LLI>;
	Mon, 27 May 2002 07:11:08 -0400
Message-ID: <3CF2144C.709@epfl.ch>
Date: Mon, 27 May 2002 13:11:08 +0200
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Alessandro Morelli <alex@alphac.it>, stilgar2k@wanadoo.fr
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,CFT] Tentative fix for mem. corruption caused by intel
 815 AGP
In-Reply-To: <fa.mm4ng1v.vmenaj@ifi.uio.no> <fa.gciunnv.cnaf99@ifi.uio.no> <3CF1EA3F.4070608@epfl.ch> <1022493086.11859.191.camel@irongate.swansea.linux.org.uk> <3CF1F4C0.5080201@epfl.ch> <1022494620.11859.207.camel@irongate.swansea.linux.org.uk> <3CF1FD4B.8060608@epfl.ch> <1022497386.11859.232.camel@irongate.swansea.linux.org.uk> <3CF205C1.6040408@epfl.ch> <1022498304.11859.239.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------000807050106030200070805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000807050106030200070805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

> Your code isnt reading the top bits from the register and anding them
> back into it with the address.
> 
> 

OK I got it now... I was confused by the 'temp' thing but I should have 
read more carefully your initial suggestion (doing 2 things at the same 
time seems beyond my possibilities today ;-)
Anyway, here is take 2 of the patch, hopefully correct this time...

Just another quick thought... in all intel chipsets datasheets, the bits 
0-11 of the ATTBASE register are also marked as 'reserved'. So far, all 
the intel_*_configure routines are writing shamelessly on these bits. 
Shouldn't we mask those bits out too (though it seems this has not 
caused any trouble so far) ?

Best regards

-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)

--------------000807050106030200070805
Content-Type: text/plain;
 name="patch-intel_815-2.4.19-pre8-ac5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-intel_815-2.4.19-pre8-ac5"

diff -u agp.orig/agp.h agp/agp.h
--- agp.orig/agp.h	Fri May 24 15:08:37 2002
+++ agp/agp.h	Mon May 27 13:00:27 2002
@@ -293,6 +293,10 @@
 /* This one is for I830MP w. an external graphic card */
 #define INTEL_I830_ERRSTS          0x92
 
+/* intel 815 register */
+#define INTEL_815_APCONT        0x51
+#define INTEL_815_ATTBASE_MASK  ~0x1FFFFFFF
+
 /* intel i820 registers */
 #define INTEL_I820_RDCR     0x51
 #define INTEL_I820_ERRSTS   0xc8
diff -u agp.orig/agpgart_be.c agp/agpgart_be.c
--- agp.orig/agpgart_be.c	Fri May 24 15:08:44 2002
+++ agp/agpgart_be.c	Mon May 27 13:00:10 2002
@@ -1490,6 +1490,44 @@
 	return 0;
 }
 
+static int intel_815_configure(void)
+{
+	u32 temp, addr;
+	u8 temp2;
+	aper_size_info_8 *current_size;
+
+	current_size = A_SIZE_8(agp_bridge.current_size);
+
+	/* aperture size */
+	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
+			      current_size->size_value); 
+
+	/* address to map to */
+	pci_read_config_dword(agp_bridge.dev, INTEL_APBASE, &temp);
+	agp_bridge.gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+	/* attbase - aperture base */
+        /* the Intel 815 chipset spec. says that bits 29-31 in the
+         * ATTBASE register are reserved -> try not to write them */
+        if (agp_bridge.gatt_bus_addr &  INTEL_815_ATTBASE_MASK)
+		panic("gatt bus addr too high");
+	pci_read_config_dword(agp_bridge.dev, INTEL_ATTBASE, &addr);
+	addr &= INTEL_815_ATTBASE_MASK;
+	addr |= agp_bridge.gatt_bus_addr;
+	pci_write_config_dword(agp_bridge.dev, INTEL_ATTBASE, &addr);
+
+	/* agpctrl */
+	pci_write_config_dword(agp_bridge.dev, INTEL_AGPCTRL, 0x0000); 
+
+	/* apcont */
+	pci_read_config_byte(agp_bridge.dev, INTEL_I815_APCONT, &temp2);
+	pci_write_config_byte(agp_bridge.dev, INTEL_I815_APCONT,
+			      temp2 | (1 << 1));
+	/* clear any possible error conditions */
+        /* Oddness : this chipset seems to have no ERRSTS register ! */
+	return 0;
+}
+
 static void intel_820_tlbflush(agp_memory * mem)
 {
   return;
@@ -1724,6 +1762,12 @@
 	{0x00000017, 0}
 };
 
+static aper_size_info_8 intel_815_sizes[2] =
+{
+	{64, 16384, 4, 0},
+	{32, 8192, 3, 8},
+};
+
 static aper_size_info_8 intel_8xx_sizes[7] =
 {
 	{256, 65536, 6, 0},
@@ -1787,7 +1831,38 @@
 	(void) pdev; /* unused */
 }
 
+static int __init intel_815_setup (struct pci_dev *pdev)
+{
+	agp_bridge.masks = intel_generic_masks;
+	agp_bridge.num_of_masks = 1;
+	agp_bridge.aperture_sizes = (void *) intel_815_sizes;
+	agp_bridge.size_type = U8_APER_SIZE;
+	agp_bridge.num_aperture_sizes = 2;
+	agp_bridge.dev_private_data = NULL;
+	agp_bridge.needs_scratch_page = FALSE;
+	agp_bridge.configure = intel_815_configure;
+	agp_bridge.fetch_size = intel_8xx_fetch_size;
+	agp_bridge.cleanup = intel_8xx_cleanup;
+	agp_bridge.tlb_flush = intel_8xx_tlbflush;
+	agp_bridge.mask_memory = intel_mask_memory;
+	agp_bridge.agp_enable = agp_generic_agp_enable;
+	agp_bridge.cache_flush = global_cache_flush;
+	agp_bridge.create_gatt_table = agp_generic_create_gatt_table;
+	agp_bridge.free_gatt_table = agp_generic_free_gatt_table;
+	agp_bridge.insert_memory = agp_generic_insert_memory;
+	agp_bridge.remove_memory = agp_generic_remove_memory;
+	agp_bridge.alloc_by_type = agp_generic_alloc_by_type;
+	agp_bridge.free_by_type = agp_generic_free_by_type;
+	agp_bridge.agp_alloc_page = agp_generic_alloc_page;
+	agp_bridge.agp_destroy_page = agp_generic_destroy_page;
+	agp_bridge.suspend = agp_generic_suspend;
+	agp_bridge.resume = agp_generic_resume;
+	agp_bridge.cant_use_aperture = 0;
 
+	return 0;
+	
+	(void) pdev; /* unused */
+}
 
 static int __init intel_820_setup (struct pci_dev *pdev)
 {
@@ -3929,7 +4004,7 @@
 		INTEL_I815,
 		"Intel",
 		"i815",
-		intel_generic_setup },
+		intel_815_setup },
 	{ PCI_DEVICE_ID_INTEL_820_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I820,

--------------000807050106030200070805--

