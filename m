Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274384AbRITJRm>; Thu, 20 Sep 2001 05:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274383AbRITJRe>; Thu, 20 Sep 2001 05:17:34 -0400
Received: from mail.2d3d.co.za ([196.14.185.200]:49124 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S274385AbRITJRR>;
	Thu, 20 Sep 2001 05:17:17 -0400
Date: Thu, 20 Sep 2001 11:18:39 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: agpgart support for Intel 830M chipset
Message-ID: <20010920111839.A32160@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.2 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 11:13am  up 40 days, 21:47, 10 users,  load average: 0.91, 1.14, 0.68
X-Edited-With-Muttmode: muttmail.sl - 2000-11-20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've included a patch below for agpgart support for the Intel 830M chipset.

There seems to be a bit of a problem regarding the agpgart module. Afaik
Jeff Hartmann (the author) doesn't work for VA Linux anymore and I don't
know whether he actually maintains the module. If not, there is no
maintainer for agpgart. If that is the case I'll maintain it if nobody
objects...

diff -Nru linux.orig/Documentation/Configure.help linux/Documentation/Configure.help
--- linux.orig/Documentation/Configure.help	Sun Aug 12 19:51:41 2001
+++ linux/Documentation/Configure.help	Thu Sep 20 10:55:36 2001
@@ -2524,10 +2524,10 @@
   module, say M here and read Documentation/modules.txt. The module
   will be called agpgart.o.
 
-Intel 440LX/BX/GX/815/840/850 support
+Intel 440LX/BX/GX/815/830M/840/850 support
 CONFIG_AGP_INTEL
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on Intel 440LX/BX/GX, 815, 840 and 850 chipsets.
+  XFree86 4.x on Intel 440LX/BX/GX, 815, 830M, 840 and 850 chipsets.
 
   For the moment, you should probably say N, unless you want to test
   the GLX component for XFree86 3.3.6, which can be downloaded from
@@ -2535,9 +2535,9 @@
 
 Intel I810/I810 DC100/I810e support
 CONFIG_AGP_I810
-  This option gives you AGP support for the Xserver on the Intel 810
-  and 815 chipset boards for their on-board integrated graphics. This
-  is required to do any useful video modes with these boards.
+  This option gives you AGP support for the Xserver on the Intel 810,
+  830M and 815 chipset boards for their on-board integrated graphics.
+  This is required to do any useful video modes with these boards.
 
 VIA chipset support
 CONFIG_AGP_VIA
diff -Nru linux.orig/drivers/char/Config.in linux/drivers/char/Config.in
--- linux.orig/drivers/char/Config.in	Sun Aug 12 19:38:48 2001
+++ linux/drivers/char/Config.in	Thu Sep 20 10:53:31 2001
@@ -187,8 +187,8 @@
 
 dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
 if [ "$CONFIG_AGP" != "n" ]; then
-   bool '  Intel 440LX/BX/GX and I815/I840/I850 support' CONFIG_AGP_INTEL
-   bool '  Intel I810/I815 (on-board) support' CONFIG_AGP_I810
+   bool '  Intel 440LX/BX/GX and I815/I830M/I840/I850 support' CONFIG_AGP_INTEL
+   bool '  Intel I810/I815/I830M (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
    bool '  AMD Irongate support' CONFIG_AGP_AMD
    bool '  Generic SiS support' CONFIG_AGP_SIS
diff -Nru linux.orig/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux.orig/drivers/char/agp/agp.h	Wed Aug 15 10:22:15 2001
+++ linux/drivers/char/agp/agp.h	Wed Sep 19 14:11:37 2001
@@ -129,6 +129,10 @@
 #define INREG16(mmap, addr)         __raw_readw((mmap)+(addr))
 #define INREG8(mmap, addr)         __raw_readb((mmap)+(addr))
 
+#define KB(x) ((x) * 1024)
+#define MB(x) (KB(x) * 1024)
+#define GB(x) (MB(x) * 1024)
+
 #define CACHE_FLUSH	agp_bridge.cache_flush
 #define A_SIZE_8(x)	((aper_size_info_8 *) x)
 #define A_SIZE_16(x)	((aper_size_info_16 *) x)
@@ -189,6 +193,12 @@
 #ifndef PCI_DEVICE_ID_INTEL_815_1
 #define PCI_DEVICE_ID_INTEL_815_1       0x1132
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_830_M_0
+#define PCI_DEVICE_ID_INTEL_830_M_0		0x3575
+#endif
+#ifndef PCI_DEVICE_ID_INTEL_830_M_1
+#define PCI_DEVICE_ID_INTEL_830_M_1		0x3577
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_82443GX_1
 #define PCI_DEVICE_ID_INTEL_82443GX_1   0x71a1
 #endif
@@ -253,6 +263,22 @@
 #define I810_DRAM_CTL          0x3000
 #define I810_DRAM_ROW_0        0x00000001
 #define I810_DRAM_ROW_0_SDRAM  0x00000001
+
+/* intel i830 registers */
+#define I830_GMCH_CTRL				0x52
+#define I830_GMCH_ENABLED			0x4
+#define I830_GMCH_MEM_MASK			0x1
+#define I830_GMCH_MEM_64M			0x1
+#define I830_GMCH_MEM_128M			0
+#define I830_GMCH_GMS_MASK			0x70
+#define I830_GMCH_GMS_DISABLED		0x00
+#define I830_GMCH_GMS_LOCAL			0x10
+#define I830_GMCH_GMS_STOLEN_512	0x20
+#define I830_GMCH_GMS_STOLEN_1024	0x30
+#define I830_GMCH_GMS_STOLEN_8192	0x40
+#define I830_RDRAM_CHANNEL_TYPE		0x03010
+#define I830_RDRAM_ND(x)			(((x) & 0x20) >> 5)
+#define I830_RDRAM_DDT(x)			(((x) & 0x18) >> 3)
 
 /* VIA register */
 #define VIA_APBASE      0x10
diff -Nru linux.orig/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- linux.orig/drivers/char/agp/agpgart_be.c	Wed Aug 15 10:22:15 2001
+++ linux/drivers/char/agp/agpgart_be.c	Wed Sep 19 15:34:41 2001
@@ -23,6 +23,17 @@
  * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+
+/*
+ * Could everyone from now on please document your changes.
+ *
+ * Changelog:
+ *
+ *     19/09/2001 Abraham van der Merwe <abraham@2d3d.co.za>
+ *         - Various bugfixes to i830 code
+ *         - Added support for local memory (i830 chipset)
+ */
+
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
@@ -812,6 +823,10 @@
 /* End - Generic Agp routines */
 
 #ifdef CONFIG_AGP_I810
+
+#define AGP_DCACHE_MEMORY 1
+#define AGP_PHYS_MEMORY   2
+
 static aper_size_info_fixed intel_i810_sizes[] =
 {
 	{64, 16384, 4},
@@ -819,9 +834,6 @@
 	{32, 8192, 4}
 };
 
-#define AGP_DCACHE_MEMORY 1
-#define AGP_PHYS_MEMORY   2
-
 static gatt_mask intel_i810_masks[] =
 {
 	{I810_PTE_VALID, 0},
@@ -1087,6 +1099,293 @@
 	return 0;
 }
 
+static aper_size_info_fixed intel_i830_sizes[] =
+{
+   { 128, 32768, 5 },
+   /* The 64M mode still requires a 128k gatt */
+   { 64, 16384, 5 }
+};
+
+static struct _intel_i830_private
+{
+   struct pci_dev *i830_dev;	/* device one */
+   volatile u8 *registers;
+   int gtt_entries;
+} intel_i830_private;
+
+static void intel_i830_init_gtt_entries (void)
+{
+   u16 gmch_ctrl;
+   int gtt_entries;
+   u8 rdct;
+   static const int ddt[4] = { 0, 16, 32, 64 };
+
+   pci_read_config_word (agp_bridge.dev,I830_GMCH_CTRL,&gmch_ctrl);
+
+   switch (gmch_ctrl & I830_GMCH_GMS_MASK)
+	 {
+	  case I830_GMCH_GMS_STOLEN_512:
+		gtt_entries = KB (512);
+		printk (KERN_INFO PFX "detected %dK stolen memory.\n",gtt_entries / KB (1));
+		break;
+	  case I830_GMCH_GMS_STOLEN_1024:
+		gtt_entries = MB (1);
+		printk (KERN_INFO PFX "detected %dK stolen memory.\n",gtt_entries / KB (1));
+		break;
+	  case I830_GMCH_GMS_STOLEN_8192:
+		gtt_entries = MB (8);
+		printk (KERN_INFO PFX "detected %dK stolen memory.\n",gtt_entries / KB (1));
+		break;
+	  case I830_GMCH_GMS_LOCAL:
+		rdct = INREG8 (intel_i830_private.registers,I830_RDRAM_CHANNEL_TYPE);
+		gtt_entries = (I830_RDRAM_ND (rdct) + 1) * MB (ddt[I830_RDRAM_DDT (rdct)]);
+		printk (KERN_INFO PFX "detected %dK local memory.\n",gtt_entries / KB (1));
+		break;
+	  default:
+		printk (KERN_INFO PFX "no video memory detected.\n");
+		gtt_entries = 0;
+		break;
+	 }
+
+   gtt_entries /= KB (4);
+   intel_i830_private.gtt_entries = gtt_entries;
+}
+
+static int intel_i830_create_gatt_table (void)
+{
+   int page_order;
+   aper_size_info_fixed *size;
+   int num_entries;
+   u32 temp;
+
+   size = agp_bridge.current_size;
+   page_order = size->page_order;
+   num_entries = size->num_entries;
+   agp_bridge.gatt_table_real = 0;
+
+   pci_read_config_dword (intel_i830_private.i830_dev,I810_MMADDR,&temp);
+   temp &= 0xfff80000;
+
+   intel_i830_private.registers = (volatile u8 *) ioremap (temp,128 * 4096);
+   if (!intel_i830_private.registers) return (-ENOMEM);
+
+   temp = INREG32 (intel_i830_private.registers,I810_PGETBL_CTL) & 0xfffff000;
+   CACHE_FLUSH ();
+
+   /* we have to call this as early as possible after the MMIO base address is known */
+   intel_i830_init_gtt_entries ();
+
+   agp_bridge.gatt_table = NULL;
+   agp_bridge.gatt_bus_addr = temp;
+
+   return (0);
+}
+
+/* Return the gatt table to a sane state. Use the top of stolen memory for the GTT. */
+static int intel_i830_free_gatt_table (void)
+{
+   return (0);
+}
+
+static int intel_i830_fetch_size (void)
+{
+   u16 gmch_ctrl;
+   aper_size_info_fixed *values;
+
+   pci_read_config_word (agp_bridge.dev,I830_GMCH_CTRL,&gmch_ctrl);
+   values = A_SIZE_FIX (agp_bridge.aperture_sizes);
+
+   if ((gmch_ctrl & I830_GMCH_MEM_MASK) == I830_GMCH_MEM_128M)
+	 {
+		agp_bridge.previous_size = agp_bridge.current_size = (void *) values;
+		agp_bridge.aperture_size_idx = 0;
+		return (values[0].size);
+	 }
+   else
+	 {
+		agp_bridge.previous_size = agp_bridge.current_size = (void *) values;
+		agp_bridge.aperture_size_idx = 1;
+		return (values[1].size);
+	 }
+
+   return (0);
+}
+
+static int intel_i830_configure (void)
+{
+   aper_size_info_fixed *current_size;
+   u32 temp;
+   u16 gmch_ctrl;
+   int i;
+
+   current_size = A_SIZE_FIX (agp_bridge.current_size);
+
+   pci_read_config_dword (intel_i830_private.i830_dev,I810_GMADDR,&temp);
+   agp_bridge.gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+   pci_read_config_word (agp_bridge.dev,I830_GMCH_CTRL,&gmch_ctrl);
+   gmch_ctrl |= I830_GMCH_ENABLED;
+   pci_write_config_word (agp_bridge.dev,I830_GMCH_CTRL,gmch_ctrl);
+
+   OUTREG32 (intel_i830_private.registers,I810_PGETBL_CTL,agp_bridge.gatt_bus_addr | I810_PGETBL_ENABLED);
+   CACHE_FLUSH ();
+
+   if (agp_bridge.needs_scratch_page == TRUE)
+	 {
+		for (i = intel_i830_private.gtt_entries; i < current_size->num_entries; i++)
+		  OUTREG32 (intel_i830_private.registers,
+					I810_PTE_BASE + (i * 4),
+					agp_bridge.scratch_page);
+	 }
+
+   return (0);
+}
+
+static void intel_i830_cleanup (void)
+{
+   iounmap ((void *) intel_i830_private.registers);
+}
+
+static int intel_i830_insert_entries (agp_memory *mem,off_t pg_start,int type)
+{
+   int i,j,num_entries;
+   void *temp;
+
+   temp = agp_bridge.current_size;
+   num_entries = A_SIZE_FIX (temp)->num_entries;
+
+   if (pg_start < intel_i830_private.gtt_entries)
+	 {
+		printk (KERN_DEBUG "pg_start == 0x%.8lx,intel_i830_private.gtt_entries == 0x%.8x\n",
+				pg_start,intel_i830_private.gtt_entries);
+
+		printk ("Trying to insert into local/stolen memory\n");
+		return (-EINVAL);
+	 }
+
+   if ((pg_start + mem->page_count) > num_entries)
+	 return (-EINVAL);
+
+   /*
+	* The i830 can't check the GTT for entries since its read only,
+	* depend on the caller to make the correct offset decisions.
+	*/
+
+   if ((type != 0 && type != AGP_PHYS_MEMORY) || (mem->type != 0 && mem->type != AGP_PHYS_MEMORY))
+	 return (-EINVAL);
+
+   CACHE_FLUSH ();
+
+   for (i = 0, j = pg_start; i < mem->page_count; i++, j++)
+	 OUTREG32 (intel_i830_private.registers,I810_PTE_BASE + (j * 4),mem->memory[i]);
+
+   CACHE_FLUSH ();
+
+   agp_bridge.tlb_flush (mem);
+
+   return (0);
+}
+
+static int intel_i830_remove_entries (agp_memory *mem,off_t pg_start,int type)
+{
+   int i;
+
+   CACHE_FLUSH ();
+
+   if (pg_start < intel_i830_private.gtt_entries)
+	 {
+		printk ("Trying to disable local/stolen memory\n");
+		return (-EINVAL);
+	 }
+
+   for (i = pg_start; i < (mem->page_count + pg_start); i++)
+	 OUTREG32 (intel_i830_private.registers,I810_PTE_BASE + (i * 4),agp_bridge.scratch_page);
+
+   CACHE_FLUSH ();
+
+   agp_bridge.tlb_flush (mem);
+
+   return (0);
+}
+
+static agp_memory *intel_i830_alloc_by_type (size_t pg_count,int type)
+{
+   agp_memory *nw;
+
+   /* always return NULL for now */
+   if (type == AGP_DCACHE_MEMORY) return (NULL);
+
+   if (type == AGP_PHYS_MEMORY)
+	 {
+		unsigned long physical;
+
+		/*
+		 * The i830 requires a physical address to program
+		 * it's mouse pointer into hardware. However the
+		 * Xserver still writes to it through the agp
+		 * aperture
+		 */
+
+		if (pg_count != 1) return (NULL);
+
+		nw = agp_create_memory (1);
+
+		if (nw == NULL) return NULL;
+
+		MOD_INC_USE_COUNT;
+
+		nw->memory[0] = agp_bridge.agp_alloc_page ();
+		physical = nw->memory[0];
+		if (nw->memory[0] == 0)
+		  {
+			 /* free this structure */
+			 agp_free_memory (nw);
+			 return (NULL);
+		  }
+		nw->memory[0] = agp_bridge.mask_memory (virt_to_phys ((void *) nw->memory[0]),type);
+		nw->page_count = 1;
+		nw->num_scratch_pages = 1;
+		nw->type = AGP_PHYS_MEMORY;
+		nw->physical = virt_to_phys ((void *) physical);
+		return (nw);
+	 }
+
+   return (NULL);
+}
+
+static int __init intel_i830_setup (struct pci_dev *i830_dev)
+{
+   intel_i830_private.i830_dev = i830_dev;
+
+   agp_bridge.masks = intel_i810_masks;
+   agp_bridge.num_of_masks = 3;
+   agp_bridge.aperture_sizes = (void *) intel_i830_sizes;
+   agp_bridge.size_type = FIXED_APER_SIZE;
+   agp_bridge.num_aperture_sizes = 2;
+
+   agp_bridge.dev_private_data = (void *) &intel_i830_private;
+   agp_bridge.needs_scratch_page = TRUE;
+
+   agp_bridge.configure = intel_i830_configure;
+   agp_bridge.fetch_size = intel_i830_fetch_size;
+   agp_bridge.cleanup = intel_i830_cleanup;
+   agp_bridge.tlb_flush = intel_i810_tlbflush;
+   agp_bridge.mask_memory = intel_i810_mask_memory;
+   agp_bridge.agp_enable = intel_i810_agp_enable;
+   agp_bridge.cache_flush = global_cache_flush;
+
+   agp_bridge.create_gatt_table = intel_i830_create_gatt_table;
+   agp_bridge.free_gatt_table = intel_i830_free_gatt_table;
+
+   agp_bridge.insert_memory = intel_i830_insert_entries;
+   agp_bridge.remove_memory = intel_i830_remove_entries;
+   agp_bridge.alloc_by_type = intel_i830_alloc_by_type;
+   agp_bridge.free_by_type = intel_i810_free_by_type;
+   agp_bridge.agp_alloc_page = agp_generic_alloc_page;
+   agp_bridge.agp_destroy_page = agp_generic_destroy_page;
+
+   return (0);
+}
 #endif /* CONFIG_AGP_I810 */
 
 #ifdef CONFIG_AGP_INTEL
@@ -2911,6 +3210,13 @@
 		"Intel",
 		"i815",
 		intel_generic_setup },
+	/* could we add support for PCI_DEVICE_ID_INTEL_830_M_1 too ? */
+	{ PCI_DEVICE_ID_INTEL_830_M_0,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_I830_M,
+		"Intel",
+		"i830M",
+		intel_generic_setup },
 	{ PCI_DEVICE_ID_INTEL_840_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I840,
@@ -3186,17 +3492,40 @@
 						   PCI_DEVICE_ID_INTEL_815_1,
 						   NULL);
 			if (i810_dev == NULL) {
-				printk(KERN_ERR PFX "agpgart: Detected an "
+				printk(KERN_ERR PFX "Detected an "
 				       "Intel i815, but could not find the"
 				       " secondary device. Assuming a "
 				       "non-integrated video card.\n");
 				break;
 			}
-			printk(KERN_INFO PFX "agpgart: Detected an Intel i815 "
+			printk(KERN_INFO PFX "Detected an Intel i815 "
 			       "Chipset.\n");
 			agp_bridge.type = INTEL_I810;
 			return intel_i810_setup(i810_dev);
 
+		 case PCI_DEVICE_ID_INTEL_830_M_0:
+		   i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+									  PCI_DEVICE_ID_INTEL_830_M_1,
+									  NULL);
+		   if(PCI_FUNC(i810_dev->devfn) != 0)
+			 {
+				i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+										   PCI_DEVICE_ID_INTEL_830_M_1,
+										   i810_dev);
+			 }
+		   if (i810_dev == NULL)
+			 {
+				printk(KERN_ERR PFX "Detected an "
+					   "Intel i830, but could not find the"
+					   " secondary device.\n");
+				agp_bridge.type = NOT_SUPPORTED;
+				return (-ENODEV);
+			 }
+		   printk(KERN_INFO PFX "Detected an Intel "
+				  "i830 Chipset.\n");
+		   agp_bridge.type = INTEL_I810;
+		   return (intel_i830_setup (i810_dev));
+
 		default:
 			break;
 		}
@@ -3349,7 +3678,7 @@
 	size_value = agp_bridge.fetch_size();
 
 	if (size_value == 0) {
-		printk(KERN_ERR PFX "unable to detrimine aperture size.\n");
+		printk(KERN_ERR PFX "unable to determine aperture size.\n");
 		rc = -EINVAL;
 		goto err_out;
 	}
diff -Nru linux.orig/include/linux/agp_backend.h linux/include/linux/agp_backend.h
--- linux.orig/include/linux/agp_backend.h	Tue Jul  3 00:27:56 2001
+++ linux/include/linux/agp_backend.h	Wed Sep 19 15:34:08 2001
@@ -46,6 +46,7 @@
 	INTEL_GX,
 	INTEL_I810,
 	INTEL_I815,
+	INTEL_I830_M,
 	INTEL_I840,
 	INTEL_I850,
 	VIA_GENERIC,


-- 

Regards
 Abraham

A woman is like your shadow; follow her, she flies; fly from her, she follows.
		-- Chamfort

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa

