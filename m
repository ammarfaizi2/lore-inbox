Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbWHIG4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbWHIG4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWHIG4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:56:06 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:10509 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S965086AbWHIG4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:56:05 -0400
Message-ID: <20060809105603.A26520@castle.nmd.msu.ru>
Date: Wed, 9 Aug 2006 10:56:03 +0400
From: Andrey Savochkin <saw@sw.ru>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Martin Bligh <mbligh@mbligh.org>, rohitseth@google.com,
       Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       pj@sgi.com
Subject: Re: memory resource accounting (was Re: [RFC, PATCH 0/5] Going forward with Resource Management - A	cpu controller)
References: <44D35F0B.5000801@sw.ru> <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru> <44D74F77.7080000@mbligh.org> <44D76B43.5080507@sw.ru> <1154975486.31962.40.camel@galaxy.corp.google.com> <1154976236.19249.9.camel@localhost.localdomain> <1154977257.31962.57.camel@galaxy.corp.google.com> <44D798B1.8010604@mbligh.org> <44D89D7D.8040006@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <44D89D7D.8040006@yahoo.com.au>; from "Nick Piggin" on Wed, Aug 09, 2006 at 12:19:41AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,

On Wed, Aug 09, 2006 at 12:19:41AM +1000, Nick Piggin wrote:
[snip]
> 
> What's the sucking semantics on exit? I haven't looked much at the
> existing memory controllers going around, but the implementation I
> imagine looks something like this (I think it is conceptually similar
> to the basic beancounters idea):

What you suggests implies an over-simplification of how memory is used in the
system, and doesn't take into account sharing and caching.

Namely:

> - anyone who allocates a page for anything gets charged for that page.
>    Except interrupt/softirq context. Could we ignore these for the moment?
> 
>    This does give you kernel (slab, pagetable, etc) allocations as well as
>    userspace. I don't like the idea of doing controllers for inode cache
>    and controllers for dentry cache, etc, etc, ad infinitum.

So, are you suggesting that the user (or container) that initially looked up
some directory /var/dir, will stay billed for this memory until
 - all users of all subdirectories /var/dir/a/b/c/d/e/f/g/h/i etc.
   are gone, and
 - dentry cache has been shrunk because of memory pressure?

It is unfair.
But more than that:
one of the goals of resource accounting and restrictions is to give users the
idea of how much resources they are using.  Then, when they start to use more
than their allotment, they should be given the opportunity to consider what
they are doing and reduce resource usage.

In my opinion, to make resource accounting useful, serious efforts should
be made not to bill anyone for resources which he isn't really using and has
no control over releasing them.

> 
> - each struct page has a backpointer to its billed container. At the mm
>    summit Linus said he didn't want back pointers, but I clarified with him
>    and he isn't against them if they are easily configured out when not using
>    memory controllers.

The same thing: if one user mapped and then released some pages from a shared
library, should he be billed for these pages until all other users unmapped
this library, and page cache has been shrunk?

Best regards
		Andrey
