Return-Path: <linux-kernel-owner+w=401wt.eu-S1751415AbXAFOzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbXAFOzk (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 09:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbXAFOzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 09:55:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:37760 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbXAFOzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 09:55:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=HmxFXnN2P6IG2JS2NeTKuOA+izMXsE/svLPRLx0JA+BgnoQgAEMQLsogo7lkjtoe7s55847FMUuk6JbYZPpobMJmcRebkGWnQeQZjswGUoFbsCKka/c5oJv12x9NrTCX1e7bYbWYiqwod40M5BPz0dMyT9W0Q/73YZHIk95u6kU=
Date: Sat, 6 Jan 2007 17:55:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: remove useless (and buggy) ->nlink settings
Message-ID: <20070106145533.GA4996@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug: pnx8550 code creates directory but resets ->nlink to 1.

create_proc_entry() et al will correctly set ->nlink for you.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/mips/philips/pnx8550/common/proc.c   |    7 +------
 arch/powerpc/kernel/proc_ppc64.c          |    1 -
 arch/powerpc/kernel/rtas_flash.c          |    1 -
 arch/powerpc/platforms/iseries/mf.c       |    4 ----
 arch/powerpc/platforms/pseries/reconfig.c |    1 -
 arch/um/drivers/ubd_kern.c                |    1 -
 drivers/char/ipmi/ipmi_msghandler.c       |    1 -
 drivers/ide/ide-proc.c                    |    1 -
 drivers/macintosh/via-pmu.c               |    1 -
 drivers/misc/hdpuftrs/hdpu_nexus.c        |    2 --
 drivers/parisc/led.c                      |    2 --
 drivers/s390/crypto/zcrypt_api.c          |    1 -
 drivers/usb/gadget/rndis.c                |    1 -
 kernel/irq/proc.c                         |    1 -
 kernel/profile.c                          |    1 -
 15 files changed, 1 insertion(+), 25 deletions(-)

--- a/arch/mips/philips/pnx8550/common/proc.c
+++ b/arch/mips/philips/pnx8550/common/proc.c
@@ -79,10 +79,7 @@ static int pnx8550_proc_init( void )
 
 	// Create /proc/pnx8550
         pnx8550_dir = create_proc_entry("pnx8550", S_IFDIR|S_IRUGO, NULL);
-        if (pnx8550_dir){
-                pnx8550_dir->nlink = 1;
-        }
-        else {
+        if (!pnx8550_dir) {
                 printk(KERN_ERR "Can't create pnx8550 proc dir\n");
                 return -1;
         }
@@ -90,7 +87,6 @@ static int pnx8550_proc_init( void )
 	// Create /proc/pnx8550/timers
         pnx8550_timers = create_proc_entry("timers", S_IFREG|S_IRUGO, pnx8550_dir );
         if (pnx8550_timers){
-                pnx8550_timers->nlink = 1;
                 pnx8550_timers->read_proc = pnx8550_timers_read;
         }
         else {
@@ -100,7 +96,6 @@ static int pnx8550_proc_init( void )
 	// Create /proc/pnx8550/registers
         pnx8550_registers = create_proc_entry("registers", S_IFREG|S_IRUGO, pnx8550_dir );
         if (pnx8550_registers){
-                pnx8550_registers->nlink = 1;
                 pnx8550_registers->read_proc = pnx8550_registers_read;
         }
         else {
--- a/arch/powerpc/kernel/proc_ppc64.c
+++ b/arch/powerpc/kernel/proc_ppc64.c
@@ -71,7 +71,6 @@ static int __init proc_ppc64_init(void)
 	pde = create_proc_entry("ppc64/systemcfg", S_IFREG|S_IRUGO, NULL);
 	if (!pde)
 		return 1;
-	pde->nlink = 1;
 	pde->data = vdso_data;
 	pde->size = PAGE_SIZE;
 	pde->proc_fops = &page_map_fops;
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -708,7 +708,6 @@ static struct proc_dir_entry *create_fla
 
 	ent = create_proc_entry(filename, S_IRUSR | S_IWUSR, NULL);
 	if (ent != NULL) {
-		ent->nlink = 1;
 		ent->proc_fops = fops;
 		ent->owner = THIS_MODULE;
 	}
--- a/arch/powerpc/platforms/iseries/mf.c
+++ b/arch/powerpc/platforms/iseries/mf.c
@@ -1249,7 +1249,6 @@ static int __init mf_proc_init(void)
 		ent = create_proc_entry("cmdline", S_IFREG|S_IRUSR|S_IWUSR, mf);
 		if (!ent)
 			return 1;
-		ent->nlink = 1;
 		ent->data = (void *)(long)i;
 		ent->read_proc = proc_mf_dump_cmdline;
 		ent->write_proc = proc_mf_change_cmdline;
@@ -1260,7 +1259,6 @@ static int __init mf_proc_init(void)
 		ent = create_proc_entry("vmlinux", S_IFREG|S_IWUSR, mf);
 		if (!ent)
 			return 1;
-		ent->nlink = 1;
 		ent->data = (void *)(long)i;
 		ent->proc_fops = &proc_vmlinux_operations;
 	}
@@ -1268,7 +1266,6 @@ static int __init mf_proc_init(void)
 	ent = create_proc_entry("side", S_IFREG|S_IRUSR|S_IWUSR, mf_proc_root);
 	if (!ent)
 		return 1;
-	ent->nlink = 1;
 	ent->data = (void *)0;
 	ent->read_proc = proc_mf_dump_side;
 	ent->write_proc = proc_mf_change_side;
@@ -1276,7 +1273,6 @@ static int __init mf_proc_init(void)
 	ent = create_proc_entry("src", S_IFREG|S_IRUSR|S_IWUSR, mf_proc_root);
 	if (!ent)
 		return 1;
-	ent->nlink = 1;
 	ent->data = (void *)0;
 	ent->read_proc = proc_mf_dump_src;
 	ent->write_proc = proc_mf_change_src;
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -513,7 +513,6 @@ static int proc_ppc64_create_ofdt(void)
 
 	ent = create_proc_entry("ppc64/ofdt", S_IWUSR, NULL);
 	if (ent) {
-		ent->nlink = 1;
 		ent->data = NULL;
 		ent->size = 0;
 		ent->proc_fops = &ofdt_fops;
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -242,7 +242,6 @@ static void make_ide_entries(char *dev_n
 
 	ent = create_proc_entry("media", S_IFREG|S_IRUGO, dir);
 	if(!ent) return;
-	ent->nlink = 1;
 	ent->data = NULL;
 	ent->read_proc = proc_ide_read_media;
 	ent->write_proc = NULL;
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1886,7 +1886,6 @@ #ifdef CONFIG_PROC_FS
 		kfree(entry);
 		rv = -ENOMEM;
 	} else {
-		file->nlink = 1;
 		file->data = data;
 		file->read_proc = read_proc;
 		file->write_proc = write_proc;
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -413,7 +413,6 @@ void ide_add_proc_entries(struct proc_di
 	while (p->name != NULL) {
 		ent = create_proc_entry(p->name, p->mode, dir);
 		if (!ent) return;
-		ent->nlink = 1;
 		ent->data = data;
 		ent->read_proc = p->read_proc;
 		ent->write_proc = p->write_proc;
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -515,7 +515,6 @@ #endif /* CONFIG_PPC32 */
 					proc_get_irqstats, NULL);
 		proc_pmu_options = create_proc_entry("options", 0600, proc_pmu_root);
 		if (proc_pmu_options) {
-			proc_pmu_options->nlink = 1;
 			proc_pmu_options->read_proc = proc_read_options;
 			proc_pmu_options->write_proc = proc_write_options;
 		}
--- a/drivers/misc/hdpuftrs/hdpu_nexus.c
+++ b/drivers/misc/hdpuftrs/hdpu_nexus.c
@@ -72,11 +72,9 @@ static int hdpu_nexus_probe(struct platf
 		printk("Could not map slot id\n");
 	hdpu_slot_id = create_proc_entry("sky_slot_id", 0666, &proc_root);
 	hdpu_slot_id->read_proc = hdpu_slot_id_read;
-	hdpu_slot_id->nlink = 1;
 
 	hdpu_chassis_id = create_proc_entry("sky_chassis_id", 0666, &proc_root);
 	hdpu_chassis_id->read_proc = hdpu_chassis_id_read;
-	hdpu_chassis_id->nlink = 1;
 	return 0;
 }
 
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -252,7 +252,6 @@ static int __init led_create_procfs(void
 	proc_pdc_root->owner = THIS_MODULE;
 	ent = create_proc_entry("led", S_IFREG|S_IRUGO|S_IWUSR, proc_pdc_root);
 	if (!ent) return -1;
-	ent->nlink = 1;
 	ent->data = (void *)LED_NOLCD; /* LED */
 	ent->read_proc = led_proc_read;
 	ent->write_proc = led_proc_write;
@@ -262,7 +261,6 @@ static int __init led_create_procfs(void
 	{
 		ent = create_proc_entry("lcd", S_IFREG|S_IRUGO|S_IWUSR, proc_pdc_root);
 		if (!ent) return -1;
-		ent->nlink = 1;
 		ent->data = (void *)LED_HASLCD; /* LCD */
 		ent->read_proc = led_proc_read;
 		ent->write_proc = led_proc_write;
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1063,7 +1063,6 @@ int __init zcrypt_api_init(void)
 		rc = -ENOMEM;
 		goto out_misc;
 	}
-	zcrypt_entry->nlink = 1;
 	zcrypt_entry->data = NULL;
 	zcrypt_entry->read_proc = zcrypt_status_read;
 	zcrypt_entry->write_proc = zcrypt_status_write;
--- a/drivers/usb/gadget/rndis.c
+++ b/drivers/usb/gadget/rndis.c
@@ -1419,7 +1419,6 @@ #ifdef	CONFIG_USB_GADGET_DEBUG_FILES
 			return -EIO;
 		}
 
-		rndis_connect_state [i]->nlink = 1;
 		rndis_connect_state [i]->write_proc = rndis_proc_write;
 		rndis_connect_state [i]->read_proc = rndis_proc_read;
 		rndis_connect_state [i]->data = (void *)
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -136,7 +136,6 @@ #ifdef CONFIG_SMP
 		entry = create_proc_entry("smp_affinity", 0600, irq_desc[irq].dir);
 
 		if (entry) {
-			entry->nlink = 1;
 			entry->data = (void *)(long)irq;
 			entry->read_proc = irq_affinity_read_proc;
 			entry->write_proc = irq_affinity_write_proc;
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -434,7 +434,6 @@ void create_prof_cpu_mask(struct proc_di
 	/* create /proc/irq/prof_cpu_mask */
 	if (!(entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir)))
 		return;
-	entry->nlink = 1;
 	entry->data = (void *)&prof_cpu_mask;
 	entry->read_proc = prof_cpu_mask_read_proc;
 	entry->write_proc = prof_cpu_mask_write_proc;

