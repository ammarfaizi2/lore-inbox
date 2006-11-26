Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967323AbWKZHbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967323AbWKZHbY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 02:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967324AbWKZHbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 02:31:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:31968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967323AbWKZHbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 02:31:23 -0500
Date: Sat, 25 Nov 2006 23:30:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>, Larry Woodman <lwoodman@redhat.com>
Subject: Re: OOM killer firing on 2.6.18 and later during LTP runs
Message-Id: <20061125233023.310dbc17.akpm@osdl.org>
In-Reply-To: <20061126072538.GA5223@redhat.com>
References: <4568AFB1.3050500@mbligh.org>
	<20061125132828.16a01762.akpm@osdl.org>
	<20061126030045.GA29656@redhat.com>
	<20061125231153.5cbd4581.akpm@osdl.org>
	<20061126072538.GA5223@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2006 02:25:38 -0500
Dave Jones <davej@redhat.com> wrote:

> On Sat, Nov 25, 2006 at 11:11:53PM -0800, Andrew Morton wrote:
>  > On Sat, 25 Nov 2006 22:00:45 -0500
>  > Dave Jones <davej@redhat.com> wrote:
>  > 
>  > > On Sat, Nov 25, 2006 at 01:28:28PM -0800, Andrew Morton wrote:
>  > >  > On Sat, 25 Nov 2006 13:03:45 -0800
>  > >  > "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>  > >  > 
>  > >  > > On 2.6.18-rc7 and later during LTP:
>  > >  > > http://test.kernel.org/abat/48393/debug/console.log
>  > >  > 
>  > >  > The traces are a bit confusing, but I don't actually see anything wrong
>  > >  > there.  The machine has used up all swap, has used up all memory and has
>  > >  > correctly gone and killed things.  After that, there's free memory again.
>  > > 
>  > > We covered this a month or two back.  For RHEL5, we've ended up
>  > > reintroducing the oom killer prevention logic that we had up until
>  > > circa 2.6.10.   It seemed that there exist circumstances where
>  > > given a little more time, some memory hogging apps will run to completion
>  > > allowing other allocators to succeed instead of being killed.
>  > 
>  > I _think_ what you're describing here is a false-positive oom-killing?  But
>  > Martin appears to be hitting a genuine oom.
>  
> what we saw during the rhel5 testing was that yes, the machine _was_ OOM
> *temporarily*, but if instead of killing the task trying to allocate, we
> postponed the killing a few times, it would give other tasks the opportunity
> to complete writeout, or free up memory some other way, allowing the
> allocating process to succeed shortly afterwards.

That would be a false positive then.

In Martin's case he's 100% out of swapspace and has only a few tens of
pages letf mapped into pagetables, so Iassume that all memory is unmapped
swapcache (but that cannot be confirmed from the info which we have).  But
it looks like a real oom.

That's not to say that we don't have omm-killer problems.

>  > But it does appear that some changes are needed, because lots of things got
>  > oom-killed.
>  >
>  > I think.  Maybe not - there's no timestamping in those logs and it is of
>  > course possible that we're seeing unrelated ooms which happened a long time
>  > apart.
> 
> Maybe, but it does sound spookily familiar.
> The last time Larry's patch got floated to lkml it was met with
> "Ah!, but we have new oom killer changes in -git which might solve this".
> We tried them. They didn't.

What's the testcase?
