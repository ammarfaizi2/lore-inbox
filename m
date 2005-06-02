Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVFBH7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVFBH7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVFBH6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:58:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56262 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261165AbVFBH6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:58:13 -0400
Date: Thu, 2 Jun 2005 16:02:30 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/9] dlm: don't add duplicate node addresses
Message-ID: <20050602080230.GB21570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="no-duplicate-addrs.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If an address has already been set for a node, don't add it again.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/lowcomms.c
===================================================================
--- linux.orig/drivers/dlm/lowcomms.c	2005-06-02 12:28:30.000000000 +0800
+++ linux/drivers/dlm/lowcomms.c	2005-06-02 12:52:51.391577056 +0800
@@ -272,6 +272,7 @@
 int dlm_set_local(int nodeid, int weight, char *addr_buf)
 {
 	struct sockaddr_storage *addr;
+	int i;
 
 	if (local_count > DLM_MAX_ADDR_COUNT - 1) {
 		log_print("too many local addresses set %d", local_count);
@@ -284,7 +285,15 @@
 	if (!addr)
 		return -ENOMEM;
 	memcpy(addr, addr_buf, sizeof(*addr));
+
+	for (i = 0; i < local_count; i++) {
+		if (!memcmp(local_addr[i], addr, sizeof(*addr))) {
+			kfree(addr);
+			goto out;
+		}
+	}
 	local_addr[local_count++] = addr;
+ out:
 	return 0;
 }
 

--

