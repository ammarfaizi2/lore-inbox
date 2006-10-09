Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932908AbWJIOOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbWJIOOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932909AbWJIOLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:11:34 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:31217 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932869AbWJIOLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:15 -0400
Date: Mon, 9 Oct 2006 07:10:19 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EAJiq026155@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 12/21] 2.6.18 perfmon2 : PMU description table management
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the function needed to manage the PMU description table
and module.

The mapping from the logical PMU view exposed by the interface (as PMC and PMD
registers) to the actual registers is driven by a description table. That table
is part of a kernel module which can be dynamically inserted.

The motivation for this mechanism is to allow new hardware to be supported before
there is a new release from distributors. It also provides a way to take care of
PMU defects and model-specific constraints. It is possible to define read or
write PMC/PMD checkers to test for complex illegal value settings.

The PMU description module can be automically loaded by the kernel on first
use. The implementation detects known CPUs and requests the module to be loaded.
If CPU is unknown, then a manual insmod also works.

Only one PMU description can be active at a time. A PMU description can be builtin
or compiled as a module (preferred).

This patch adds the perfmon_pmu.c and perfmon_pmu.h files. the following interface
is provided to PMU description module:

int pfm_pmu_register(struct pfm_pmu_config *cfg):
	- register a PMU description module
	- validate table passed by module and initialize generic data structures
	- populate /sys with table information
	- reset PMU to quiescent state based on the information

void pfm_pmu_unregister(struct pfm_pmu_config *cfg):
	- unregister a PMU description module




--- linux-2.6.18.base/perfmon/perfmon_pmu.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/perfmon/perfmon_pmu.c	2006-09-25 12:10:04.000000000 -0700
@@ -0,0 +1,439 @@
+/*
+ * perfmon_pmu.c: perfmon2 PMU configuration management
+ *
+ * This file implements the perfmon2 interface which
+ * provides access to the hardware performance counters
+ * of the host processor.
+ *
+ * The initial version of perfmon.c was written by
+ * Ganesh Venkitachalam, IBM Corp.
+ *
+ * Then it was modified for perfmon-1.x by Stephane Eranian and
+ * David Mosberger, Hewlett Packard Co.
+ *
+ * Version Perfmon-2.x is a complete rewrite of perfmon-1.x
+ * by Stephane Eranian, Hewlett Packard Co.
+ *
+ * Copyright (c) 1999-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *                David Mosberger-Tang <davidm@hpl.hp.com>
+ *
+ * More information about perfmon available at:
+ * 	http://perfmon2.sf.net
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+
+#ifndef CONFIG_MODULE_UNLOAD
+#define module_refcount(n)	1
+#endif
+
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(pfm_pmu_conf_lock);
+static __cacheline_aligned_in_smp int request_mod_in_progress;
+/*
+ * _pfm_pmu_conf contains all the runtime PMU description information.
+ * It is construction from the PMU specific description implemented
+ * by PMU description modules + the architected virtual PMDS.
+ */
+static struct _pfm_pmu_config _pfm_pmu_conf;
+
+/*
+ * perfmon core must acces PMU information ONLY through pfm_pmu_conf
+ * if pfm_pmu_conf is NULL, then no description is registered
+ */
+struct _pfm_pmu_config	*pfm_pmu_conf;
+EXPORT_SYMBOL(pfm_pmu_conf);
+
+
+static inline int pmu_is_module(struct _pfm_pmu_config *c)
+{
+	return !(c->flags & PFM_PMUFL_IS_BUILTIN);
+}
+
+/*
+ * initialize PMU configuration from PMU config descriptor
+ */
+static int pfm_pmu_config_init(struct pfm_pmu_config *cfg)
+{
+	u16 n, n_counters, i;
+	int max1, max2, max3, first_cnt, first_i;
+
+	memset(&_pfm_pmu_conf, 0 , sizeof(_pfm_pmu_conf));
+	/*
+	 * compute the number of implemented PMC from the
+	 * description tables
+	 *
+	 * We separate actual PMC registers from virtual
+	 * PMC registers. Needed for PMC save/restore routines.
+	 */
+	n = 0;
+	max1 = max2 = -1;
+	for (i = 0; i < cfg->num_pmc_entries;  i++) {
+
+		_pfm_pmu_conf.pmc_desc[i] = cfg->pmc_desc[i];
+
+		/*
+		 * non implemented registers have type 0
+		 */
+		if (!(cfg->pmc_desc[i].type & PFM_REG_I))
+			continue;
+
+		pfm_bv_set(_pfm_pmu_conf.impl_pmcs, i);
+
+		max1 = i;
+		n++;
+	}
+
+	if (!n) {
+		PFM_INFO("%s PMU description has no PMC registers",
+			 cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	_pfm_pmu_conf.max_pmc = max1 + 1;
+	_pfm_pmu_conf.num_pmcs = n;
+
+	n = n_counters = 0;
+	max1 = max2 = max3 = first_cnt = first_i = -1;
+	for (i = 0; i < cfg->num_pmd_entries;  i++) {
+
+		_pfm_pmu_conf.pmd_desc[i] = cfg->pmd_desc[i];
+
+		if (!(cfg->pmd_desc[i].type & PFM_REG_I))
+			continue;
+
+		if (first_i == -1)
+			first_i = i;
+
+		/*
+		 * implemented registers
+		 */
+		pfm_bv_set(_pfm_pmu_conf.impl_pmds, i);
+		max1 = i;
+		n++;
+
+		/*
+		 * implemented read-write registers
+		 */
+		if (!(cfg->pmd_desc[i].type & PFM_REG_RO)) {
+			pfm_bv_set(_pfm_pmu_conf.impl_rw_pmds, i);
+			max3 = i;
+		}
+
+		/*
+		 * counters
+		 */
+		if (cfg->pmd_desc[i].type & PFM_REG_C64) {
+			pfm_bv_set(_pfm_pmu_conf.cnt_pmds, i);
+			max2 = i;
+			n_counters++;
+			if (first_cnt == -1)
+				first_cnt = i;
+		}
+	}
+
+	if (!n) {
+		PFM_INFO("%s PMU description has no PMD registers",
+			 cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	_pfm_pmu_conf.pmu_name = cfg->pmu_name;
+	_pfm_pmu_conf.version = cfg->version ? cfg->version : "0.0";
+	_pfm_pmu_conf.pmc_write_check = cfg->pmc_write_check;
+	_pfm_pmu_conf.pmd_write_check = cfg->pmd_write_check;
+	_pfm_pmu_conf.pmd_sread = cfg->pmd_sread;
+	_pfm_pmu_conf.pmd_swrite = cfg->pmd_swrite;
+	_pfm_pmu_conf.arch_info = cfg->arch_info;
+	_pfm_pmu_conf.flags = cfg->flags;
+	_pfm_pmu_conf.owner = cfg->owner;
+
+	_pfm_pmu_conf.max_pmd = max1 + 1;
+	_pfm_pmu_conf.first_cnt_pmd = first_cnt == -1 ?  first_i : first_cnt;
+	_pfm_pmu_conf.max_cnt_pmd  = max2 + 1;
+	_pfm_pmu_conf.num_counters = n_counters;
+	_pfm_pmu_conf.num_pmds = n;
+	_pfm_pmu_conf.counter_width = cfg->counter_width;
+	_pfm_pmu_conf.ovfl_mask = (PFM_ONE_64 << cfg->counter_width) -1;
+	_pfm_pmu_conf.max_rw_pmd = max3 + 1;
+
+	PFM_INFO("%s PMU detected, %u PMCs, %u PMDs, %u counters (%u bits)",
+		 _pfm_pmu_conf.pmu_name,
+		 _pfm_pmu_conf.num_pmcs,
+		 _pfm_pmu_conf.num_pmds,
+		 _pfm_pmu_conf.num_counters,
+		 _pfm_pmu_conf.counter_width);
+
+	return 0;
+}
+
+int pfm_pmu_register(struct pfm_pmu_config *cfg)
+{
+	u16 i, nspec, nspec_ro, num_pmcs, num_pmds, num_wc = 0;
+	int type, ret;
+
+	if (atomic_read(&perfmon_disabled)) {
+		PFM_INFO("perfmon disabled, cannot add PMU description");
+		return -ENOSYS;
+	}
+
+	nspec = nspec_ro = num_pmds = num_pmcs = 0;
+
+	/* some sanity checks */
+	if (cfg == NULL || cfg->pmu_name == NULL) {
+		PFM_INFO("PMU config descriptor is invalid");
+		return -EINVAL;
+	}
+
+	/* must have a probe */
+	if (cfg->probe_pmu == NULL) {
+		PFM_INFO("PMU config has no probe routine");
+		return -EINVAL;
+	}
+
+	/*
+	 * execute probe routine before anything else as it
+	 * may update configuration tables
+	 */
+	if ((*cfg->probe_pmu)() == -1) {
+		PFM_INFO("%s PMU detection failed", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	if (!(cfg->flags & PFM_PMUFL_IS_BUILTIN) && cfg->owner == NULL) {
+		PFM_INFO("PMU config %s is missing owner", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	if (!cfg->num_pmd_entries) {
+		PFM_INFO("%s needs to define num_pmd_entries", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	if (!cfg->num_pmc_entries) {
+		PFM_INFO("%s needs to define num_pmc_entries", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	if (!cfg->counter_width) {
+		PFM_INFO("PMU config %s, zero width counters", cfg->pmu_name);
+		return -EINVAL;
+	}
+
+	/*
+	 * REG_RO, REG_V not supported on PMC registers
+	 */
+	for (i = 0; i < cfg->num_pmc_entries;  i++) {
+
+		type = cfg->pmc_desc[i].type;
+
+		if (type & PFM_REG_I)
+			num_pmcs++;
+
+		if (type & PFM_REG_WC)
+			num_wc++;
+
+		if (type & PFM_REG_V) {
+			PFM_INFO("PFM_REG_V is not supported on "
+				 "PMCs (PMC%d)", i);
+			return -EINVAL;
+		}
+		if (type & PFM_REG_RO) {
+			PFM_INFO("PFM_REG_RO meaningless on "
+				 "PMCs (PMC%u)", i);
+			return -EINVAL;
+		}
+	}
+
+	if (num_wc && cfg->pmc_write_check == NULL) {
+		PFM_INFO("PMC have write-checker but no callback provided\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * check virtual PMD registers
+	 */
+	num_wc= 0;
+	for (i = 0; i < cfg->num_pmd_entries;  i++) {
+
+		type = cfg->pmd_desc[i].type;
+
+		if (type & PFM_REG_I)
+			num_pmds++;
+
+		if (type & PFM_REG_V)
+			nspec++;
+
+		if (type & PFM_REG_WC)
+			num_wc++;
+
+		if ((type & (PFM_REG_V|PFM_REG_RO)) == (PFM_REG_V|PFM_REG_RO))
+			nspec_ro++;
+	}
+
+	if (num_wc && cfg->pmd_write_check == NULL) {
+		PFM_INFO("PMD have write-checker but no callback provided\n");
+		return -EINVAL;
+	}
+
+	if (nspec_ro && cfg->pmd_sread == NULL) {
+		PFM_INFO("PMU config is missing pmd_sread()");
+		return -EINVAL;
+	}
+
+	nspec = nspec - nspec_ro;
+	if (nspec && cfg->pmd_swrite == NULL) {
+		PFM_INFO("PMU config is missing pmd_swrite()");
+		return -EINVAL;
+	}
+
+	if (num_pmcs >= PFM_MAX_PMCS) {
+		PFM_INFO("%s PMCS registers exceed name space [0-%u]",
+			 cfg->pmu_name,
+			 PFM_MAX_PMCS);
+		return -EINVAL;
+	}
+
+	spin_lock(&pfm_pmu_conf_lock);
+
+	if (pfm_pmu_conf &&
+	    (!pmu_is_module(pfm_pmu_conf) ||
+	     module_refcount(pfm_pmu_conf->owner))) {
+		ret = -EBUSY;
+	} else {
+		ret = pfm_pmu_config_init(cfg);
+		if (!ret)
+			ret = pfm_arch_pmu_config_init(cfg);
+	}
+	if (!ret) {
+		pfm_pmu_conf = &_pfm_pmu_conf;
+		ret = pfm_sysfs_add_pmu(pfm_pmu_conf);
+		if (ret)
+			pfm_pmu_conf = NULL;
+	}
+	spin_unlock(&pfm_pmu_conf_lock);
+
+	if (ret) {
+		PFM_INFO("register %s PMU error %d", cfg->pmu_name, ret);
+	} else {
+		PFM_INFO("%s PMU installed", cfg->pmu_name);
+		/* 
+		 * (re)initialize PMU on each PMU now that we have a description
+		 */
+		on_each_cpu(__pfm_init_percpu, NULL, 0, 0);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(pfm_pmu_register);
+
+/*
+ * remove PMU description. Caller must pass address of current
+ * configuration. This is mostly for sanity checking as only
+ * one config can exist at any time.
+ *
+ * We are using the module refcount mechanism to protect against
+ * removal while the configuration is being used. As long as there is
+ * one context, a PMU configuration cannot be removed. The protection is
+ * managed in module logic.
+ */
+void pfm_pmu_unregister(struct pfm_pmu_config *cfg)
+{
+	if (cfg == NULL)
+		return;
+
+	spin_lock(&pfm_pmu_conf_lock);
+
+	BUG_ON(module_refcount(pfm_pmu_conf->owner));
+
+	if (cfg->owner == pfm_pmu_conf->owner) {
+		pfm_sysfs_remove_pmu(pfm_pmu_conf);
+		pfm_pmu_conf = NULL;
+	}
+
+	spin_unlock(&pfm_pmu_conf_lock);
+}
+EXPORT_SYMBOL(pfm_pmu_unregister);
+
+static int pfm_pmu_request_module(void)
+{
+	char *mod_name;
+	int ret;
+
+	mod_name = pfm_arch_get_pmu_module_name();
+	if (mod_name == NULL)
+		return -ENOSYS;
+
+	ret = request_module(mod_name);
+
+	PFM_DBG("mod=%s ret=%d\n", mod_name, ret);
+	return ret;
+}
+
+/*
+ * autoload:
+ * 	0     : do not try to autoload the PMU description module
+ * 	not 0 : try to autoload the PMU description module
+ */
+int pfm_pmu_conf_get(int autoload)
+{
+	int ret;
+
+	spin_lock(&pfm_pmu_conf_lock);
+
+	if (request_mod_in_progress) {
+		ret = -ENOSYS;
+		goto skip;
+	}
+	
+	if (autoload && pfm_pmu_conf == NULL) {
+
+		request_mod_in_progress = 1;
+
+		spin_unlock(&pfm_pmu_conf_lock);
+
+		pfm_pmu_request_module();
+
+		spin_lock(&pfm_pmu_conf_lock);
+
+		request_mod_in_progress = 0;
+
+		/*
+		 * request_module() may succeed but the module
+		 * may not have registered properly so we need
+		 * to check
+		 */
+	} 
+
+	ret = pfm_pmu_conf == NULL ? -ENOSYS : 0;
+	if (!ret && pmu_is_module(pfm_pmu_conf)
+	    && !try_module_get(pfm_pmu_conf->owner))
+		ret = -ENOSYS;
+skip:
+	spin_unlock(&pfm_pmu_conf_lock);
+
+	return ret;
+}
+
+void pfm_pmu_conf_put(void)
+{
+	if (pfm_pmu_conf == NULL || !pmu_is_module(pfm_pmu_conf))
+		return;
+
+	spin_lock(&pfm_pmu_conf_lock);
+	module_put(pfm_pmu_conf->owner);
+	spin_unlock(&pfm_pmu_conf_lock);
+}
--- linux-2.6.18.base/include/linux/perfmon_pmu.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/include/linux/perfmon_pmu.h	2006-09-25 12:16:29.000000000 -0700
@@ -0,0 +1,191 @@
+/*
+ * Copyright (c) 2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * Interface for PMU description modules
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#ifndef __PERFMON_PMU_H__
+#define __PERFMON_PMU_H__ 1
+
+/*
+ * generic information about a PMC or PMD register
+ */
+struct pfm_reg_desc {
+	u16  type;		/* role of the register */
+	u16  reserved1;		/* for future use */
+	u32  reserved2;		/* for future use */
+	u64  dfl_val;		/* power-on default value (quiescent) */
+	u64  rsvd_msk;		/* reserved bits: 0 means reserved */
+	u64  no_emul64_msk;	/* bits to clear for PFM_REGFL_NO_EMUL64 */
+	unsigned long hw_addr;	/* HW register address or index */
+	struct kobject	kobj;	/* for internal use only */
+	char *desc;		/* HW register description string */
+};
+#define to_reg(n) container_of(n, struct pfm_reg_desc, kobj)
+
+/*
+ * pfm_reg_desc declaration help macros
+ */
+#define PMC_D(t,d,v,r,n, h)   \
+	{ .type = t,          \
+	  .desc = d,          \
+	  .dfl_val = v,       \
+	  .rsvd_msk = r,      \
+	  .no_emul64_msk = n, \
+	  .hw_addr = h	      \
+        }
+
+#define PMD_D(t,d, h)     \
+	{ .type = t,      \
+	  .desc = d,      \
+	  .rsvd_msk = -1, \
+	  .hw_addr = h	  \
+        }
+
+#define PMX_NA \
+	{ .type = PFM_REG_NA }
+
+/*
+ * type of a PMU register (16-bit bitmask) for use with pfm_reg_desc.type
+ */
+#define PFM_REG_NA	0x00  /* not avail. (not impl.,no access) must be 0 */
+#define PFM_REG_I	0x01  /* implemented */
+#define PFM_REG_WC	0x02  /* has write_checker */
+#define PFM_REG_C64	0x04  /* PMD: 64-bit virtualization */
+#define PFM_REG_RO	0x08  /* PMD: read-only (writes ignored) */
+#define PFM_REG_V	0x10  /* PMD: virtual reg (provided by PMU description) */
+#define PFM_REG_NO64	0x100 /* PMC: supports REGFL_NOEMUL64 */
+
+/*
+ * define some shortcuts for common types
+ */
+#define PFM_REG_W	(PFM_REG_WC|PFM_REG_I)
+#define PFM_REG_W64	(PFM_REG_WC|PFM_REG_NO64|PFM_REG_I)
+#define PFM_REG_C	(PFM_REG_C64|PFM_REG_I)
+#define PFM_REG_I64	(PFM_REG_NO64|PFM_REG_I)
+
+typedef int (*pfm_pmc_check_t)(struct pfm_context *ctx,
+			       struct pfm_event_set *set,
+			       struct pfarg_pmc *req);
+
+typedef int (*pfm_pmd_check_t)(struct pfm_context *ctx,
+			       struct pfm_event_set *set,
+			       struct pfarg_pmd *req);
+
+
+typedef u64 (*pfm_pmd_sread_t)(struct pfm_context *ctx, unsigned int cnum);
+typedef void (*pfm_pmd_swrite_t)(struct pfm_context *ctx, unsigned int cnum, u64 val);
+
+/*
+ * _pfm_pmu_config is for perfmon core/arch specific use only.
+ * PMU description modules must use strutc pfm_pmu_config.
+ *
+ * The pfm_internal_pmu_config is shared between all CPUs. It is accessed for reading
+ * only, as such the cache lines will be shared (replicated) and we should not
+ * suffer any major penalty for having only one copy of the struct on large NUMA
+ * systems.
+ */
+struct _pfm_pmu_config {
+	u64 impl_pmcs[PFM_PMC_BV];		/* impl PMC */
+	u64 impl_pmds[PFM_PMD_BV];		/* impl PMD */
+	u64 impl_rw_pmds[PFM_PMD_BV];		/* impl RW PMD */
+	u64 cnt_pmds[PFM_PMD_BV];		/* impl counter */
+	u64 ovfl_mask;				/* overflow mask */
+	u16 max_pmc;				/* highest+1 impl PMC */
+	u16 max_pmd;				/* highest+1 impl PMD */
+	u16 max_rw_pmd;				/* highest+1 impl RW PMD */
+	u16 first_cnt_pmd;			/* first counting PMD */
+	u16 max_cnt_pmd;			/* highest+1 impl counter */
+	u16 num_pmcs;				/* logical PMCS  */
+	u16 num_pmds;				/* logical PMDS  */
+	u16 num_counters;			/* PMC/PMD counter pairs */
+
+	char *pmu_name;				/* PMU family name */
+	char *version;				/* config module version number */
+	int counter_width;			/* width of hardware counter */
+
+	struct pfm_reg_desc	pmc_desc[PFM_MAX_PMCS+1];/* PMC register descriptions */
+	struct pfm_reg_desc	pmd_desc[PFM_MAX_PMDS+1];/* PMD register descriptions */
+
+	pfm_pmc_check_t		pmc_write_check;/* PMC write checker callback (optional) */
+	pfm_pmd_check_t		pmd_write_check;/* PMD write checker callback (optional) */
+
+	pfm_pmd_sread_t		pmd_sread;	/* PMD model specific read (optional) */
+	pfm_pmd_swrite_t	pmd_swrite;	/* PMD model specific write (optional) */
+	void			*arch_info;	/* arch-specific information */
+	u32			flags;		/* set of flags */
+
+	struct module		*owner;		/* pointer to module struct */
+	struct kobject	kobj;			/* for internal use only */
+};
+#define to_pmu(n) container_of(n, struct _pfm_pmu_config, kobj)
+
+/*
+ * structure used by pmu description modules
+ *
+ * probe_pmu() routine return value:
+ * 	- 1 means recognized PMU
+ * 	- 0 means not recognized PMU
+ */
+struct pfm_pmu_config {
+	char *pmu_name;				/* PMU family name */
+	char *version;				/* config module version number */
+
+	int counter_width;			/* width of hardware counter */
+
+	struct pfm_reg_desc	*pmc_desc;	/* PMC register descriptions */
+	struct pfm_reg_desc	*pmd_desc;	/* PMD register descriptions */
+
+	pfm_pmc_check_t		pmc_write_check;/* PMC write checker callback (optional) */
+	pfm_pmd_check_t		pmd_write_check;/* PMD write checker callback (optional) */
+	pfm_pmd_check_t		pmd_read_check;	/* PMD read checker callback  (optional) */
+
+	pfm_pmd_sread_t		pmd_sread;	/* PMD model specific read (optional) */
+	pfm_pmd_swrite_t	pmd_swrite;	/* PMD model specific write (optional) */
+
+	int             	(*probe_pmu)(void);/* probe PMU routine */
+
+	u16			num_pmc_entries;/* number of entries in pmc_desc */
+	u16			num_pmd_entries;/* number of entries in pmd_desc */
+
+	void			*arch_info;	/* arch-specific information */
+	u32			flags;		/* set of flags */
+
+	struct module		*owner;		/* pointer to module struct */
+};
+
+/*
+ * pfm_pmu_config flags
+ */
+#define PFM_PMUFL_IS_BUILTIN	0x1	/* pmu config is compiled in */
+
+/*
+ * we need to know whether the PMU description is builtin or compiled
+ * as a module
+ */
+#ifdef MODULE
+#define PFM_PMU_BUILTIN_FLAG	0	/* not built as a module */
+#else
+#define PFM_PMU_BUILTIN_FLAG	PFM_PMUFL_IS_BUILTIN /* built as a module */
+#endif
+
+int  pfm_pmu_register(struct pfm_pmu_config *);
+void pfm_pmu_unregister(struct pfm_pmu_config *);
+
+u64 pfm_pmu_sread(struct pfm_context *, unsigned int);
+
+#endif /* __PERFMON_PMU_H__ */
