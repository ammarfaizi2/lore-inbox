Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWALR3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWALR3X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWALR3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:29:22 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:48914 "EHLO
	smtp-vbr3.xs4all.nl") by vger.kernel.org with ESMTP id S932376AbWALR3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:29:21 -0500
Date: Thu, 12 Jan 2006 18:29:00 +0100
From: Jurriaan on adsl-gate <thunder7@xs4all.nl>
To: Neil Brown <neilb@suse.de>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm3 hangs during boot (raid related?)
Message-ID: <20060112172900.GA3687@gates.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20060112062310.GA12471@gates.of.nowhere> <17349.63738.220760.681335@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17349.63738.220760.681335@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Brown <neilb@suse.de>
Date: Thu, Jan 12, 2006 at 05:36:42PM +1100
Sent-To: 
> On Thursday January 12, thunder7@xs4all.nl wrote:
> > 
> > 2.6.15-mm3 hangs during boot for me, after the lines
> > 
> > ========
> > md4: bitmap initialized from disk: read 15/15 pages, set 51 bits, status: 0
> > created bitmap (224 pages) for device md4
> > ========
> > 
> > ctrl-alt-del to reboot works sometimes (2 out of 3). Below is complete
> > dmesg (from 2.6.15-mm2, ver_linux output, .config and raid details).
> 
> Yep, this is probably a known problem with recent changes to the
> 'barrier' code.
> 
> Try to convince md not to use barrier by changing md_super_write in
> drivers/md/md.c.  Simply remove
> 
> 	if (!test_bit(BarriersNotsupp, &rdev->flags)) {
> 		struct bio *rbio;
> 		rw |= (1<<BIO_RW_BARRIER);
> 		rbio = bio_clone(bio, GFP_NOIO);
> 		rbio->bi_private = bio;
> 		rbio->bi_end_io = super_written_barrier;
> 		submit_bio(rw, rbio);
> 	} else
> 
> leaving the
> 		submit_bio(rw, rbio);
> 
> which comes after it.
> 
With this patch, it boots and works just fine.

Kind regards,
Jurriaan
-- 
His pride could withstand anything. He simply wouldn't care.
	Melanie Rawn - Skybowl
Debian (Unstable) GNU/Linux 2.6.15-mm3 2x4802 bogomips 0.31
