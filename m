Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbUAEQJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 11:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbUAEQJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 11:09:56 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40616 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264415AbUAEQJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 11:09:51 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Christophe Saout <christophe@saout.de>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Mon, 5 Jan 2004 17:12:41 +0100
User-Agent: KMail/1.5.4
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401032302.32914.bzolnier@elka.pw.edu.pl> <1073237458.6069.31.camel@leto.cs.pocnet.net>
In-Reply-To: <1073237458.6069.31.camel@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401051712.41695.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 of January 2004 18:30, Christophe Saout wrote:
> Am Sa, den 03.01.2004 schrieb Bartlomiej Zolnierkiewicz um 23:02:
> > > The way I would prefer is that when someone calls bio_endio the bi_idx
> > > and bv_offset just point where the processed data begins.
> >
> > Are you aware that this will make partial completions illegal?
> > [ No problem for me. ]
>
> Why that? __end_that_request_first already does this (when moving thw
> two lines updating bv_offset/bv_len after the call of the bi_end_io
> function).

Looking once again, I see it is OK.

> > > Can't another (some local) variable be used as bvec index instead of
> > > bi_idx in the original bio? (except from ide_map_buffer using exactly
> > > this index...)
> >
> > see rq_map_buffer() in include/linux/blkdev.h
>
> Right. I've been going through ide-taskfile.c for the last hours.
>
> The IDE_TASKFILE_IO gets things right (from my point of view) and is
> also much cleaner. (I would personally vote for dropping the non
> TASKFILE_IO code, it would make my problem go away :D - why is it still
> marked as experimental BTW? I've been using it since it was introduced,
> without any problems)

There are still some issues to be resolved:
- hangs during reading /proc/ide/<cdrom>/identify on some drives
  (workaround is now known thanks to debugging done by Andi+BenH+Andre)
- unexplained fs corruption on x86-64 with AMD IDE chipsets
  (the real showstopper)
- somebody needs to test taskfile code on old Promise PDC4030 controller
  (low priority)

> BTW: The taskfile code that is used when IDE_TASKFILE_IO is disabled
> might partially end requests without knowing the actual status, right?

Right.

> So non TASKFILE_IO code has two multout codepaths (taskfile and not)
> that are both "awkward" while TASKFILE_IO merges both into a single and
> clean version.

Yes.

> > > Would you be interested in a small patch (well, if I can come up with
> > > one)?
> >
> > Sure, but I don't know what you want to change... :-)
>
> I'm not yet sure, either. I don't think that a too invasive version
> would be adequate though converting this mess to the cbio method would
> be nice. Or would you prefer to see that? I don't think it's worth
> starting on that since you said you'de like to see this part of the IDE
> layer die in 2.7 anyway. I would really like to see ide_map_buffer die
> in favor of rq_map_buffer though. Hmm.
> Perhaps I can think of something else. It's really tricky...

I would like to remove non CONFIG_IDE_TASKFILE_IO paths in 2.6.x
(after issues are resolved) instead of trying to fix them.

--bart

