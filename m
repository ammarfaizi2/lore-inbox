Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265706AbUHCKJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265706AbUHCKJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 06:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUHCKJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 06:09:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54251 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265706AbUHCKJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 06:09:32 -0400
Date: Tue, 3 Aug 2004 11:06:43 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, dipankar@in.ibm.com
Subject: Re: [patchset] Lockfree fd lookup 0 of 5
Message-ID: <20040803100643.GQ12308@parcelfarce.linux.theplanet.co.uk>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802165607.GN12308@parcelfarce.linux.theplanet.co.uk> <20040803092316.GE1753@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803092316.GE1753@vitalstatistix.in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 02:53:17PM +0530, Ravikiran G Thirumalai wrote:
> > How about this for comparison?  That's just a dumb "convert to rwlock"
> > patch; we can be smarter in e.g. close_on_exec handling, but that's a
> > separate story.
> > 
> 
> I ran tiobench on this patch and here is the comparison:
> 
> 
> Kernel		Seqread		Randread	Seqwrite	Randwrite
> --------------------------------------------------------------------------
> 2.6.7		410.33		234.15		254.39		189.36
> rwlocks-viro	401.84		232.69		254.09		194.62
> refcount (kref)	455.72		281.75		272.87		230.10

Thanks.  IOW, we are really seeing cacheline bounces - not contention...

I'm still not sure that in the current form patch is a good idea.  The thing
is, existing checks for ->f_count value are bogus in practically all cases;
IMO we should sort that out before making any decision based on the need for
such checks.  Ditto for uses of fcheck() (open-coded or not) in arch/*.

I agree that some form of "postpone freeing and make fget() lockless" would
make sense, but I'd rather clean the area *before* doing that; afterwards it
will be harder and results of cleanup can affect the patches in non-trivial
way.
