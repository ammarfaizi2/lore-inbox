Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbTGBKtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 06:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTGBKtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 06:49:13 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:27401 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264944AbTGBKrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 06:47:00 -0400
Date: Wed, 2 Jul 2003 12:00:44 +0100
From: Joe Thornber <thornber@sistina.com>
To: dm-devel@sistina.com
Cc: Kevin Corry <kevcorry@us.ibm.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] Re: [RFC 3/3] dm: v4 ioctl interface
Message-ID: <20030702110044.GE6243@fib011235813.fsnet.co.uk>
References: <20030701145812.GA1596@fib011235813.fsnet.co.uk> <20030701150246.GD1596@fib011235813.fsnet.co.uk> <200307011505.07184.kevcorry@us.ibm.com> <20030702085951.GB410@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702085951.GB410@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm_swap_table() will now fail for a table with no targets.
--- diff/drivers/md/dm.c	2003-07-01 15:36:42.000000000 +0100
+++ source/drivers/md/dm.c	2003-07-02 11:53:22.000000000 +0100
@@ -664,10 +664,10 @@
 	md->map = t;
 
 	size = dm_table_get_size(t);
-	set_capacity(md->disk, size);
-	if (size == 0)
-		return 0;
+	if (!size)
+		return -EINVAL;
 
+	set_capacity(md->disk, size);
 	dm_table_event_callback(md->map, event_callback, md);
 
 	dm_table_get(t);
@@ -759,8 +759,10 @@
 
 	__unbind(md);
 	r = __bind(md, table);
-	if (r)
+	if (r) {
+		up_write(&md->lock);
 		return r;
+	}
 
 	up_write(&md->lock);
 	return 0;
