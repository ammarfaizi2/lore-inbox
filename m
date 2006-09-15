Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWIOOfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWIOOfC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWIOOfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:35:01 -0400
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:31679 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751535AbWIOOe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:34:59 -0400
X-AuditID: 7f000001-a2073bb000000c39-17-450ab6806f2a 
Date: Fri, 15 Sep 2006 15:19:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Yingchao Zhou <yc_zhou@ncic.ac.cn>
cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       alan <alan@redhat.com>, zxc <zxc@ncic.ac.cn>
Subject: Re: Re: Re: [RFC] PAGE_RW Should be added to PAGE_COPY ?
In-Reply-To: <Pine.LNX.4.64.0609150514190.7397@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0609151431320.22674@blonde.wat.veritas.com>
References: <20060915033842.C205FFB045@ncic.ac.cn>
 <Pine.LNX.4.64.0609150514190.7397@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Sep 2006 14:19:31.0724 (UTC) FILETIME=[F63794C0:01C6D8D1]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006, Hugh Dickins wrote:
> On Fri, 15 Sep 2006, Yingchao Zhou wrote:
> > >On Fri, 15 Sep 2006, Yingchao Zhou wrote:
> > >> It's ok to mmap MAP_SHARED. But is it not a normal way to malloc()
> > >> a space and then registered to NIC ?
> > >
> > >Not that I know of.  How would one register malloc()ed space to a NIC?
> > >Sorry, I may well be misunderstanding you.
> > The user-level NIC does this, eg. Myrinet...
> 
> Okay, thanks, I know nothing of that, and must defer to those who do.
> 
> But it sounds broken to me, in the way that you have described.

I replied too hastily.  I've since looked back to your original mail
(in which you do mention Infiniband as an example, which has now
helped to jog my brain), and realized that I was misinterpreting
what you meant by "user-level network driver".

The model I had in my head was a driver exporting, say, a ringbuffer
for userspace to mmap via device node, the pages being allocated by
the driver.  But that's not what you meant at all, and many of my
comments may therefore have been hard to understand, because they
were quite wrong in your scenario - for example, when I said the
page coming to do_wp_page is not PageAnon: in my model it wasn't,
but in your model it is, or may well be, PageAnon.

Sorry for that.

This mprotect'ing back and forth: that's something you'd like your
userspace to be able to do safely on these areas?  Infiniband had a
similar problem when the process fork()s, which write-protects private
ptes in both parent and child, danger of incoherency if either then
writes to the area.  It's an awkward problem, and in the end we
side-stepped it by adding madvise(,,MADV_DONTFORK) to help exempt
a particular area from propagation into the child.

> 
> And the fix would not be to change the kernel's semantics for private
> mappings,

That I do stand by: your idea to include PAGE_RW in PAGE_COPY
would be very wrong.

> but for the app to use a shared mapping instead of a private.

But that suggestion wasn't helpful: you'd much prefer not to
restrict what areas of userspace are used in this way.

The problem, as I now see it, is precisely with do_wp_page()'s
TestSetPageLocked, as you first said.  There is indeed a small
but real chance that will fail.  At some time in the past I did
realize that, but pushed it to the back of my mind, waiting for
someone actually to complain: now you have.

Yes, it would be good if we could do that check in some other,
reliable way.  The problem is that can_share_swap_page has to
check page_mapcount (and PageSwapCache) and page_swapcount in
an atomic way: the page lock is what we have used to guard the
movement between mapcount and swapcount.

I'll try to think whether we can do that better,
but not until next week.

Hugh
