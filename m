Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVLYXFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVLYXFJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 18:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbVLYXFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 18:05:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750964AbVLYXFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 18:05:07 -0500
Date: Sun, 25 Dec 2005 15:05:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXPERIMENT] Add new "flush" option
Message-Id: <20051225150500.317bb7b3.akpm@osdl.org>
In-Reply-To: <878xu99rxx.fsf@devron.myhome.or.jp>
References: <877j9ufeio.fsf@devron.myhome.or.jp>
	<20051225041900.38fdcba7.akpm@osdl.org>
	<878xu99rxx.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> >> +	if (bdi_write_congested(bdi)) {
> >> +		mod_timer(&sb->flush_timer, jiffies + (HZ / 10));
> >> +		return;
> >> +	}
> >
> > The bdi_write_congested() test probably isn't doing anything useful: it
> > only returns true if there's really heavy writeout in progress.  Possibly
> > you could look at the disk queue accounting stats, work out how much I/O
> > has been happening lately.
> 
> Umm... If queue is too busy, we can't flush immediately. So, this code
> is delaying flush, and we can wait the more user's request by it, I think.

The thing is that bdi_write_congested() will only return true when the
queue is under really really heavy writeout.  Most of the time it just
won't trigger, so this code isn't doing anything very useful.

If you indeed want to implement something like "only sync the device when
it is otherwise idle" then some different approach will be needed.  One
which

a) detects when there is light writeout happening and which

b) detects when there are reads happening too.

I don't know whether any of this is particularly useful, really.  So I'd
suggest that we just remove the bdi_write_contested() test and leave it at
that.

I could be wrong, of course - if you have some testcase in which the
bdi_write_congested() test makes some perceptible difference then I'd be
interested in hearing about it.  If you put a printk in there, does it
trigger much?
