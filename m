Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265272AbSIWJps>; Mon, 23 Sep 2002 05:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265273AbSIWJps>; Mon, 23 Sep 2002 05:45:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:65441 "EHLO
	e33.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S265272AbSIWJpr>; Mon, 23 Sep 2002 05:45:47 -0400
Date: Mon, 23 Sep 2002 15:26:32 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm2 [PATCH] (dcache)
Message-ID: <20020923152632.C29900@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3D8E96AA.C2FA7D8@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8E96AA.C2FA7D8@digeo.com>; from akpm@digeo.com on Mon, Sep 23, 2002 at 04:22:28AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 04:22:28AM +0000, Andrew Morton wrote:
> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.38/2.5.38-mm2/
> 
> read_barrier_depends.patch
>   extended barrier primitives
> 
> rcu_ltimer.patch
>   RCU core
> 
> dcache_rcu.patch
>   Use RCU for dcache
> 

Hi Andrew,

dcache_rcu orders writes using wmb() (list_del_rcu) while deleting from
the hash list and the d_lookup() hash list traversal requires an rmb() for 
alpha. So, we need to use the read_barrier_depends() interface there. 
This isn't a problem with any other archs AFAIK.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


--- fs/dcache.c	Mon Sep 23 11:47:26 2002
+++ /tmp/dcache.c	Mon Sep 23 12:54:33 2002
@@ -870,7 +870,9 @@
 	rcu_read_lock();
 	tmp = head->next;
 	for (;;) {
-		struct dentry * dentry = list_entry(tmp, struct dentry, d_hash);
+		struct dentry * dentry;
+		read_barrier_depends();
+	       	dentry = list_entry(tmp, struct dentry, d_hash);
 		if (tmp == head)
 			break;
 		tmp = tmp->next;
