Return-Path: <linux-kernel-owner+w=401wt.eu-S932976AbWLSWQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932976AbWLSWQF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933045AbWLSWQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:16:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45588 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933049AbWLSWQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:16:01 -0500
Date: Tue, 19 Dec 2006 17:15:41 -0500 (EST)
Message-Id: <20061219.171541.102766013.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, agk@redhat.com, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com
Cc: j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH APPENDIX] rqbased-dm: add API to libdevmapper
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the feature to use the kernel request-based dm feature
to the device-mapper user-space tool.

For dmsetup:
    # dmsetup --rqbase create <device name>

For library users:
    int dm_task_request_base(struct dm_task *dmt);

This patch is for device-mapper-1.02.13.


diff -rupN dm-1.02.13/dmsetup/dmsetup.c dm-1.02.13.rqbase/dmsetup/dmsetup.c
--- dm-1.02.13/dmsetup/dmsetup.c	2006-10-19 11:34:50.000000000 -0400
+++ dm-1.02.13.rqbase/dmsetup/dmsetup.c	2006-12-12 16:39:35.000000000 -0500
@@ -114,6 +114,7 @@ enum {
 	NOOPENCOUNT_ARG,
 	NOTABLE_ARG,
 	OPTIONS_ARG,
+	RQBASE_ARG,
 	SHOWKEYS_ARG,
 	TABLE_ARG,
 	TARGET_ARG,
@@ -458,6 +459,9 @@ static int _create(int argc, char **argv
 	if (_switches[NOOPENCOUNT_ARG] && !dm_task_no_open_count(dmt))
 		goto out;
 
+	if (_switches[RQBASE_ARG] && !dm_task_request_base(dmt))
+		goto out;
+
 	if (!dm_task_run(dmt))
 		goto out;
 
@@ -1522,7 +1526,7 @@ struct command {
 static struct command _commands[] = {
 	{"create", "<dev_name> [-j|--major <major> -m|--minor <minor>]\n"
 	  "\t                  [-U|--uid <uid>] [-G|--gid <gid>] [-M|--mode <octal_mode>]\n"
-	  "\t                  [-u|uuid <uuid>]\n"
+	  "\t                  [-u|uuid <uuid>] [--rqbase]\n"
 	  "\t                  [--notable | --table <table> | <table_file>]",
 	 1, 2, _create},
 	{"remove", "[-f|--force] <device>", 0, 1, _remove},
@@ -1884,6 +1888,7 @@ static int _process_switches(int *argc, 
 		{"noopencount", 0, &ind, NOOPENCOUNT_ARG},
 		{"notable", 0, &ind, NOTABLE_ARG},
 		{"options", 1, &ind, OPTIONS_ARG},
+		{"rqbase", 0, &ind, RQBASE_ARG},
 		{"showkeys", 0, &ind, SHOWKEYS_ARG},
 		{"table", 1, &ind, TABLE_ARG},
 		{"target", 1, &ind, TARGET_ARG},
@@ -2005,6 +2010,8 @@ static int _process_switches(int *argc, 
 			_switches[NOLOCKFS_ARG]++;
 		if ((ind == NOOPENCOUNT_ARG))
 			_switches[NOOPENCOUNT_ARG]++;
+		if ((ind == RQBASE_ARG))
+			_switches[RQBASE_ARG]++;
 		if ((ind == SHOWKEYS_ARG))
 			_switches[SHOWKEYS_ARG]++;
 		if ((ind == TABLE_ARG)) {
diff -rupN dm-1.02.13/kernel/ioctl/dm-ioctl.h dm-1.02.13.rqbase/kernel/ioctl/dm-ioctl.h
--- dm-1.02.13/kernel/ioctl/dm-ioctl.h	2006-10-12 11:42:24.000000000 -0400
+++ dm-1.02.13.rqbase/kernel/ioctl/dm-ioctl.h	2006-12-12 16:42:18.000000000 -0500
@@ -330,4 +330,9 @@ typedef char ioctl_struct[308];
  */
 #define DM_NOFLUSH_FLAG		(1 << 11) /* In */
 
+/*
+ * Set this to create request based device-mapper device.
+ */
+#define DM_REQUEST_BASE_FLAG	(1 << 12) /* In */
+
 #endif				/* _LINUX_DM_IOCTL_H */
diff -rupN dm-1.02.13/lib/.exported_symbols dm-1.02.13.rqbase/lib/.exported_symbols
--- dm-1.02.13/lib/.exported_symbols	2006-10-12 11:42:24.000000000 -0400
+++ dm-1.02.13.rqbase/lib/.exported_symbols	2006-12-12 16:43:18.000000000 -0500
@@ -30,6 +30,7 @@ dm_task_suppress_identical_reload
 dm_task_add_target
 dm_task_no_flush
 dm_task_no_open_count
+dm_task_request_base
 dm_task_skip_lockfs
 dm_task_update_nodes
 dm_task_run
diff -rupN dm-1.02.13/lib/ioctl/libdm-iface.c dm-1.02.13.rqbase/lib/ioctl/libdm-iface.c
--- dm-1.02.13/lib/ioctl/libdm-iface.c	2006-10-12 13:29:05.000000000 -0400
+++ dm-1.02.13.rqbase/lib/ioctl/libdm-iface.c	2006-12-12 17:02:43.000000000 -0500
@@ -1040,6 +1040,13 @@ int dm_task_no_open_count(struct dm_task
 	return 1;
 }
 
+int dm_task_request_base(struct dm_task *dmt)
+{
+	dmt->request_base = 1;
+
+	return 1;
+}
+
 int dm_task_skip_lockfs(struct dm_task *dmt)
 {
 	dmt->skip_lockfs = 1;
@@ -1283,6 +1290,8 @@ static struct dm_ioctl *_flatten(struct 
 		dmi->flags |= DM_READONLY_FLAG;
 	if (dmt->skip_lockfs)
 		dmi->flags |= DM_SKIP_LOCKFS_FLAG;
+	if (dmt->request_base)
+		dmi->flags |= DM_REQUEST_BASE_FLAG;
 
 	dmi->target_count = count;
 	dmi->event_nr = dmt->event_nr;
@@ -1415,6 +1424,7 @@ static int _create_and_load_v4(struct dm
 	task->uid = dmt->uid;
 	task->gid = dmt->gid;
 	task->mode = dmt->mode;
+	task->request_base = dmt->request_base;
 
 	r = dm_task_run(task);
 	dm_task_destroy(task);
@@ -1552,7 +1562,7 @@ static struct dm_ioctl *_do_dm_ioctl(str
 		dmi->flags |= DM_SKIP_BDGET_FLAG;
 
 	log_debug("dm %s %s %s%s%s %s%.0d%s%.0d%s"
-		  "%s%c%c%s %.0llu %s [%u]",
+		  "%s%c%c%c%s %.0llu %s [%u]",
 		  _cmd_data_v4[dmt->type].name,
 		  dmi->name, dmi->uuid, dmt->newname ? " " : "",
 		  dmt->newname ? dmt->newname : "",
@@ -1564,6 +1574,7 @@ static struct dm_ioctl *_do_dm_ioctl(str
 		  dmt->major > 0 ? ") " : "",
 		  dmt->no_open_count ? 'N' : 'O',
 		  dmt->no_flush ? 'N' : 'F',
+		  dmt->request_base ? 'R' : 'B',
 		  dmt->skip_lockfs ? "S " : "",
 		  dmt->sector, dmt->message ? dmt->message : "",
 		  dmi->data_size);
diff -rupN dm-1.02.13/lib/ioctl/libdm-targets.h dm-1.02.13.rqbase/lib/ioctl/libdm-targets.h
--- dm-1.02.13/lib/ioctl/libdm-targets.h	2006-10-12 13:29:05.000000000 -0400
+++ dm-1.02.13.rqbase/lib/ioctl/libdm-targets.h	2006-12-12 16:59:28.000000000 -0500
@@ -54,6 +54,7 @@ struct dm_task {
 	uint64_t sector;
 	int no_flush;
 	int no_open_count;
+	int request_base;
 	int skip_lockfs;
 	int suppress_identical_reload;
 
diff -rupN dm-1.02.13/lib/libdevmapper.h dm-1.02.13.rqbase/lib/libdevmapper.h
--- dm-1.02.13/lib/libdevmapper.h	2006-10-12 11:42:24.000000000 -0400
+++ dm-1.02.13.rqbase/lib/libdevmapper.h	2006-12-12 17:00:04.000000000 -0500
@@ -153,6 +153,7 @@ int dm_task_set_message(struct dm_task *
 int dm_task_set_sector(struct dm_task *dmt, uint64_t sector);
 int dm_task_no_flush(struct dm_task *dmt);
 int dm_task_no_open_count(struct dm_task *dmt);
+int dm_task_request_base(struct dm_task *dmt);
 int dm_task_skip_lockfs(struct dm_task *dmt);
 int dm_task_suppress_identical_reload(struct dm_task *dmt);
 

