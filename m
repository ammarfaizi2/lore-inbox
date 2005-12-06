Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVLFBSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVLFBSi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVLFBSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:18:38 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:11673 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S964894AbVLFBSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:18:37 -0500
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200512052328.01999.rjw@sisk.pl>
References: <20051205081935.GI22168@hexapodia.org>
	 <20051205121728.GF5509@elf.ucw.cz>
	 <1133791084.3872.53.camel@laptop.cunninghams>
	 <200512052328.01999.rjw@sisk.pl>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133831242.6360.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 06 Dec 2005 11:07:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-12-06 at 08:28, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 5 December 2005 14:58, Nigel Cunningham wrote:
> > On Mon, 2005-12-05 at 22:17, Pavel Machek wrote:
> > > > On recent kernels such as 2.6.14-rc2-mm1, a swsusp of my laptop (1.25
> > > > GB, P4M 1.4 GHz) was a pretty fast process; freeing memory took about 3
> > > > seconds or less, and writing out the swap image took less than 5
> > > > seconds, so within 15 seconds of running my suspend script power was
> > > > off.
> > > 
> > > So suspend took 15 second, and boot another 5 to read the image + 20
> > > first time desktops are switched. ... ~40 second total.
> > 
> > Plus what is mentioned in the next paragraph.
> 
> Indeed.  Yet, the point has been made and backed up with some numbers:
> There's at least one swsusp user (Andy) who would apparently _prefer_ if more
> memory were freed during suspend.  The reason is the amount of
> RAM in the Andy's box.
> 
> }-- snip --{ 
> > > * and of course you can apply one very big patch and do all of the
> > > above :-).
> > 
> > Could you stop being nasty, please?
> > 
> > Yes, suspend2 is bigger, but let's keep things in perspective. Including
> > comments and so on, it's about 12000 lines. fs/ext3 contains 15000 lines
> > and fs/xfs is just below 115000 lines. For those 12000 lines you get a
> > clean internal api, support for compression, encryption, swap
> > partitions, swap files and ordinary files. You get asynchronous I/O and
> > read ahead where I/O needs to be synchronous. You get saving a full
> > image of memory and support for a nice user interface (mostly in
> > userspace). It's not 12000 lines of bloat, but real functionality that
> > people are using right now.
> 
> Let me say I think you're doing a great job with maintaining suspend2.
> It looks like a really difficult thing to do, particularly in recent times.
> Moreover, you have solved many very difficult problems and I respect
> that very much.  Still, I don't agree with some points you are making.
> 
> First, I don't think that saving a full image of memory is generally a good
> idea.  It is - for systems with relatively small RAM, but for systems with
> more than, say, 512 MB that's questionable.  Of course that depends a lot
> on the usage patterns of particular system, but having 768 MB of RAM
> in my box I wouldn't like it to save more than a half of it during suspend,
> for performance reasons.

I agree that whether it's a good idea varies according to individual
tastes and usage. That's why I've made it configurable. The other point
to remember is that suspend2's I/O performance is much better. My
desktop here at work, for example, writes the image at 72MB/s and reads
it back at 116MB/s. (3GHz P4 with a Maxtor 6Y120L0). Writing 1GB at
these rates is not a problem.

> Second, IMHO, some things you are doing in suspend2, like image encryption,
> or accessing ordinary files, should not be implemented in the kernel.

Image encryption is just done using cryptoapi - I just expose the
parameters and optionally save them in the image; there's no nous in
suspend2 regarding encryption beyond that.

Regarding accessing ordinary files, it's really just a variation on the
swapwriter in that we bmap the storage and then use the blocks we're
given. There were two reasons for adding this - first removing the
dependency on available swapspace, and secondly working towards better
support for embedded (write the image to a file and include the file in
place of a ramdisk image). The second reason might sound like fluff, but
I can assure you as an embedded developer myself that embedded people
are really interested in seeing if this technique will be a viable way
of speeding up boot times.

> That said, I think at least some of the functionalities you have already
> implemented in suspend2 are needed and generally can be shared between
> your code and swsusp.  I've been going to look for such possibilities for some
> time, but unfortunately, in its downloadable form, your patch is
> quite difficult to follow, so if you have a version that is organized in a more
> functionality-oriented way, could you please point me to it?

I'm working toward getting a git tree prepared, but it's taking quite a
while because I've been doing cleanups and so on at the same time. I
believe I've finally run out of new functionality to add (thankfully!),
so I'm now concentrating on bug blatting and on finishing off the git
tree preparation. I'm doing this all mostly in spare time though, so I'm
sorry but it's not ready yet. I could give you the collection of patches
as I have it at the moment, but it's being modified heavily pretty
constantly.

Regards,

Nigel

