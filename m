Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbULNXd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbULNXd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbULNX2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:28:37 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:3228 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261745AbULNX1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:27:14 -0500
Date: Tue, 14 Dec 2004 23:26:48 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
In-Reply-To: <20041214164548.GA18817@kroah.com>
Message-ID: <Pine.LNX.4.44.0412142304160.11826-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Greg KH wrote:
> 
> So I finally try to get dri working on my laptop and I get the following
> kernel bug when killing X (the program gish was running at the time):
> 
> kernel BUG at mm/rmap.c:480!
> EIP is at page_remove_rmap+0x32/0x40
> Process gish (pid: 10864, threadinfo=c8aea000 task=c7c2c040)
>  [<c0141495>] zap_pte_range+0x135/0x290
>...
>  [<c0145f41>] exit_mmap+0x71/0x140
>  [<c01163c4>] mmput+0x24/0x80
>  [<c011a756>] do_exit+0x146/0x370
>...

It's my BUG_ON(page_mapcount(page) < 0).

We've had about one report per month, over the last six months.
But this is the first citing "gish"; sometimes it's been "cc1".

I've given it a lot of thought, but I'm still mystified.  The last
report turned out to be attributable to bad memory; but this BUG_ON
is too persistent and specific to be put down to that in all cases.

One case that's easy to explain: if it was preceded (perhaps hours
earlier) by a "Bad page state" message and stacktrace, referring to
the same page (in ecx, edx, ebp in your dump), which showed non-zero
mapcount, then this is an after-effect of bad_page resetting mapcount.
And the real problem was probably a double free, which bad_page noted,
but carried on regardless.  Worth checking your logs for, let us know,
but there have been several reports where that's definitely not so.

I presume this was just a one-off?  If you can repeat it from time to
time, I'll try to devise some printk'ing to shed more light.  You might
wonder why I haven't got such a patch already prepared: precisely
because I'm mystified and have no hypothesis worth testing out.

In the meantime, any similar or related traces,
please do send me to scan for commonalities.

Thanks!
Hugh

