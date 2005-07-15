Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263282AbVGOKeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbVGOKeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbVGOKcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:32:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8594 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261810AbVGOKaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:30:00 -0400
Date: Fri, 15 Jul 2005 18:34:26 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 01/12] dlm: fix lowcomms race
Message-ID: <20050715103426.GD17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-lowcomms-race.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix potential race in lowcomms.

Signed-off-by: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux-2.6.12-mm1/drivers/dlm/lowcomms.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/lowcomms.c
+++ linux-2.6.12-mm1/drivers/dlm/lowcomms.c
@@ -1101,8 +1101,8 @@ static void process_output_queue(void)
 	list_for_each_safe(list, temp, &write_nodes) {
 		struct nodeinfo *ni =
 		    list_entry(list, struct nodeinfo, write_list);
-		list_del(&ni->write_list);
 		clear_bit(NI_WRITE_PENDING, &ni->flags);
+		list_del(&ni->write_list);
 
 		spin_unlock_bh(&write_nodes_lock);
 
@@ -1271,11 +1271,7 @@ static int daemons_start(void)
 
 /*
  * This is quite likely to sleep...
- * Temporarily initialise the waitq head so that lowcomms_send_message
- * doesn't crash if it gets called before the thread is fully
- * initialised
  */
-
 int dlm_lowcomms_start(void)
 {
 	int error;

--
