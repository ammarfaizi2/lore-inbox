Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWHHRgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWHHRgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWHHRgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:36:31 -0400
Received: from smtp-out.google.com ([216.239.45.12]:41923 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030198AbWHHRga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:36:30 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=sMoL06EeyZLepHEe9fKMPYmP5ZdaE0WJFonlA/tR7k+qgah+qC971OZUvJRjmwO5n
	e4y+HzbOGvy5gsUHrwr7w==
Subject: Re: memory resource accounting (was Re: [RFC, PATCH 0/5] Going
	forward with Resource Management - A	cpu controller)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Martin Bligh <mbligh@mbligh.org>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@sw.ru>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
In-Reply-To: <44D89D7D.8040006@yahoo.com.au>
References: <20060804050753.GD27194@in.ibm.com>
	 <20060803223650.423f2e6a.akpm@osdl.org>
	 <20060803224253.49068b98.akpm@osdl.org>
	 <1154684950.23655.178.camel@localhost.localdomain>
	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>
	 <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>
	 <44D74F77.7080000@mbligh.org>  <44D76B43.5080507@sw.ru>
	 <1154975486.31962.40.camel@galaxy.corp.google.com>
	 <1154976236.19249.9.camel@localhost.localdomain>
	 <1154977257.31962.57.camel@galaxy.corp.google.com>
	 <44D798B1.8010604@mbligh.org>  <44D89D7D.8040006@yahoo.com.au>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 08 Aug 2006 10:34:21 -0700
Message-Id: <1155058462.1072.84.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 00:19 +1000, Nick Piggin wrote:

> 
> What's the sucking semantics on exit? I haven't looked much at the
> existing memory controllers going around, but the implementation I
> imagine looks something like this (I think it is conceptually similar
> to the basic beancounters idea):
> 
> - anyone who allocates a page for anything gets charged for that page.
>    Except interrupt/softirq context. Could we ignore these for the moment?
> 

And what happens when processes belonging to different containers start
accessing the same page?
 
>    This does give you kernel (slab, pagetable, etc) allocations as well as
>    userspace. I don't like the idea of doing controllers for inode cache
>    and controllers for dentry cache, etc, etc, ad infinitum.
> 

IMO, we don't need to worry about the kernel internal data structures in
the first pass of container support.  I agree that something like dcache
can grow to consume a meaningful amount of memory in a system, but I
still think if we can have something more simple to start with that can
track user memory (both anon and pagecache) will be a good start.

> - each struct page has a backpointer to its billed container. At the mm
>    summit Linus said he didn't want back pointers, but I clarified with him
>    and he isn't against them if they are easily configured out when not using
>    memory controllers.
> 

I think adding a pointer to struct page brings additional cost without
that much of additional benefit.  Doing it at the address_space/anon_vma
level for page_cache is useful.

> - memory accounting containers are in a hierarchy. If you want to destroy a
>    container but it still has billed memory outstanding, that gets charged
>    back to the parent. The data structure itself obviously still needs to
>    stay around, to keep the backpointers from going stale... but that could
>    be as little as a word or two in size.
> 

Before we go and say that we need hierarchy of containers, we should
have a design of what a container should be containing.  AFAICS, flat
containers should be able to do the job.

But in general, if a container is getting aborted, then any residual
resources should also be aborted where ever make sense(may mean flushing
of any page_cache pages) or the operation should not be permitted. 

> The reason I like this way of accounting is that it can be done with a couple
> of hooks into page_alloc.c and an ifdef in mm.h, and that is the extent of
> the impact on core mm/ so I'd be against anything more intrusive unless this
> really doesn't work.
> 

hmm, probably the changes to core mm are not going to be that intrusive.
The catch will be what happens when you hit the limit of memory assigned
to a container.

-rohit

