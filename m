Return-Path: <linux-kernel-owner+w=401wt.eu-S1750925AbWLXLcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWLXLcg (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 06:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWLXLcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 06:32:36 -0500
Received: from smtp-out.google.com ([216.239.33.17]:52976 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbWLXLcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 06:32:35 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=beTWXGgrxQCgEkhL8Sv+fEC2Rc+SZ5gbGV6OLAMTnLj15ex8m2fALp7hSIKDqMOjT
	Rim2j5VAAEcbTfW1kBbzA==
Message-ID: <6599ad830612240332j55ebaa04sddb6f16e5bf38c4c@mail.gmail.com>
Date: Sun, 24 Dec 2006 03:32:25 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Menage" <menage@google.com>, akpm@osdl.org, pj@sgi.com,
       sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru, serue@us.ibm.com,
       vatsa@in.ibm.com, rohitseth@google.com, winget@google.com,
       containers@lists.osdl.org, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] containers: BeanCounters over generic process containers
In-Reply-To: <20061223194955.GA30764@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222141442.753211763@menage.corp.google.com>
	 <20061222145217.107513155@menage.corp.google.com>
	 <20061223194955.GA30764@MAIL.13thfloor.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/06, Herbert Poetzl <herbert@13thfloor.at> wrote:
> On Fri, Dec 22, 2006 at 06:14:48AM -0800, Paul Menage wrote:
> > This patch implements the BeanCounter resource control abstraction
> > over generic process containers. It contains the beancounter core
> > code, plus the numfiles resource counter. It doesn't currently contain
> > any of the memory tracking code or the code for switching beancounter
> > context in interrupts.
>
> I don't like it, it looks bloated and probably
> adds plenty of overhead (similar to the OVZ
> implementation where this seems to be taken from)

Yes - perhaps I should have been clearer in the patch description.
It's basically code taken from the OpenVZ bean counters patches that
have been posted recently, but with the filesystem and process
tracking code ripped out (since it's implemented over the generic
containers).

The main point of this patch is to demonstrate that UBC can be
implemented effectively over generic containers, rather than to be a
proposal in favour of UBC versus any of the other potential resource
control mechanisms.

Most of your comments are about code taken pretty much directly from
the UBC patches, so I won't address them.

>
> > +int bc_file_charge(struct file *file)
> > +{
> > +     int sev;
> > +     struct beancounter *bc;
> > +
> > +     task_lock(current);
>
> why do we lock current? it won't go away that
> easily, and for switching the bc, it might be
> better to use RCU or a separate lock, no?
>

The locking model (taken originally from the Cpusets code) in generic
containers is that while you can use RCU to guarantee that a pointer
read from current->container remains valid until you exit the RCU
critical section, if you want to make consistent changes to data
referenced from a task P's container, you need to hold either
P->alloc_lock or one of the two container mutexes (manage_mutex and/or
callback_mutex).

In this particular case (sorry, not on the VPN right now to be able to
figure out the potential code changes) the fact that the call to
css_get_current() uses atomic operations (currently a spinlock, but I
suspect I could optimize it to be a cmpxchg) could mean that we can
skip the task_lock(), at the cost of occasionally accounting a file to
the container that the task had just left.

Paul
