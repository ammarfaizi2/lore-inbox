Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTDUSup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTDUSt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:49:57 -0400
Received: from air-2.osdl.org ([65.172.181.6]:26271 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261896AbTDUSs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:48:58 -0400
Date: Mon, 21 Apr 2003 12:01:11 -0700
From: Dave Olien <dmo@osdl.org>
To: Christoph Hellwig <hch@infradead.org>, marcelo@conectiva.com.br,
       alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DAC960 open with O_NONBLOCK
Message-ID: <20030421190111.GA27126@osdl.org>
References: <20030421172402.GA26863@osdl.org> <20030421183752.A8782@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421183752.A8782@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 06:37:52PM +0100, Christoph Hellwig wrote:
> 
> I just went over the same code in 2.5 - the reference counts are
> entirely superflous, you can just nuke them.

Yup, that was the plan.

> 
> > I don't like this "special file descriptor" method.  I would have much
> > rather created an entry in /proc or something to support these pass through
> > commands.  But I imagine there are applications out there that expect
> > these special file descriptors.  On the other hand, this HAS been
> > broken throught the life on linux 2.4.
> 
> What applications?

John Kamp has run across a libhd applcation from Suse that hit this bug.
It's some kind of hardware detection application.  It opens devices with
O_NONBLOCK.  But, it doesn't in fact use the DAC960 pass-through commands.

The Mylex web page has a RAID management application for DAC960 on Linux that
is available only in BINARY form.  Unfortunately, it requires
a Windows front-end to provide a GUI.  So, I haven't actually experimented
with it. If any application uses the pass-through commands, this would likely
be it.  But since no one has complained about this being broken, it may
indicate no one is using this application.

Or, maybe the application is just not being used in a way that triggers
this bug.

I'm reluctant to just eliminate the behavior because of that.

> 
> > I'll be submitting a similar patch to linux 2.5 shortly.
> 
> Don't even bother.  Linux 2.5 is the place to fix this issue
> correctly.

It would be nice to just eliminate the O_NONBLOCK sillines from the
open(), ioctl(), and release() methods.

The pass-through behavior could be made available either through
a /proc or a sysfs file.

The difficulty is that the Mylex application is available only in binary
form.  Mylex is very secretive about its controller commands.
It would be nice to be able to create a library that an application
could call to perform high-level operations, and the library would
construct the pass-through commands and pass them to the driver.
Then, anyone could write their own GUI.

A related question, why does linux 2.5 continue to have a "struct file *"
argument to driver release methods? As far as I can tell, that argument
is always NULL?

