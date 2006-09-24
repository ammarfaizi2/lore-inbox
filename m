Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWIXWmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWIXWmE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWIXWmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:42:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751519AbWIXWmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:42:00 -0400
Date: Sun, 24 Sep 2006 15:41:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org,
       Chris Mason <mason@suse.com>, ext2-devel@lists.sourceforge.net,
       reiserfs-dev@namesys.com
Subject: Re: [2.6.18-rc7-mm1] slow boot
Message-Id: <20060924154149.6f8dc5b2.akpm@osdl.org>
In-Reply-To: <1159137402.11049.40.camel@localhost.localdomain>
References: <4516B966.3010909@imap.cc>
	<20060924145337.ae152efd.akpm@osdl.org>
	<1159137402.11049.40.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 23:36:41 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Sul, 2006-09-24 am 14:53 -0700, ysgrifennodd Andrew Morton:
> > I've *never* seen any reports of any problems being caused by disk
> > writeback caching.  Yes, it's a theoretical problem but for some reason it
> > just doesn't seem to be a problem in practice.  Hence I'm really reluctant
> > to go and slow everyone's machines down so much in this manner.
> 
> It happens in some cases, the usual one is sudden loss of power. In the
> crashed box cases the disk still gets to write data back and in the
> Linux power off sanely cases we explicitly cache flush. Its the sudden
> loss of power case that is nasty.

I don't know about reiserfs, but for ext3 writeback caching delays aren't a
problem per-se.  It's write *reordering* which matters.

And given that the jounal tends to be a single contiguous hunk of disk, the
probability that a journal block at LBA #N gets written before the commit
block at LBA #N+20 is probably fairly low.  There's block remapping of
course, but software journal wrapping might be a more likely cause of write
reordering.

And of course the time window is small - a few milliseconds per five
seconds, and not every five seconds at that.

Hand wavy, I know.  But I wouldn't pay 15% throughput for it..

> We are also helped of course by the fact the cache is never more than
> can be flushed in about 7 seconds because of other-os features.

Well, as I say, the absolute value of any delay doesn't really matter,
except you'd lose an additional seven seconds worth of work.  It's
write reordering which can damage the fs.

