Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVCAQxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVCAQxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 11:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVCAQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 11:53:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64201 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261971AbVCAQxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 11:53:17 -0500
Date: Tue, 1 Mar 2005 16:46:05 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "goggin, edward" <egoggin@emc.com>
Subject: [PATCH] device-mapper: multipath: avoid infinite suspend requeueing
Message-ID: <20050301164605.GN10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	"goggin, edward" <egoggin@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't requeue I/O repeatedly if there are no paths left and the device
is in the process of being suspended, or else the suspend can never complete.

Reported-By: "goggin, edward" <egoggin@emc.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-mpath.c	2005-03-01 16:20:56.000000000 +0000
+++ source/drivers/md/dm-mpath.c	2005-03-01 16:20:50.000000000 +0000
@@ -986,7 +986,7 @@
 
 	spin_lock(&m->lock);
 	if (!m->nr_valid_paths) {
-		if (!m->queue_if_no_path) {
+		if (!m->queue_if_no_path || m->suspended) {
 			spin_unlock(&m->lock);
 			return -EIO;
 		} else {
