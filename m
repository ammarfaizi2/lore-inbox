Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271210AbTHLXGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 19:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271214AbTHLXGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 19:06:49 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:27113 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S271210AbTHLXGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 19:06:46 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 13 Aug 2003 09:05:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16185.29398.80225.875488@gargle.gargle.HOWL>
Cc: Tupshin Harper <tupshin@tupshin.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
In-Reply-To: message from Andrew Morton on Tuesday August 12
References: <3F3951F1.9040605@tupshin.com>
	<20030812142846.46eacc48.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 12, akpm@osdl.org wrote:
> Tupshin Harper <tupshin@tupshin.com> wrote:
> >
> > raid0_make_request bug: can't convert block across chunks or bigger than 
> > 8k 12436792 8
> 
> There is a fix for this at
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm1/broken-out/bio-too-big-fix.patch
> 
> Results of testing are always appreciated...

I don't think this will help.  It is a different problem.

As far as I can tell, the problem is that dm doesn't honour the
merge_bvec_fn of the underlying device (neither does md for that
matter).
I think it does honour the max_sectors restriction, so it will only
allow a request as big as one chunk, but it will allow such a requests
to span a chunk boundary.

Probably the simplest solution to this is to put in calls to
bio_split, which will need to be strengthed to handle multi-page bios.

The policy would be:
  "a client of a block device *should* honour the various bio size 
   restrictions, and may suffer performance loss if it doesn't;
   a block device driver *must* handle any bio it is passed, and may
   call bio_split to help out".

A better solution, which is too much for 2.6.0, is to have a cleaner
interface wherein the client of the block device uses a two-stage
process to submit requests.
Firstly it says:
  I want to do IO at this location, what is the max number of sectors
  allowed?
Then it adds pages to the bio upto that limit. 
Finally it say
  OK, here is the request.

The first and final stages have to be properly paired so that a
device knows if there are any pending requests and can hold-off any
device reconfiguration until all pending requests have completed.

NeilBrown
