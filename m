Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVIVSdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVIVSdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 14:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVIVSdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 14:33:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:21433 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751014AbVIVSdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 14:33:18 -0400
Date: Thu, 22 Sep 2005 23:57:19 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Roland Dreier <rolandd@cisco.com>,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on 2.6.14-rc2
Message-ID: <20050922182719.GA4729@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4332CAEA.1010509@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 09:16:58AM -0600, Christopher Friesen wrote:
> Al Viro wrote:
> 
> >Umm...   How many RCU callbacks are pending?
> 
> According to this we had 4127306 pending rcu callbacks.  A few seconds 
> later it was down to 0.
> 
> Full output is below.
> 
> /proc/sys/fs/dentry-state:
> 1611    838     45      0       0       0
> 
> pages_with_[29]_dentries: 142355
> dcache_pages total: 142407
> prune_dcache: requested  1 freed 1
> dcache lru list data:
> dentries total: 839
> dentries in_use: 43
> dentries free: 796
> dentries referenced: 839

These two should make it clear that there were only 1611 dentries
in the dcache and 839 in LRU list. Not too many pinned dentries.
So, all the dentries you saw in the slab were dentries out
of dcache but waiting for corresponding RCU grace periods
to happen.

This can happen if a task runs for too long inside the kernel
holding up context switches or usermode code running on that
cpu. The fact that RCU grace period eventually happens
and the dentries are freed means that something intermittently
holds up RCU. Is this 2.6.10 vanilla or does it have other
patches in there ?

Thanks
Dipankar
