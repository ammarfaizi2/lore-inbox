Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265291AbUHCJYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUHCJYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 05:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUHCJYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 05:24:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:36531 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265291AbUHCJYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 05:24:30 -0400
Date: Tue, 3 Aug 2004 14:53:17 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, dipankar@in.ibm.com
Subject: Re: [patchset] Lockfree fd lookup 0 of 5
Message-ID: <20040803092316.GE1753@vitalstatistix.in.ibm.com>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802165607.GN12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802165607.GN12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 05:56:07PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Aug 02, 2004 at 03:40:55PM +0530, Ravikiran G Thirumalai wrote:
> > Here is a patchset to eliminate taking struct files_struct.file_lock on 
> > reader side using rcu and rcu based refcounting.  These patches
> > extend the kref api to include kref_lf_xxx api and kref_lf_get_rcu to
> > do lockfree refcounting, and use the same.  As posted earlier, since fd
> > lookups (struct files_struct.fd[]) will be lock free with these patches, 
> > threaded workloads doing lots of io should see performance benefits 
> > due to this patchset.  I have observed 13-15% improvement with tiobench 
> > on a 4 way xeon with this patchset.
> 
> How about this for comparison?  That's just a dumb "convert to rwlock"
> patch; we can be smarter in e.g. close_on_exec handling, but that's a
> separate story.
> 

I ran tiobench on this patch and here is the comparison:


Kernel		Seqread		Randread	Seqwrite	Randwrite
--------------------------------------------------------------------------
2.6.7		410.33		234.15		254.39		189.36
rwlocks-viro	401.84		232.69		254.09		194.62
refcount (kref)	455.72		281.75		272.87		230.10

All of this was 2.6.7 based.  Nos are througput rates in mega bytes per sec.
Test was on ramfs, 48 threads doing 100 MB of io per thread averaged over
8 runs.  This was on a 4 way PIII xeon. 

Thanks,
Kiran
