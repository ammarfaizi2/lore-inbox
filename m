Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWITS63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWITS63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWITS6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:58:18 -0400
Received: from smtp-out.google.com ([216.239.45.12]:11224 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932270AbWITS55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:57:57 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=m5YVifOylmppp/+1hmbQo8azLtr/6FO9iOuZgvA6aNWj/TaFahb60KVxZy0+0ba2m
	2zwzuOxL2XDbxaFOpVu0w==
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <1158777463.28174.37.camel@lappy>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <4510D3F4.1040009@yahoo.com.au> <1158751720.8970.67.camel@twins>
	 <4511626B.9000106@yahoo.com.au> <1158767787.3278.103.camel@taijtu>
	 <451173B5.1000805@yahoo.com.au>
	 <1158774657.8574.65.camel@galaxy.corp.google.com>
	 <1158777463.28174.37.camel@lappy>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 11:57:40 -0700
Message-Id: <1158778660.8574.114.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 20:37 +0200, Peter Zijlstra wrote:
> On Wed, 2006-09-20 at 10:50 -0700, Rohit Seth wrote:
> > On Thu, 2006-09-21 at 03:00 +1000, Nick Piggin wrote:
> > > (this time to the lists as well)
> > > 
> > > Peter Zijlstra wrote:
> > > 
> > >  > I'd much rather containterize the whole reclaim code, which should not
> > >  > be too hard since he already adds a container pointer to struct page.
> > > 
> > > 
> > 
> > Right now the memory handler in this container subsystem is written in
> > such a way that when existing kernel reclaimer kicks in, it will first
> > operate on those (container with pages over the limit) pages first.  But
> > in general I like the notion of containerizing the whole reclaim code.
> 
> Patch 5/5 seems to have a horrid deactivation scheme.
> 
> > >  > I still have to reread what Rohit does for file backed pages, that gave
> > >  > my head a spin.
> > 
> > Please let me know if there is any specific part that isn't making much
> > sense.
> 
> Well, the whole over the limit handler is quite painfull, having taken a
> second reading it isn't all that complex after all, just odd.
> 

It is very basic right now.  

> You just start invalidating whole files for file backed pages. Granted,
> this will get you below the threshold. but you might just have destroyed
> your working set.
> 

When a container gone over the limit then it is okay to penalize it.  I
agree that I'm not making an attempt to maintain the current working
set.  Any suggestions that I can incorporate to improve this algorithm
will be very appreciated.

> Pretty much the same for you anonymous memory handler, you scan through
> the pages in linear fashion and demote the first that you encounter.
> 
> Both things pretty thoroughly destroy the existing kernel reclaim.
> 

I agree that with in a container I need to do add more smarts to (for
example) not do a linear search.  Simple additions like last task or
last mapping visited could be useful. And I definitely want to improve
on that.

Though it should not destroy the existing kernel reclaim.  Pages
belonging to over the limit container should be the first ones to either
get flushed out to FS or swapped if necessary.  (Means that is the cost
that you will have to pay if you, for example, want to container your
tar to 100MB memory foot print).

-rohit

