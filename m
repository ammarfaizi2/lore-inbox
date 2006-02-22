Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWBVQfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWBVQfA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWBVQfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:35:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65417 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751359AbWBVQe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:34:59 -0500
Date: Wed, 22 Feb 2006 16:34:38 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [PATCH 2/3] sysfs representation of stacked devices (dm) (rev.2)
Message-ID: <20060222163438.GC31641@agk.surrey.redhat.com>
Mail-Followup-To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Marowsky-Bree <lmb@suse.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>,
	Mike Anderson <andmike@us.ibm.com>
References: <43FC8C00.5020600@ce.jp.nec.com> <43FC8D92.6010006@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FC8D92.6010006@ce.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 11:13:06AM -0500, Jun'ichi Nomura wrote:
> This patch modifies dm driver to call bd_claim_by_kobject
> and bd_release_from_kobject.
> To do that, reference to the mapped_device is added in
> dm_table.
 
This patch needs splitting up so that independent changes can be 
considered separately.

c.f. The proposal from Mike Anderson (repeated below) which I prefer 
because it makes it clear that a table always belongs to exactly one md.

Exposing dm_table_set_md() suggests a table can have its owning md 
changed - it can't.

Alasdair
-- 
agk@redhat.com


 This patch adds a mapped_device member to the dm_table struct.

 Signed-off-by: Mike Anderson <andmike@us.ibm.com>

 drivers/md/dm-ioctl.c |   32 +++++++++++++++++++-------------
 drivers/md/dm-table.c |   12 +++++++++++-
 drivers/md/dm.h       |    4 +++-
 3 files changed, 33 insertions(+), 15 deletions(-)

Index: sas-2.6-patched/drivers/md/dm.h
===================================================================
--- sas-2.6-patched.orig/drivers/md/dm.h	2006-02-20 01:05:32.000000000 -0800
+++ sas-2.6-patched/drivers/md/dm.h	2006-02-20 01:42:29.000000000 -0800
@@ -99,7 +99,8 @@ int dm_suspended(struct mapped_device *m
  * Functions for manipulating a table.  Tables are also reference
  * counted.
  *---------------------------------------------------------------*/
-int dm_table_create(struct dm_table **result, int mode, unsigned num_targets);
+int dm_table_create(struct dm_table **result, int mode, unsigned
+		    num_targets, struct mapped_device *md);
 
 void dm_table_get(struct dm_table *t);
 void dm_table_put(struct dm_table *t);
@@ -123,6 +124,7 @@ void dm_table_resume_targets(struct dm_t
 int dm_table_any_congested(struct dm_table *t, int bdi_bits);
 void dm_table_unplug_all(struct dm_table *t);
 int dm_table_flush_all(struct dm_table *t);
+struct mapped_device *dm_table_get_md(struct dm_table *t);
 
 /*-----------------------------------------------------------------
  * A registry of target types.
Index: sas-2.6-patched/drivers/md/dm-table.c
===================================================================
--- sas-2.6-patched.orig/drivers/md/dm-table.c	2006-02-20 01:05:32.000000000 -0800
+++ sas-2.6-patched/drivers/md/dm-table.c	2006-02-20 01:42:29.000000000 -0800
@@ -33,6 +33,7 @@ struct dm_table {
 	unsigned int num_allocated;
 	sector_t *highs;
 	struct dm_target *targets;
+	struct mapped_device *md;
 
 	/*
 	 * Indicates the rw permissions for the new logical
@@ -204,7 +205,8 @@ static int alloc_targets(struct dm_table
 	return 0;
 }
 
-int dm_table_create(struct dm_table **result, int mode, unsigned num_targets)
+int dm_table_create(struct dm_table **result, int mode,
+		    unsigned num_targets, struct mapped_device *md)
 {
 	struct dm_table *t = kmalloc(sizeof(*t), GFP_KERNEL);
 
@@ -227,6 +229,7 @@ int dm_table_create(struct dm_table **re
 	}
 
 	t->mode = mode;
+	t->md = md;
 	*result = t;
 	return 0;
 }
@@ -945,6 +948,12 @@ int dm_table_flush_all(struct dm_table *
 	return ret;
 }
 
+struct mapped_device *dm_table_get_md(struct dm_table *t)
+{
+	dm_get(t->md);
+	return t->md;
+}
+
 EXPORT_SYMBOL(dm_vcalloc);
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);
@@ -955,3 +964,4 @@ EXPORT_SYMBOL(dm_table_put);
 EXPORT_SYMBOL(dm_table_get);
 EXPORT_SYMBOL(dm_table_unplug_all);
 EXPORT_SYMBOL(dm_table_flush_all);
+EXPORT_SYMBOL(dm_table_get_md);
Index: sas-2.6-patched/drivers/md/dm-ioctl.c
===================================================================
--- sas-2.6-patched.orig/drivers/md/dm-ioctl.c	2006-02-20 01:05:32.000000000 -0800
+++ sas-2.6-patched/drivers/md/dm-ioctl.c	2006-02-20 01:42:29.000000000 -0800
@@ -972,27 +972,26 @@ static int populate_table(struct dm_tabl
 
 static int table_load(struct dm_ioctl *param, size_t param_size)
 {
-	int r;
+	int r = -ENXIO;
 	struct hash_cell *hc;
 	struct dm_table *t;
 
-	r = dm_table_create(&t, get_mode(param), param->target_count);
-	if (r)
-		return r;
-
-	r = populate_table(t, param, param_size);
-	if (r) {
-		dm_table_put(t);
-		return r;
-	}
 
 	down_write(&_hash_lock);
 	hc = __find_device_hash_cell(param);
 	if (!hc) {
 		DMWARN("device doesn't appear to be in the dev hash table.");
-		up_write(&_hash_lock);
-		dm_table_put(t);
-		return -ENXIO;
+		goto out;
+	}
+
+	r = dm_table_create(&t, get_mode(param), param->target_count,
+			    hc->md);
+	if (r)
+		goto out;
+
+	r = populate_table(t, param, param_size);
+	if (r) {
+		goto table_out;
 	}
 
 	if (hc->new_map)
@@ -1001,6 +1000,13 @@ static int table_load(struct dm_ioctl *p
 	param->flags |= DM_INACTIVE_PRESENT_FLAG;
 
 	r = __dev_status(hc->md, param);
+
+	up_write(&_hash_lock);
+	return r;
+
+table_out:
+	dm_table_put(t);
+out:
 	up_write(&_hash_lock);
 	return r;
 }
