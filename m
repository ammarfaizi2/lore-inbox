Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSKCX3V>; Sun, 3 Nov 2002 18:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSKCX3V>; Sun, 3 Nov 2002 18:29:21 -0500
Received: from netrider.rowland.org ([192.131.102.5]:21777 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP
	id <S263837AbSKCX3T>; Sun, 3 Nov 2002 18:29:19 -0500
Date: Sun, 3 Nov 2002 18:35:52 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: <stern@netrider.rowland.org>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fixes for the ide-tape driver
In-Reply-To: <20021103140328.GL807@suse.de>
Message-ID: <Pine.LNX.4.33L2.0211031822200.26264-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Jens Axboe wrote:

> On Sat, Nov 02 2002, Alan Cox wrote:
> > Thanks for the 2.5 bits. For the 2.4 tree send them on to Marcelo after
> > 2.4.20 is out. You might also want to talk to Pete Zaitcev
> > <zaitcev@redhat.com> as I know he posted some fixes too recently
>
> The use of IDETAPE_RQ_CMD looks shady, at best. And idetape_do_request()
> does a direct switch() on the flags, ugh.

I agree, absolutely.  Those are the least of this driver's stylistic
infelicities.  The two things I have found to be most objectionable are:

First, the driver is a mish-mash, including code for handling OnStream
devices along with generic ATAPI devices.  In some places the specialized
code is set off with regular conditional tests, in others by pre-processor
conditionals, and in others not at all.  Willem Riede has expressed his
intention to write a different driver just for the OnStream, which I think
is a very good idea.

Second, the use of write buffering means that the driver is unable to
detect and report end-of-media or other write errors until they occur,
long after returning successfully from the corresponding system call.
Considering that tape drives are often used for backups, this lack of
proper error-reporting is not appropriate for such a mission-critical
application.  (This was a conscious decision on the part of the original
author of the driver.  There is supposed to be support for compiling it
without the write buffer, but -- presumably as a result of later changes
-- it doesn't work.)

My version of the driver is not perfect.  For example, I know (because I
have seen it happen) that the driver can hang when encountering a
faulty-media error.  All I have done is add a more-or-less minimal number
of changes that suffice to make the driver work okay on my system, and
hence presumably for other ATAPI systems as well.  It might be nice to
make larger-scale changes, but I don't have the time or the desire to do
so.

Alan Stern

