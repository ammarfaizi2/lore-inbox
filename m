Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVLFCG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVLFCG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbVLFCG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:06:28 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:22850 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S964918AbVLFCG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:06:27 -0500
Date: Mon, 5 Dec 2005 18:06:26 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051206020626.GO22168@hexapodia.org>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <200512052328.01999.rjw@sisk.pl> <1133832773.6360.38.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133832773.6360.38.camel@localhost>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 11:36:13AM +1000, Nigel Cunningham wrote:
> > > > > On recent kernels such as 2.6.14-rc2-mm1, a swsusp of my
> > > > > laptop (1.25 GB, P4M 1.4 GHz) was a pretty fast process;
> > > > > freeing memory took about 3 seconds or less, and writing out
> > > > > the swap image took less than 5 seconds, so within 15 seconds
> > > > > of running my suspend script power was off.
> > > > 
> > > > So suspend took 15 second, and boot another 5 to read the image + 20
> > > > first time desktops are switched. ... ~40 second total.
> > > 
> > > Plus what is mentioned in the next paragraph.
> > 
> > Indeed.  Yet, the point has been made and backed up with some numbers:
> > There's at least one swsusp user (Andy) who would apparently
> > _prefer_ if more memory were freed during suspend.  The reason is
> > the amount of RAM in the Andy's box.
> 
> Perhaps I wasn't clear enough. I was arguing that if you get your prompt
> back in 40s, but the computer is still thrashing for the next minute or
> ten, you haven't really finished resuming yet.

I started this thread to complain about the increase in time from "zzz"
to "power's off" (which has increased approximately 2x to 3x in
2.6.15-rc3-mm1), but it's also relevant to consider restart time and
performance (which was the genesis of the changes in 15-rc3-mm1 IIUC).

Previous kernels (2.6.14-rc2-mm1) got me back to the prompt faster, but
at the cost of leaving most of a GB of memory unused (and forcing me to
manually page stuff in as I used it over the next half hour).

Newer kernels write and read a bigger image, which makes the prompt show
up somewhat later, but gives the benefit of putting me back in
approximately the same place I left off with regards to working set.

I would like the best of both worlds - I want my suspend to go faster
(so I want a smaller image), and I also want my working set paged back
in after resume.

I'm assuming that the difference is that with Rafael's patches, clean
pages that would have been evicted in the "freeing pages..." step are
now being written out to the swsusp image.  If so, this is a waste - no
point in having the data on disk twice.  (It would be nice to confirm
this suspicion.)

Could we rework it to avoid writing clean pages out to the swsusp image,
but keep a list of those pages and read them back in *after* having
resumed?  Maybe do the /dev/initrd ('less +/once Documentation/initrd.txt'
if you're not familiar with it) trick to make the list of pages available 
to a userland helper.

Someone suggested the 'cat `grep / /proc/*/maps`' trick.  This kills the
working set calculations that the kernel has so painstakingly built up,
reading in all kinds of pages that were flushed with good reason, and
also fails to get my Mercurial .d files back into cache, since they are
not mapped by any long-running process.

-andy
