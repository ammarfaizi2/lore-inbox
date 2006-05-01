Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWEAWwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWEAWwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 18:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWEAWwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 18:52:05 -0400
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:61071 "EHLO
	mail8.fw-sd.sony.com") by vger.kernel.org with ESMTP
	id S932298AbWEAWwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 18:52:04 -0400
Message-ID: <445690F7.5050605@am.sony.com>
Date: Mon, 01 May 2006 15:51:35 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
CC: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org, paulus@samba.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
       cbe-oss-dev@ozlabs.org
Subject: Re: [PATCH 11/13] cell: split out board specific files
References: <20060429232812.825714000@localhost.localdomain>	<20060429233922.167124000@localhost.localdomain> <F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org>
In-Reply-To: <F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool wrote:
>> Split the Cell BE support into generic and platform
>> dependant parts.
>>
>> Creates a new config variable CONFIG_PPC_IBM_CELL_BLADE.
>> The existing CONFIG_PPC_CELL is now used to denote the
>> generic Cell processor support.  Also renames spu_priv1.c
>> to spu_priv1_mmio.c.
> 
>>  config CELL_IIC
>> -	depends on PPC_CELL
>> +	depends on PPC_IBM_CELL_BLADE
>>  	bool
>>  	default y
> 
> Erm no...  Make this
> 
> 	depends on PPC_CELL && !SOME_HYPERVISOR_THING
> 
> to reflect the _real_ dependency please?  Similar in a few other
> places perhaps.


Seems CELL_IIC is never used.  Must be some stale variable,
so I removed it.  Arnd, could you ack this.

Segher, a problem with your suggestion is that our
makefiles don't have as rich a set of logical ops as the
config files.  Its easy to express 'build A if B', but not
so easy to do 'build A if not C'.  To make this work
cleanly I made PPC_CELL denote !SOME_HYPERVISOR_THING,
so I can have constructions like this in the makefile:

obj-$(CONFIG_PPC_CELL)	+= ...

I also got rid of SPUFS_PRIV1_MMIO, since SPUFS_PRIV1_MMIO
just meant spufs with !SOME_HYPERVISOR_THING.

Updated patch follows.

-Geoff



Split the Cell BPA support into generic and platform
dependant parts.

Creates new config variable CONFIG_PPC_IBM_CELL_BLADE.
Also renames spu_priv1.c to spu_priv1_mmio.c.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Index: cell--alp--2/arch/powerpc/Kconfig
===================================================================
--- cell--alp--2.orig/arch/powerpc/Kconfig	2006-05-01 15:13:22.000000000 -0700
+++ cell--alp--2/arch/powerpc/Kconfig	2006-05-01 15:16:38.000000000 -0700
@@ -391,15 +391,20 @@
 	  For more informations, refer to <http://www.970eval.com>

 config PPC_CELL
-	bool "  Cell Broadband Processor Architecture"
+	bool
+	default n
+
+config PPC_IBM_CELL_BLADE
+	bool "  IBM Cell Blade"
 	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL
 	select PPC_RTAS
 	select MMIO_NVRAM
 	select PPC_UDBG_16550

 config PPC_SYSTEMSIM
 	bool "  IBM Full System Simulator (systemsim) support"
-	depends on PPC_CELL || PPC_PSERIES || PPC_MAPLE
+	depends on PPC_IBM_CELL_BLADE || PPC_PSERIES || PPC_MAPLE
 	help
 	  Support booting resulting image under IBMs Full System Simulator.
 	  If you enable this option, you are able to select device
@@ -450,11 +455,6 @@
 	depends on PPC_MAPLE
 	default y

-config CELL_IIC
-	depends on PPC_CELL
-	bool
-	default y
-
 config IBMVIO
 	depends on PPC_PSERIES || PPC_ISERIES
 	bool
Index: cell--alp--2/arch/powerpc/configs/cell_defconfig
===================================================================
--- cell--alp--2.orig/arch/powerpc/configs/cell_defconfig	2006-05-01 15:13:22.000000000 -0700
+++ cell--alp--2/arch/powerpc/configs/cell_defconfig	2006-05-01 15:13:23.000000000 -0700
@@ -116,6 +116,7 @@
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 CONFIG_PPC_CELL=y
+CONFIG_PPC_IBM_CELL_BLADE=y
 CONFIG_PPC_SYSTEMSIM=y
 # CONFIG_U3_DART is not set
 CONFIG_PPC_RTAS=y
@@ -123,7 +124,6 @@
 CONFIG_RTAS_PROC=y
 CONFIG_RTAS_FLASH=y
 CONFIG_MMIO_NVRAM=y
-CONFIG_CELL_IIC=y
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
@@ -133,6 +133,7 @@
 #
 CONFIG_BE_DD2=y
 CONFIG_SPU_FS=m
+CONFIG_SPU_BASE=y
 CONFIG_SPUFS_MMAP=y

 #
Index: cell--alp--2/arch/powerpc/configs/systemsim_defconfig
===================================================================
--- cell--alp--2.orig/arch/powerpc/configs/systemsim_defconfig	2006-05-01 15:13:22.000000000 -0700
+++ cell--alp--2/arch/powerpc/configs/systemsim_defconfig	2006-05-01 15:13:23.000000000 -0700
@@ -117,6 +117,7 @@
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_MAPLE=y
 CONFIG_PPC_CELL=y
+CONFIG_PPC_IBM_CELL_BLADE=y
 CONFIG_PPC_SYSTEMSIM=y
 CONFIG_SYSTEMSIM_IDLE=y
 CONFIG_XICS=y
@@ -128,7 +129,6 @@
 # CONFIG_RTAS_FLASH is not set
 CONFIG_MMIO_NVRAM=y
 CONFIG_MPIC_BROKEN_U3=y
-CONFIG_CELL_IIC=y
 CONFIG_IBMVIO=y
 # CONFIG_IBMEBUS is not set
 # CONFIG_PPC_MPC106 is not set
@@ -139,6 +139,7 @@
 # Cell Broadband Engine options
 #
 CONFIG_SPU_FS=m
+CONFIG_SPU_BASE=y

 #
 # Kernel options
Index: cell--alp--2/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- cell--alp--2.orig/arch/powerpc/platforms/cell/Kconfig	2006-05-01 15:13:22.000000000 -0700
+++ cell--alp--2/arch/powerpc/platforms/cell/Kconfig	2006-05-01 15:13:23.000000000 -0700
@@ -11,10 +11,15 @@
 	  or may crash other CPUs.
 	  Say 'n' here unless you expect to run on DD2.0 only.

+config SPU_BASE
+	bool
+	default n
+
 config SPU_FS
 	tristate "SPU file system"
 	default m
 	depends on PPC_CELL
+	select SPU_BASE
 	help
 	  The SPU file system is used to access Synergistic Processing
 	  Units on machines implementing the Broadband Processor
Index: cell--alp--2/arch/powerpc/platforms/cell/Makefile
===================================================================
--- cell--alp--2.orig/arch/powerpc/platforms/cell/Makefile	2006-05-01 15:13:22.000000000 -0700
+++ cell--alp--2/arch/powerpc/platforms/cell/Makefile	2006-05-01 15:17:58.000000000 -0700
@@ -1,14 +1,14 @@
-obj-y			+= interrupt.o iommu.o setup.o spider-pic.o
-obj-y			+= pervasive.o pci.o
-
-obj-$(CONFIG_SMP)	+= smp.o
+obj-$(CONFIG_PPC_CELL)		+= interrupt.o iommu.o setup.o \
+				   spider-pic.o pervasive.o pci.o
+ifeq ($(CONFIG_SMP),y)
+obj-$(CONFIG_PPC_CELL)		+= smp.o
+endif

 # needed only when building loadable spufs.ko
-spufs-modular-$(CONFIG_SPU_FS) += spu_syscalls.o
-obj-y			+= $(spufs-modular-m)
-
-# always needed in kernel
-spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o spu_base.o spu_priv1.o
-obj-y			+= $(spufs-builtin-y) $(spufs-builtin-m)
-
-obj-$(CONFIG_SPU_FS)	+= spufs/
+spufs-modular-$(CONFIG_SPU_FS)	+= spu_syscalls.o
+obj-$(CONFIG_SPU_BASE)		+= spu_callbacks.o spu_base.o \
+				   $(spufs-modular-m)
+ifdef CONFIG_SPU_FS
+obj-$(CONFIG_PPC_CELL)		+= spu_priv1_mmio.o
+endif
+obj-$(CONFIG_SPU_FS)		+= spufs/
Index: cell--alp--2/arch/powerpc/platforms/cell/spu_priv1.c
===================================================================
--- cell--alp--2.orig/arch/powerpc/platforms/cell/spu_priv1.c	2006-05-01 15:13:22.000000000 -0700
+++ cell--alp--2/arch/powerpc/platforms/cell/spu_priv1.c	2006-04-21 13:04:41.284693750 -0700
@@ -1,142 +0,0 @@
-/*
- * access to SPU privileged registers
- */
-#include <linux/module.h>
-
-#include <asm/io.h>
-#include <asm/spu.h>
-
-void spu_int_mask_and(struct spu *spu, int class, u64 mask)
-{
-	u64 old_mask;
-
-	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
-	out_be64(&spu->priv1->int_mask_RW[class], old_mask & mask);
-}
-EXPORT_SYMBOL_GPL(spu_int_mask_and);
-
-void spu_int_mask_or(struct spu *spu, int class, u64 mask)
-{
-	u64 old_mask;
-
-	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
-	out_be64(&spu->priv1->int_mask_RW[class], old_mask | mask);
-}
-EXPORT_SYMBOL_GPL(spu_int_mask_or);
-
-void spu_int_mask_set(struct spu *spu, int class, u64 mask)
-{
-	out_be64(&spu->priv1->int_mask_RW[class], mask);
-}
-EXPORT_SYMBOL_GPL(spu_int_mask_set);
-
-u64 spu_int_mask_get(struct spu *spu, int class)
-{
-	return in_be64(&spu->priv1->int_mask_RW[class]);
-}
-EXPORT_SYMBOL_GPL(spu_int_mask_get);
-
-void spu_int_stat_clear(struct spu *spu, int class, u64 stat)
-{
-	out_be64(&spu->priv1->int_stat_RW[class], stat);
-}
-EXPORT_SYMBOL_GPL(spu_int_stat_clear);
-
-u64 spu_int_stat_get(struct spu *spu, int class)
-{
-	return in_be64(&spu->priv1->int_stat_RW[class]);
-}
-EXPORT_SYMBOL_GPL(spu_int_stat_get);
-
-void spu_int_route_set(struct spu *spu, u64 route)
-{
-	out_be64(&spu->priv1->int_route_RW, route);
-}
-EXPORT_SYMBOL_GPL(spu_int_route_set);
-
-u64 spu_mfc_dar_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->mfc_dar_RW);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_dar_get);
-
-u64 spu_mfc_dsisr_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->mfc_dsisr_RW);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_dsisr_get);
-
-void spu_mfc_dsisr_set(struct spu *spu, u64 dsisr)
-{
-	out_be64(&spu->priv1->mfc_dsisr_RW, dsisr);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_dsisr_set);
-
-void spu_mfc_sdr_set(struct spu *spu, u64 sdr)
-{
-	out_be64(&spu->priv1->mfc_sdr_RW, sdr);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_sdr_set);
-
-void spu_mfc_sr1_set(struct spu *spu, u64 sr1)
-{
-	out_be64(&spu->priv1->mfc_sr1_RW, sr1);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_sr1_set);
-
-u64 spu_mfc_sr1_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->mfc_sr1_RW);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_sr1_get);
-
-void spu_mfc_tclass_id_set(struct spu *spu, u64 tclass_id)
-{
-	out_be64(&spu->priv1->mfc_tclass_id_RW, tclass_id);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_tclass_id_set);
-
-u64 spu_mfc_tclass_id_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->mfc_tclass_id_RW);
-}
-EXPORT_SYMBOL_GPL(spu_mfc_tclass_id_get);
-
-void spu_smm_pgsz_set(struct spu *spu, u64 pgsz)
-{
-	u64 smm_hid;
-	smm_hid = in_be64(&spu->priv1->smm_hid);
-	smm_hid &= ~(0xfull << 60);
-	smm_hid |= pgsz << 60;
-	out_be64(&spu->priv1->smm_hid, smm_hid);
-}
-
-void spu_tlb_invalidate(struct spu *spu)
-{
-	out_be64(&spu->priv1->tlb_invalidate_entry_W, 0ul);
-}
-EXPORT_SYMBOL_GPL(spu_tlb_invalidate);
-
-void spu_resource_allocation_groupID_set(struct spu *spu, u64 id)
-{
-	out_be64(&spu->priv1->resource_allocation_groupID_RW, id);
-}
-EXPORT_SYMBOL_GPL(spu_resource_allocation_groupID_set);
-
-u64 spu_resource_allocation_groupID_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->resource_allocation_groupID_RW);
-}
-EXPORT_SYMBOL_GPL(spu_resource_allocation_groupID_get);
-
-void spu_resource_allocation_enable_set(struct spu *spu, u64 enable)
-{
-	out_be64(&spu->priv1->resource_allocation_enable_RW, enable);
-}
-EXPORT_SYMBOL_GPL(spu_resource_allocation_enable_set);
-
-u64 spu_resource_allocation_enable_get(struct spu *spu)
-{
-	return in_be64(&spu->priv1->resource_allocation_enable_RW);
-}
-EXPORT_SYMBOL_GPL(spu_resource_allocation_enable_get);
Index: cell--alp--2/arch/powerpc/platforms/cell/spu_priv1_mmio.c
===================================================================
--- cell--alp--2.orig/arch/powerpc/platforms/cell/spu_priv1_mmio.c	2006-04-21 13:04:41.284693750 -0700
+++ cell--alp--2/arch/powerpc/platforms/cell/spu_priv1_mmio.c	2006-05-01 15:16:49.000000000 -0700
@@ -0,0 +1,142 @@
+/*
+ * access to SPU privileged registers
+ */
+#include <linux/module.h>
+
+#include <asm/io.h>
+#include <asm/spu.h>
+
+void spu_int_mask_and(struct spu *spu, int class, u64 mask)
+{
+	u64 old_mask;
+
+	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
+	out_be64(&spu->priv1->int_mask_RW[class], old_mask & mask);
+}
+EXPORT_SYMBOL_GPL(spu_int_mask_and);
+
+void spu_int_mask_or(struct spu *spu, int class, u64 mask)
+{
+	u64 old_mask;
+
+	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
+	out_be64(&spu->priv1->int_mask_RW[class], old_mask | mask);
+}
+EXPORT_SYMBOL_GPL(spu_int_mask_or);
+
+void spu_int_mask_set(struct spu *spu, int class, u64 mask)
+{
+	out_be64(&spu->priv1->int_mask_RW[class], mask);
+}
+EXPORT_SYMBOL_GPL(spu_int_mask_set);
+
+u64 spu_int_mask_get(struct spu *spu, int class)
+{
+	return in_be64(&spu->priv1->int_mask_RW[class]);
+}
+EXPORT_SYMBOL_GPL(spu_int_mask_get);
+
+void spu_int_stat_clear(struct spu *spu, int class, u64 stat)
+{
+	out_be64(&spu->priv1->int_stat_RW[class], stat);
+}
+EXPORT_SYMBOL_GPL(spu_int_stat_clear);
+
+u64 spu_int_stat_get(struct spu *spu, int class)
+{
+	return in_be64(&spu->priv1->int_stat_RW[class]);
+}
+EXPORT_SYMBOL_GPL(spu_int_stat_get);
+
+void spu_int_route_set(struct spu *spu, u64 route)
+{
+	out_be64(&spu->priv1->int_route_RW, route);
+}
+EXPORT_SYMBOL_GPL(spu_int_route_set);
+
+u64 spu_mfc_dar_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->mfc_dar_RW);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_dar_get);
+
+u64 spu_mfc_dsisr_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->mfc_dsisr_RW);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_dsisr_get);
+
+void spu_mfc_dsisr_set(struct spu *spu, u64 dsisr)
+{
+	out_be64(&spu->priv1->mfc_dsisr_RW, dsisr);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_dsisr_set);
+
+void spu_mfc_sdr_set(struct spu *spu, u64 sdr)
+{
+	out_be64(&spu->priv1->mfc_sdr_RW, sdr);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_sdr_set);
+
+void spu_mfc_sr1_set(struct spu *spu, u64 sr1)
+{
+	out_be64(&spu->priv1->mfc_sr1_RW, sr1);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_sr1_set);
+
+u64 spu_mfc_sr1_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->mfc_sr1_RW);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_sr1_get);
+
+void spu_mfc_tclass_id_set(struct spu *spu, u64 tclass_id)
+{
+	out_be64(&spu->priv1->mfc_tclass_id_RW, tclass_id);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_tclass_id_set);
+
+u64 spu_mfc_tclass_id_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->mfc_tclass_id_RW);
+}
+EXPORT_SYMBOL_GPL(spu_mfc_tclass_id_get);
+
+void spu_smm_pgsz_set(struct spu *spu, u64 pgsz)
+{
+	u64 smm_hid;
+	smm_hid = in_be64(&spu->priv1->smm_hid);
+	smm_hid &= ~(0xfull << 60);
+	smm_hid |= pgsz << 60;
+	out_be64(&spu->priv1->smm_hid, smm_hid);
+}
+
+void spu_tlb_invalidate(struct spu *spu)
+{
+	out_be64(&spu->priv1->tlb_invalidate_entry_W, 0ul);
+}
+EXPORT_SYMBOL_GPL(spu_tlb_invalidate);
+
+void spu_resource_allocation_groupID_set(struct spu *spu, u64 id)
+{
+	out_be64(&spu->priv1->resource_allocation_groupID_RW, id);
+}
+EXPORT_SYMBOL_GPL(spu_resource_allocation_groupID_set);
+
+u64 spu_resource_allocation_groupID_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->resource_allocation_groupID_RW);
+}
+EXPORT_SYMBOL_GPL(spu_resource_allocation_groupID_get);
+
+void spu_resource_allocation_enable_set(struct spu *spu, u64 enable)
+{
+	out_be64(&spu->priv1->resource_allocation_enable_RW, enable);
+}
+EXPORT_SYMBOL_GPL(spu_resource_allocation_enable_set);
+
+u64 spu_resource_allocation_enable_get(struct spu *spu)
+{
+	return in_be64(&spu->priv1->resource_allocation_enable_RW);
+}
+EXPORT_SYMBOL_GPL(spu_resource_allocation_enable_get);
Index: cell--alp--2/drivers/net/Kconfig
===================================================================
--- cell--alp--2.orig/drivers/net/Kconfig	2006-05-01 15:13:22.000000000 -0700
+++ cell--alp--2/drivers/net/Kconfig	2006-05-01 15:13:23.000000000 -0700
@@ -2179,7 +2179,7 @@

 config SPIDER_NET
 	tristate "Spider Gigabit Ethernet driver"
-	depends on PCI && PPC_CELL
+	depends on PCI && PPC_IBM_CELL_BLADE
 	select FW_LOADER
 	help
 	  This driver supports the Gigabit Ethernet chips present on the
