Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbULHBkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbULHBkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbULHBkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:40:10 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:39322 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261993AbULHBhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:37:37 -0500
Date: Wed, 8 Dec 2004 02:37:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208013732.GF16322@dualathlon.random>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102467253.8095.10.camel@npiggin-nld.site>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 11:54:13AM +1100, Nick Piggin wrote:
> That is synch write bandwidth. Yes that seems to be a problem.

It's not just sync write, it's a write in general, blkdev doesn't know
if the one waiting is pdflush or some other task. Once this will be
fixed I will have to reconsider my opinion of course, but I guess after
it gets fixed the benefit of "as" on the desktop will as well decrease
compared to cfq. The desktop is ok with "as" simply because it's
normally optimal to stop writes completely, since there are few apps
doing write journaling or heavy writes, and there's normally no
contigous read happening in the background. Desktop just needs a
temporary peak read max bandwidth when you click on openoffice or
similar app (and "as" provides it). But on a mixed server doing some
significant read and write (i.e.  somebody downloading the kernel from
kernel.org and installing it on some application server) I don't think
"as" is general purpose enough. Another example is the multiuser usage
with one user reading a big mbox folder in mutt, whole the other user
s exiting mutt at the same time. The one exiting will pratically have to
wait the first user to finish its read I/O. All I/O becomes sync when it
exceeds the max size of the writeback cache.

"as" is clearly the best for the common case of the very desktop usage
(i.e. machine 99.9% idle and without any I/O except when starting an app
or saving a file, and the user noticing delay only while waiting the
window to open up after he clicked the button).  But I believe cfq is
better for a general purpose usage where we cannot assume how the kernel
will be used.
