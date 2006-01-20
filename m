Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422700AbWATAFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbWATAFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422701AbWATAFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:05:45 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:43698 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1422700AbWATAFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:05:44 -0500
Date: Thu, 19 Jan 2006 16:05:27 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] shrink_list: Use of && instead || leads to unintended writing
 of pages 
Message-ID: <Pine.LNX.4.62.0601191602260.13428@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The check for laptop mode and sc->may_writepage is intended to not write
pages if either laptop mode is set or we are not allowed to write.

The && there means that currently pages may be written in laptop mode and during
zone_reclaim. This patch also applies to 2.6.15 and 2.6.14!

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc1-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.16-rc1-mm1.orig/mm/vmscan.c	2006-01-19 15:40:28.000000000 -0800
+++ linux-2.6.16-rc1-mm1/mm/vmscan.c	2006-01-19 15:40:30.000000000 -0800
@@ -491,7 +491,7 @@ static int shrink_list(struct list_head 
 				goto keep_locked;
 			if (!may_enter_fs)
 				goto keep_locked;
-			if (laptop_mode && !sc->may_writepage)
+			if (laptop_mode || !sc->may_writepage)
 				goto keep_locked;
 
 			/* Page is dirty, try to write it out here */

