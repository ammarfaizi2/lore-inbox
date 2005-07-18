Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVGRPzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVGRPzw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 11:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVGRPzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 11:55:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36292 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261529AbVGRPzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 11:55:50 -0400
Date: Mon, 18 Jul 2005 15:49:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2 and as-iosched
Message-ID: <20050718134933.GA1890@suse.de>
References: <403f93.f22097@family-bbs.org> <20050718115929.GE2403@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050718115929.GE2403@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18 2005, Jens Axboe wrote:
> On Mon, Jul 18 2005, Kenneth Parrish wrote:
> > Randy> Need more info.
> > 
> >         Greetings.  :)
> > CONFIG_HZ_ changes the block device elevator time-out values -- didn't see.
> 
> I cannot reproduce here with cfq and HZ == 250, the jiffies <-> msec
> conversions are working fine. Please provide a proper bug report, did
> you change the values and not getting the expected back, or what is
> going wrong??

ok, AS is definitely broken, it does an internal HZ <-> msec conversion
in the store/show functions as well. This should fix it.

--- /opt/kernel/linux-2.6.13-rc3/drivers/block/as-iosched.c	2005-07-13 06:46:46.000000000 +0200
+++ linux-2.6.13-rc3/drivers/block/as-iosched.c	2005-07-18 15:46:23.000000000 +0200
@@ -1935,23 +1935,15 @@
 static ssize_t
 as_var_show(unsigned int var, char *page)
 {
-	var = (var * 1000) / HZ;
 	return sprintf(page, "%d\n", var);
 }
 
 static ssize_t
 as_var_store(unsigned long *var, const char *page, size_t count)
 {
-	unsigned long tmp;
 	char *p = (char *) page;
 
-	tmp = simple_strtoul(p, &p, 10);
-	if (tmp != 0) {
-		tmp = (tmp * HZ) / 1000;
-		if (tmp == 0)
-			tmp = 1;
-	}
-	*var = tmp;
+	*var = simple_strtoul(p, &p, 10);
 	return count;
 }
 

-- 
Jens Axboe

