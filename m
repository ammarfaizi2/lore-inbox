Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270984AbTHSRBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270730AbTHSRBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:01:39 -0400
Received: from 66-65-113-21.nyc.rr.com ([66.65.113.21]:57526 "EHLO
	siri.morinfr.org") by vger.kernel.org with ESMTP id S272367AbTHSQdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:33:37 -0400
Date: Tue, 19 Aug 2003 12:32:59 -0400
From: Guillaume Morin <guillaume@morinfr.org>
To: torvalds@osdl.org
Cc: arndb@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fix cu3088 group write
Message-ID: <20030819163257.GA3316@siri.morinfr.org>
Mail-Followup-To: torvalds@osdl.org, arndb@de.ibm.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The current cu3088 ccwgroup write code overwrite the last char of the
given arguments. This patch fixes the problem :

--- linux-2.6.0-test3-bk6.orig/drivers/s390/net/cu3088.c	2003-08-19 16:19:32.000000000 +0000
+++ linux-2.6.0-test3-bk6/drivers/s390/net/cu3088.c	2003-08-19 16:22:46.000000000 +0000
@@ -64,7 +64,7 @@
 group_write(struct device_driver *drv, const char *buf, size_t count)
 {
 	const char *start, *end;
-	char bus_ids[2][BUS_ID_SIZE], *argv[2];
+	char bus_ids[2][BUS_ID_SIZE+1], *argv[2];
 	int i;
 	int ret;
 	struct ccwgroup_driver *cdrv;
@@ -79,7 +79,7 @@
 
 		if (!(end = strchr(start, delim[i])))
 			return count;
-		len = min_t(ptrdiff_t, BUS_ID_SIZE, end - start);
+		len = min_t(ptrdiff_t, BUS_ID_SIZE, end - start)+1;
 		strlcpy (bus_ids[i], start, len);
 		argv[i] = bus_ids[i];
 		start = end + 1;


memcpy is not an option since the string will be used with strncmp with
a length > BUS_ID_SIZE.

Please apply.

-- 
Guillaume Morin <guillaume@morinfr.org>

     Build a man a fire, and he'll be warm for a day.  Set a man on fire,
         and he'll be warm for the rest of his life. (Terry Pratchett)
