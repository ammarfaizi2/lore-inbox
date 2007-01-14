Return-Path: <linux-kernel-owner+w=401wt.eu-S1750912AbXANBAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbXANBAb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbXANBAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:00:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52752 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbXANBAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:00:25 -0500
Subject: [patch 02/12] mark struct file_operations const 2
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:53:23 -0800
Message-Id: <1168736003.3123.321.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 02/12] mark struct file_operations const

Many struct file_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6/arch/arm/common/rtctime.c
===================================================================
--- linux-2.6.orig/arch/arm/common/rtctime.c
+++ linux-2.6/arch/arm/common/rtctime.c
@@ -329,7 +329,7 @@ static int rtc_fasync(int fd, struct fil
 	return fasync_helper(fd, file, on, &rtc_async_queue);
 }
 
-static struct file_operations rtc_fops = {
+static const struct file_operations rtc_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= rtc_read,
Index: linux-2.6/arch/arm/kernel/apm.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/apm.c
+++ linux-2.6/arch/arm/kernel/apm.c
@@ -446,7 +446,7 @@ static int apm_open(struct inode * inode
 	return as ? 0 : -ENOMEM;
 }
 
-static struct file_operations apm_bios_fops = {
+static const struct file_operations apm_bios_fops = {
 	.owner		= THIS_MODULE,
 	.read		= apm_read,
 	.poll		= apm_poll,
Index: linux-2.6/arch/arm/mach-at91rm9200/clock.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-at91rm9200/clock.c
+++ linux-2.6/arch/arm/mach-at91rm9200/clock.c
@@ -407,7 +407,7 @@ static int at91_clk_open(struct inode *i
 	return single_open(file, at91_clk_show, NULL);
 }
 
-static struct file_operations at91_clk_operations = {
+static const struct file_operations at91_clk_operations = {
 	.open		= at91_clk_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/arch/avr32/mm/tlb.c
===================================================================
--- linux-2.6.orig/arch/avr32/mm/tlb.c
+++ linux-2.6/arch/avr32/mm/tlb.c
@@ -360,7 +360,7 @@ static int tlb_open(struct inode *inode,
 	return seq_open(file, &tlb_ops);
 }
 
-static struct file_operations proc_tlb_operations = {
+static const struct file_operations proc_tlb_operations = {
 	.open		= tlb_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/arch/cris/arch-v10/drivers/ds1302.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v10/drivers/ds1302.c
+++ linux-2.6/arch/cris/arch-v10/drivers/ds1302.c
@@ -499,7 +499,7 @@ print_rtc_status(void)
 
 /* The various file operations we support. */
 
-static struct file_operations rtc_fops = {
+static const struct file_operations rtc_fops = {
 	.owner =	THIS_MODULE,
 	.ioctl =	rtc_ioctl,
 }; 
Index: linux-2.6/arch/cris/arch-v10/drivers/eeprom.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v10/drivers/eeprom.c
+++ linux-2.6/arch/cris/arch-v10/drivers/eeprom.c
@@ -172,7 +172,7 @@ static const char eeprom_name[] = "eepro
 static struct eeprom_type eeprom;
 
 /* This is the exported file-operations structure for this device. */
-struct file_operations eeprom_fops =
+const struct file_operations eeprom_fops =
 {
   .llseek  = eeprom_lseek,
   .read    = eeprom_read,
Index: linux-2.6/arch/cris/arch-v10/drivers/gpio.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v10/drivers/gpio.c
+++ linux-2.6/arch/cris/arch-v10/drivers/gpio.c
@@ -838,7 +838,7 @@ gpio_leds_ioctl(unsigned int cmd, unsign
 	return 0;
 }
 
-struct file_operations gpio_fops = {
+const struct file_operations gpio_fops = {
 	.owner       = THIS_MODULE,
 	.poll        = gpio_poll,
 	.ioctl       = gpio_ioctl,
Index: linux-2.6/arch/cris/arch-v10/drivers/i2c.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v10/drivers/i2c.c
+++ linux-2.6/arch/cris/arch-v10/drivers/i2c.c
@@ -692,7 +692,7 @@ i2c_ioctl(struct inode *inode, struct fi
 	return 0;
 }
 
-static struct file_operations i2c_fops = {
+static const struct file_operations i2c_fops = {
 	.owner    = THIS_MODULE,
 	.ioctl    = i2c_ioctl,
 	.open     = i2c_open,
Index: linux-2.6/arch/cris/arch-v10/drivers/pcf8563.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v10/drivers/pcf8563.c
+++ linux-2.6/arch/cris/arch-v10/drivers/pcf8563.c
@@ -56,7 +56,7 @@ static const unsigned char days_in_month
 
 int pcf8563_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
 
-static struct file_operations pcf8563_fops = {
+static const struct file_operations pcf8563_fops = {
 	.owner = THIS_MODULE,
 	.ioctl = pcf8563_ioctl,
 };
Index: linux-2.6/arch/cris/arch-v32/drivers/cryptocop.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/drivers/cryptocop.c
+++ linux-2.6/arch/cris/arch-v32/drivers/cryptocop.c
@@ -266,7 +266,7 @@ static void print_user_dma_lists(struct 
 
 
 
-struct file_operations cryptocop_fops = {
+const struct file_operations cryptocop_fops = {
 	owner: THIS_MODULE,
 	open: cryptocop_open,
 	release: cryptocop_release,
Index: linux-2.6/arch/cris/arch-v32/drivers/gpio.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/drivers/gpio.c
+++ linux-2.6/arch/cris/arch-v32/drivers/gpio.c
@@ -705,7 +705,7 @@ gpio_leds_ioctl(unsigned int cmd, unsign
 	return 0;
 }
 
-struct file_operations gpio_fops = {
+const struct file_operations gpio_fops = {
 	.owner       = THIS_MODULE,
 	.poll        = gpio_poll,
 	.ioctl       = gpio_ioctl,
Index: linux-2.6/arch/cris/arch-v32/drivers/i2c.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/drivers/i2c.c
+++ linux-2.6/arch/cris/arch-v32/drivers/i2c.c
@@ -573,7 +573,7 @@ i2c_ioctl(struct inode *inode, struct fi
 	return 0;
 }
 
-static struct file_operations i2c_fops = {
+static const struct file_operations i2c_fops = {
 	owner:    THIS_MODULE,
 	ioctl:    i2c_ioctl,
 	open:     i2c_open,
Index: linux-2.6/arch/cris/arch-v32/drivers/pcf8563.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/drivers/pcf8563.c
+++ linux-2.6/arch/cris/arch-v32/drivers/pcf8563.c
@@ -50,7 +50,7 @@ int pcf8563_ioctl(struct inode *, struct
 int pcf8563_open(struct inode *, struct file *);
 int pcf8563_release(struct inode *, struct file *);
 
-static struct file_operations pcf8563_fops = {
+static const struct file_operations pcf8563_fops = {
 	owner: THIS_MODULE,
 	ioctl: pcf8563_ioctl,
 	open: pcf8563_open,
Index: linux-2.6/arch/cris/arch-v32/drivers/sync_serial.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/drivers/sync_serial.c
+++ linux-2.6/arch/cris/arch-v32/drivers/sync_serial.c
@@ -187,7 +187,7 @@ static struct sync_port ports[]=
 
 #define NUMBER_OF_PORTS (sizeof(ports)/sizeof(sync_port))
 
-static struct file_operations sync_serial_fops = {
+static const struct file_operations sync_serial_fops = {
 	.owner   = THIS_MODULE,
 	.write   = sync_serial_write,
 	.read    = sync_serial_read,
Index: linux-2.6/arch/cris/kernel/profile.c
===================================================================
--- linux-2.6.orig/arch/cris/kernel/profile.c
+++ linux-2.6/arch/cris/kernel/profile.c
@@ -50,7 +50,7 @@ write_cris_profile(struct file *file, co
   memset(sample_buffer, 0, SAMPLE_BUFFER_SIZE);
 }
 
-static struct file_operations cris_proc_profile_operations = {
+static const struct file_operations cris_proc_profile_operations = {
 	.read		= read_cris_profile,
 	.write		= write_cris_profile,
 };
Index: linux-2.6/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/apm.c
+++ linux-2.6/arch/i386/kernel/apm.c
@@ -1894,7 +1894,7 @@ static int __init apm_setup(char *str)
 __setup("apm=", apm_setup);
 #endif
 
-static struct file_operations apm_bios_fops = {
+static const struct file_operations apm_bios_fops = {
 	.owner		= THIS_MODULE,
 	.read		= do_read,
 	.poll		= do_poll,
Index: linux-2.6/arch/i386/kernel/cpu/mtrr/if.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/cpu/mtrr/if.c
+++ linux-2.6/arch/i386/kernel/cpu/mtrr/if.c
@@ -339,7 +339,7 @@ static int mtrr_open(struct inode *inode
 	return single_open(file, mtrr_seq_show, NULL);
 }
 
-static struct file_operations mtrr_fops = {
+static const struct file_operations mtrr_fops = {
 	.owner   = THIS_MODULE,
 	.open	 = mtrr_open, 
 	.read    = seq_read,
Index: linux-2.6/arch/i386/kernel/cpuid.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/cpuid.c
+++ linux-2.6/arch/i386/kernel/cpuid.c
@@ -148,7 +148,7 @@ static int cpuid_open(struct inode *inod
 /*
  * File operations we support
  */
-static struct file_operations cpuid_fops = {
+static const struct file_operations cpuid_fops = {
 	.owner = THIS_MODULE,
 	.llseek = cpuid_seek,
 	.read = cpuid_read,
Index: linux-2.6/arch/i386/kernel/microcode.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/microcode.c
+++ linux-2.6/arch/i386/kernel/microcode.c
@@ -451,7 +451,7 @@ static ssize_t microcode_write (struct f
 	return ret;
 }
 
-static struct file_operations microcode_fops = {
+static const struct file_operations microcode_fops = {
 	.owner		= THIS_MODULE,
 	.write		= microcode_write,
 	.open		= microcode_open,
Index: linux-2.6/arch/i386/kernel/msr.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/msr.c
+++ linux-2.6/arch/i386/kernel/msr.c
@@ -230,7 +230,7 @@ static int msr_open(struct inode *inode,
 /*
  * File operations we support
  */
-static struct file_operations msr_fops = {
+static const struct file_operations msr_fops = {
 	.owner = THIS_MODULE,
 	.llseek = msr_seek,
 	.read = msr_read,
Index: linux-2.6/arch/ia64/hp/common/sba_iommu.c
===================================================================
--- linux-2.6.orig/arch/ia64/hp/common/sba_iommu.c
+++ linux-2.6/arch/ia64/hp/common/sba_iommu.c
@@ -1881,7 +1881,7 @@ ioc_open(struct inode *inode, struct fil
 	return seq_open(file, &ioc_seq_ops);
 }
 
-static struct file_operations ioc_fops = {
+static const struct file_operations ioc_fops = {
 	.open    = ioc_open,
 	.read    = seq_read,
 	.llseek  = seq_lseek,
Index: linux-2.6/arch/ia64/kernel/perfmon.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/perfmon.c
+++ linux-2.6/arch/ia64/kernel/perfmon.c
@@ -621,7 +621,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(pfm_syst_info)
 
 
 /* forward declaration */
-static struct file_operations pfm_file_ops;
+static const struct file_operations pfm_file_ops;
 
 /*
  * forward declarations
@@ -2126,7 +2126,7 @@ pfm_no_open(struct inode *irrelevant, st
 
 
 
-static struct file_operations pfm_file_ops = {
+static const struct file_operations pfm_file_ops = {
 	.llseek   = no_llseek,
 	.read     = pfm_read,
 	.write    = pfm_write,
@@ -6597,7 +6597,7 @@ found:
 	return 0;
 }
 
-static struct file_operations pfm_proc_fops = {
+static const struct file_operations pfm_proc_fops = {
 	.open		= pfm_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/arch/ia64/kernel/salinfo.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/salinfo.c
+++ linux-2.6/arch/ia64/kernel/salinfo.c
@@ -352,7 +352,7 @@ retry:
 	return size;
 }
 
-static struct file_operations salinfo_event_fops = {
+static const struct file_operations salinfo_event_fops = {
 	.open  = salinfo_event_open,
 	.read  = salinfo_event_read,
 };
@@ -568,7 +568,7 @@ salinfo_log_write(struct file *file, con
 	return count;
 }
 
-static struct file_operations salinfo_data_fops = {
+static const struct file_operations salinfo_data_fops = {
 	.open    = salinfo_log_open,
 	.release = salinfo_log_release,
 	.read    = salinfo_log_read,
Index: linux-2.6/arch/ia64/sn/kernel/sn2/sn2_smp.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/sn2/sn2_smp.c
+++ linux-2.6/arch/ia64/sn/kernel/sn2/sn2_smp.c
@@ -455,7 +455,7 @@ static int sn2_ptc_proc_open(struct inod
 	return seq_open(file, &sn2_ptc_seq_ops);
 }
 
-static struct file_operations proc_sn2_ptc_operations = {
+static const struct file_operations proc_sn2_ptc_operations = {
 	.open = sn2_ptc_proc_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
Index: linux-2.6/arch/ia64/sn/kernel/sn2/sn_hwperf.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/sn2/sn_hwperf.c
+++ linux-2.6/arch/ia64/sn/kernel/sn2/sn_hwperf.c
@@ -865,7 +865,7 @@ error:
 	return r;
 }
 
-static struct file_operations sn_hwperf_fops = {
+static const struct file_operations sn_hwperf_fops = {
 	.ioctl = sn_hwperf_ioctl,
 };
 
Index: linux-2.6/arch/m68k/bvme6000/rtc.c
===================================================================
--- linux-2.6.orig/arch/m68k/bvme6000/rtc.c
+++ linux-2.6/arch/m68k/bvme6000/rtc.c
@@ -159,7 +159,7 @@ static int rtc_release(struct inode *ino
  *	The various file operations we support.
  */
 
-static struct file_operations rtc_fops = {
+static const struct file_operations rtc_fops = {
 	.ioctl =	rtc_ioctl,
 	.open =		rtc_open,
 	.release =	rtc_release,
Index: linux-2.6/arch/m68k/mvme16x/rtc.c
===================================================================
--- linux-2.6.orig/arch/m68k/mvme16x/rtc.c
+++ linux-2.6/arch/m68k/mvme16x/rtc.c
@@ -147,7 +147,7 @@ static int rtc_release(struct inode *ino
  *	The various file operations we support.
  */
 
-static struct file_operations rtc_fops = {
+static const struct file_operations rtc_fops = {
 	.ioctl =	rtc_ioctl,
 	.open =		rtc_open,
 	.release =	rtc_release,
Index: linux-2.6/arch/mips/basler/excite/excite_iodev.c
===================================================================
--- linux-2.6.orig/arch/mips/basler/excite/excite_iodev.c
+++ linux-2.6/arch/mips/basler/excite/excite_iodev.c
@@ -48,7 +48,7 @@ static DECLARE_WAIT_QUEUE_HEAD(wq);
 
 
 
-static struct file_operations fops =
+static const struct file_operations fops =
 {
 	.owner		= THIS_MODULE,
 	.open		= iodev_open,
Index: linux-2.6/arch/mips/kernel/apm.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/apm.c
+++ linux-2.6/arch/mips/kernel/apm.c
@@ -379,7 +379,7 @@ static int apm_open(struct inode * inode
 	return as ? 0 : -ENOMEM;
 }
 
-static struct file_operations apm_bios_fops = {
+static const struct file_operations apm_bios_fops = {
 	.owner		= THIS_MODULE,
 	.read		= apm_read,
 	.poll		= apm_poll,
Index: linux-2.6/arch/mips/kernel/rtlx.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/rtlx.c
+++ linux-2.6/arch/mips/kernel/rtlx.c
@@ -476,7 +476,7 @@ static ssize_t file_write(struct file *f
 	return rtlx_write(minor, (void *)buffer, count, 1);
 }
 
-static struct file_operations rtlx_fops = {
+static const struct file_operations rtlx_fops = {
 	.owner =   THIS_MODULE,
 	.open =    file_open,
 	.release = file_release,
Index: linux-2.6/arch/mips/kernel/vpe.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/vpe.c
+++ linux-2.6/arch/mips/kernel/vpe.c
@@ -1202,7 +1202,7 @@ static ssize_t vpe_write(struct file *fi
 	return ret;
 }
 
-static struct file_operations vpe_fops = {
+static const struct file_operations vpe_fops = {
 	.owner = THIS_MODULE,
 	.open = vpe_open,
 	.release = vpe_release,
Index: linux-2.6/arch/mips/sibyte/sb1250/bcm1250_tbprof.c
===================================================================
--- linux-2.6.orig/arch/mips/sibyte/sb1250/bcm1250_tbprof.c
+++ linux-2.6/arch/mips/sibyte/sb1250/bcm1250_tbprof.c
@@ -374,7 +374,7 @@ static long sbprof_tb_ioctl(struct file 
 	return error;
 }
 
-static struct file_operations sbprof_tb_fops = {
+static const struct file_operations sbprof_tb_fops = {
 	.owner		= THIS_MODULE,
 	.open		= sbprof_tb_open,
 	.release	= sbprof_tb_release,
Index: linux-2.6/arch/parisc/kernel/perf.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/perf.c
+++ linux-2.6/arch/parisc/kernel/perf.c
@@ -479,7 +479,7 @@ static long perf_ioctl(struct file *file
 	return error;
 }
 
-static struct file_operations perf_fops = {
+static const struct file_operations perf_fops = {
 	.llseek = no_llseek,
 	.read = perf_read,
 	.write = perf_write,
Index: linux-2.6/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/lparcfg.c
+++ linux-2.6/arch/powerpc/kernel/lparcfg.c
@@ -567,7 +567,7 @@ static int lparcfg_open(struct inode *in
 	return single_open(file, lparcfg_data, NULL);
 }
 
-struct file_operations lparcfg_fops = {
+const struct file_operations lparcfg_fops = {
 	.owner		= THIS_MODULE,
 	.read		= seq_read,
 	.write		= lparcfg_write,
Index: linux-2.6/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/nvram_64.c
+++ linux-2.6/arch/powerpc/kernel/nvram_64.c
@@ -179,7 +179,7 @@ static int dev_nvram_ioctl(struct inode 
 	}
 }
 
-struct file_operations nvram_fops = {
+const struct file_operations nvram_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	dev_nvram_llseek,
 	.read =		dev_nvram_read,
Index: linux-2.6/arch/powerpc/kernel/proc_ppc64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/proc_ppc64.c
+++ linux-2.6/arch/powerpc/kernel/proc_ppc64.c
@@ -33,7 +33,7 @@ static ssize_t page_map_read( struct fil
 			      loff_t *ppos);
 static int     page_map_mmap( struct file *file, struct vm_area_struct *vma );
 
-static struct file_operations page_map_fops = {
+static const struct file_operations page_map_fops = {
 	.llseek	= page_map_seek,
 	.read	= page_map_read,
 	.mmap	= page_map_mmap
Index: linux-2.6/arch/powerpc/kernel/rtas_flash.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/rtas_flash.c
+++ linux-2.6/arch/powerpc/kernel/rtas_flash.c
@@ -702,7 +702,7 @@ static int initialize_flash_pde_data(con
 }
 
 static struct proc_dir_entry *create_flash_pde(const char *filename,
-					       struct file_operations *fops)
+					       const struct file_operations *fops)
 {
 	struct proc_dir_entry *ent = NULL;
 
@@ -716,21 +716,21 @@ static struct proc_dir_entry *create_fla
 	return ent;
 }
 
-static struct file_operations rtas_flash_operations = {
+static const struct file_operations rtas_flash_operations = {
 	.read		= rtas_flash_read,
 	.write		= rtas_flash_write,
 	.open		= rtas_excl_open,
 	.release	= rtas_flash_release,
 };
 
-static struct file_operations manage_flash_operations = {
+static const struct file_operations manage_flash_operations = {
 	.read		= manage_flash_read,
 	.write		= manage_flash_write,
 	.open		= rtas_excl_open,
 	.release	= rtas_excl_release,
 };
 
-static struct file_operations validate_flash_operations = {
+static const struct file_operations validate_flash_operations = {
 	.read		= validate_flash_read,
 	.write		= validate_flash_write,
 	.open		= rtas_excl_open,
Index: linux-2.6/arch/powerpc/kernel/rtas-proc.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/rtas-proc.c
+++ linux-2.6/arch/powerpc/kernel/rtas-proc.c
@@ -160,7 +160,7 @@ static int sensors_open(struct inode *in
 	return single_open(file, ppc_rtas_sensors_show, NULL);
 }
 
-struct file_operations ppc_rtas_sensors_operations = {
+const struct file_operations ppc_rtas_sensors_operations = {
 	.open		= sensors_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -172,7 +172,7 @@ static int poweron_open(struct inode *in
 	return single_open(file, ppc_rtas_poweron_show, NULL);
 }
 
-struct file_operations ppc_rtas_poweron_operations = {
+const struct file_operations ppc_rtas_poweron_operations = {
 	.open		= poweron_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -185,7 +185,7 @@ static int progress_open(struct inode *i
 	return single_open(file, ppc_rtas_progress_show, NULL);
 }
 
-struct file_operations ppc_rtas_progress_operations = {
+const struct file_operations ppc_rtas_progress_operations = {
 	.open		= progress_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -198,7 +198,7 @@ static int clock_open(struct inode *inod
 	return single_open(file, ppc_rtas_clock_show, NULL);
 }
 
-struct file_operations ppc_rtas_clock_operations = {
+const struct file_operations ppc_rtas_clock_operations = {
 	.open		= clock_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -211,7 +211,7 @@ static int tone_freq_open(struct inode *
 	return single_open(file, ppc_rtas_tone_freq_show, NULL);
 }
 
-struct file_operations ppc_rtas_tone_freq_operations = {
+const struct file_operations ppc_rtas_tone_freq_operations = {
 	.open		= tone_freq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -224,7 +224,7 @@ static int tone_volume_open(struct inode
 	return single_open(file, ppc_rtas_tone_volume_show, NULL);
 }
 
-struct file_operations ppc_rtas_tone_volume_operations = {
+const struct file_operations ppc_rtas_tone_volume_operations = {
 	.open		= tone_volume_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -237,7 +237,7 @@ static int rmo_buf_open(struct inode *in
 	return single_open(file, ppc_rtas_rmo_buf_show, NULL);
 }
 
-struct file_operations ppc_rtas_rmo_buf_ops = {
+const struct file_operations ppc_rtas_rmo_buf_ops = {
 	.open		= rmo_buf_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -144,7 +144,7 @@ spufs_mem_mmap(struct file *file, struct
 	return 0;
 }
 
-static struct file_operations spufs_mem_fops = {
+static const struct file_operations spufs_mem_fops = {
 	.open	 = spufs_mem_open,
 	.read    = spufs_mem_read,
 	.write   = spufs_mem_write,
@@ -249,7 +249,7 @@ static int spufs_cntl_open(struct inode 
 					spufs_cntl_set, "0x%08lx");
 }
 
-static struct file_operations spufs_cntl_fops = {
+static const struct file_operations spufs_cntl_fops = {
 	.open = spufs_cntl_open,
 	.release = simple_attr_close,
 	.read = simple_attr_read,
@@ -309,7 +309,7 @@ spufs_regs_write(struct file *file, cons
 	return ret;
 }
 
-static struct file_operations spufs_regs_fops = {
+static const struct file_operations spufs_regs_fops = {
 	.open	 = spufs_regs_open,
 	.read    = spufs_regs_read,
 	.write   = spufs_regs_write,
@@ -360,7 +360,7 @@ spufs_fpcr_write(struct file *file, cons
 	return ret;
 }
 
-static struct file_operations spufs_fpcr_fops = {
+static const struct file_operations spufs_fpcr_fops = {
 	.open = spufs_regs_open,
 	.read = spufs_fpcr_read,
 	.write = spufs_fpcr_write,
@@ -426,7 +426,7 @@ static ssize_t spufs_mbox_read(struct fi
 	return count;
 }
 
-static struct file_operations spufs_mbox_fops = {
+static const struct file_operations spufs_mbox_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_mbox_read,
 };
@@ -452,7 +452,7 @@ static ssize_t spufs_mbox_stat_read(stru
 	return 4;
 }
 
-static struct file_operations spufs_mbox_stat_fops = {
+static const struct file_operations spufs_mbox_stat_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_mbox_stat_read,
 };
@@ -559,7 +559,7 @@ static unsigned int spufs_ibox_poll(stru
 	return mask;
 }
 
-static struct file_operations spufs_ibox_fops = {
+static const struct file_operations spufs_ibox_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_ibox_read,
 	.poll	= spufs_ibox_poll,
@@ -585,7 +585,7 @@ static ssize_t spufs_ibox_stat_read(stru
 	return 4;
 }
 
-static struct file_operations spufs_ibox_stat_fops = {
+static const struct file_operations spufs_ibox_stat_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_ibox_stat_read,
 };
@@ -692,7 +692,7 @@ static unsigned int spufs_wbox_poll(stru
 	return mask;
 }
 
-static struct file_operations spufs_wbox_fops = {
+static const struct file_operations spufs_wbox_fops = {
 	.open	= spufs_pipe_open,
 	.write	= spufs_wbox_write,
 	.poll	= spufs_wbox_poll,
@@ -718,7 +718,7 @@ static ssize_t spufs_wbox_stat_read(stru
 	return 4;
 }
 
-static struct file_operations spufs_wbox_stat_fops = {
+static const struct file_operations spufs_wbox_stat_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_wbox_stat_read,
 };
@@ -823,7 +823,7 @@ static int spufs_signal1_mmap(struct fil
 	return 0;
 }
 
-static struct file_operations spufs_signal1_fops = {
+static const struct file_operations spufs_signal1_fops = {
 	.open = spufs_signal1_open,
 	.read = spufs_signal1_read,
 	.write = spufs_signal1_write,
@@ -934,7 +934,7 @@ static int spufs_signal2_mmap(struct fil
 #define spufs_signal2_mmap NULL
 #endif /* !SPUFS_MMAP_4K */
 
-static struct file_operations spufs_signal2_fops = {
+static const struct file_operations spufs_signal2_fops = {
 	.open = spufs_signal2_open,
 	.read = spufs_signal2_read,
 	.write = spufs_signal2_write,
@@ -1037,7 +1037,7 @@ static int spufs_mss_open(struct inode *
 	return nonseekable_open(inode, file);
 }
 
-static struct file_operations spufs_mss_fops = {
+static const struct file_operations spufs_mss_fops = {
 	.open	 = spufs_mss_open,
 	.mmap	 = spufs_mss_mmap,
 };
@@ -1076,7 +1076,7 @@ static int spufs_psmap_open(struct inode
 	return nonseekable_open(inode, file);
 }
 
-static struct file_operations spufs_psmap_fops = {
+static const struct file_operations spufs_psmap_fops = {
 	.open	 = spufs_psmap_open,
 	.mmap	 = spufs_psmap_mmap,
 };
@@ -1393,7 +1393,7 @@ static int spufs_mfc_fasync(int fd, stru
 	return fasync_helper(fd, file, on, &ctx->mfc_fasync);
 }
 
-static struct file_operations spufs_mfc_fops = {
+static const struct file_operations spufs_mfc_fops = {
 	.open	 = spufs_mfc_open,
 	.read	 = spufs_mfc_read,
 	.write	 = spufs_mfc_write,
@@ -1650,7 +1650,7 @@ static ssize_t spufs_mbox_info_read(stru
 	return ret;
 }
 
-static struct file_operations spufs_mbox_info_fops = {
+static const struct file_operations spufs_mbox_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_mbox_info_read,
 	.llseek  = generic_file_llseek,
@@ -1688,7 +1688,7 @@ static ssize_t spufs_ibox_info_read(stru
 	return ret;
 }
 
-static struct file_operations spufs_ibox_info_fops = {
+static const struct file_operations spufs_ibox_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_ibox_info_read,
 	.llseek  = generic_file_llseek,
@@ -1729,7 +1729,7 @@ static ssize_t spufs_wbox_info_read(stru
 	return ret;
 }
 
-static struct file_operations spufs_wbox_info_fops = {
+static const struct file_operations spufs_wbox_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_wbox_info_read,
 	.llseek  = generic_file_llseek,
@@ -1779,7 +1779,7 @@ static ssize_t spufs_dma_info_read(struc
 	return ret;
 }
 
-static struct file_operations spufs_dma_info_fops = {
+static const struct file_operations spufs_dma_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_dma_info_read,
 };
@@ -1830,7 +1830,7 @@ static ssize_t spufs_proxydma_info_read(
 	return ret;
 }
 
-static struct file_operations spufs_proxydma_info_fops = {
+static const struct file_operations spufs_proxydma_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_proxydma_info_read,
 };
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -224,7 +224,7 @@ struct inode_operations spufs_dir_inode_
 	.lookup = simple_lookup,
 };
 
-struct file_operations spufs_context_fops = {
+const struct file_operations spufs_context_fops = {
 	.open		= dcache_dir_open,
 	.release	= spufs_dir_close,
 	.llseek		= dcache_dir_lseek,
@@ -372,7 +372,7 @@ static int spufs_gang_close(struct inode
 	return dcache_dir_close(inode, file);
 }
 
-struct file_operations spufs_gang_fops = {
+const struct file_operations spufs_gang_fops = {
 	.open		= dcache_dir_open,
 	.release	= spufs_gang_close,
 	.llseek		= dcache_dir_lseek,
Index: linux-2.6/arch/powerpc/platforms/iseries/lpevents.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/lpevents.c
+++ linux-2.6/arch/powerpc/platforms/iseries/lpevents.c
@@ -308,7 +308,7 @@ static int proc_lpevents_open(struct ino
 	return single_open(file, proc_lpevents_show, NULL);
 }
 
-static struct file_operations proc_lpevents_operations = {
+static const struct file_operations proc_lpevents_operations = {
 	.open		= proc_lpevents_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/arch/powerpc/platforms/iseries/mf.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/mf.c
+++ linux-2.6/arch/powerpc/platforms/iseries/mf.c
@@ -1224,7 +1224,7 @@ out:
 	return rc;
 }
 
-static struct file_operations proc_vmlinux_operations = {
+static const struct file_operations proc_vmlinux_operations = {
 	.write		= proc_mf_change_vmlinux,
 };
 
Index: linux-2.6/arch/powerpc/platforms/iseries/proc.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/proc.c
+++ linux-2.6/arch/powerpc/platforms/iseries/proc.c
@@ -101,7 +101,7 @@ static int proc_titantod_open(struct ino
 	return single_open(file, proc_titantod_show, NULL);
 }
 
-static struct file_operations proc_titantod_operations = {
+static const struct file_operations proc_titantod_operations = {
 	.open		= proc_titantod_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/arch/powerpc/platforms/iseries/viopath.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/viopath.c
+++ linux-2.6/arch/powerpc/platforms/iseries/viopath.c
@@ -173,7 +173,7 @@ static int proc_viopath_open(struct inod
 	return single_open(file, proc_viopath_show, NULL);
 }
 
-static struct file_operations proc_viopath_operations = {
+static const struct file_operations proc_viopath_operations = {
 	.open		= proc_viopath_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/eeh.c
+++ linux-2.6/arch/powerpc/platforms/pseries/eeh.c
@@ -1065,7 +1065,7 @@ static int proc_eeh_open(struct inode *i
 	return single_open(file, proc_eeh_show, NULL);
 }
 
-static struct file_operations proc_eeh_operations = {
+static const struct file_operations proc_eeh_operations = {
 	.open      = proc_eeh_open,
 	.read      = seq_read,
 	.llseek    = seq_lseek,
Index: linux-2.6/arch/powerpc/platforms/pseries/hvCall_inst.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ linux-2.6/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -90,7 +90,7 @@ static int hcall_inst_seq_open(struct in
 	return rc;
 }
 
-static struct file_operations hcall_inst_seq_fops = {
+static const struct file_operations hcall_inst_seq_fops = {
 	.open = hcall_inst_seq_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
Index: linux-2.6/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/reconfig.c
+++ linux-2.6/arch/powerpc/platforms/pseries/reconfig.c
@@ -499,7 +499,7 @@ out:
 	return rv ? rv : count;
 }
 
-static struct file_operations ofdt_fops = {
+static const struct file_operations ofdt_fops = {
 	.write = ofdt_write
 };
 
Index: linux-2.6/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/rtasd.c
+++ linux-2.6/arch/powerpc/platforms/pseries/rtasd.c
@@ -331,7 +331,7 @@ static unsigned int rtas_log_poll(struct
 	return 0;
 }
 
-struct file_operations proc_rtas_log_operations = {
+const struct file_operations proc_rtas_log_operations = {
 	.read =		rtas_log_read,
 	.poll =		rtas_log_poll,
 	.open =		rtas_log_open,
Index: linux-2.6/arch/powerpc/platforms/pseries/scanlog.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/scanlog.c
+++ linux-2.6/arch/powerpc/platforms/pseries/scanlog.c
@@ -184,7 +184,7 @@ static int scanlog_release(struct inode 
 	return 0;
 }
 
-struct file_operations scanlog_fops = {
+const struct file_operations scanlog_fops = {
 	.owner		= THIS_MODULE,
 	.read		= scanlog_read,
 	.write		= scanlog_write,
Index: linux-2.6/arch/ppc/8xx_io/cs4218_tdm.c
===================================================================
--- linux-2.6.orig/arch/ppc/8xx_io/cs4218_tdm.c
+++ linux-2.6/arch/ppc/8xx_io/cs4218_tdm.c
@@ -1712,7 +1712,7 @@ static int mixer_ioctl(struct inode *ino
 }
 
 
-static struct file_operations mixer_fops =
+static const struct file_operations mixer_fops =
 {
 	.owner =	THIS_MODULE,
 	.llseek =	sound_lseek,
@@ -2299,7 +2299,7 @@ static int sq_ioctl(struct inode *inode,
 
 
 
-static struct file_operations sq_fops =
+static const struct file_operations sq_fops =
 {
 	.owner =	THIS_MODULE,
 	.llseek =	sound_lseek,
@@ -2434,7 +2434,7 @@ static ssize_t state_read(struct file *f
 }
 
 
-static struct file_operations state_fops =
+static const struct file_operations state_fops =
 {
 	.owner =	THIS_MODULE,
 	.llseek =	sound_lseek,
Index: linux-2.6/arch/s390/hypfs/inode.c
===================================================================
--- linux-2.6.orig/arch/s390/hypfs/inode.c
+++ linux-2.6/arch/s390/hypfs/inode.c
@@ -35,7 +35,7 @@ struct hypfs_sb_info {
 	struct mutex lock;		/* lock to protect update process */
 };
 
-static struct file_operations hypfs_file_ops;
+static const struct file_operations hypfs_file_ops;
 static struct file_system_type hypfs_type;
 static struct super_operations hypfs_s_ops;
 
@@ -435,7 +435,7 @@ struct dentry *hypfs_create_str(struct s
 	return dentry;
 }
 
-static struct file_operations hypfs_file_ops = {
+static const struct file_operations hypfs_file_ops = {
 	.open		= hypfs_open,
 	.release	= hypfs_release,
 	.read		= do_sync_read,
Index: linux-2.6/arch/s390/kernel/debug.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/debug.c
+++ linux-2.6/arch/s390/kernel/debug.c
@@ -167,7 +167,7 @@ DECLARE_MUTEX(debug_lock);
 
 static int initialized;
 
-static struct file_operations debug_file_ops = {
+static const struct file_operations debug_file_ops = {
 	.owner   = THIS_MODULE,
 	.read    = debug_output,
 	.write   = debug_input,
Index: linux-2.6/arch/sh/boards/landisk/landisk_pwb.c
===================================================================
--- linux-2.6.orig/arch/sh/boards/landisk/landisk_pwb.c
+++ linux-2.6/arch/sh/boards/landisk/landisk_pwb.c
@@ -150,7 +150,7 @@ static irqreturn_t sw_interrupt(int irq,
 	return IRQ_HANDLED;
 }
 
-static struct file_operations swdrv_fops = {
+static const struct file_operations swdrv_fops = {
 	.read = swdrv_read,	/* read */
 	.write = swdrv_write,	/* write */
 	.open = swdrv_open,	/* open */
Index: linux-2.6/arch/sh/kernel/apm.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/apm.c
+++ linux-2.6/arch/sh/kernel/apm.c
@@ -385,7 +385,7 @@ static int apm_open(struct inode * inode
 	return as ? 0 : -ENOMEM;
 }
 
-static struct file_operations apm_bios_fops = {
+static const struct file_operations apm_bios_fops = {
 	.owner		= THIS_MODULE,
 	.read		= apm_read,
 	.poll		= apm_poll,
Index: linux-2.6/arch/sh/mm/cache-debugfs.c
===================================================================
--- linux-2.6.orig/arch/sh/mm/cache-debugfs.c
+++ linux-2.6/arch/sh/mm/cache-debugfs.c
@@ -114,7 +114,7 @@ static int cache_debugfs_open(struct ino
 	return single_open(file, cache_seq_show, inode->i_private);
 }
 
-static struct file_operations cache_debugfs_fops = {
+static const struct file_operations cache_debugfs_fops = {
 	.owner		= THIS_MODULE,
 	.open		= cache_debugfs_open,
 	.read		= seq_read,
Index: linux-2.6/arch/sh/mm/pmb.c
===================================================================
--- linux-2.6.orig/arch/sh/mm/pmb.c
+++ linux-2.6/arch/sh/mm/pmb.c
@@ -378,7 +378,7 @@ static int pmb_debugfs_open(struct inode
 	return single_open(file, pmb_seq_show, NULL);
 }
 
-static struct file_operations pmb_debugfs_fops = {
+static const struct file_operations pmb_debugfs_fops = {
 	.owner		= THIS_MODULE,
 	.open		= pmb_debugfs_open,
 	.read		= seq_read,
Index: linux-2.6/arch/sh/oprofile/op_model_sh7750.c
===================================================================
--- linux-2.6.orig/arch/sh/oprofile/op_model_sh7750.c
+++ linux-2.6/arch/sh/oprofile/op_model_sh7750.c
@@ -187,7 +187,7 @@ static ssize_t sh7750_write_count(struct
 	return count;
 }
 
-static struct file_operations count_fops = {
+static const struct file_operations count_fops = {
 	.read		= sh7750_read_count,
 	.write		= sh7750_write_count,
 };
Index: linux-2.6/arch/sparc/kernel/apc.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/apc.c
+++ linux-2.6/arch/sparc/kernel/apc.c
@@ -127,7 +127,7 @@ static int apc_ioctl(struct inode *inode
 	return 0;
 }
 
-static struct file_operations apc_fops = {
+static const struct file_operations apc_fops = {
 	.ioctl =	apc_ioctl,
 	.open =		apc_open,
 	.release =	apc_release,
Index: linux-2.6/arch/sparc64/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/time.c
+++ linux-2.6/arch/sparc64/kernel/time.c
@@ -1327,7 +1327,7 @@ static int mini_rtc_release(struct inode
 }
 
 
-static struct file_operations mini_rtc_fops = {
+static const struct file_operations mini_rtc_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= mini_rtc_ioctl,
 	.open		= mini_rtc_open,
Index: linux-2.6/arch/sparc64/solaris/socksys.c
===================================================================
--- linux-2.6.orig/arch/sparc64/solaris/socksys.c
+++ linux-2.6/arch/sparc64/solaris/socksys.c
@@ -55,7 +55,7 @@ extern void mykfree(void *);
 
 static unsigned int (*sock_poll)(struct file *, poll_table *);
 
-static struct file_operations socksys_file_ops = {
+static const struct file_operations socksys_file_ops = {
 	/* Currently empty */
 };
 
@@ -163,7 +163,7 @@ static unsigned int socksys_poll(struct 
 	return mask;
 }
 	
-static struct file_operations socksys_fops = {
+static const struct file_operations socksys_fops = {
 	.open =		socksys_open,
 	.release =	socksys_release,
 };
Index: linux-2.6/arch/um/drivers/harddog_kern.c
===================================================================
--- linux-2.6.orig/arch/um/drivers/harddog_kern.c
+++ linux-2.6/arch/um/drivers/harddog_kern.c
@@ -138,7 +138,7 @@ static int harddog_ioctl(struct inode *i
 	}
 }
 
-static struct file_operations harddog_fops = {
+static const struct file_operations harddog_fops = {
 	.owner		= THIS_MODULE,
 	.write		= harddog_write,
 	.ioctl		= harddog_ioctl,
Index: linux-2.6/arch/v850/kernel/rte_cb_leds.c
===================================================================
--- linux-2.6.orig/arch/v850/kernel/rte_cb_leds.c
+++ linux-2.6/arch/v850/kernel/rte_cb_leds.c
@@ -117,7 +117,7 @@ static loff_t leds_dev_lseek (struct fil
 	return 0;
 }
 
-static struct file_operations leds_fops = {
+static const struct file_operations leds_fops = {
 	.read		= leds_dev_read,
 	.write		= leds_dev_write,
 	.llseek		= leds_dev_lseek
Index: linux-2.6/arch/x86_64/kernel/mce.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/mce.c
+++ linux-2.6/arch/x86_64/kernel/mce.c
@@ -516,7 +516,7 @@ static int mce_ioctl(struct inode *i, st
 	} 
 }
 
-static struct file_operations mce_chrdev_ops = {
+static const struct file_operations mce_chrdev_ops = {
 	.read = mce_read,
 	.ioctl = mce_ioctl,
 };


