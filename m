Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWEBSUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWEBSUc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWEBSUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:20:32 -0400
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:40081 "EHLO
	mail8.fw-sd.sony.com") by vger.kernel.org with ESMTP
	id S964935AbWEBSUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:20:31 -0400
Message-ID: <4457A2D6.4070400@am.sony.com>
Date: Tue, 02 May 2006 11:20:06 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: cbe-oss-dev@ozlabs.org, Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
References: <20060429232812.825714000@localhost.localdomain> <F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org> <445690F7.5050605@am.sony.com> <200605020150.14152.arnd@arndb.de>
In-Reply-To: <200605020150.14152.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
>> I also got rid of SPUFS_PRIV1_MMIO, since SPUFS_PRIV1_MMIO
>> just meant spufs with !SOME_HYPERVISOR_THING.
>> 
> 
> I guess that one should really be (SPU_FS && CELL_NATIVE),
> using the option Segher suggested now.


OK.  I set it up that way.  Updated patch below.


>>  config PPC_SYSTEMSIM
>>  	bool "  IBM Full System Simulator (systemsim) support"
>> -	depends on PPC_CELL || PPC_PSERIES || PPC_MAPLE
>> +	depends on PPC_IBM_CELL_BLADE || PPC_PSERIES || PPC_MAPLE
>>  	help
>>  	  Support booting resulting image under IBMs Full System Simulator.
>>  	  If you enable this option, you are able to select device
> 
> whoops, this one should not be there at all. Note that I updated
> your previous patch as well to fit into the series for submission,
> and that did not include systemsim.


Sorry, didn't notice you changed it.  Fixed now.


>>  # needed only when building loadable spufs.ko
>> -spufs-modular-$(CONFIG_SPU_FS) += spu_syscalls.o
>> -obj-y			+= $(spufs-modular-m)
>> -
>> -# always needed in kernel
>> -spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o spu_base.o spu_priv1.o
>> -obj-y			+= $(spufs-builtin-y) $(spufs-builtin-m)
>> -
>> -obj-$(CONFIG_SPU_FS)	+= spufs/
>> +spufs-modular-$(CONFIG_SPU_FS)	+= spu_syscalls.o
>> +obj-$(CONFIG_SPU_BASE)		+= spu_callbacks.o spu_base.o \
>> +				   $(spufs-modular-m)
>> +ifdef CONFIG_SPU_FS
>> +obj-$(CONFIG_PPC_CELL)		+= spu_priv1_mmio.o
>> +endif
> 
> I guess this could then become something like
> 
> spu-priv1-$(CONFIG_PPC_CELL_NATIVE)	+= spu_priv1_mmio.o
> spufs-modular-$(CONFIG_SPU_FS)		+= spu_syscalls.o
> obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
> 					   $(spufs-modular-m) \
> 					   $(spu-priv1-y)


Yes, a nice way.


>> --- cell--alp--2.orig/drivers/net/Kconfig	2006-05-01 15:13:22.000000000 -0700
>> +++ cell--alp--2/drivers/net/Kconfig	2006-05-01 15:13:23.000000000 -0700
>> @@ -2179,7 +2179,7 @@
>> 
>>  config SPIDER_NET
>>  	tristate "Spider Gigabit Ethernet driver"
>> -	depends on PCI && PPC_CELL
>> +	depends on PCI && PPC_IBM_CELL_BLADE
>>  	select FW_LOADER
>>  	help
>>  	  This driver supports the Gigabit Ethernet chips present on the
> 
> Hmm, I'm also no longer sure if this is right. In theory, spidernet
> could be used in all sorts of products, wether they are using the
> same bridge chip or just the gigabit ethernet macro from it.
> 
> For now, I guess you can just leave this one alone if you respin
> the patch another time. It's disabled by default, so the dependency
> can be updated the next time we get a user in _addition_ to PPC_CELL.


OK, based on your other mail I just left it as PCI && PPC_IBM_CELL_BLADE.
We can change it when another system uses it.


-Geoff


Split the Cell BE support into generic and platform dependent parts.

Creates new config variables PPC_CELL_NATIVE and PPC_IBM_CELL_BLADE.
The existing CONFIG_PPC_CELL is now used to denote the generic
Cell processor support.

Also renames spu_priv1.c to spu_priv1_mmio.c.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Index: cell--alp--3/arch/powerpc/Kconfig
===================================================================
--- cell--alp--3.orig/arch/powerpc/Kconfig	2006-05-02 10:10:52.000000000 -0700
+++ cell--alp--3/arch/powerpc/Kconfig	2006-05-02 10:11:42.000000000 -0700
@@ -391,8 +391,18 @@
 	  For more informations, refer to <http://www.970eval.com>

 config PPC_CELL
-	bool "  Cell Broadband Processor Architecture"
+	bool
+	default n
+
+config PPC_CELL_NATIVE
+	bool
+	select PPC_CELL
+	default n
+
+config PPC_IBM_CELL_BLADE
+	bool "  IBM Cell Blade"
 	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL_NATIVE
 	select PPC_RTAS
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
@@ -439,11 +449,6 @@
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
Index: cell--alp--3/arch/powerpc/configs/cell_defconfig
===================================================================
--- cell--alp--3.orig/arch/powerpc/configs/cell_defconfig	2006-05-02 10:10:52.000000000 -0700
+++ cell--alp--3/arch/powerpc/configs/cell_defconfig	2006-05-02 10:12:22.000000000 -0700
@@ -118,13 +118,14 @@
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 CONFIG_PPC_CELL=y
+CONFIG_PPC_CELL_NATIVE=y
+CONFIG_PPC_IBM_CELL_BLADE=y
 # CONFIG_U3_DART is not set
 CONFIG_PPC_RTAS=y
 # CONFIG_RTAS_ERROR_LOGGING is not set
 CONFIG_RTAS_PROC=y
 CONFIG_RTAS_FLASH=y
 CONFIG_MMIO_NVRAM=y
-CONFIG_CELL_IIC=y
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
@@ -133,6 +134,7 @@
 # Cell Broadband Engine options
 #
 CONFIG_SPU_FS=m
+CONFIG_SPU_BASE=y
 CONFIG_SPUFS_MMAP=y

 #
Index: cell--alp--3/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- cell--alp--3.orig/arch/powerpc/platforms/cell/Kconfig	2006-05-02 10:10:52.000000000 -0700
+++ cell--alp--3/arch/powerpc/platforms/cell/Kconfig	2006-05-02 10:14:05.000000000 -0700
@@ -5,11 +5,16 @@
 	tristate "SPU file system"
 	default m
 	depends on PPC_CELL
+	select SPU_BASE
 	help
 	  The SPU file system is used to access Synergistic Processing
 	  Units on machines implementing the Broadband Processor
 	  Architecture.

+config SPU_BASE
+	bool
+	default n
+
 config SPUFS_MMAP
 	bool
 	depends on SPU_FS && SPARSEMEM && !PPC_64K_PAGES
Index: cell--alp--3/arch/powerpc/platforms/cell/Makefile
===================================================================
--- cell--alp--3.orig/arch/powerpc/platforms/cell/Makefile	2006-05-02 10:10:52.000000000 -0700
+++ cell--alp--3/arch/powerpc/platforms/cell/Makefile	2006-05-02 10:39:27.000000000 -0700
@@ -1,14 +1,14 @@
-obj-y			+= interrupt.o iommu.o setup.o spider-pic.o
-obj-y			+= pervasive.o
+obj-$(CONFIG_PPC_CELL_NATIVE)		+= interrupt.o iommu.o setup.o \
+					   spider-pic.o pervasive.o

-obj-$(CONFIG_SMP)	+= smp.o
+ifeq ($(CONFIG_SMP),y)
+obj-$(CONFIG_PPC_CELL_NATIVE)		+= smp.o
+endif

 # needed only when building loadable spufs.ko
-spufs-modular-$(CONFIG_SPU_FS) += spu_syscalls.o
-obj-y			+= $(spufs-modular-m)
+spufs-modular-$(CONFIG_SPU_FS)		+= spu_syscalls.o
+spu-priv1-$(CONFIG_PPC_CELL_NATIVE)	+= spu_priv1_mmio.o

-# always needed in kernel
-spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o spu_base.o spu_priv1.o
-obj-y			+= $(spufs-builtin-y) $(spufs-builtin-m)
-
-obj-$(CONFIG_SPU_FS)	+= spufs/
+obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
+					   $(spufs-modular-m) $(spu-priv1-y)
+obj-$(CONFIG_SPU_FS)			+= spufs/
Index: cell--alp--3/arch/powerpc/platforms/cell/spu_priv1.c
===================================================================
--- cell--alp--3.orig/arch/powerpc/platforms/cell/spu_priv1.c	2006-05-02 10:10:52.000000000 -0700
+++ cell--alp--3/arch/powerpc/platforms/cell/spu_priv1.c	2006-05-01 17:06:59.032678000 -0700
@@ -1,133 +0,0 @@
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
Index: cell--alp--3/arch/powerpc/platforms/cell/spu_priv1_mmio.c
===================================================================
--- cell--alp--3.orig/arch/powerpc/platforms/cell/spu_priv1_mmio.c	2006-05-01 17:06:59.032678000 -0700
+++ cell--alp--3/arch/powerpc/platforms/cell/spu_priv1_mmio.c	2006-05-02 10:11:42.000000000 -0700
@@ -0,0 +1,133 @@
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
Index: cell--alp--3/drivers/net/Kconfig
===================================================================
--- cell--alp--3.orig/drivers/net/Kconfig	2006-05-02 10:10:52.000000000 -0700
+++ cell--alp--3/drivers/net/Kconfig	2006-05-02 10:11:42.000000000 -0700
@@ -2171,7 +2171,7 @@

 config SPIDER_NET
 	tristate "Spider Gigabit Ethernet driver"
-	depends on PCI && PPC_CELL
+	depends on PCI && PPC_IBM_CELL_BLADE
 	select FW_LOADER
 	help
 	  This driver supports the Gigabit Ethernet chips present on the
