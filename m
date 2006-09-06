Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWIFGxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWIFGxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 02:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWIFGxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 02:53:33 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:7002 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751249AbWIFGxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 02:53:32 -0400
Message-ID: <44FE7067.9070700@tls.msk.ru>
Date: Wed, 06 Sep 2006 10:53:27 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Raid 0 Swap?
References: <44FB5AAD.7020307@perkel.com> <44FBD08A.1080600@tls.msk.ru> <44FE0BDE.40309@tmr.com>
In-Reply-To: <44FE0BDE.40309@tmr.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Michael Tokarev wrote:
>> Marc Perkel wrote:
>>> If I have two drives and I want swap to be fast if I allocate swap spam
>>> on both drives does it break up the load between them? Or would it run
>>> faster if I did a Raid 0 swap?
>>
>> Don't do that - swap on raid0.  Don't do that.  Unless you don't care
>> about your data, ofcourse.  Seriously.
> 
> Please don't spread FUD. Particularly when there are valid technical
> arguments to be made. RAID0 does increase the chance of any error, but
> it is still a very small chance. With drive failures measured in years,
> it's misleading to make it sound as if going RAID0 will result in a
> rapid failure.

It's not FUD, unfortunately.  It's real life.

We had about 70 systems with swap on raid0 (not even raid0, but using
several swap partitions with equal priority, but it makes almost no real
difference).  And in a year, 5 or 6 of them failed in a way which
required major recovery efforts each, exactly due to this swap-on-raid0
thing. That is, from 2*70=140 disk drives, 5 failed in a year.

Yes, maybe, we just had a bad luck and used somehow defected batch of
drives.  Yes, for an average home machine with only two drives you've
less chance of failure than one in 140.  But it's still not something
to ignore, thinking "it's still very small chance".

>> If something with swap space goes wrong, God only knows what will break.
> 
> The same thing that will go wrong if your one and only swap drive goes
> bad. You get a disk error, the kernel copes with it well or badly, the
> system grinds to a halt or crashes. Flames do not come out and your cat
> will NOT get pregnant (at least from swap failure).

Yes.  Well, flames did come once, but cats, indeed, didn't become pregnant
due to swap issues.

>> It is trivial to break userspace data this way, when an app is swapped
>> out and there's an error reading it from swap, its data file very likely
>> to be corrupt, especially when it is interrupted during file update.
>> It is probably possible to corrupt the whole filesystem this way too,
>> when some kernel memory has been swapped out and is needed to write some
>> parts of filesystem, but it can't be read back.
> 
> More FUD.

Which is?

It all depends on the application, and on the "place" where the failure
has been encountered.  There are bad apps out there, and there are bad
places to interrupt them.  In about 15 years we had plenty of examples
of e.g. corrupted m$ office files, some of them was due to swap problems
too (but it's difficult to say for sure what was actual prob; at least,
when system shows blue screen and we trying to repair the drive, disk
test shows errors in swap area; and at this time, the document which
was open during crash becomes corrupt.  I dislike windows, I don't
use it last several years, but it still serves as an example)

Yes, if you have single drive, it's mostly irrelevant whenever it will
be swap who dies or your data partition (or whole drive) - data will
be corrupt somehow, or will be not.  But when we're talking about
several drives, most likely the data is on raid1 (or raid5, 6, 10...),
so is protected better.

Speaking of kernel space, again, I had at least single example when
bad swap resulted in corrupt filesystem.  It was quite some time
ago, with linux-2.2, and squid cache.  The system was alive but any
access to the squid FS resulted in hanging process.  After forced
reboot the fs was in quite bad state, alot of lost+found entries
(some of which where files with old timestamps), whole directories
lost (squid does not create/delete directories at will), and many
other errors during fsck, some of which it wasn't able to fix.
I don't remember details already, as it was quite some time ago.
And according to the logs, problematic place on disk was in swap
area, not elsewhere.  I can't be sure what exactly caused this
corruption, whenever it's still possible with nowadays kernels,
but I don't really care - one trivial lesson I learned is not
to use raid0 for swap, that's all, that's trivial to accomplish,
and that costs nothing.

The point was that it's unreasonable thing to have swap on raid0 IF
you care about protecting your data.  Especially since swap usage
should generally be reduced to a minimum where you don't really
care how fast it is.

Especially with modern drives, reliability of which, it seems,
decreases - I mean, error rate per megabyte stays almost the
same, but amount of those megabytes increases rapidly ;)
[]
> Final note: if you are building a really reliable system, PAID6 on all
> data, redundant power supplies (the highest point of total failure),
> then you should go to RAID0 for swap, on multiple controllers,
> preferably one drives in different enclosures. RAID6 for swap sucks
> rocks off the bottom of the ocean, three way RAID1 performs well even
> after a one drive failure.

Well, it's arguable which raid levels to use for data (eg, for database
workloads, with concurrent direct writes, it's better to use raid10
because of the cost to calculate parity).

But raid0 for swap - again? - no, no thank you ;)  You probably mistyped
0 for 1 above, or else I don't understand the whole last statement ;)

By the way, there are at least two types of drive failure.  When a single
sector becomes unreadable (media failure), and when the whole device
fails for some reason.  It turns out both types of failure occurs on
a regular basis (well, it also depends on environment, like temperature
and the like).  Yes, both aren't frequent, but it isn't something to
ignore either, if you care about your system and data.

/mjt
