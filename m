Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbUCOLzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 06:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUCOLzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 06:55:16 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:27416
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S262548AbUCOLzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 06:55:10 -0500
Message-Id: <s055999d.048@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Mon, 15 Mar 2004 12:55:44 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] for error-case kernel fault in sys_swapon
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the epilogue code, 'name' was passed to putname() regardless of
whether getname() succeeded, whereas 'swap_file' was cleared to NULL and
nevertheless checked through IS_ERR(). The patch fixes the first and
streamlines the second.

Jan Beulich
Novell, Inc.

--- 2.6.3/mm/swapfile.c.0	2004-03-02 16:35:17.000000000 +0100
+++ 2.6.3/mm/swapfile.c	2004-03-15 12:46:12.597498944 +0100
@@ -1269,8 +1269,10 @@
 	swap_list_unlock();
 	name = getname(specialfile);
 	error = PTR_ERR(name);
-	if (IS_ERR(name))
+	if (IS_ERR(name)) {
+		name = NULL;
 		goto bad_swap_2;
+	}
 	swap_file = filp_open(name, O_RDWR, 0);
 	error = PTR_ERR(swap_file);
 	if (IS_ERR(swap_file)) {
@@ -1456,7 +1458,7 @@
 	destroy_swap_extents(p);
 	if (swap_map)
 		vfree(swap_map);
-	if (swap_file && !IS_ERR(swap_file))
+	if (swap_file)
 		filp_close(swap_file, NULL);
 out:
 	if (page && !IS_ERR(page)) {

