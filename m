Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTEGQdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264065AbTEGQdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:33:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53199 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264060AbTEGQdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:33:40 -0400
Date: Wed, 7 May 2003 18:46:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030507164613.GN823@suse.de>
References: <20030507084920.GA823@suse.de> <Pine.LNX.4.44.0305070915470.2726-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305070915470.2726-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07 2003, Linus Torvalds wrote:
> 
> On Wed, 7 May 2003, Jens Axboe wrote:
> > 
> > I did a patch for 2.4 some weeks ago that added (what I consider) proper
> > 48-bit lba usage to ide-disk.
> 
> Ok, let me disagree a bit.
> 
> At least if I read the patch correctly, theer's no way for upper layers to
> say "I want 48-bit addressing" - it's just turned on automatically for
> high sectors (or big transfers).

Correct.

> Well, you can mark the drive itself as wanting 48-bit transfers, but
> you can't do it on a per-request basis.
> 
> And I think this is 100% equivalent to the 6 vs 10 vs 16-byte SCSI
> command issue, and I really think it should b esolved the same way.
> Namely, you should be able to (on a "struct request" level) explicitly
> say that you want the big requests, and then the default prep_fn()
> would do roughly what you do now by default.

I dunno what the purpose of that would be exactly, I guess to cater to
some hardware odditites?

> That way something like a SG_IO interface could force one mode or the
> other on a per-request basis.

Doesn't make a lot of sense in this case I think, because the command
associated with the SG_IO request would implicitly be either a 28-bit or
48-bit command based on the opcode of the request.

> Comments?

You haven't really convinced me yet. Is there some hardware out there
that requires to be addressed in 48-bit mode? If that is the case, then
yes a bit is missing to fully support that. We'd probably have a forced
addressing flag in the hwif, and the drive->addressing would inherit
that. So instead of

	const int lba48 = rq_lba48(rq);

it would be

	const int lba48 = rq_lba48(rq) || drive->addressing == FORCED_48;

(forgive the ugliness of the above construct, it's just meant to below
operation of it, rq_lba48 would probably just take both drive and rq as
parameter).

-- 
Jens Axboe

