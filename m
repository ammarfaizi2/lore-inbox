Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932775AbVINVjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbVINVjq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbVINVjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:39:45 -0400
Received: from hera.kernel.org ([209.128.68.125]:4540 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932775AbVINVjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:39:45 -0400
Date: Wed, 14 Sep 2005 18:34:04 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Bharata B Rao <bharata@in.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050914213404.GC9808@dmt.cnet>
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913084752.GC4474@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 02:17:52PM +0530, Bharata B Rao wrote:
> On Sun, Sep 11, 2005 at 11:16:36PM -0400, Theodore Ts'o wrote:
> > On Sun, Sep 11, 2005 at 05:30:46PM +0530, Dipankar Sarma wrote:
> > > Do you have the /proc/sys/fs/dentry-state output when such lowmem
> > > shortage happens ?
> > 
> > Not yet, but the situation occurs on my laptop about 2 or 3 times
> > (when I'm not travelling and so it doesn't get rebooted).  So
> > reproducing it isn't utterly trivial, but it's does happen often
> > enough that it should be possible to get the necessary data.
> > 
> > > This is a problem that Bharata has been investigating at the moment.
> > > But he hasn't seen anything that can't be cured by a small memory
> > > pressure - IOW, dentries do get freed under memory pressure. So
> > > your case might be very useful. Bharata is maintaing an instrumentation
> > > patch to collect more information and an alternative dentry aging patch 
> > > (using rbtree). Perhaps you could try with those.
> > 
> > Send it to me, and I'd be happy to try either the instrumentation
> > patch or the dentry aging patch.
> > 
> 
> Ted,
> 
> I am sending two patches here.
> 
> First is dentry_stats patch which collects some dcache statistics
> and puts it into /proc/meminfo. This patch provides information 
> about how dentries are distributed in dcache slab pages, how many
> free and in use dentries are present in dentry_unused lru list and
> how prune_dcache() performs with respect to freeing the requested
> number of dentries.

Hi Bharata,

+void get_dstat_info(void)
+{
+       struct dentry *dentry;
+
+       lru_dentry_stat.nr_total = lru_dentry_stat.nr_inuse = 0;
+       lru_dentry_stat.nr_ref = lru_dentry_stat.nr_free = 0;
+
+       spin_lock(&dcache_lock);
+       list_for_each_entry(dentry, &dentry_unused, d_lru) {
+               if (atomic_read(&dentry->d_count))
+                       lru_dentry_stat.nr_inuse++;

Dentries on dentry_unused list with d_count positive? Is that possible 
at all? As far as my limited understanding goes, only dentries with zero 
count can be part of the dentry_unused list.

+               if (dentry->d_flags & DCACHE_REFERENCED)
+                       lru_dentry_stat.nr_ref++;
+       }


@@ -393,6 +430,9 @@ static inline void prune_one_dentry(stru

 static void prune_dcache(int count)
 {
+       int nr_requested = count;
+       int nr_freed = 0;
+
        spin_lock(&dcache_lock);
        for (; count ; count--) {
                struct dentry *dentry;
@@ -427,8 +467,13 @@ static void prune_dcache(int count)
                        continue;
                }
                prune_one_dentry(dentry);
+               nr_freed++;
        }
        spin_unlock(&dcache_lock);
+       spin_lock(&prune_dcache_lock);
+       lru_dentry_stat.dprune_req = nr_requested;
+       lru_dentry_stat.dprune_freed = nr_freed;

Don't you mean "+=" ? 

+       spin_unlock(&prune_dcache_lock);



