Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTHYOAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 10:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbTHYOAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 10:00:53 -0400
Received: from 66-65-113-21.nyc.rr.com ([66.65.113.21]:25798 "EHLO
	siri.morinfr.org") by vger.kernel.org with ESMTP id S261921AbTHYOAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 10:00:51 -0400
Date: Mon, 25 Aug 2003 10:00:00 -0400
From: Guillaume Morin <guillaume@morinfr.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH resend #1] fix cu3088 group write
Message-ID: <20030825140000.GB883@siri.morinfr.org>
Mail-Followup-To: torvalds@osdl.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030819163257.GA3316@siri.morinfr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819163257.GA3316@siri.morinfr.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew
 
The current cu3088 ccwgroup write code overwrite the last char of the
given arguments. This following patch fixes the problem. It is been
tested and applies on latest bk.

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
