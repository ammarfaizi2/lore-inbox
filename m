Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267789AbTAHJrk>; Wed, 8 Jan 2003 04:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267790AbTAHJrk>; Wed, 8 Jan 2003 04:47:40 -0500
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:3849 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267789AbTAHJre>; Wed, 8 Jan 2003 04:47:34 -0500
Date: Wed, 8 Jan 2003 09:55:44 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/10] dm: Correct target_type reference counting
Message-ID: <20030108095544.GD2063@reti>
References: <20030108095221.GA2063@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108095221.GA2063@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ti->use was only getting incremented the first time a target type was
retrieved (bug introduced by recent hch patch).
--- diff/drivers/md/dm-target.c	2003-01-02 10:43:06.000000000 +0000
+++ source/drivers/md/dm-target.c	2003-01-02 11:16:16.000000000 +0000
@@ -43,15 +43,16 @@
 	struct tt_internal *ti;
 
 	read_lock(&_lock);
+
 	ti = __find_target_type(name);
-	if (ti && ti->use == 0) {
-		if (try_module_get(ti->tt.module))
-			ti->use++;
-		else
+	if (ti) {
+		if ((ti->use == 0) && !try_module_get(ti->tt.module))
 			ti = NULL;
+		else
+			ti->use++;
 	}
-	read_unlock(&_lock);
 
+	read_unlock(&_lock);
 	return ti;
 }
 
