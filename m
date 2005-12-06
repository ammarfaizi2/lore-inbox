Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVLFCMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVLFCMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVLFCMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:12:13 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:17123 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S964921AbVLFCMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:12:12 -0500
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051206013759.GI1770@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org>
	 <20051205121728.GF5509@elf.ucw.cz>
	 <1133791084.3872.53.camel@laptop.cunninghams>
	 <200512052328.01999.rjw@sisk.pl> <1133831242.6360.15.camel@localhost>
	 <20051206013759.GI1770@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133834576.3896.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 06 Dec 2005 12:02:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-12-06 at 11:37, Pavel Machek wrote:
> Hi!
> 
> > > First, I don't think that saving a full image of memory is generally a good
> > > idea.  It is - for systems with relatively small RAM, but for systems with
> > > more than, say, 512 MB that's questionable.  Of course that depends a lot
> > > on the usage patterns of particular system, but having 768 MB of RAM
> > > in my box I wouldn't like it to save more than a half of it during suspend,
> > > for performance reasons.
> > 
> > I agree that whether it's a good idea varies according to individual
> > tastes and usage. That's why I've made it configurable. The other point
> > to remember is that suspend2's I/O performance is much better. My
> > desktop here at work, for example, writes the image at 72MB/s and reads
> > it back at 116MB/s. (3GHz P4 with a Maxtor 6Y120L0). Writing 1GB at
> > these rates is not a problem.
> 
> Andy reported 20MB/sec on hdparm. I do not think it is possible to
> write faster than that. And that seems about ok for notebooks, X32
> (pretty new) has:

Depending upon what speed his CPU is, he should be able to achieve close
to 40MB/s with LZF compression (assuming 50% compression and a CPU fast
enough that the disk continues to be the bottleneck).

> root@amd:~# hdparm -t /dev/hda
> 
> /dev/hda:
>  Timing buffered disk reads:  108 MB in  3.01 seconds =  35.85 MB/sec
> 
> > > Second, IMHO, some things you are doing in suspend2, like image encryption,
> > > or accessing ordinary files, should not be implemented in the kernel.
> > 
> > Image encryption is just done using cryptoapi - I just expose the
> > parameters and optionally save them in the image; there's no nous in
> > suspend2 regarding encryption beyond that.
> 
> Unfortunately all these "small things" add up.

But so does doing it from userspace - you then have to make the pages
available to the userspace program, implement encryption there, provide
safety nets in case userspace dies unexpectedly and so on. There is a
cost to encryption that occurs regardless of where we do the
compressing.

> > Regarding accessing ordinary files, it's really just a variation on the
> > swapwriter in that we bmap the storage and then use the blocks we're
> > given. There were two reasons for adding this - first removing the
> > dependency on available swapspace, and secondly working towards better
> > support for embedded (write the image to a file and include the file in
> > place of a ramdisk image). The second reason might sound like fluff, but
> > I can assure you as an embedded developer myself that embedded people
> > are really interested in seeing if this technique will be a viable way
> > of speeding up boot times.
> 
> Interesting use, but for embedded app, they can just reserve partition
> as well. [I have seen some patches doing that.]

For swap?

Regards,

Nigel


