Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWHYOb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWHYOb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWHYOb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:31:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751470AbWHYObZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:31:25 -0400
Date: Fri, 25 Aug 2006 07:30:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH] BC: resource beancounters (v2)
Message-Id: <20060825073003.e6b5ae16.akpm@osdl.org>
In-Reply-To: <44EEE3BB.10303@sw.ru>
References: <44EC31FB.2050002@sw.ru>
	<20060823100532.459da50a.akpm@osdl.org>
	<44EEE3BB.10303@sw.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 15:49:15 +0400
Kirill Korotaev <dev@sw.ru> wrote:

> > We need to go over this work before we can commit to the BC
> > core.  Last time I looked at the VM accounting patch it
> > seemed rather unpleasing from a maintainability POV.
> hmmm... in which regard?

Little changes all over the MM code which might get accidentally broken.

> > And, if I understand it correctly, the only response to a job
> > going over its VM limits is to kill it, rather than trimming
> > it.  Which sounds like a big problem?
> No, UBC virtual memory management refuses occur on mmap()'s.

That's worse, isn't it?  Firstly it rules out big sparse mappings and secondly

	mmap_and_use(80% of container size)
	fork_and_immediately_exec(/bin/true)

will fail at the fork?


> Andrey Savochkin wrote already a brief summary on vm resource management:
> 
> ------------- cut ----------------
> The task of limiting a container to 4.5GB of memory bottles down to the
> question: what to do when the container starts to use more than assigned
> 4.5GB of memory?
> 
> At this moment there are only 3 viable alternatives.
> 
> A) Have separate memory management for each container,
>    with separate buddy allocator, lru lists, page replacement mechanism.
>    That implies a considerable overhead, and the main challenge there
>    is sharing of pages between these separate memory managers.
> 
> B) Return errors on extension of mappings, but not on page faults, where
>    memory is actually consumed.
>    In this case it makes sense to take into account not only the size of used
>    memory, but the size of created mappings as well.
>    This is approximately what "privvmpages" accounting/limiting provides in
>    UBC.
> 
> C) Rely on OOM killer.
>    This is a fall-back method in UBC, for the case "privvmpages" limits
>    still leave the possibility to overload the system.
> 

D) Virtual scan of mm's in the over-limit container

E) Modify existing physical scanner to be able to skip pages which
   belong to not-over-limit containers.

F) Something else ;)


