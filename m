Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269423AbTGJR2w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269433AbTGJR2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:28:51 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:44197 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269423AbTGJR2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:28:42 -0400
Date: Thu, 10 Jul 2003 19:43:22 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Rik van Riel <riel@redhat.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
In-Reply-To: <Pine.LNX.4.44.0307101030270.3903-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0307101934090.6757-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The problem, as I see it, is that you can dirty pages 10-15 times
> > faster than they can be written to disk. So, you will always
> > have the possibility of an OOM situation as long as you are I/O
> > bound.
>
> That's not a problem at all.  I think the VM never starts
> pageout IO on a page that doesn't look like it'll become
> freeable after the IO is done, so we simply shouldn't go
> into the OOM killer as long as there are pages waiting on
> pageout IO to finish.
>
> Once we really are OOM we shouldn't have pages in pageout
> IO.

What piece of code does prevent that?
As I see, OOM is triggered if no pages were freed in few loops. It
doesn't care about pages that are already being written or pages for which
write operation was started.

The only thing that prevents total oom when writing a lot of dirty pages
is blk_congestion_wait, but it's pretty unreliable because
1) it uses timeout
2) not all page writes go through block devices (NFS, NBD etc.)
blk_congestion_wait may be used for improving performance, but not for
ensuring stability.

> This is what I am doing in current 2.4-rmap and it seems
> to do the right thing in both the "heavy IO" and the "out
> of memory" corner cases.

I remember there was (and probably still is, only with smaller
probability) a similar bug in 2.2.

Mikulas

