Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbUA0LH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 06:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbUA0LH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 06:07:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6846 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263453AbUA0LHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 06:07:23 -0500
Date: Tue, 27 Jan 2004 12:07:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MO: opening for write in cdrom.c
Message-ID: <20040127110713.GR11683@suse.de>
References: <Pine.LNX.4.44.0401261826340.1102-100000@neptune.local> <Pine.LNX.4.44.0401261900460.855-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401261900460.855-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26 2004, Pascal Schmidt wrote:
> On Mon, 26 Jan 2004, Pascal Schmidt wrote:
> 
> [short summary for l-k: this is about finding out whether an MO is 
> write-protected or not, code that is yet missing from cdrom.c]
> 
> > I'll try to implement the fallback that sd.c uses next. That code
> > tries several mode senses with different page and length.
> 
> Okay, I got it working with the exact method that sd.c uses. I've put
> a few printk's in to see where it fails a mode sense. It's actually
> inconsistent:
> 
> 	a) insert a writable disc first after boot, method 1 works
> 	b) then insert a non-writable disc once - suddenly method 1
> 	   stops working, even on writable discs, instead method 2
> 	   works
> 	c) insert a non-writable disc first after boot, method 1
> 	   never works, but method 2 does

Sounds pretty shaky...

> There's a third method in sd.c. I've also left that in since I suspect
> it might be necessary under some circumstances, too.

Probably a good idea.

> >From my testing, I get the impression that this Fujitsu drive only
> has mode page 0, meaning that only 0x00 and 0x3F make sense, and that
> mode page 0x00 also only contains very few bytes of information -
> because asking for 16 bytes from 0x3F didn't work, but 4 bytes does.
> What's weird is that asking for all pages can also stop suddenly, after
> which only page 0x00 is accessible. And when that happens, we only get
> a meaningless request sense of 00/00/00 back.
> 
> Oh well, strange hardware indeed.
> 
> Here's the patch that works for me, please consider applying and
> pushing to Linus/Andrew:

Hmm, looks a bit strange. You want write protect to be set _if_
detection works, not otherwise. If it fails, just assume that you can
write to the drive and let the normal drive rejection work fail those
(maybe even catch them and write protect then). Seeing as the method is
unreliable, we cannot solely rely on that.

-- 
Jens Axboe

