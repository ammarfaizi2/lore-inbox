Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTLOPy0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTLOPy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:54:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28847 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263788AbTLOPyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:54:23 -0500
Message-ID: <3FDDD923.30509@pobox.com>
Date: Mon, 15 Dec 2003 10:54:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Toad <toad@amphibian.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11,
 reading an apparently duff DVD-R
References: <20031215135802.GA4332@amphibian.dyndns.org> <Pine.LNX.4.58.0312150715410.1488@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312150715410.1488@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 15 Dec 2003, Toad wrote:
> 
>>I got the following when trying to mount a particular DVD-R on Linux
>>2.6.0-test11, using an IDE DVD-RW drive, using SCSI emulation, with the
>>preempt kernel option enabled, and taskfile I/O:
>>(the middle bit was repeated several times):
> 
> 
> ide-scsi does
> 
>         spin_lock_irqsave(&ide_lock, flags);
>         while (HWGROUP(drive)->handler) {
>                 HWGROUP(drive)->handler = NULL;
>                 schedule_timeout(1);
>         }
> 
> which is obvious crap. Scheduling while holding a spinlock is not a good
> idea.
> 
> You could try dropping the lock over the schedule and re-aquire it
> afterwards, but the comment tries to say that it is required for avoiding
> new requests.
> 
> This is why ide-scsi needs a maintainer, btw - somebody who cares about
> it, and actually tries to resolve the current mess.


Pardon me for asking a dumb and possibly impertinent question, but why 
keep it around at all?

In 2.6 it just seems like it's causing more problems than it's worth.  I 
mean, replacing ide-scsi with a simple 4-line driver would suffice...

int init_module(void)
{
	printk(KERN_INFO "fix your app to use SG_IO\n");
}

Since the major app, cdrecord, has already been fixed, that just leaves 
a few IMO minor apps out there that (a) should be using SG IO and (b) 
are depending on an unmaintained and perpetually broken driver anyway.

	Jeff


P.S. Yes, libata will probably (not definite) use the SCSI layer to 
drive ATAPI devices... but that's a long way off, and will not be using 
the ide-scsi code.  ide-scsi is basically a glue driver specifically for 
drivers/ide.

