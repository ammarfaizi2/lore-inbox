Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTDXUim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTDXUim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:38:42 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:61888 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263452AbTDXUij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:38:39 -0400
Date: Thu, 24 Apr 2003 22:48:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@digeo.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>, cat@zip.com.au,
       mbligh@aracnet.com, gigerstyle@gmx.ch, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424204805.GA379@elf.ucw.cz>
References: <1051143408.4305.15.camel@laptop-linux> <20030423173720.6cc5ee50.akpm@digeo.com> <20030424091236.GA3039@elf.ucw.cz> <20030424022505.5b22eeed.akpm@digeo.com> <20030424093534.GB3084@elf.ucw.cz> <20030424024613.053fbdb9.akpm@digeo.com> <1051182797.2250.10.camel@laptop-linux> <20030424043637.71c3812e.akpm@digeo.com> <20030424142632.GB229@elf.ucw.cz> <20030424103734.O26054@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424103734.O26054@schatzie.adilger.int>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > > Sorry, I still don't get it.  Go through the steps for me:
> > > > > > > 
> > > > > > > 1) suspend writes pages to disk
> > > > > > > 
> > > > > > > 2) machine is shutdown
> > > > > > > 
> > > > > > > 3) restart, journal replay
> > > > 
> > > > Corruption comes here. The journal reply tidies things up that shouldn't
> > > > be tidied up. They shouldn't be tidied up because once we reload the
> > > > image, things should be in the same state as prior to suspend. If replay
> > > > frees a block (thinking it wasn't properly linked or something similar),
> > > > it introduces corruption.
> > > 
> > > No, this will not happen.  All swapfile blocks must be allocated by swapon
> > > time.  It is just a chunk of disk and replay will not touch it.
> > > 
> > > That's for ext3, and no other filesystems journal data anyway...
> > 
> > Its not about data.
> > 
> > Corruption is not in suspended image. Imagine you have running system
> > (X open, applications running, gcc compiling) and someone runs journal
> > replay. Bye bye data. And that's what happens there. When you restore,
> > restored kernel no longer knows you did replay.
> 
> Wouldn't that be true in all cases where you have a journaled filesystem
> and you suspend?  

No. In normal state you restore without mounting anything (thus no
journal replay).

> Are you talking about someone restarting system (without
> doing a resume), mounting the file system (causing journal replay), and
> then shutting down and going back to the suspended image?

No, I'm not.

> I think the important thing to note is that if you don't unmount the
> filesystem during suspend, then no journal recovery will take place
> at resume time, because you are not really mounting the filesystem
> at all.  And I can't see how you could be unmounting the filesystems
> without killing all of the applications, at which point it would make
> suspend pretty useless.

No, I'm not unmounting it.

> What is also important to note is that during normal filesystem operation,
> the ext3 journaling code never reads back any data from the journal, with
> the exception of a couple of fields in the journal superblock.  I would
> hazard a guess that if you did a suspend, wiped the journal, and then
> resumed the journaling code wouldn't know the difference.

That's possible, but I do not want suspend to know about filesystem
specifics.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
