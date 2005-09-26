Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVIZLUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVIZLUh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 07:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVIZLUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 07:20:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22465 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751227AbVIZLUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 07:20:36 -0400
Date: Mon, 26 Sep 2005 13:20:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3][Fix] swsusp: prevent swsusp from failing if there's too many pagedir pages
Message-ID: <20050926112022.GD3554@elf.ucw.cz>
References: <200509252018.36867.rjw@sisk.pl> <200509252044.00928.rjw@sisk.pl> <20050926103336.GA3693@elf.ucw.cz> <200509261311.29269.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509261311.29269.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Lets see...
> > 
> > for i386, we have 768 pagedir entries. Each pagedir entry points to
> > page with 1023 pointers to pages. That means that up-to 768*1023*4096
> > bytes image can be saved to swap ~= 768 * 1K * 4K ~= 3 GB. That's more
> > than enough for i386.
> > 
> > for x86-64, we can have 128 pagedir entries (could not we fit more
> > there? 384 entries should fit, no?).
> 
> Yes.  To be exact, 460.
> 
> > Each pagedir entry has 511 pointers to pages (IIRC)...
> 
> 512, I think.

Okay, can we do simple solution where we put 460 there, plus a check
if it overflows (printk, abort suspend), for now? That should fix
768MB machine...

> > that is up-to 128*511*4K ~= 64*1K*4K = 256 MB image.
> > Hmm, that should still be enough for any 512MB machine, and 
> > probably okay for much bigger machines, too...
> > 
> > We can still get to 768 MB image (good enough for any 1.5GB machine,
> > and probably for anything else, too).
> > 
> > If that is not good enough for you, can you simply allocate more than
> > 1 page for swsusp_info? No need for linklists yet.
> 
> I can.  The problem is I have to track the swap offsets of these pages
> which is necessary for resume.  Is it guaranteed that the swap offsets
> of pages allocated in a row will be consecutive?

No, they probably will not be consecutive.

OTOH pagedirs are stored as a link list in memory already. Maybe we
should be able to extend that link list for a disk, too, with minimal
fuss? ...we'd have to write pagedir _backwards_ for that to work,
probably not nice, and swap_free() would really like direct access.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
