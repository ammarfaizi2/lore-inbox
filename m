Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVGHTnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVGHTnD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVGHTlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:41:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34741 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262822AbVGHTk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:40:28 -0400
Date: Fri, 8 Jul 2005 20:38:34 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
       "goggin, edward" <egoggin@emc.com>
Subject: [PATCH] device-mapper multipath: Fix pg initialisation races
Message-ID: <20050708193834.GG12355@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Lars Marowsky-Bree <lmb@suse.de>,
	"goggin, edward" <egoggin@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent more than one priority group initialisation function from being
outstanding at once.  Otherwise the completion functions interfere with
each other.  Also, reloading the table could reference a freed pointer.
 
Only reset queue_io in pg_init_complete if another pg_init isn't required.
Skip process_queued_ios if the queue is empty so that we only trigger a
pg_init if there's I/O.

Signed-off-by: Lars Marowsky-Bree <lmb@suse.de>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

--- diff/drivers/md/dm-mpath.c	2005-07-08 20:24:55.000000000 +0100
+++ source/drivers/md/dm-mpath.c	2005-07-08 20:26:10.000000000 +0100
@@ -63,6 +63,7 @@
 	unsigned nr_priority_groups;
 	struct list_head priority_groups;
 	unsigned pg_init_required;	/* pg_init needs calling? */
+	unsigned pg_init_in_progress;	/* Only one pg_init allowed at once */
 
 	unsigned nr_valid_paths;	/* Total number of usable paths */
 	struct pgpath *current_pgpath;
@@ -308,7 +309,8 @@
 		/* Queue for the daemon to resubmit */
 		bio_list_add(&m->queued_ios, bio);
 		m->queue_size++;
-		if (m->pg_init_required || !m->queue_io)
+		if ((m->pg_init_required && !m->pg_init_in_progress) ||
+		    !m->queue_io)
 			queue_work(kmultipathd, &m->process_queued_ios);
 		pgpath = NULL;
 		r = 0;
@@ -335,7 +337,7 @@
 
 	m->saved_queue_if_no_path = m->queue_if_no_path;
 	m->queue_if_no_path = queue_if_no_path;
-	if (!m->queue_if_no_path)
+	if (!m->queue_if_no_path && m->queue_size)
 		queue_work(kmultipathd, &m->process_queued_ios);
 
 	spin_unlock_irqrestore(&m->lock, flags);
@@ -380,25 +382,31 @@
 {
 	struct multipath *m = (struct multipath *) data;
 	struct hw_handler *hwh = &m->hw_handler;
-	struct pgpath *pgpath;
-	unsigned init_required, must_queue = 0;
+	struct pgpath *pgpath = NULL;
+	unsigned init_required = 0, must_queue = 1;
 	unsigned long flags;
 
 	spin_lock_irqsave(&m->lock, flags);
 
+	if (!m->queue_size)
+		goto out;
+
 	if (!m->current_pgpath)
 		__choose_pgpath(m);
 
 	pgpath = m->current_pgpath;
 
-	if ((pgpath && m->queue_io) ||
-	    (!pgpath && m->queue_if_no_path))
-		must_queue = 1;
+	if ((pgpath && !m->queue_io) ||
+	    (!pgpath && !m->queue_if_no_path))
+		must_queue = 0;
 
-	init_required = m->pg_init_required;
-	if (init_required)
+	if (m->pg_init_required && !m->pg_init_in_progress) {
 		m->pg_init_required = 0;
+		m->pg_init_in_progress = 1;
+		init_required = 1;
+	}
 
+out:
 	spin_unlock_irqrestore(&m->lock, flags);
 
 	if (init_required)
@@ -843,7 +851,7 @@
 	pgpath->path.is_active = 1;
 
 	m->current_pgpath = NULL;
-	if (!m->nr_valid_paths++)
+	if (!m->nr_valid_paths++ && m->queue_size)
 		queue_work(kmultipathd, &m->process_queued_ios);
 
 	queue_work(kmultipathd, &m->trigger_event);
@@ -969,12 +977,13 @@
 		bypass_pg(m, pg, 1);
 
 	spin_lock_irqsave(&m->lock, flags);
-	if (!err_flags)
-		m->queue_io = 0;
-	else {
+	if (err_flags) {
 		m->current_pgpath = NULL;
 		m->current_pg = NULL;
-	}
+	} else if (!m->pg_init_required)
+		m->queue_io = 0;
+
+	m->pg_init_in_progress = 0;
 	queue_work(kmultipathd, &m->process_queued_ios);
 	spin_unlock_irqrestore(&m->lock, flags);
 }
