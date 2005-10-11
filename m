Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVJKDLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVJKDLL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 23:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVJKDLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 23:11:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18083 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751365AbVJKDLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 23:11:10 -0400
Date: Mon, 10 Oct 2005 20:10:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adam Litke <agl@us.ibm.com>
Cc: hugh@veritas.com, kenneth.w.chen@intel.com, rohit.seth@intel.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: FW: [PATCH 0/3] Demand faulting for huge pages
Message-Id: <20051010201024.081aeff1.akpm@osdl.org>
In-Reply-To: <1128961046.8453.11.camel@localhost.localdomain>
References: <200510080758.j987w0g06343@unix-os.sc.intel.com>
	<Pine.LNX.4.61.0510091306440.7878@goblin.wat.veritas.com>
	<1128961046.8453.11.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke <agl@us.ibm.com> wrote:
>
>  Honestly, I think there is an even more fundamental issue at hand.  If
>  the goal is transparent and flexible use of huge pages it seems to me
>  that there is two ways to go:
> 
>  1) Continue with hugetlbfs and work to finish implementing all of the
>  operations (that make sense) properly (like read, write, truncate, etc).

hugetlbfs provides the API by which applications may obtain
hugetlb-page-backed memory.  In fact the filesystem didn't even exist in the
initial version of the patch - the first version used specific syscalls to
obtain the hugepage memory.

So.  Given that hugetlbfs is purely there as a means by which applications
can access (and share) hugepage memory, it doesn't make sense to flesh that
filesystem out any further.  IOW: no need for read() and write().

>  2) Recognize that trying to use hugetlbfs files to transparently replace
>  normal memory is ultimately a hack.  Normal memory is not implemented as
>  a file system so using hugetlb pages here will always cause headaches as
>  implemented.  So work towards removing filesystem-like behaviour and
>  treating huge pages more like regular memory.

Early Linus diktat was that we shouldn't attempt to make the core MM aware
of multiple page sizes in the manner which you suggest.  Trying to sneak
this in via "improved integration of hugepage support" would likely create
a mess.

The design approach for hugepage integration was that the MM would continue
to be focussed on a fixed page size and that hugepages would be some
non-intrusive thing off to the side - more like a mmappable device driver
than some core part of the MM system.

This is not all meant to say "don't do it".  But I am saying that you'll
need to review several years worth of discussion on the topic and
understand the downsides and objections, and be prepared for a big project.
One which risks causing Hugh a ton of grief in ongoing core MM
improvements.

Aside: one problem with the kernel's hugepage support is that it doesn't
have a single person who performs the overall maintenance function.  Bill
Irwin was doing this for a while, but now seems to have gone quiet. 

Consequently various people come in and attempt various
this-is-a-change-i-need operations.  Problem is, with no single person
keeping track of who the affected stakeholders are, and what the likely
effects of each change upon the stakeholders will be, things proceed slowly
and various people end up maintaining various out-of-tree things (I think).

I attempt to plug the gaps, but the time interval between flurries of
hugetlb activity are long and I forget who's doing what.
