Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUFCG2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUFCG2C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUFCG2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:28:02 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:34176 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S261162AbUFCG1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:27:44 -0400
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ak@suse.de, Greg KH <greg@kroah.com>
In-Reply-To: <20040602212547.448c7cc7.pj@sgi.com>
References: <20040602161115.1340f698.pj@sgi.com>
	 <1086222156.29391.337.camel@bach>  <20040602212547.448c7cc7.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1086243997.29390.527.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 03 Jun 2004 16:26:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-03 at 14:25, Paul Jackson wrote:
> Rusty wrote:
> > Then just use -1UL as the arg to scnprintf, if you don't have a real
> > number.  That way the overflow will at least have a chance of detection
> > in the sysfs code, which I think it should check in
> > file.c:fill_read_buffer().  Greg?
> 
> That doesn't make sense.

Then I apologize.

Please allow me to demonstrate with code, which should be clearer.

Name: Fix sysfs Node Cpumap for Large NR_CPUS
Status: Booted on 2.6.7-rc2-bk3
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

As pointed out by Paul Jackson, sometimes 99 chars is not enough.  We
currently get a page from sysfs: that code should check we don't
haven't overrun it, and for futureproofing, detect problem at
buildtime.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9869-linux-2.6.7-rc2-bk3/drivers/base/node.c .9869-linux-2.6.7-rc2-bk3.updated/drivers/base/node.c
--- .9869-linux-2.6.7-rc2-bk3/drivers/base/node.c	2004-05-31 09:57:07.000000000 +1000
+++ .9869-linux-2.6.7-rc2-bk3.updated/drivers/base/node.c	2004-06-03 16:18:44.000000000 +1000
@@ -21,9 +21,10 @@ static ssize_t node_read_cpumap(struct s
 	cpumask_t mask = node_dev->cpumap;
 	int len;
 
-	/* FIXME - someone should pass us a buffer size (count) or
-	 * use seq_file or something to avoid buffer overrun risk. */
-	len = cpumask_scnprintf(buf, 99 /* XXX FIXME */, mask);
+	/* 2004/06/03: buf currently PAGE_SIZE, need > 1 char per 4 bits. */
+	BUILD_BUG_ON(NR_CPUS/4 > PAGE_SIZE/2);
+
+	len = cpumask_scnprintf(buf, -1UL, mask);
 	len += sprintf(buf + len, "\n");
 	return len;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9869-linux-2.6.7-rc2-bk3/fs/sysfs/file.c .9869-linux-2.6.7-rc2-bk3.updated/fs/sysfs/file.c
--- .9869-linux-2.6.7-rc2-bk3/fs/sysfs/file.c	2004-05-31 09:57:31.000000000 +1000
+++ .9869-linux-2.6.7-rc2-bk3.updated/fs/sysfs/file.c	2004-06-03 16:19:39.000000000 +1000
@@ -89,6 +90,7 @@ static int fill_read_buffer(struct file 
 		return -ENOMEM;
 
 	count = ops->show(kobj,attr,buffer->page);
+	BUG_ON(count > PAGE_SIZE);
 	if (count >= 0)
 		buffer->count = count;
 	else

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

