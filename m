Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWFUQo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWFUQo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWFUQo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:44:27 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:48591 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932260AbWFUQo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:44:26 -0400
Date: Wed, 21 Jun 2006 18:44:25 +0200
From: Andreas Mohr <andim2@users.sourceforge.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: andi@lisas.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, hal@lists.freedesktop.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner underruns, USB HDD hard resets)
Message-ID: <20060621164425.GB22736@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
References: <20060621093348.GA13143@rhlx01.fht-esslingen.de> <Pine.LNX.4.44L0.0606211158030.6700-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606211158030.6700-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 21, 2006 at 12:15:08PM -0400, Alan Stern wrote:
> On Wed, 21 Jun 2006, Andreas Mohr wrote:
> > - TEST_UNIT_READY
> > - TEST_UNIT_READY
> > - READ_TOC (failure?)
> 
> I don't know why this failed.  Maybe the disc didn't have a valid Table of 
> Contents.

Ah, silly me, I should have stated that this was a simulation burn on an
otherwise rather blank disc ;)


> > - WRITE_10 (ok!)
> > - ALLOW_MEDIUM_REMOVAL (ok!)
> > - WRITE_10 (*** FAILURE! ***)
> > - going downhill from here...
> > 
> > 
> > So what could be the problem here?
> > READ_TOC might be it, but then it might be fully ok to have it fail
> > (after all it's non-valid data content), so ALLOW_MEDIUM_REMOVAL would be the
> > problem then? (next WRITE_10 FAILS!).
> 
> It sure does look like the ALLOW_MEDIUM_REMOVAL is the cause of the 
> problem.

Yup, already was quite sure of that after having written the previous mail.

I'll try to verify this by simply removing all ALLOW_MEDIUM_REMOVAL calls ;)


> > I could be totally wrong, though, since I don't have much storage debugging
> > experience.
> > 
> > 
> > A good idea would be to further check whether it's the open() or the close()
> > which disrupts burning for me.
> 
> Yep.  The ALLOW_MEDIUM_REMOVAL occurs as part of handling the close().  
> And you can understand a CD drive not wanting to carry out a long write 
> when the door is unlocked.
> 
> The real problem seems to be that the device is reachable in two different 
> ways, and they don't implement proper mutual exclusion.  HAL (or your test 
> program) is undoubtedly using /dev/sr0 or something similar, whereas 
> cdrecord uses /dev/sg0.  Going through two different drivers, it's no 
> surprise they wind up interfering with each other.

HAL is /dev/host0/.../cd
cdrecord is -dev=0,0,0 (whatever Linux device file this translates into)
or a similar device ID as returned by -scanbus.


Probably (stating the obvious here, I'm afraid) we should only send
non-ALLOW_MEDIUM_REMOVAL for the *very first* device open,
and then send ALLOW_MEDIUM_REMOVAL after the *very last* device close only.

So you think that with sr and sg drivers both talking to the device,
proper inter-driver device tracking is not doable or quite difficult
to implement?


> Unfortunately I can't debug this without seeing the start of the oops 
> message.

[OOPS output of a *different* issue]

Right, it's a rather incomplete OOPS. Let me try to get one with a nice
long-line VGA mode soon...

Thanks!

Andreas Mohr
