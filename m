Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267783AbTAHJqC>; Wed, 8 Jan 2003 04:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267785AbTAHJqC>; Wed, 8 Jan 2003 04:46:02 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:20240 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267783AbTAHJqA>; Wed, 8 Jan 2003 04:46:00 -0500
Date: Wed, 8 Jan 2003 09:54:10 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/10] dm: Don't let the ioctl interface drop a suspended device
Message-ID: <20030108095410.GB2063@reti>
References: <20030108095221.GA2063@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108095221.GA2063@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't let the ioctl interface drop a suspended device.
--- diff/drivers/md/dm-ioctl.c	2002-12-30 10:17:13.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2003-01-02 11:10:14.000000000 +0000
@@ -812,6 +812,24 @@
 		return -EINVAL;
 	}
 
+	/*
+	 * You may ask the interface to drop its reference to an
+	 * in use device.  This is no different to unlinking a
+	 * file that someone still has open.  The device will not
+	 * actually be destroyed until the last opener closes it.
+	 * The name and uuid of the device (both are interface
+	 * properties) will be available for reuse immediately.
+	 *
+	 * You don't want to drop a _suspended_ device from the
+	 * interface, since that will leave you with no way of
+	 * resuming it.
+	 */
+	if (dm_suspended(hc->md)) {
+		DMWARN("refusing to remove a suspended device.");
+		up_write(&_hash_lock);
+		return -EPERM;
+	}
+
 	__hash_remove(hc);
 	up_write(&_hash_lock);
 	return 0;
