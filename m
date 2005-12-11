Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVLKSZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVLKSZh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVLKSZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:25:37 -0500
Received: from mail.gmx.de ([213.165.64.21]:12440 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750774AbVLKSY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:24:59 -0500
X-Authenticated: #20799612
Date: Sun, 11 Dec 2005 19:20:38 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 6/9] isdn4linux: Siemens Gigaset drivers - procfs interface
Message-ID: <gigaset307x.2005.12.11.001.6@hjlipp.my-fqdn.de>
References: <gigaset307x.2005.12.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.1@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.2@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.3@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.4@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.5@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2005.12.11.001.5@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch adds the procfs interface to the gigaset module.
The procfs interface provides access to status information and statistics
about the Gigaset devices. If the drivers are built with the debugging
option it also allows to change the amount of debugging output on the fly.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/proc.c |  323 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 323 insertions(+)

--- linux-2.6.14/drivers/isdn/gigaset/proc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-gig/drivers/isdn/gigaset/proc.c	2005-12-11 13:21:42.000000000 +0100
@@ -0,0 +1,323 @@
+/*
+ * Stuff used by all variants of the driver
+ *
+ * Copyright (c) 2001 by Stefan Eilers <Eilers.Stefan@epost.de>,
+ *                       Hansjoerg Lipp <hjlipp@web.de>,
+ *                       Tilman Schmidt <tilman@imap.cc>.
+ *
+ * =====================================================================
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation; either version 2 of
+ *	the License, or (at your option) any later version.
+ * =====================================================================
+ * ToDo: ...
+ * =====================================================================
+ * Version: $Id: proc.c,v 1.5.2.8 2005/11/13 23:05:19 hjlipp Exp $
+ * =====================================================================
+ */
+
+#include "gigaset.h"
+
+#if defined(CONFIG_PROC_FS)
+
+static struct proc_dir_entry *common_proc = NULL;
+
+static int proc_cidmode_callback(unsigned long data, int value)
+{
+	struct cardstate *cs = (struct cardstate *) data;
+	int retval = 0;
+
+	if (down_interruptible(&cs->sem))
+		return -ERESTARTSYS; // FIXME -EINTR?
+
+	cs->waiting = 1;
+	if (!gigaset_add_event(cs, &cs->at_state, EV_PROC_CIDMODE,
+		               NULL, value, NULL)) {
+		cs->waiting = 0;
+		retval = -ENOMEM;
+		goto exit;
+	}
+
+	dbg(DEBUG_CMD, "scheduling PROC_CIDMODE");
+	gigaset_schedule_event(cs);
+
+	wait_event(cs->waitqueue, !cs->waiting);
+
+	// retval = cs->cmd_result;
+exit:
+	up(&cs->sem);
+
+	return retval;
+}
+
+static int read_proc_info(char *buf, char **start, off_t offset,
+                          int count, int *eof, void *data)
+{
+	int len = 0;
+	int i;
+	struct cardstate *cs = data;
+
+	if (down_interruptible(&cs->sem))
+		return -ERESTARTSYS; // FIXME -EINTR?
+
+	len += scnprintf(buf+len, count-len, "Device id         : %d\n", cs->myid); //FIXME spin_lock_irqsave? is the only problem corrupted output?
+	len += scnprintf(buf+len, count-len, "Current mstate    : %d\n", atomic_read(&cs->mstate));
+	len += scnprintf(buf+len, count-len, "Current mode      : %d\n", atomic_read(&cs->mode));
+	len += scnprintf(buf+len, count-len, "DLE mode          : %d\n", cs->dle);
+	len += scnprintf(buf+len, count-len, "connected         : %d\n", atomic_read(&cs->connected));
+	for (i = 0; i < cs->channels; ++i) {
+		// -> move to bcs level
+		len += scnprintf(buf+len, count-len, "Corrupt Packages  (%d): %d\n", i, cs->bcs[i].corrupted);
+		len += scnprintf(buf+len, count-len, "Trans. Up         (%d): %d\n", i, cs->bcs[i].trans_up);
+		len += scnprintf(buf+len, count-len, "Trans. Down       (%d): %d\n", i, cs->bcs[i].trans_down);
+		len += scnprintf(buf+len, count-len, "use count         (%d): %d\n", i, cs->bcs[i].use_count);
+		len += scnprintf(buf+len, count-len, "busy              (%d): %d\n", i, cs->bcs[i].busy);
+		// at_states without channel?
+		len += scnprintf(buf+len, count-len, "Current CID       (%d): %d\n", i, cs->bcs[i].at_state.cid);
+		len += scnprintf(buf+len, count-len, "ZSAU state        (%d): %d\n", i, cs->bcs[i].at_state.int_var[VAR_ZSAU]);
+	}
+
+	*eof = 1;
+
+	up(&cs->sem);
+
+	return len;
+}
+
+static int gigaset_read_proc_atomic(char *buf, char **start, off_t offset,
+				     int count, int *eof, void *data)
+{
+	struct proc_atomic *pi = (struct proc_atomic *) data;
+	int len;
+	off_t end;
+	char numbuf[4 + 2 * sizeof(int)]; /* 0x...\n\0 */
+
+	//down(&cs->sem);
+
+	len = sprintf(numbuf, "0x%x\n", atomic_read(pi->variable));
+
+	*start = buf;
+
+	end = (off_t) count + offset;
+
+	if (end >= (off_t)len) { /* we don't have enough data */
+		*eof = 1;
+		count = ((off_t) len > offset) ?
+			(int) ((off_t) len - offset) : 0;
+	}
+
+	memcpy(buf, numbuf + offset, count);
+
+	//up(&cs->sem);
+
+	return count;
+}
+
+static int gigaset_write_proc_atomic(struct file *file, const char __user *buffer,
+                                     unsigned long count, void *data)
+{
+	struct proc_atomic *pi = (struct proc_atomic *) data;
+	int value, retval;
+	char *tempbuf;
+	unsigned long size = (count < ULONG_MAX) ? count + 1 : count;
+	long int tempval;
+
+	//down(&cs->sem);
+
+	if (!(tempbuf = kmalloc(size, GFP_KERNEL))) {
+		warn("out of memory");
+		retval = -ENOMEM;
+		goto exit;
+	}
+
+	if (copy_from_user(tempbuf, buffer, count)) {
+		warn("copy_from_user failed");
+		kfree(tempbuf);
+		retval = -EFAULT;
+		goto exit;
+	}
+
+	tempbuf[size - 1] = '\0';
+
+	if (gigaset_scan_long(tempbuf, &tempval)) {
+		warn("could not parse number!");
+		kfree(tempbuf);
+		retval = -EINVAL;
+		goto exit;
+	}
+
+	kfree(tempbuf);
+
+	if (tempval < (long) pi->min || tempval > (long) pi->max) {
+		warn("value %ld out of range (%d..%d)",
+		     tempval, pi->min, pi->max);
+		retval = -EINVAL;
+		goto exit;
+	}
+
+	value = tempval;
+
+	if (pi->write_callback) {
+		retval = pi->write_callback(pi->data, value);
+		if (retval >= 0)
+			retval = count;
+	} else {
+		atomic_set(pi->variable, value);
+		retval = count;
+		dbg(DEBUG_ANY, "Variable set to %d (0x%x)", value, value);
+	}
+
+exit:	//up(&cs->sem);
+	return retval;
+}
+
+static struct proc_atomic glob_proc_atomic[]=
+{        /* &variable, &callback, min, max, data */
+	{ &gigaset_debuglevel, NULL, 0, DEBUG_ANY, 0 },
+};
+
+void gigaset_free_cs_proc(struct cardstate *cs)
+{
+	char filename[80];
+
+	dbg(DEBUG_INIT, "removing procfs entries");
+
+	if (!cs->proc_entry)
+		return;
+
+	remove_proc_entry("info", cs->proc_entry);
+	remove_proc_entry("hwinfo", cs->proc_entry);
+	remove_proc_entry("cidmode", cs->proc_entry);
+
+	if (snprintf(filename, sizeof(filename), "%u", cs->minor_index)
+	    < sizeof(filename)) //FIXME else branch
+		remove_proc_entry(filename, cs->driver->proc_entry);
+	cs->proc_entry = NULL;
+}
+
+void gigaset_free_drv_proc(struct gigaset_driver *drv)
+{
+	dbg(DEBUG_INIT, "removing procfs entries");
+
+	if (!drv->proc_entry)
+		return;
+
+	remove_proc_entry(drv->proc_path, common_proc);
+	drv->proc_entry = NULL;
+}
+
+
+/* initialize proc fs for driver (/proc/driver/gigaset/DRIVERNAME/) */
+void gigaset_init_drv_proc(struct gigaset_driver *drv)
+{
+	dbg(DEBUG_INIT, "setting up procfs");
+
+	if (!common_proc)
+		return;
+
+	drv->proc_entry = proc_mkdir(drv->proc_path, common_proc);
+}
+
+/* initialize proc fs for minor (/proc/driver/gigaset/DRIVERNAME/MINORNUMBER/,
+ *                               /proc/driver/gigaset/DRIVERNAME/MINORNUMBER/CHANNEL/) */
+void gigaset_init_cs_proc(struct cardstate *cs)
+{
+	struct proc_dir_entry *root;
+	struct proc_dir_entry *proc_file;
+	char filename[80];
+
+	dbg(DEBUG_INIT, "setting up procfs");
+
+	if (!cs->driver->proc_entry)
+		return;
+
+	root = NULL;
+	if (snprintf(filename, sizeof(filename), "%u", cs->minor_index)
+	    < sizeof(filename))
+		root = proc_mkdir(filename, cs->driver->proc_entry);
+	if (!root)
+		return;
+	cs->proc_entry = root;
+
+	proc_file = create_proc_entry("info", /* Name of proc-file */
+				      0444,                      /* r--r--r-- */
+				      root);
+
+	if (proc_file != NULL) {
+		proc_file->owner = cs->driver->owner;
+		proc_file->data = cs;
+		proc_file->read_proc = read_proc_info;
+		proc_file->write_proc = NULL; //gigaset_write_proc;
+	}
+
+	proc_file = create_proc_entry("hwinfo", /* Name of proc-file */
+				      0444,                      /* r--r--r-- */
+				      root);
+
+	if (proc_file != NULL) {
+		proc_file->owner = cs->driver->owner;
+		proc_file->data = cs;
+		proc_file->read_proc = cs->ops->read_proc_hwinfo;
+		proc_file->write_proc = NULL; //gigaset_write_proc;
+	}
+
+	cs->proc_atomic[0].variable       = &cs->cidmode;
+	cs->proc_atomic[0].write_callback = proc_cidmode_callback;
+	cs->proc_atomic[0].min            = 0;
+	cs->proc_atomic[0].max            = 1;
+	cs->proc_atomic[0].data           = (unsigned long) cs;
+
+	proc_file = create_proc_entry("cidmode", /* Name of proc-file */
+				      0644,                      /* rw-r--r-- */
+				      root);
+
+	if (proc_file != NULL) {
+		proc_file->owner = cs->driver->owner;
+		proc_file->data = cs->proc_atomic + 0;
+		proc_file->read_proc = gigaset_read_proc_atomic;
+		proc_file->write_proc = gigaset_write_proc_atomic;
+	}
+}
+
+void gigaset_init_common_proc(void)
+{
+	struct proc_dir_entry *proc_file;
+
+	common_proc = proc_mkdir("driver/gigaset", NULL);
+	if (!common_proc)
+		return;
+
+	proc_file = create_proc_entry("debug", /* Name of proc-file */
+	                              0644,                      /* rw-r--r-- */
+	                              common_proc);
+
+	if (proc_file != NULL) {
+		proc_file->owner = THIS_MODULE;
+		proc_file->data = glob_proc_atomic + 0;
+		proc_file->read_proc = gigaset_read_proc_atomic;
+		proc_file->write_proc = gigaset_write_proc_atomic;
+	}
+}
+
+void gigaset_free_common_proc(void)
+{
+	if (!common_proc)
+		return;
+
+	remove_proc_entry("debug", common_proc);
+	remove_proc_entry("driver/gigaset", NULL);
+	common_proc = NULL;
+}
+
+#else
+
+void gigaset_free_cs_proc(struct cardstate *cs) {}
+void gigaset_init_cs_proc(struct cardstate *cs) {}
+void gigaset_free_drv_proc(struct gigaset_driver *drv) {}
+void gigaset_init_drv_proc(struct gigaset_driver *drv) {}
+
+void gigaset_init_common_proc(void) {}
+void gigaset_free_common_proc(void) {}
+
+#endif
