Return-Path: <linux-kernel-owner+w=401wt.eu-S932156AbXASQZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbXASQZ6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 11:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbXASQZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 11:25:58 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:18554 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932156AbXASQZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 11:25:57 -0500
Date: Fri, 19 Jan 2007 19:30:30 +0300
From: Alexey Dobriyan <adobriyan@openvz.org>
To: akpm@osdl.org
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH] Don't map random pages if swapoff errors
Message-ID: <20070119163030.GA12507@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>

If read failed we cannot map not-uptodate page to user space.
Actually, we are in serious troubles, we do not even know what
process to kill. So, the only variant remains: to stop swapoff()
and allow someone to kill processes to zap invalid pages.

Signed-off-by: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
---

 mm/swapfile.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -766,6 +766,19 @@ static int try_to_unuse(unsigned int typ
 		lock_page(page);
 		wait_on_page_writeback(page);
 
+		/* If read failed we cannot map not-uptodate page to
+		 * user space. Actually, we are in serious troubles,
+		 * we do not even know what process to kill. So, the only
+		 * variant remains: to stop swapoff() and allow someone
+		 * to kill processes to zap invalid pages.
+		 */
+		if (unlikely(!PageUptodate(page))) {
+			unlock_page(page);
+			page_cache_release(page);
+			retval = -EIO;
+			break;
+		}
+
 		/*
 		 * Remove all references to entry.
 		 * Whenever we reach init_mm, there's no address space

