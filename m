Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVJAX0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVJAX0N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 19:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbVJAX0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 19:26:13 -0400
Received: from hera.kernel.org ([140.211.167.34]:46544 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750893AbVJAX0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 19:26:12 -0400
Date: Sat, 1 Oct 2005 20:22:11 -0300
From: Marcelo <marcelo.tosatti@cyclades.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "Theodore Ts'o" <tytso@mit.edu>, dipankar@in.ibm.com,
       viro@ftp.linux.org.uk
Subject: Re: dentry_cache using up all my zone normal memory
Message-ID: <20051001232211.GA21518@xeon.cnet>
References: <433189B5.3030308@nortel.com> <433DB64B.70405@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433DB64B.70405@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris,

On Fri, Sep 30, 2005 at 04:03:55PM -0600, Christopher Friesen wrote:
> Friesen, Christopher [CAR:VC21:EXCH] wrote:
> 
> >With a bit of digging the culprit appears to be the dentry_cache.  The 
> >last log I have shows it using 817MB of memory.  Right after that the 
> >oom killer kicked me off the system.  When I logged back in, the cache 
> >usage was back down to normal and everything was fine.
> 
> There hasn't been any new suggestions as to the culprit, so I started 
> experimenting a bit.
> 
> It turns out that if I limit the memory on the system to 896MB, the 
> dcache slab usage peaks at around 600MB and sits there for the duration 
> of the test.
>
> When I limit the memory to 1024MB, the dcache slab chews up all my zone 
> normal memory and the oom killer runs.

The different 896 and 1024Mb behaviour looks like a problem. I don't
see how the addition of 128Mb of highmem could interfere here. Probably
because highmem creatures additional pressure on lowmem (certain kernel
allocations can only be satisfied from lowmem, such as dcache).

Seems that your workload makes the allocation paths/OOM killer behave in
a fragile manner.

How can this be reproduced? (point to a URL if you already explained
that in detail).

Another problem is why dentries can't be freed.

> It almost seems like the dcache responds to memory pressure on the 
> system as a whole, but not as well to pressure on zone normal. Would 
> this make sense?

Dentries can only be freed when their reference count reaches zero.

Someone else on the thread said you had zillions of file descriptors
open?

Need to figure out they can't be freed. The kernel is surely trying it
(also a problem if it is not trying). How does the "slabs_scanned" field
of /proc/vmstats looks like?

Bharata maintains a patch to record additional statistics, haven't 
you tried it already? Can find it at

http://marc.theaimsgroup.com/?l=linux-mm&m=112660138015732&w=2

And change:

@@ -427,8 +467,13 @@ static void prune_dcache(int count)
 			continue;
 		}
 		prune_one_dentry(dentry);
+		nr_freed++;
 	}
 	spin_unlock(&dcache_lock);
+	spin_lock(&prune_dcache_lock);
+	lru_dentry_stat.dprune_req = nr_requested;
+	lru_dentry_stat.dprune_freed = nr_freed;
+	spin_unlock(&prune_dcache_lock);

to use "+=" in nr_requested/nr_freed assignments instead
of "=".

Stats available in /proc/meminfo.

