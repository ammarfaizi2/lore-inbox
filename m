Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265524AbUABMDn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 07:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbUABMDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 07:03:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37330 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265524AbUABMDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 07:03:41 -0500
Date: Fri, 2 Jan 2004 13:03:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Hugang <hugang@soulinfo.com>
Cc: Bart Samwel <bart@samwel.tk>, Andrew Morton <akpm@osdl.org>,
       smackinlay@mail.com, Bartek Kania <mrbk@gnarf.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] laptop-mode-2.6.0 version 5
Message-ID: <20040102120327.GA19822@suse.de>
References: <20031231210756.315.qmail@mail.com> <3FF3887C.90404@samwel.tk> <20031231184830.1168b8ff.akpm@osdl.org> <3FF43BAF.7040704@samwel.tk> <3FF457C0.2040303@samwel.tk> <20040101183545.GD5523@suse.de> <20040102170234.66d6811d@localhost> <20040102112733.GA19526@suse.de> <20040102193849.6ff090da@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102193849.6ff090da@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02 2004, Hugang wrote:
> On Fri, 2 Jan 2004 12:27:33 +0100
> Jens Axboe <axboe@suse.de> wrote:
> 
> > I dunno, I can't possibly tell since you haven't given any info about
> > this crash. Where does it crash, do you have an oops? All I could say
> > from your report + patch is that it wasn't valid. There's just no way
> > for current->comm to be NULL, so your patch couldn't possibly have made
> > a difference.
> 
> Attached file is the crashed dmesg, When I disable CONFIG_LBD, the
> problem not found any more.

Ah there you go, then it's just the missing cast to u64. It has nothing
to do with current->comm at all. The compiler should have warned you
about this error, did it not?

The dump printk() needs to be changed anyways, the rw deciphering is not
correct. Something like this is more appropriate:

	if (unlikely(block_dump)) {
		char b[BDEVNAME_SIZE];

		printk("%s(%d): %s block %Lu on %s\n", current->comm,
			current->pid, (rw & WRITE) ? "WRITE" : "READ",
			(u64) bio->bi_sector, bdevname(bio->bi_bdev, b));
	}

-- 
Jens Axboe

