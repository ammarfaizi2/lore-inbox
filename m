Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVJOShs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVJOShs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 14:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVJOShs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 14:37:48 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:53691 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751194AbVJOShr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 14:37:47 -0400
Subject: PATCH: EDAC, core EDAC support code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 15 Oct 2005 20:06:57 +0100
Message-Id: <1129403217.17923.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a subset of the bluesmoke project core code, stripped of the NMI
work which isn't ready to merge and some of the "interesting" proc
functionality that needs reworking or just has no place in kernel. It
requires no core kernel changes except the added scrub functions already
posted.

The goal is to merge further functionality only after the core code is
accepted and proven in the base kernel, and only at the point the
upstream extras are really ready to merge.

Alan

Signed-off-by: Alan Cox <alan@redhat.com>


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/edac/edac_mc.c linux-2.6.14-rc2-mm1/drivers/edac/edac_mc.c
--- linux.vanilla-2.6.14-rc2-mm1/drivers/edac/edac_mc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc2-mm1/drivers/edac/edac_mc.c	2005-10-14 18:26:12.000000000 +0100
@@ -0,0 +1,1308 @@
+/*
+ * edac_mc kernel module
+ * (C) 2003 Linux Networx (http://lnxi.com)
+ * This file may be distributed under the terms of the
+ * GNU General Public License.
+ *
+ * Written by Thayne Harbaugh
+ * Based on work by Dan Hollis <goemon at anime dot net> and others.
+ *	http://www.anime.net/~goemon/linux-ecc/
+ *
+ * $Id: edac_mc.c,v 1.7.2.19 2005/10/05 22:01:42 dsp_llnl Exp $
+ *
+ */
+
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/sysctl.h>
+#include <linux/highmem.h>
+#include <linux/timer.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+
+#include <asm/uaccess.h>
+#include <asm/page.h>
+
+#include "edac_mc.h"
+
+
+#define	EDAC_MC_VERSION	"edac_mc  Ver: 2.0.0.devel " __DATE__
+
+#ifdef CONFIG_EDAC_DEBUG
+int edac_debug_level = 0;
+EXPORT_SYMBOL(edac_debug_level);
+#endif
+
+#define MC_PROC_DIR "mc"
+#define	EDAC_THREAD_NAME	"kedac"
+
+
+/* /proc/mc dir */
+static struct proc_dir_entry *proc_mc;
+
+/* Setable by module parameter and sysctl */
+static int panic_on_ue = 1;
+static int check_pci_parity = 1;	/* default YES check PCI parity */
+static int panic_on_pci_parity = 0;     /* default no panic on PCI Parity */
+static int log_ue = 1;
+static int log_ce = 1;
+static int poll_msec = 1000;
+
+static u32 pci_parity_count = 0;
+
+
+/* lock to memory controller's control array */
+static DECLARE_MUTEX(mem_ctls_mutex);
+
+static struct list_head mc_devices = LIST_HEAD_INIT(mc_devices);
+
+static struct mem_ctl_info * find_mc_by_idx (int idx)
+{
+	struct list_head *item;
+	struct mem_ctl_info *mci;
+
+	list_for_each(item, &mc_devices) {
+		mci = list_entry(item, struct mem_ctl_info, link);
+
+		if (mci->mc_idx >= idx) {
+			if (mci->mc_idx == idx)
+				return mci;
+
+			break;
+		}
+	}
+
+	return NULL;
+}
+
+#ifdef CONFIG_SYSCTL
+static void dimm_labels(char *buf, void *data)
+{
+	int mcidx, ridx, chidx;
+	char *mcstr, *rstr, *chstr, *lstr, *p;
+	struct mem_ctl_info *mci;
+
+	lstr = buf;
+
+	mcstr = strsep(&lstr, ".");
+	if (!lstr)
+		return;
+	mcidx = simple_strtol(mcstr, &p, 0);
+	if (*p)
+		return;
+	if ((mci = find_mc_by_idx(mcidx)) == NULL)
+		return;
+	rstr = strsep(&lstr, ".");
+	if (!lstr)
+		return;
+	ridx = simple_strtol(rstr, &p, 0);
+	if (*p)
+		return;
+	if ((ridx >= mci->nr_csrows) || !mci->csrows)
+		return;
+
+	chstr = strsep(&lstr, ":");
+	if (!lstr)
+		return;
+	chidx = simple_strtol(chstr, &p, 0);
+	if (*p)
+		return;
+	if ((chidx >= mci->csrows[ridx].nr_channels) ||
+	    !mci->csrows[ridx].channels)
+		return;
+
+	debugf1("%d:%d.%d:%s\n", mcidx, ridx, chidx, lstr);
+
+	strncpy(mci->csrows[ridx].channels[chidx].label, lstr,
+		EDAC_MC_LABEL_LEN + 1);
+	/*
+	 * no need to NULL terminate label since
+	 * get_user_tok() NULL terminates.
+	 */
+}
+
+
+static void counter_reset(char *buf, void *data)
+{
+	char *p = buf;
+	int mcidx, row, chan;
+	struct mem_ctl_info *mci;
+
+	pci_parity_count = 0;
+
+	mcidx = simple_strtol(buf, &p, 0);
+	if (*p)
+		return;
+
+	down(&mem_ctls_mutex);
+	mci = find_mc_by_idx(mcidx);
+
+	if (mci == NULL)
+		goto out;
+
+	mci->ue_noinfo_count = 0;
+	mci->ce_noinfo_count = 0;
+	mci->ue_count = 0;
+	mci->ce_count = 0;
+	for (row = 0; row < mci->nr_csrows; row++) {
+		struct csrow_info *ri = &mci->csrows[row];
+
+		ri->ue_count = 0;
+		ri->ce_count = 0;
+		for (chan = 0; chan < ri->nr_channels; chan++)
+			ri->channels[chan].ce_count = 0;
+	}
+	mci->start_time = jiffies;
+out:
+	up(&mem_ctls_mutex);
+}
+
+
+static ctl_table mc_table[] = {
+	{-1, "panic_on_ue", &panic_on_ue,
+	 sizeof(int), 0644, NULL, proc_dointvec},
+	{-2, "log_ue", &log_ue,
+	 sizeof(int), 0644, NULL, proc_dointvec},
+	{-3, "log_ce", &log_ce,
+	 sizeof(int), 0644, NULL, proc_dointvec},
+	{-4, "poll_msec", &poll_msec,
+	 sizeof(int), 0644, NULL, proc_dointvec},
+	{-7, "panic_on_pci_parity", &panic_on_pci_parity,
+	 sizeof(int), 0644, NULL, proc_dointvec},
+	{-8, "check_pci_parity", &check_pci_parity,
+	 sizeof(int), 0644, NULL, proc_dointvec},
+#ifdef CONFIG_EDAC_DEBUG
+	{-9, "debug_level", &edac_debug_level,
+	 sizeof(int), 0644, NULL, proc_dointvec},
+#endif
+	{0}
+};
+
+
+static ctl_table mc_root_table[] = {
+	{CTL_DEBUG, MC_PROC_DIR, NULL, 0, 0555, mc_table},
+	{0}
+};
+
+
+static struct ctl_table_header *mc_sysctl_header = NULL;
+#endif				/* CONFIG_SYSCTL */
+
+
+#ifdef CONFIG_PROC_FS
+static const char *mem_types[] = {
+	[MEM_EMPTY] = "Empty",
+	[MEM_RESERVED] = "Reserved",
+	[MEM_UNKNOWN] = "Unknown",
+	[MEM_FPM] = "FPM",
+	[MEM_EDO] = "EDO",
+	[MEM_BEDO] = "BEDO",
+	[MEM_SDR] = "Unbuffered-SDR",
+	[MEM_RDR] = "Registered-SDR",
+	[MEM_DDR] = "Unbuffered-DDR",
+	[MEM_RDDR] = "Registered-DDR",
+	[MEM_RMBS] = "RMBS"
+};
+
+static const char *dev_types[] = {
+	[DEV_UNKNOWN] = "Unknown",
+	[DEV_X1] = "x1",
+	[DEV_X2] = "x2",
+	[DEV_X4] = "x4",
+	[DEV_X8] = "x8",
+	[DEV_X16] = "x16",
+	[DEV_X32] = "x32",
+	[DEV_X64] = "x64"
+};
+
+static const char *edac_caps[] = {
+	[EDAC_UNKNOWN] = "Unknown",
+	[EDAC_NONE] = "None",
+	[EDAC_RESERVED] = "Reserved",
+	[EDAC_PARITY] = "PARITY",
+	[EDAC_EC] = "EC",
+	[EDAC_SECDED] = "SECDED",
+	[EDAC_S2ECD2ED] = "S2ECD2ED",
+	[EDAC_S4ECD4ED] = "S4ECD4ED",
+	[EDAC_S8ECD8ED] = "S8ECD8ED",
+	[EDAC_S16ECD16ED] = "S16ECD16ED"
+};
+
+
+/* FIXME - CHANNEL_PREFIX is pretty bad */
+#define CHANNEL_PREFIX(...) \
+	do { \
+		p += sprintf(p, "%d.%d:%s", \
+			chan->csrow->csrow_idx, \
+			chan->chan_idx, \
+			chan->label); \
+		p += sprintf(p, ":" __VA_ARGS__); \
+	} while (0)
+
+
+static inline int mc_proc_output_channel(char *buf,
+					 struct channel_info *chan)
+{
+	char *p = buf;
+
+	CHANNEL_PREFIX("CE:\t\t%d\n", chan->ce_count);
+	return p - buf;
+}
+
+#undef CHANNEL_PREFIX
+
+
+#define CSROW_PREFIX(...) \
+	do { \
+		int i; \
+		p += sprintf(p, "%d:", csrow->csrow_idx); \
+		p += sprintf(p, "%s", csrow->channels[0].label); \
+		for (i = 1; i < csrow->nr_channels; i++) \
+			p += sprintf(p, "|%s", csrow->channels[i].label); \
+		p += sprintf(p, ":" __VA_ARGS__); \
+	} while (0)
+
+
+static inline int mc_proc_output_csrow(char *buf, struct csrow_info *csrow)
+{
+	char *p = buf;
+	int chan_idx;
+
+	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+
+	CSROW_PREFIX("Memory Size:\t%d MiB\n",
+		     (u32) PAGES_TO_MiB(csrow->nr_pages));
+	CSROW_PREFIX("Mem Type:\t\t%s\n", mem_types[csrow->mtype]);
+	CSROW_PREFIX("Dev Type:\t\t%s\n", dev_types[csrow->dtype]);
+	CSROW_PREFIX("EDAC Mode:\t\t%s\n", edac_caps[csrow->edac_mode]);
+	CSROW_PREFIX("UE:\t\t\t%d\n", csrow->ue_count);
+	CSROW_PREFIX("CE:\t\t\t%d\n", csrow->ce_count);
+
+	for (chan_idx = 0; chan_idx < csrow->nr_channels; chan_idx++)
+		p += mc_proc_output_channel(p, &csrow->channels[chan_idx]);
+
+	p += sprintf(p, "\n");
+	return p - buf;
+}
+
+#undef CSROW_PREFIX
+
+
+static inline int mc_proc_output_edac_cap(char *buf,
+					  unsigned long edac_cap)
+{
+	char *p = buf;
+	int bit_idx;
+
+	for (bit_idx = 0; bit_idx < 8 * sizeof(edac_cap); bit_idx++) {
+		if ((edac_cap >> bit_idx) & 0x1)
+			p += sprintf(p, "%s ", edac_caps[bit_idx]);
+	}
+
+	return p - buf;
+}
+
+
+static inline int mc_proc_output_mtype_cap(char *buf,
+					   unsigned long mtype_cap)
+{
+	char *p = buf;
+	int bit_idx;
+
+	for (bit_idx = 0; bit_idx < 8 * sizeof(mtype_cap); bit_idx++) {
+		if ((mtype_cap >> bit_idx) & 0x1)
+			p += sprintf(p, "%s ", mem_types[bit_idx]);
+	}
+
+	return p - buf;
+}
+
+
+static int mc_proc_output(struct mem_ctl_info *mci, char *buf)
+{
+	int csrow_idx;
+	u32 total_pages;
+	char *p = buf;
+
+	debugf3("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+
+	p += sprintf(p, "Check PCI Parity:\t%d\n", check_pci_parity);
+	p += sprintf(p, "Panic PCI Parity:\t%d\n", panic_on_pci_parity);
+	p += sprintf(p, "Panic UE:\t\t%d\n", panic_on_ue);
+	p += sprintf(p, "Log UE:\t\t\t%d\n", log_ue);
+	p += sprintf(p, "Log CE:\t\t\t%d\n", log_ce);
+	p += sprintf(p, "Poll msec:\t\t%d\n", poll_msec);
+
+	p += sprintf(p, "\n");
+
+	p += sprintf(p, "MC Core:\t\t%s\n", EDAC_MC_VERSION );
+	p += sprintf(p, "MC Module:\t\t%s %s\n", mci->mod_name,
+		     mci->mod_ver);
+	p += sprintf(p, "Memory Controller:\t%s\n", mci->ctl_name);
+	p += sprintf(p, "PCI Bus ID:\t\t%s (%s)\n", mci->pdev->dev.bus_id,
+		     pci_name(mci->pdev));
+
+	p += sprintf(p, "EDAC capability:\t");
+	p += mc_proc_output_edac_cap(p, mci->edac_ctl_cap);
+	p += sprintf(p, "\n");
+
+	p += sprintf(p, "Current EDAC capability:\t");
+	p += mc_proc_output_edac_cap(p, mci->edac_cap);
+	p += sprintf(p, "\n");
+
+	p += sprintf(p, "Supported Mem Types:\t");
+	p += mc_proc_output_mtype_cap(p, mci->mtype_cap);
+	p += sprintf(p, "\n");
+
+	p += sprintf(p, "\n");
+
+	for (total_pages = csrow_idx = 0; csrow_idx < mci->nr_csrows;
+	     csrow_idx++) {
+		struct csrow_info *csrow = &mci->csrows[csrow_idx];
+
+		if (!csrow->nr_pages)
+			continue;
+		total_pages += csrow->nr_pages;
+		p += mc_proc_output_csrow(p, csrow);
+	}
+
+	p += sprintf(p, "Total Memory Size:\t%d MiB\n",
+		     (u32) PAGES_TO_MiB(total_pages));
+	p += sprintf(p, "Seconds since reset:\t%ld\n",
+		     (jiffies - mci->start_time) / HZ);
+	p += sprintf(p, "UE No Info:\t\t%d\n", mci->ue_noinfo_count);
+	p += sprintf(p, "CE No Info:\t\t%d\n", mci->ce_noinfo_count);
+	p += sprintf(p, "Total UE:\t\t%d\n", mci->ue_count);
+	p += sprintf(p, "Total CE:\t\t%d\n", mci->ce_count);
+	p += sprintf(p, "Total PCI Parity:\t%u\n\n", pci_parity_count);
+	return p - buf;
+}
+
+
+static int mc_read_proc(char *page, char **start, off_t off, int count,
+			int *eof, void *data)
+{
+	int len;
+	struct mem_ctl_info *mci = (struct mem_ctl_info *) data;
+
+	debugf3("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+
+	down(&mem_ctls_mutex);
+	len = mc_proc_output(mci, page);
+	up(&mem_ctls_mutex);
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+#endif				/* CONFIG_PROC_FS */
+
+
+#if CONFIG_EDAC_DEBUG
+
+
+EXPORT_SYMBOL(edac_mc_dump_channel);
+
+void edac_mc_dump_channel(struct channel_info *chan)
+{
+	printk(KERN_INFO "\tchannel = %p\n", chan);
+	printk(KERN_INFO "\tchannel->chan_idx = %d\n", chan->chan_idx);
+	printk(KERN_INFO "\tchannel->ce_count = %d\n", chan->ce_count);
+	printk(KERN_INFO "\tchannel->label = '%s'\n", chan->label);
+	printk(KERN_INFO "\tchannel->csrow = %p\n\n", chan->csrow);
+}
+
+
+EXPORT_SYMBOL(edac_mc_dump_csrow);
+
+void edac_mc_dump_csrow(struct csrow_info *csrow)
+{
+	printk(KERN_INFO "\tcsrow = %p\n", csrow);
+	printk(KERN_INFO "\tcsrow->csrow_idx = %d\n", csrow->csrow_idx);
+	printk(KERN_INFO "\tcsrow->first_page = 0x%lx\n",
+	       csrow->first_page);
+	printk(KERN_INFO "\tcsrow->last_page = 0x%lx\n", csrow->last_page);
+	printk(KERN_INFO "\tcsrow->page_mask = 0x%lx\n", csrow->page_mask);
+	printk(KERN_INFO "\tcsrow->nr_pages = 0x%x\n", csrow->nr_pages);
+	printk(KERN_INFO "\tcsrow->nr_channels = %d\n",
+	       csrow->nr_channels);
+	printk(KERN_INFO "\tcsrow->channels = %p\n", csrow->channels);
+	printk(KERN_INFO "\tcsrow->mci = %p\n\n", csrow->mci);
+}
+
+
+EXPORT_SYMBOL(edac_mc_dump_mci);
+
+void edac_mc_dump_mci(struct mem_ctl_info *mci)
+{
+	printk(KERN_INFO "\tmci = %p\n", mci);
+	printk(KERN_INFO "\tmci->mtype_cap = %lx\n", mci->mtype_cap);
+	printk(KERN_INFO "\tmci->edac_ctl_cap = %lx\n", mci->edac_ctl_cap);
+	printk(KERN_INFO "\tmci->edac_cap = %lx\n", mci->edac_cap);
+	printk(KERN_INFO "\tmci->edac_check = %p\n", mci->edac_check);
+	printk(KERN_INFO "\tmci->nr_csrows = %d, csrows = %p\n",
+	       mci->nr_csrows, mci->csrows);
+	printk(KERN_INFO "\tpdev = %p\n", mci->pdev);
+	printk(KERN_INFO "\tmod_name:ctl_name = %s:%s\n",
+	       mci->mod_name, mci->ctl_name);
+	printk(KERN_INFO "\tproc_name = %s, proc_ent = %p\n",
+	       mci->proc_name, mci->proc_ent);
+	printk(KERN_INFO "\tpvt_info = %p\n\n", mci->pvt_info);
+}
+
+
+#endif				/* CONFIG_EDAC_DEBUG */
+
+/* 'ptr' points to a possibly unaligned item X such that sizeof(X) is 'size'.
+ * Adjust 'ptr' so that its alignment is at least as stringent as what the
+ * compiler would provide for X and return the aligned result.
+ *
+ * If 'size' is a constant, the compiler will optimize this whole function
+ * down to either a no-op or the addition of a constant to the value of 'ptr'.
+ */
+static inline char * align_ptr (void *ptr, unsigned size)
+{
+	unsigned align, r;
+
+	/* Here we assume that the alignment of a "long long" is the most
+	 * stringent alignment that the compiler will ever provide by default.
+	 * As far as I know, this is a reasonable assumption.
+	 */
+	if (size > sizeof(long))
+		align = sizeof(long long);
+	else if (size > sizeof(int))
+		align = sizeof(long);
+	else if (size > sizeof(short))
+		align = sizeof(int);
+	else if (size > sizeof(char))
+		align = sizeof(short);
+	else
+		return (char *) ptr;
+
+	r = size % align;
+
+	if (r == 0)
+		return (char *) ptr;
+
+	return (char *) (((unsigned long) ptr) + align - r);
+}
+
+
+EXPORT_SYMBOL(edac_mc_alloc);
+
+/* Everything is kmalloc'ed as one big chunk - more efficient.
+ * Only can be used if all structures have the same lifetime - otherwise
+ * you have to allocate and initialize your own structures.
+ *
+ * Use edac_mc_free() to free mc structures allocated by this function.
+ */
+struct mem_ctl_info *edac_mc_alloc(unsigned sz_pvt, unsigned nr_csrows,
+					unsigned nr_chans)
+{
+	struct mem_ctl_info *mci;
+	struct csrow_info *csi, *csrow;
+	struct channel_info *chi, *chp, *chan;
+	void *pvt;
+	unsigned size;
+	int row, chn;
+
+	/* Figure out the offsets of the various items from the start of an mc
+	 * structure.  We want the alignment of each item to be at least as
+	 * stringent as what the compiler would provide if we could simply
+	 * hardcode everything into a single struct.
+	 */
+	mci = (struct mem_ctl_info *) 0;
+	csi = (struct csrow_info *)
+	      align_ptr(&mci[1], sizeof(*csi));
+	chi = (struct channel_info *)
+	      align_ptr(&csi[nr_csrows], sizeof(*chi));
+	pvt = align_ptr(&chi[nr_chans * nr_csrows], sz_pvt);
+	size = ((unsigned long) pvt) + sz_pvt;
+
+	if ((mci = kmalloc(size, GFP_KERNEL)) == NULL)
+		return NULL;
+
+	/* Adjust pointers so they point within the memory we just allocated
+	 * rather than an imaginary chunk of memory located at address 0.
+	 */
+	csi = (struct csrow_info *) (((char *) mci) + ((unsigned long) csi));
+	chi = (struct channel_info *) (((char *) mci) + ((unsigned long) chi));
+	pvt = sz_pvt ? (((char *) mci) + ((unsigned long) pvt)) : NULL;
+
+	memset(mci, 0, size);
+	mci->csrows = csi;
+	mci->pvt_info = pvt;
+	mci->nr_csrows = nr_csrows;
+
+	for (row = 0; row < nr_csrows; row++) {
+		csrow = &csi[row];
+		csrow->csrow_idx = row;
+		csrow->mci = mci;
+		csrow->nr_channels = nr_chans;
+		chp = &chi[row * nr_chans];
+		csrow->channels = chp;
+
+		for (chn = 0; chn < nr_chans; chn++) {
+			chan = &chp[chn];
+			chan->chan_idx = chn;
+			chan->csrow = csrow;
+		}
+	}
+
+	return mci;
+}
+
+EXPORT_SYMBOL(edac_mc_find_mci_by_pdev);
+
+struct mem_ctl_info *edac_mc_find_mci_by_pdev(struct pci_dev *pdev)
+{
+	struct mem_ctl_info *mci;
+	struct list_head *item;
+
+	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+
+	list_for_each(item, &mc_devices) {
+		mci = list_entry(item, struct mem_ctl_info, link);
+
+		if (mci->pdev == pdev)
+			return mci;
+	}
+
+	return NULL;
+}
+
+static int add_mc_to_global_list (struct mem_ctl_info *mci)
+{
+	struct list_head *item, *insert_before;
+	struct mem_ctl_info *p;
+	int i;
+
+	if (list_empty(&mc_devices)) {
+		mci->mc_idx = 0;
+		insert_before = &mc_devices;
+	} else {
+		if (edac_mc_find_mci_by_pdev(mci->pdev)) {
+			printk(KERN_WARNING
+			       "MC: %s (%s) %s %s already assigned %d\n",
+			       mci->pdev->dev.bus_id, pci_name(mci->pdev),
+			       mci->mod_name, mci->ctl_name, mci->mc_idx);
+			return 1;
+		}
+
+		insert_before = NULL;
+		i = 0;
+
+		list_for_each(item, &mc_devices) {
+			p = list_entry(item, struct mem_ctl_info, link);
+
+			if (p->mc_idx != i) {
+				insert_before = item;
+				break;
+			}
+
+			i++;
+		}
+
+		mci->mc_idx = i;
+
+		if (insert_before == NULL)
+			insert_before = &mc_devices;
+	}
+
+	list_add_tail_rcu(&mci->link, insert_before);
+	return 0;
+}
+
+EXPORT_SYMBOL(edac_mc_add_mc);
+
+/* FIXME - should a warning be printed if no error detection? correction? */
+int edac_mc_add_mc(struct mem_ctl_info *mci)
+{
+	int rc = 1;
+
+	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+#ifdef CONFIG_EDAC_DEBUG
+	if (edac_debug_level >= 1)
+		edac_mc_dump_mci(mci);
+	if (edac_debug_level >= 2) {
+		int i;
+
+		for (i = 0; i < mci->nr_csrows; i++) {
+			int j;
+			edac_mc_dump_csrow(&mci->csrows[i]);
+			for (j = 0; j < mci->csrows[i].nr_channels; j++)
+				edac_mc_dump_channel(&mci->csrows[i].
+							  channels[j]);
+		}
+	}
+#endif
+	down(&mem_ctls_mutex);
+
+	if (add_mc_to_global_list(mci))
+		goto finish;
+
+	printk(KERN_INFO
+	       "MC%d: Giving out device to %s %s: PCI %s (%s)\n",
+	       mci->mc_idx, mci->mod_name, mci->ctl_name,
+	       mci->pdev->dev.bus_id, pci_name(mci->pdev));
+
+	/* set load time so that error rate can be tracked */
+	mci->start_time = jiffies;
+
+	if (snprintf(mci->proc_name, MC_PROC_NAME_MAX_LEN,
+		     "%d", mci->mc_idx) == MC_PROC_NAME_MAX_LEN) {
+		printk(KERN_WARNING
+		       "MC%d: proc entry too long for device\n",
+		       mci->mc_idx);
+		/* FIXME - should there be an error code and unwind? */
+		goto finish;
+	}
+
+	mci->proc_ent = create_proc_read_entry(mci->proc_name, 0, proc_mc,
+					       mc_read_proc, (void *) mci);
+
+	if (mci->proc_ent == NULL) {
+		printk(KERN_WARNING
+		       "MC%d: failed to create proc entry for controller\n",
+		       mci->mc_idx);
+		/* FIXME - should there be an error code and unwind? */
+		goto finish;
+	}
+
+	rc = 0;
+
+finish:
+	up(&mem_ctls_mutex);
+	return rc;
+}
+
+static void complete_mc_list_del (struct rcu_head *head)
+{
+	struct mem_ctl_info *mci;
+
+	mci = container_of(head, struct mem_ctl_info, rcu);
+	INIT_LIST_HEAD(&mci->link);
+	complete(&mci->complete);
+}
+
+static void del_mc_from_global_list (struct mem_ctl_info *mci)
+{
+	list_del_rcu(&mci->link);
+	init_completion(&mci->complete);
+	call_rcu(&mci->rcu, complete_mc_list_del);
+	wait_for_completion(&mci->complete);
+}
+
+EXPORT_SYMBOL(edac_mc_del_mc);
+
+int edac_mc_del_mc(struct mem_ctl_info *mci)
+{
+	int rc = 1;
+
+	debugf0("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+	down(&mem_ctls_mutex);
+	del_mc_from_global_list(mci);
+	remove_proc_entry(mci->proc_name, proc_mc);
+	printk(KERN_INFO
+	       "MC%d: Removed device %d for %s %s: PCI %s (%s)\n",
+	       mci->mc_idx, mci->mc_idx, mci->mod_name, mci->ctl_name,
+	       mci->pdev->dev.bus_id, pci_name(mci->pdev));
+	rc = 0;
+	up(&mem_ctls_mutex);
+	return rc;
+}
+
+
+/* FIXME - this should go in an arch dependant file */
+EXPORT_SYMBOL(edac_mc_scrub_block);
+
+void edac_mc_scrub_block(unsigned long page, unsigned long offset,
+			      u32 size)
+{
+	struct page *pg;
+	unsigned long *virt_addr;
+	int i;
+
+	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+
+	/* ECC error page was not in our memory. Ignore it. */	
+	if(!pfn_valid(page))
+		return;
+
+	/* Find the actual page structure then map it and fix */
+	pg = pfn_to_page(page);
+
+	virt_addr = kmap_atomic(pg, KM_BOUNCE_READ) + offset;
+
+	/* Perform architecture specific atomic scrub operation */
+	atomic_scrub(virt_addr, size);
+	
+	/* Unmap and complete */
+	kunmap_atomic(pg, KM_BOUNCE_READ);
+}
+
+
+/* FIXME - should return -1 */
+EXPORT_SYMBOL(edac_mc_find_csrow_by_page);
+
+int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
+				    unsigned long page)
+{
+	struct csrow_info *csrows = mci->csrows;
+	int row, i;
+
+	debugf1("MC%d: " __FILE__ ": %s(): 0x%lx\n", mci->mc_idx, __func__,
+		page);
+	row = -1;
+
+	for (i = 0; i < mci->nr_csrows; i++) {
+		struct csrow_info *csrow = &csrows[i];
+
+		if (csrow->nr_pages == 0)
+			continue;
+
+		debugf3("MC%d: " __FILE__
+			": %s(): first(0x%lx) page(0x%lx)"
+			" last(0x%lx) mask(0x%lx)\n", mci->mc_idx,
+			__func__, csrow->first_page, page,
+			csrow->last_page, csrow->page_mask);
+
+		if ((page >= csrow->first_page) &&
+		    (page <= csrow->last_page) &&
+		    ((page & csrow->page_mask) ==
+		     (csrow->first_page & csrow->page_mask))) {
+			row = i;
+			break;
+		}
+	}
+
+	if (row == -1)
+		printk(KERN_ERR
+		       "MC%d: could not look up page error address %lx\n",
+		       mci->mc_idx, (unsigned long) page);
+
+	return row;
+}
+
+
+EXPORT_SYMBOL(edac_mc_handle_ce);
+
+/* FIXME - setable log (warning/emerg) levels */
+/* FIXME - integrate with evlog: http://evlog.sourceforge.net/ */
+void edac_mc_handle_ce(struct mem_ctl_info *mci,
+			    unsigned long page_frame_number,
+			    unsigned long offset_in_page,
+			    unsigned long syndrome, int row, int channel,
+			    const char *msg)
+{
+	unsigned long remapped_page;
+
+	debugf3("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+
+	/* FIXME - maybe make panic on INTERNAL ERROR an option */
+	if (row >= mci->nr_csrows || row < 0) {
+		/* something is wrong */
+		printk(KERN_ERR
+		       "MC%d: INTERNAL ERROR: row out of range (%d >= %d)\n",
+		       mci->mc_idx, row, mci->nr_csrows);
+		edac_mc_handle_ce_no_info(mci, "INTERNAL ERROR");
+		return;
+	}
+	if (channel >= mci->csrows[row].nr_channels || channel < 0) {
+		/* something is wrong */
+		printk(KERN_ERR
+		       "MC%d: INTERNAL ERROR: channel out of range "
+		       "(%d >= %d)\n",
+		       mci->mc_idx, channel, mci->csrows[row].nr_channels);
+		edac_mc_handle_ce_no_info(mci, "INTERNAL ERROR");
+		return;
+	}
+
+	if (log_ce)
+		/* FIXME - put in DIMM location */
+		printk(KERN_WARNING
+		       "MC%d: CE page 0x%lx, offset 0x%lx,"
+		       " grain %d, syndrome 0x%lx, row %d, channel %d,"
+		       " label \"%s\": %s\n", mci->mc_idx,
+		       page_frame_number, offset_in_page,
+		       mci->csrows[row].grain, syndrome, row, channel,
+		       mci->csrows[row].channels[channel].label, msg);
+
+	mci->ce_count++;
+	mci->csrows[row].ce_count++;
+	mci->csrows[row].channels[channel].ce_count++;
+
+	if (mci->scrub_mode & SCRUB_SW_SRC) {
+		/*
+		 * Some MC's can remap memory so that it is still available
+		 * at a different address when PCI devices map into memory.
+		 * MC's that can't do this lose the memory where PCI devices
+		 * are mapped.  This mapping is MC dependant and so we call
+		 * back into the MC driver for it to map the MC page to
+		 * a physical (CPU) page which can then be mapped to a virtual
+		 * page - which can then be scrubbed.
+		 */
+		remapped_page = mci->ctl_page_to_phys ?
+		    mci->ctl_page_to_phys(mci, page_frame_number) :
+		    page_frame_number;
+
+		edac_mc_scrub_block(remapped_page, offset_in_page,
+					 mci->csrows[row].grain);
+	}
+}
+
+
+EXPORT_SYMBOL(edac_mc_handle_ce_no_info);
+
+void edac_mc_handle_ce_no_info(struct mem_ctl_info *mci,
+				    const char *msg)
+{
+	if (log_ce)
+		printk(KERN_WARNING
+		       "MC%d: CE - no information available: %s\n",
+		       mci->mc_idx, msg);
+	mci->ce_noinfo_count++;
+	mci->ce_count++;
+}
+
+
+EXPORT_SYMBOL(edac_mc_handle_ue);
+
+void edac_mc_handle_ue(struct mem_ctl_info *mci,
+			    unsigned long page_frame_number,
+			    unsigned long offset_in_page, int row,
+			    const char *msg)
+{
+	int len = EDAC_MC_LABEL_LEN * 4;
+	char labels[len + 1];
+	char *pos = labels;
+	int chan;
+	int chars;
+
+	debugf3("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+
+	/* FIXME - maybe make panic on INTERNAL ERROR an option */
+	if ((row >= mci->nr_csrows) || (row < 0)) {
+		/* something is wrong */
+		printk(KERN_ERR
+		       "MC%d: INTERNAL ERROR: row out of range (%d >= %d)\n",
+		       mci->mc_idx, row, mci->nr_csrows);
+		edac_mc_handle_ue_no_info(mci, "INTERNAL ERROR");
+		return;
+	}
+
+	chars = snprintf(pos, len + 1, "%s",
+			 mci->csrows[row].channels[0].label);
+	len -= chars;
+	pos += chars;
+	for (chan = 1; (chan < mci->csrows[row].nr_channels) && (len > 0);
+	     chan++) {
+		chars = snprintf(pos, len + 1, ":%s",
+				 mci->csrows[row].channels[chan].label);
+		len -= chars;
+		pos += chars;
+	}
+
+	if (log_ue)
+		printk(KERN_EMERG
+		       "MC%d: UE page 0x%lx, offset 0x%lx, grain %d, row %d,"
+		       " labels \"%s\": %s\n", mci->mc_idx,
+		       page_frame_number, offset_in_page,
+		       mci->csrows[row].grain, row, labels, msg);
+
+	if (panic_on_ue)
+		panic
+		    ("MC%d: UE page 0x%lx, offset 0x%lx, grain %d, row %d,"
+		     " labels \"%s\": %s\n", mci->mc_idx,
+		     page_frame_number, offset_in_page,
+		     mci->csrows[row].grain, row, labels, msg);
+
+	mci->ue_count++;
+	mci->csrows[row].ue_count++;
+}
+
+
+EXPORT_SYMBOL(edac_mc_handle_ue_no_info);
+
+void edac_mc_handle_ue_no_info(struct mem_ctl_info *mci,
+				    const char *msg)
+{
+	if (panic_on_ue)
+		panic("MC%d: Uncorrected Error", mci->mc_idx);
+
+	if (log_ue)
+		printk(KERN_WARNING
+		       "MC%d: UE - no information available: %s\n",
+		       mci->mc_idx, msg);
+	mci->ue_noinfo_count++;
+	mci->ue_count++;
+}
+
+
+/*
+ *  PCI Parity polling
+ *
+ */
+static inline void edac_pci_dev_parity_test( struct pci_dev *dev )
+{
+	u16 status;
+	u8  header_type;
+
+	/* read the STATUS register on this device
+	 */
+	pci_read_config_word(dev, PCI_STATUS, &status);
+
+	debugf2("PCI STATUS= 0x%04x %s\n", status, dev->dev.bus_id );
+	status &= PCI_STATUS_DETECTED_PARITY | PCI_STATUS_SIG_SYSTEM_ERROR |
+		  PCI_STATUS_PARITY;
+
+	/* check the status reg for errors */
+	if (status) {
+
+		/* reset only the bits we are interested in */
+		pci_write_config_word(dev, PCI_STATUS, status);
+
+		if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
+			printk(KERN_CRIT
+			   	"PCI- "
+				"Signaled System Error on %s %s\n",
+				dev->dev.bus_id,
+				pci_name(dev));
+
+		if (status & (PCI_STATUS_PARITY)) {
+			printk(KERN_CRIT
+			   	"PCI- "
+				"Master Data Parity Error on %s %s\n",
+				dev->dev.bus_id,
+				pci_name(dev));
+
+			pci_parity_count++;
+		}
+
+		if (status & (PCI_STATUS_DETECTED_PARITY)) {
+			printk(KERN_CRIT
+			   	"PCI- "
+				"Detected Parity Error on %s %s\n",
+				dev->dev.bus_id,
+				pci_name(dev));
+
+			pci_parity_count++;
+		}
+	}
+
+	/* read the device TYPE, looking for bridges */
+	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
+
+	debugf2("PCI HEADER TYPE= 0x%02x %s\n", header_type, dev->dev.bus_id );
+
+	if( (header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE ) {
+
+	 	/* On bridges, need to examine secondary status register  */
+		pci_read_config_word(dev, PCI_SEC_STATUS, &status);
+
+		debugf2("PCI SEC_STATUS= 0x%04x %s\n", status, dev->dev.bus_id );
+		status &= PCI_STATUS_DETECTED_PARITY |
+			  PCI_STATUS_SIG_SYSTEM_ERROR |
+			  PCI_STATUS_PARITY;
+
+		/* check the secondary status reg for errors */
+		if (status) {
+
+			/* reset only the bits we are interested in */
+			pci_write_config_word(dev, PCI_SEC_STATUS, status);
+	
+			if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
+				printk(KERN_CRIT
+					"PCI-Bridge- "
+					"Signaled System Error on %s %s\n",
+					dev->dev.bus_id,
+					pci_name(dev));
+
+			if (status & (PCI_STATUS_PARITY)) {
+				printk(KERN_CRIT
+					"PCI-Bridge- "
+					"Master Data Parity Error on %s %s\n",
+					dev->dev.bus_id,
+					pci_name(dev));
+
+				pci_parity_count++;
+			}
+
+			if (status & (PCI_STATUS_DETECTED_PARITY)) {
+				printk(KERN_CRIT
+					"PCI-Bridge- "
+					"Detected Parity Error on %s %s\n",
+					dev->dev.bus_id,
+					pci_name(dev));
+
+				pci_parity_count++;
+			}
+		}
+	}
+}
+
+/* 
+ * pci_dev parity list iterator
+ * 	Scan the PCI device list for one iteration, looking for SERRORs
+ *	Master Parity ERRORS or Parity ERRORs on primary or secondary devices
+ */
+static inline void edac_pci_dev_parity_iterator(void)
+{
+	struct pci_dev *dev=NULL;
+	u32 before_count = pci_parity_count;
+	
+
+	/* request for kernel access to the next PCI device, if any,
+	 * and while we are looking at it have its reference count
+	 * bumped until we are done with it
+	 */
+	while((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		
+		edac_pci_dev_parity_test( dev );
+	}
+
+	/* Only if operator has selected panic on PCI Error */
+	if(panic_on_pci_parity) {
+		/* If the count is different 'after' from 'before' */
+		if( before_count != pci_parity_count )
+			panic("EDAC: PCI Parity Error");
+	}
+}
+
+
+static void check_mc_devices (void)
+{
+	unsigned long flags;
+	struct list_head *item;
+	struct mem_ctl_info *mci;
+
+	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	/* during poll, have interrupts off */
+	local_irq_save(flags);
+
+	list_for_each(item, &mc_devices) {
+		mci = list_entry(item, struct mem_ctl_info, link);
+
+		if (mci->edac_check != NULL)
+			mci->edac_check(mci);
+	}
+
+	local_irq_restore(flags);
+}
+
+
+/*
+ * Check MC status every poll_msec.
+ * This where the work gets done for edac.
+ *
+ * SMP safe, doesn't use NMI, and auto-rate-limits.
+ */
+static void check_mc(unsigned long dummy)
+{
+	unsigned long flags;
+
+	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+	check_mc_devices();
+
+	if (check_pci_parity) {
+		/* scan all PCI devices looking for a Parity Error on
+		 * devices and bridges
+		 */
+		local_irq_save(flags);
+		edac_pci_dev_parity_iterator();
+		local_irq_restore(flags);
+	}
+}
+
+/*
+ * EDAC thread state information
+ */
+struct bs_thread_info
+{
+	struct task_struct *task;
+	struct completion *event;
+	char *name;
+	void (*run)(unsigned long dummy);
+	long dummy;
+};
+
+static struct bs_thread_info bs_thread;
+
+/*
+ *  edac_kernel_thread
+ *      This the kernel thread that processes edac operations
+ *      in a normal thread environment
+ */
+static int edac_kernel_thread(void *arg)
+{
+	struct bs_thread_info *thread = (struct bs_thread_info *) arg;
+
+	/* detach thread */
+	daemonize(thread->name);
+
+	current->exit_signal = SIGCHLD;
+	allow_signal(SIGKILL);
+	thread->task = current;
+
+	/* indicate to starting task we have started */
+	complete(thread->event);
+
+	/* loop forever, until we are told to stop */
+	while(thread->run != NULL) {
+		void (*run)(unsigned long dummy);
+
+		/* call the function to check the memory controllers */
+		run = thread->run;
+		if(run)
+			run(thread->dummy);
+
+		if(signal_pending(current))
+			flush_signals(current);
+
+		/* ensure we are interruptable */
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		/* goto sleep for the interval */
+		schedule_timeout((HZ * poll_msec) / 1000);
+	}
+
+	/* notify waiter that we are exiting */
+	complete(thread->event);
+
+	return 0;
+}
+
+/*
+ * edac_mc_init
+ *      module initialization entry point
+ */
+int __init edac_mc_init(void)
+{
+	int ret;
+	struct completion event;
+
+	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+	printk(KERN_INFO "MC: " __FILE__ " version " EDAC_MC_VER
+	       "\n");
+
+	/* perform check for first time */
+	check_mc(0);
+
+	/* Create the /proc tree */
+	proc_mc = proc_mkdir(MC_PROC_DIR, &proc_root);
+	if (proc_mc == NULL)
+		return -ENODEV;
+
+
+#ifdef CONFIG_SYSCTL
+	/* configure the /proc/sys system control filesystem tree */
+	mc_sysctl_header = register_sysctl_table(mc_root_table, 1);
+#endif				/* CONFIG_SYSCTL */
+
+	/* Create our kernel thread */
+	init_completion(&event);
+	bs_thread.event = &event;
+	bs_thread.name = EDAC_THREAD_NAME;
+	bs_thread.run = check_mc;
+	bs_thread.dummy = 0;
+
+	/* create our kernel thread */
+	ret = kernel_thread(edac_kernel_thread, &bs_thread, CLONE_KERNEL);
+	if(ret < 0) {
+		if (proc_mc)
+			remove_proc_entry(MC_PROC_DIR, &proc_root);
+
+#ifdef CONFIG_SYSCTL
+		/* if enabled, unregister our /sys tree */
+		if (mc_sysctl_header) {
+			unregister_sysctl_table(mc_sysctl_header);
+			mc_sysctl_header = NULL;
+		}
+#endif                          /* CONFIG_SYSCTL */
+		return -ENOMEM;
+	}
+
+	/* wait for our kernel theard ack that it is up and running */
+	wait_for_completion(&event);
+
+	return 0;
+}
+
+
+/*
+ * edac_mc_exit()
+ *      module exit/termination functioni
+ */
+static void __exit edac_mc_exit(void)
+{
+	struct completion event;
+
+	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+
+	init_completion(&event);
+	bs_thread.event = &event;
+
+	/* As soon as ->run is set to NULL, the task could disappear,
+	 * so we need to hold tasklist_lock until we have sent the signal
+	 */
+	read_lock(&tasklist_lock);
+	bs_thread.run = NULL;
+	send_sig(SIGKILL, bs_thread.task, 1);
+	read_unlock(&tasklist_lock);
+	wait_for_completion(&event);
+
+	/* if enabled, unregister our /proc/mc tree */
+	if (proc_mc)
+		remove_proc_entry(MC_PROC_DIR, &proc_root);
+
+#ifdef CONFIG_SYSCTL
+	/* if enabled, unregister our /sys tree */
+	if (mc_sysctl_header) {
+		unregister_sysctl_table(mc_sysctl_header);
+		mc_sysctl_header = NULL;
+	}
+#endif				/* CONFIG_SYSCTL */
+}
+
+
+
+
+module_init(edac_mc_init);
+module_exit(edac_mc_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Linux Networx (http://lnxi.com) Thayne Harbaugh et al\n"
+	      "Based on.work by Dan Hollis et al");
+MODULE_DESCRIPTION("Core library routines for MC reporting");
+
+module_param(panic_on_ue, int, 0644);
+MODULE_PARM_DESC(panic_on_ue, "Panic on uncorrected error: 0=off 1=on");
+module_param(check_pci_parity, int, 0644);
+MODULE_PARM_DESC(check_pci_parity, "Check for PCI bus parity errors: 0=off 1=on");
+module_param(panic_on_pci_parity, int, 0644);
+MODULE_PARM_DESC(panic_on_pci_parity, "Panic on PCI Bus Parity error: 0=off 1=on");
+module_param(log_ue, int, 0644);
+MODULE_PARM_DESC(log_ue, "Log uncorrectable error to console: 0=off 1=on");
+module_param(log_ce, int, 0644);
+MODULE_PARM_DESC(log_ce, "Log correctable error to console: 0=off 1=on");
+module_param(poll_msec, int, 0644);
+MODULE_PARM_DESC(poll_msec, "Polling period in milliseconds");
+#ifdef CONFIG_EDAC_DEBUG
+module_param(edac_debug_level, int, 0644);
+MODULE_PARM_DESC(edac_debug_level, "Debug level");
+#endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/edac/edac_mc.h linux-2.6.14-rc2-mm1/drivers/edac/edac_mc.h
--- linux.vanilla-2.6.14-rc2-mm1/drivers/edac/edac_mc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc2-mm1/drivers/edac/edac_mc.h	2005-10-07 16:51:37.000000000 +0100
@@ -0,0 +1,438 @@
+/*
+ * MC kernel module
+ * (C) 2003 Linux Networx (http://lnxi.com)
+ * This file may be distributed under the terms of the
+ * GNU General Public License.
+ *
+ * Written by Thayne Harbaugh
+ * Based on work by Dan Hollis <goemon at anime dot net> and others.
+ *	http://www.anime.net/~goemon/linux-ecc/
+ *
+ * NMI handling support added by
+ *     Dave Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
+ *
+ * $Id: edac_mc.h,v 1.4.2.10 2005/10/05 00:43:44 dsp_llnl Exp $
+ *
+ */
+
+
+#ifndef _EDAC_MC_H_
+#define _EDAC_MC_H_
+
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/pci.h>
+#include <linux/time.h>
+#include <linux/nmi.h>
+#include <linux/rcupdate.h>
+#include <linux/completion.h>
+
+
+#define	EDAC_MC_VER	"MC $Revision: 1.4.2.10 $"
+#define EDAC_MC_LABEL_LEN	31
+#define MC_PROC_NAME_MAX_LEN 7
+
+#if PAGE_SHIFT < 20
+#define PAGES_TO_MiB( pages )	( ( pages ) >> ( 20 - PAGE_SHIFT ) )
+#else				/* PAGE_SHIFT > 20 */
+#define PAGES_TO_MiB( pages )	( ( pages ) << ( PAGE_SHIFT - 20 ) )
+#endif
+
+#if defined(CONFIG_EDAC_DEBUG)
+extern int edac_debug_level;
+#define edac_debug_printk(level, fmt, args...) \
+do { if (level <= edac_debug_level) printk(KERN_DEBUG fmt, ##args); } while(0)
+#define debugf0( ... ) edac_debug_printk(0, __VA_ARGS__ )
+#define debugf1( ... ) edac_debug_printk(1, __VA_ARGS__ )
+#define debugf2( ... ) edac_debug_printk(2, __VA_ARGS__ )
+#define debugf3( ... ) edac_debug_printk(3, __VA_ARGS__ )
+#else				/* !CONFIG_EDAC_DEBUG */
+#define debugf0( ... )
+#define debugf1( ... )
+#define debugf2( ... )
+#define debugf3( ... )
+#endif				/* !CONFIG_EDAC_DEBUG */
+
+
+#define bs_xstr(s) bs_str(s)
+#define bs_str(s) #s
+#define BS_MOD_STR bs_xstr(KBUILD_BASENAME)
+
+#define BIT(x) (1 << (x))
+
+#define PCI_VEND_DEV(vend, dev) PCI_VENDOR_ID_ ## vend, PCI_DEVICE_ID_ ## vend ## _ ## dev
+
+/* memory devices */
+enum dev_type {
+	DEV_UNKNOWN = 0,
+	DEV_X1,
+	DEV_X2,
+	DEV_X4,
+	DEV_X8,
+	DEV_X16,
+	DEV_X32,		/* Do these parts exist? */
+	DEV_X64			/* Do these parts exist? */
+};
+
+#define DEV_FLAG_UNKNOWN	BIT(DEV_UNKNOWN)
+#define DEV_FLAG_X1		BIT(DEV_X1)
+#define DEV_FLAG_X2		BIT(DEV_X2)
+#define DEV_FLAG_X4		BIT(DEV_X4)
+#define DEV_FLAG_X8		BIT(DEV_X8)
+#define DEV_FLAG_X16		BIT(DEV_X16)
+#define DEV_FLAG_X32		BIT(DEV_X32)
+#define DEV_FLAG_X64		BIT(DEV_X64)
+
+/* memory types */
+enum mem_type {
+	MEM_EMPTY = 0,		/* Empty csrow */
+	MEM_RESERVED,		/* Reserved csrow type */
+	MEM_UNKNOWN,		/* Unknown csrow type */
+	MEM_FPM,		/* Fast page mode */
+	MEM_EDO,		/* Extended data out */
+	MEM_BEDO,		/* Burst Extended data out */
+	MEM_SDR,		/* Single data rate SDRAM */
+	MEM_RDR,		/* Registered single data rate SDRAM */
+	MEM_DDR,		/* Double data rate SDRAM */
+	MEM_RDDR,		/* Registered Double data rate SDRAM */
+	MEM_RMBS		/* Rambus DRAM */
+};
+
+#define MEM_FLAG_EMPTY		BIT(MEM_EMPTY)
+#define MEM_FLAG_RESERVED	BIT(MEM_RESERVED)
+#define MEM_FLAG_UNKNOWN	BIT(MEM_UNKNOWN)
+#define MEM_FLAG_FPM		BIT(MEM_FPM)
+#define MEM_FLAG_EDO		BIT(MEM_EDO)
+#define MEM_FLAG_BEDO		BIT(MEM_BEDO)
+#define MEM_FLAG_SDR		BIT(MEM_SDR)
+#define MEM_FLAG_RDR		BIT(MEM_RDR)
+#define MEM_FLAG_DDR		BIT(MEM_DDR)
+#define MEM_FLAG_RDDR		BIT(MEM_RDDR)
+#define MEM_FLAG_RMBS		BIT(MEM_RMBS)
+
+
+/* chipset Error Detection and Correction capabilities and mode */
+enum edac_type {
+	EDAC_UNKNOWN = 0,	/* Unknown if ECC is available */
+	EDAC_NONE,		/* Doesnt support ECC */
+	EDAC_RESERVED,		/* Reserved ECC type */
+	EDAC_PARITY,		/* Detects parity errors */
+	EDAC_EC,		/* Error Checking - no correction */
+	EDAC_SECDED,		/* Single bit error correction, Double detection */
+	EDAC_S2ECD2ED,		/* Chipkill x2 devices - do these exist? */
+	EDAC_S4ECD4ED,		/* Chipkill x4 devices */
+	EDAC_S8ECD8ED,		/* Chipkill x8 devices */
+	EDAC_S16ECD16ED,	/* Chipkill x16 devices */
+};
+
+#define EDAC_FLAG_UNKNOWN	BIT(EDAC_UNKNOWN)
+#define EDAC_FLAG_NONE		BIT(EDAC_NONE)
+#define EDAC_FLAG_PARITY	BIT(EDAC_PARITY)
+#define EDAC_FLAG_EC		BIT(EDAC_EC)
+#define EDAC_FLAG_SECDED	BIT(EDAC_SECDED)
+#define EDAC_FLAG_S2ECD2ED	BIT(EDAC_S2ECD2ED)
+#define EDAC_FLAG_S4ECD4ED	BIT(EDAC_S4ECD4ED)
+#define EDAC_FLAG_S8ECD8ED	BIT(EDAC_S8ECD8ED)
+#define EDAC_FLAG_S16ECD16ED	BIT(EDAC_S16ECD16ED)
+
+
+/* scrubbing capabilities */
+enum scrub_type {
+	SCRUB_UNKNOWN = 0,	/* Unknown if scrubber is available */
+	SCRUB_NONE,		/* No scrubber */
+	SCRUB_SW_PROG,		/* SW progressive (sequential) scrubbing */
+	SCRUB_SW_SRC,		/* Software scrub only errors */
+	SCRUB_SW_PROG_SRC,	/* Progressive software scrub from an error */
+	SCRUB_SW_TUNABLE,	/* Software scrub frequency is tunable */
+	SCRUB_HW_PROG,		/* HW progressive (sequential) scrubbing */
+	SCRUB_HW_SRC,		/* Hardware scrub only errors */
+	SCRUB_HW_PROG_SRC,	/* Progressive hardware scrub from an error */
+	SCRUB_HW_TUNABLE	/* Hardware scrub frequency is tunable */
+};
+
+#define SCRUB_FLAG_SW_PROG	BIT(SCRUB_SW_PROG)
+#define SCRUB_FLAG_SW_SRC	BIT(SCRUB_SW_SRC_CORR)
+#define SCRUB_FLAG_SW_PROG_SRC	BIT(SCRUB_SW_PROG_SRC_CORR)
+#define SCRUB_FLAG_SW_TUN	BIT(SCRUB_SW_SCRUB_TUNABLE)
+#define SCRUB_FLAG_HW_PROG	BIT(SCRUB_HW_PROG)
+#define SCRUB_FLAG_HW_SRC	BIT(SCRUB_HW_SRC_CORR)
+#define SCRUB_FLAG_HW_PROG_SRC	BIT(SCRUB_HW_PROG_SRC_CORR)
+#define SCRUB_FLAG_HW_TUN	BIT(SCRUB_HW_TUNABLE)
+
+
+/* FIXME - should have notify capabilities: NMI, LOG, PROC, etc */
+
+/*
+ * There are several things to be aware of that aren't at all obvious:
+ *
+ *
+ * SOCKETS, SOCKET SETS, BANKS, ROWS, CHIP-SELECT ROWS, CHANNELS, etc..
+ *
+ * These are some of the many terms that are thrown about that don't always
+ * mean what people think they mean (Inconceivable!).  In the interest of
+ * creating a common ground for discussion, terms and their definitions
+ * will be established.
+ *
+ * Memory devices:	The individual chip on a memory stick.  These devices
+ *			commonly output 4 and 8 bits each.  Grouping several
+ *			of these in parallel provides 64 bits which is common
+ *			for a memory stick.
+ *
+ * Memory Stick:	A printed circuit board that agregates multiple
+ *			memory devices in parallel.  This is the atomic
+ *			memory component that is purchaseable by Joe consumer
+ *			and loaded into a memory socket.
+ *
+ * Socket:		A physical connector on the motherboard that accepts
+ *			a single memory stick.
+ *
+ * Channel:		Set of memory devices on a memory stick that must be
+ *			grouped in parallel with one or more additional
+ *			channels from other memory sticks.  This parallel
+ *			grouping of the output from multiple channels are
+ *			necessary for the smallest granularity of memory access.
+ *			Some memory controllers are capable of single channel -
+ *			which means that memory sticks can be loaded
+ *			individually.  Other memory controllers are only
+ *			capable of dual channel - which means that memory
+ *			sticks must be loaded as pairs (see "socket set").
+ *
+ * Chip-select row:	All of the memory devices that are selected together.
+ *			for a single, minimum grain of memory access.
+ *			This selects all of the parallel memory devices across
+ *			all of the parallel channels.  Common chip-select rows
+ *			for single channel are 64 bits, for dual channel 128
+ *			bits.
+ *
+ * Single-Ranked stick:	A Single-ranked stick has 1 chip-select row of memmory.
+ *			Motherboards commonly drive two chip-select pins to
+ *			a memory stick. A single-ranked stick, will occupy
+ *			only one of those rows. The other will be unused.
+ *
+ * Double-Ranked stick:	A double-ranked stick has two chip-select rows which
+ *			access different sets of memory devices.  The two
+ *			rows cannot be accessed concurrently.  
+ *
+ * Double-sided stick:	DEPRECATED TERM, see Double-Ranked stick.
+ *			A double-sided stick has two chip-select rows which
+ *			access different sets of memory devices.  The two
+ *			rows cannot be accessed concurrently.  "Double-sided"
+ *			is irrespective of the memory devices being mounted
+ *			on both sides of the memory stick.
+ *
+ * Socket set:		All of the memory sticks that are required for for
+ *			a single memory access or all of the memory sticks
+ *			spanned by a chip-select row.  A single socket set
+ *			has two chip-select rows and if double-sided sticks 
+ *			are used these will occupy those chip-select rows.
+ *
+ * Bank:		This term is avoided because it is unclear when
+ *			needing to distinguish between chip-select rows and
+ *			socket sets.
+ *
+ * Controller pages:
+ *
+ * Physical pages:
+ *
+ * Virtual pages:
+ *
+ *
+ * STRUCTURE ORGANIZATION AND CHOICES
+ *
+ * 
+ *
+ * PS - I enjoyed writing all that about as much as you enjoyed reading it.
+ */
+
+
+struct channel_info {
+	int chan_idx;		/* channel index */
+	u32 ce_count;		/* Correctable Errors for this CHANNEL */
+	char label[EDAC_MC_LABEL_LEN + 1];	/* DIMM label on motherboard */
+	struct csrow_info *csrow;	/* the parent */
+};
+
+
+struct csrow_info {
+	unsigned long first_page;	/* first page number in dimm */
+	unsigned long last_page;	/* last page number in dimm */
+	unsigned long page_mask;	/* used for interleaving - 
+					   0UL for non intlv */
+	u32 nr_pages;		/* number of pages in csrow */
+	u32 grain;		/* granularity of reported error in bytes */
+	int csrow_idx;		/* the chip-select row */
+	enum dev_type dtype;	/* memory device type */
+	u32 ue_count;		/* Uncorrectable Errors for this csrow */
+	u32 ce_count;		/* Correctable Errors for this csrow */
+	enum mem_type mtype;	/* memory csrow type */
+	enum edac_type edac_mode;	/* EDAC mode for this csrow */
+	struct mem_ctl_info *mci;	/* the parent */
+	/* FIXME the number of CHANNELs might need to become dynamic */
+	u32 nr_channels;
+	struct channel_info *channels;
+};
+
+
+struct mem_ctl_info {
+	struct list_head link;  /* for global list of mem_ctl_info structs */
+	unsigned long mtype_cap;	/* memory types supported by mc */
+	unsigned long edac_ctl_cap;	/* Mem controller EDAC capabilities */
+	unsigned long edac_cap;	/* configuration capabilities - this is
+				   closely related to edac_ctl_cap.  The
+				   difference is that the controller
+				   may be capable of s4ecd4ed which would
+				   be listed in edac_ctl_cap, but if
+				   channels aren't capable of s4ecd4ed then the
+				   edac_cap would not have that capability. */
+	unsigned long scrub_cap;	/* chipset scrub capabilities */
+	enum scrub_type scrub_mode;	/* current scrub mode */
+	/* pointer to edac checking routine */
+	void (*edac_check) (struct mem_ctl_info * mci);
+	/*
+	 * Remaps memory pages: controller pages to physical pages.
+	 * For most MC's, this will be NULL.
+	 */
+	/* FIXME - why not send the phys page to begin with? */
+	unsigned long (*ctl_page_to_phys) (struct mem_ctl_info * mci,
+					   unsigned long page);
+	int mc_idx;
+	int nr_csrows;
+	struct csrow_info *csrows;
+	/*
+	 * FIXME - what about controllers on other busses? - IDs must be
+	 * unique.  pdev pointer should be sufficiently unique, but
+	 * BUS:SLOT.FUNC numbers may not be unique.
+	 */
+	struct pci_dev *pdev;
+	const char *mod_name;
+	const char *mod_ver;
+	const char *ctl_name;
+	char proc_name[MC_PROC_NAME_MAX_LEN + 1];
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *proc_ent;
+#endif
+	void *pvt_info;
+	u32 ue_noinfo_count;	/* Uncorrectable Errors w/o info */
+	u32 ce_noinfo_count;	/* Correctable Errors w/o info */
+	u32 ue_count;		/* Total Uncorrectable Errors for this MC */
+	u32 ce_count;		/* Total Correctable Errors for this MC */
+	unsigned long start_time;	/* mci load start time (in jiffies) */
+
+	/* this stuff is for safe removal of mc devices from global list while
+	 * NMI handlers may be traversing list
+	 */
+	struct rcu_head rcu;
+	struct completion complete;
+};
+
+
+/* write all or some bits in a byte-register*/
+static inline void pci_write_bits8(struct pci_dev *pdev, int offset,
+				   u8 value, u8 mask)
+{
+	if (mask != 0xff) {
+		u8 buf;
+		pci_read_config_byte(pdev, offset, &buf);
+		value &= mask;
+		buf &= ~mask;
+		value |= buf;
+	}
+	pci_write_config_byte(pdev, offset, value);
+}
+
+
+/* write all or some bits in a word-register*/
+static inline void pci_write_bits16(struct pci_dev *pdev, int offset,
+				    u16 value, u16 mask)
+{
+	if (mask != 0xffff) {
+		u16 buf;
+		pci_read_config_word(pdev, offset, &buf);
+		value &= mask;
+		buf &= ~mask;
+		value |= buf;
+	}
+	pci_write_config_word(pdev, offset, value);
+}
+
+
+/* write all or some bits in a dword-register*/
+static inline void pci_write_bits32(struct pci_dev *pdev, int offset,
+				    u32 value, u32 mask)
+{
+	if (mask != 0xffff) {
+		u32 buf;
+		pci_read_config_dword(pdev, offset, &buf);
+		value &= mask;
+		buf &= ~mask;
+		value |= buf;
+	}
+	pci_write_config_dword(pdev, offset, value);
+}
+
+
+#if CONFIG_EDAC_DEBUG
+void edac_mc_dump_channel(struct channel_info *chan);
+void edac_mc_dump_mci(struct mem_ctl_info *mci);
+void edac_mc_dump_csrow(struct csrow_info *csrow);
+#endif				/* CONFIG_EDAC_DEBUG */
+
+extern int edac_mc_add_mc(struct mem_ctl_info *mci);
+extern int edac_mc_del_mc(struct mem_ctl_info *mci);
+
+extern int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
+					   unsigned long page);
+
+extern struct mem_ctl_info *edac_mc_find_mci_by_pdev(struct pci_dev
+							  *pdev);
+
+extern void edac_mc_scrub_block(unsigned long page,
+				     unsigned long offset, u32 size);
+
+/*
+ * The no info errors are used when error overflows are reported.
+ * There are a limited number of error logging registers that can
+ * be exausted.  When all registers are exhausted and an additional
+ * error occurs then an error overflow register records that an
+ * error occured and the type of error, but doesn't have any
+ * further information.  The ce/ue versions make for cleaner
+ * reporting logic and function interface - reduces conditional
+ * statement clutter and extra function arguments.
+ */
+extern void edac_mc_handle_ce(struct mem_ctl_info *mci,
+				   unsigned long page_frame_number,
+				   unsigned long offset_in_page,
+				   unsigned long syndrome,
+				   int row, int channel, const char *msg);
+
+extern void edac_mc_handle_ce_no_info(struct mem_ctl_info *mci,
+					   const char *msg);
+
+extern void edac_mc_handle_ue(struct mem_ctl_info *mci,
+				   unsigned long page_frame_number,
+				   unsigned long offset_in_page,
+				   int row, const char *msg);
+
+extern void edac_mc_handle_ue_no_info(struct mem_ctl_info *mci,
+					   const char *msg);
+
+/*
+ * This kmalloc's and initializes all the structures.
+ * Can't be used if all structures don't have the same lifetime.
+ */
+extern struct mem_ctl_info *edac_mc_alloc(unsigned sz_pvt,
+		unsigned nr_csrows, unsigned nr_chans);
+
+/* Free an mc previously allocated by edac_mc_alloc() */
+static inline void edac_mc_free(struct mem_ctl_info *mci)
+{
+	kfree(mci);
+}
+
+
+#endif				/* _EDAC_MC_H_ */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/edac/Kconfig linux-2.6.14-rc2-mm1/drivers/edac/Kconfig
--- linux.vanilla-2.6.14-rc2-mm1/drivers/edac/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc2-mm1/drivers/edac/Kconfig	2005-10-07 16:20:14.000000000 +0100
@@ -0,0 +1,81 @@
+#
+#	EDAC Kconfig
+#	Copyright (c) 2003 Linux Networx
+#	Licensed and distributed under the GPL
+#
+# $Id: Kconfig,v 1.4.2.7 2005/07/08 22:05:38 dsp_llnl Exp $
+#
+
+menu 'EDAC - error detection and reporting (RAS)'
+
+config EDAC
+	tristate "EDAC core system error reporting"
+	help
+	  EDAC is designed to report errors in the core system.
+	  These are low-level errors that are reported in the CPU or
+	  supporting chipset: memory errors, cache errors, PCI errors,
+	  thermal throttling, etc..  If unsure, select 'Y'.
+
+
+comment "Reporting subsystems"
+	depends on EDAC
+
+config EDAC_DEBUG
+	bool "Debugging"
+	depends on EDAC
+	help
+	  This turns on debugging information for the entire EDAC
+	  sub-system. You can insert module with "debug_level=x", current
+	  there're four debug levels (x=0,1,2,3 from low to high).
+	  Usually you should select 'N'.
+
+config EDAC_MM_EDAC
+	tristate "Main Memory EDAC (Error Detection And Correction) reporting"
+	depends on EDAC
+	help
+	  Some systems are able to detect and correct errors in main
+	  memory.  Bluesmoke can report statistics on memory error
+	  detection and correction (EDAC - or commonly referred to ECC
+	  errors).  Bluesmoke will also try to decode where these errors
+	  occurred so that a particular failing memory module can be
+	  replaced.  If unsure, select 'Y'.
+
+
+config EDAC_AMD76X
+	tristate "AMD 76x (760, 762, 768)"
+	depends on EDAC
+
+config EDAC_E7XXX
+	tristate "Intel e7xxx (e7205, e7500, e7501, e7505)"
+	depends on EDAC
+
+config EDAC_E752X
+	tristate "Intel e752x (e7520, e7525, e7320)"
+	depends on EDAC
+
+config EDAC_I82875P
+	tristate "Intel 82875p (D82875P, E7210)"
+	depends on EDAC
+
+config EDAC_I82860
+	tristate "Intel 82860"
+	depends on EDAC
+
+config EDAC_R82600
+	tristate "Radisys 82600 embedded chipset"
+	depends on EDAC
+
+choice
+	prompt "Error detecting method"
+	depends on EDAC
+	default EDAC_POLL
+
+config EDAC_POLL
+	bool "Poll for errors"
+	depends on EDAC
+	help
+	  Poll the chipset periodically to detect errors.
+
+endchoice
+
+endmenu
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/edac/Makefile linux-2.6.14-rc2-mm1/drivers/edac/Makefile
--- linux.vanilla-2.6.14-rc2-mm1/drivers/edac/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc2-mm1/drivers/edac/Makefile	2005-10-07 16:44:33.000000000 +0100
@@ -0,0 +1,18 @@
+#
+# Makefile for the Linux kernel bluesmoke drivers.
+#
+# Copyright 02 Jul 2003, Linux Networx (http://lnxi.com)
+# This file may be distributed under the terms of the
+# GNU General Public License.
+#
+# $Id: Makefile,v 1.4.2.3 2005/07/08 22:05:38 dsp_llnl Exp $
+
+
+obj-$(CONFIG_EDAC_MM_EDAC)		+= edac_mc.o
+obj-$(CONFIG_EDAC_AMD76X)		+= amd76x_edac.o 
+obj-$(CONFIG_EDAC_E7XXX)		+= e7xxx_edac.o 
+obj-$(CONFIG_EDAC_E752X)		+= e752x_edac.o 
+obj-$(CONFIG_EDAC_I82875P)		+= i82875p_edac.o 
+obj-$(CONFIG_EDAC_I82860)		+= i82860_edac.o
+obj-$(CONFIG_EDAC_R82600)		+= r82600_edac.o
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/Kconfig linux-2.6.14-rc2-mm1/drivers/Kconfig
--- linux.vanilla-2.6.14-rc2-mm1/drivers/Kconfig	2005-09-22 15:22:54.000000000 +0100
+++ linux-2.6.14-rc2-mm1/drivers/Kconfig	2005-10-07 16:19:27.000000000 +0100
@@ -70,4 +70,6 @@
 
 source "drivers/dlm/Kconfig"
 
+source "drivers/edac/Kconfig"
+
 endmenu
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/Makefile linux-2.6.14-rc2-mm1/drivers/Makefile
--- linux.vanilla-2.6.14-rc2-mm1/drivers/Makefile	2005-09-22 15:22:54.000000000 +0100
+++ linux-2.6.14-rc2-mm1/drivers/Makefile	2005-10-07 16:19:41.000000000 +0100
@@ -69,3 +69,4 @@
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_DLM)		+= dlm/
+obj-$(CONFIG_EDAC)		+= edac/

