Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVKROvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVKROvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 09:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVKROvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 09:51:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50579 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750742AbVKROvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 09:51:02 -0500
Date: Fri, 18 Nov 2005 14:50:53 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: list_versions fix
Message-ID: <20051118145053.GH11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In some circumstances the LIST_VERSIONS output is truncated
because the size calculation forgets about a 'uint32_t' in each
structure - but the inclusion of the whole of ALIGN_MASK frequently 
compensates for the omission.

This is a quick workaround to use an upper bound.  (The code ought
to be fixed to supply the actual size.)

Running 'dmsetup targets' may demonstrate the problem: when I run it,
the last line comes out as 'erro' instead of 'error'.
Consequently, 'lvcreate --type error' doesn't work.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14-rc2/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/md/dm-ioctl.c	2005-10-26 20:22:59.000000000 +0100
+++ linux-2.6.14-rc2/drivers/md/dm-ioctl.c	2005-11-03 21:54:07.000000000 +0000
@@ -425,8 +425,8 @@ static void list_version_get_needed(stru
 {
     size_t *needed = needed_param;
 
+    *needed += sizeof(struct dm_target_versions);
     *needed += strlen(tt->name);
-    *needed += sizeof(tt->version);
     *needed += ALIGN_MASK;
 }
 
