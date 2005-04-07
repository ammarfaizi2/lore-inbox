Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVDGQCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVDGQCQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVDGQCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:02:15 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:36021 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262498AbVDGQCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:02:10 -0400
Date: Fri, 8 Apr 2005 02:01:57 +1000
From: Greg Banks <gnb@sgi.com>
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050407160157.GD8579@sgi.com>
References: <20050406160123.GH347@unthought.net> <20050406231906.GA4473@sgi.com> <20050407153848.GN347@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407153848.GN347@unthought.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 05:38:48PM +0200, Jakob Oestergaard wrote:
> On Thu, Apr 07, 2005 at 09:19:06AM +1000, Greg Banks wrote:
> ...
> > How large is the client's RAM? 
> 
> 2GB - (32 bit kernel because it's dual PIII, so I use highmem)

Ok, that's probably not enough to fully trigger some of the problems
I've seen on large-memory NFS clients.

> A few more details:
> 
> With standard VM settings, the client will be laggy during the copy, but
> it will also have a load average around 10 (!)   And really, the only
> thing I do with it is one single 'cp' operation.  The CPU hogs are
> pdflush, rpciod/0 and rpciod/1.

NFS writes of single files much larger than client RAM still have
interesting issues.

> I tweaked the VM a bit, put the following in /etc/sysctl.conf:
>  vm.dirty_writeback_centisecs=100
>  vm.dirty_expire_centisecs=200
> 
> The defaults are 500 and 3000 respectively...

Yes, you want more frequent and smaller writebacks.  It may help to
reduce vm.dirty_ratio and possibly vm.dirty_background_ratio.

> This improved things a lot; the client is now "almost not very laggy",
> and load stays in the saner 1-2 range.
> 
> Still, system CPU utilization is very high (still from rpciod and
> pdflush - more rpciod and less pdflush though),

This is probably the rpciod's and pdflush all trying to do things
at the same time and contending for the BKL.

> During the copy I typically see:
> 
> nfs_write_data  681   952 480  8 1 : tunables  54 27 8 : slabdata 119 119 108
> nfs_page      15639 18300  64 61 1 : tunables 120 60 8 : slabdata 300 300 180

That's not so bad, it's only about 3% of the system's pages.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
