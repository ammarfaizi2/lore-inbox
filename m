Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTDTWXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 18:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbTDTWXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 18:23:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64171 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263740AbTDTWXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 18:23:07 -0400
Date: Sun, 20 Apr 2003 23:35:08 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andries.Brouwer@cwi.nl
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [CFT] more kdev_t-ectomy
Message-ID: <20030420223508.GK10374@parcelfarce.linux.theplanet.co.uk>
References: <UTC200304202158.h3KLwIu10935.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200304202158.h3KLwIu10935.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 20, 2003 at 11:58:18PM +0200, Andries.Brouwer@cwi.nl wrote:
 
> [Now that we are talking anyway, let me ask about something.
> You wrote blk_register_region so that subregions override
> superregions. At the bottom there is the full region.
> Was this just a general good idea, or do you have definite
> applications in mind? I ask this mostly because the hash

A lot of them.  Consider, e.g., ide code.  Or any other driver with
subdrivers - anything that can't be just done by blind "here's device
number, that's enough to know what should be loaded".

In case of ide we have regions corresponding to hwifs (== IDE cables)
and each of them can carry up to two devices.  We can see that 22:43
is to be handled by IDE, no problems with that.  But then we get to
decide whether it's ide-disk or ide-cd or ide-floppy.  IDE code knows
what is needed - it had probed devices already and it knows that
master on that cable is a disk.  So attempt to open that sucker
should refer to IDE code, which, in turn, should know that we need
to load a high-level driver (ide-disk.o).  After that we have a
normal range (64 numbers) for master.  But not necessary for slave -
if it is an ide-cd, we still might have no driver loaded.

We could play splitting these ranges and merging them (i.e. original range
shrinks and subrange is added as the first-level one), but that gets very
nasty when you try to get it right (you need to merge these suckers during
cleanup, etc.)
 
> and that is OK for regions with constant major.
> For multimajor regions a hash does not work very well, and
> a tree looks better.]

Tree certainly looks better.  I'd played with route cache code (after
all, that's exactly the same problem), but it looked like an overkill.
I'm porting genhd.c code for character devices, if that will show up
in profiles we'll always be able to optimize that stuff.  It is fairly
isolated, so changes of lookup data structures should not affect anything
else.
