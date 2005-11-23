Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVKWSCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVKWSCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVKWSCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:02:34 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:15156 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932123AbVKWSCc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:02:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cIXjUhRAMsps3sMvCfeJiyFqlcs/annFp8IAI3ISYSOFrXAcJWsYYZKTkJ76MrEnLQCL3XZ8B6TjiSu+bog7OcnJ23rULSJ22UsIapk0nNzE87RVXIKs8yMvQhWtXxwJI/v7Y/YcCCgyhoPPxWHFYAsp8GxAgFu161OkecUfxxg=
Message-ID: <35fb2e590511231002q65b12280t2e1b8b65e72e7aba@mail.gmail.com>
Date: Wed, 23 Nov 2005 18:02:31 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: 7eggert@gmx.de
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct ..."
Cc: Andrew Morton <akpm@osdl.org>, cp@absolutedigital.net,
       linux-kernel@vger.kernel.org, jcm@jonmasters.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@lst.de
In-Reply-To: <E1Eeyae-00012o-CV@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <59olg-7rC-3@gated-at.bofh.it> <59rsT-3Co-27@gated-at.bofh.it>
	 <5arTK-5Wu-1@gated-at.bofh.it> <5bAW4-8wm-19@gated-at.bofh.it>
	 <5bEYO-6oH-15@gated-at.bofh.it> <5bOEG-5jk-19@gated-at.bofh.it>
	 <5bUK2-61i-5@gated-at.bofh.it> <E1Eeyae-00012o-CV@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Jon Masters <jonmasters@gmail.com> wrote:
> > On 11/22/05, Andrew Morton <akpm@osdl.org> wrote:
>
> >> In the meanwhile I think we should revert back to the 2.6.14 version of
> >> floppy.c - the present problem is probably worse than the one which it
> >> kinda-fixes.
> >
> > Ok, as you please. It's probably going to take something much more
> > ugly to make this work with things as they stand - I'll get something
> > out at the weekend.
>
> I think it should be a general solution to flipped CP switches on floppies
> and USB sticks as well as network block devices on a fs that got remounted
> ro or hdparm -W.

Yes. We talked about this before and I even started proposing ideas,
but nobody was interested in more disruptive changes to the block
layer - I'm quite happy to do it.

> The device needs a WP status that gets updated on open or mount (must
> complete before open()/mount() completes),

Yes. In fact I thought about the floppy case some more yesterday and
realised that we can have it do the expensive check only in the case
that we want to open to write, read paths are then still cheap but we
check the media in the write case - this isn't as generic as I want.
It seems to me that this is a whole class of problem that needs a
higher solution and I did propose a callback approach so we can tell
Linux that the media WP state changed.

> on failed write()s iff the write failed because of write protection error and whenever
> checking is cheap.

Which is basically what I said before. But then, I also sent a patch
to rename policy sanely and would like to introduce wrapper macros for
all of this too.

> If the check can't be done sanely on open() calls (as in the case of NBD),
> asume it to be RW enabled unless we know otherwise (e.g. the user told us).

No. That's dangerous and gets us back into the same position. We want
to do the checks according to what kind of open we are trying to do,
in the worse case. Still, we need to handle non-blocking open but
that's the user's problem - they asked for it.

> (re)mounts should allways enforce the check as long as it's possible.
> The filesystems will need to get updated to use this status as well and
> remount themselves ro (or do a panic/reboot, if desired).

As viro said, just randomly changing the media status isn't easy. But
in the case that we changed the media to RO then the higher layers
aren't going to be able to write anyway so we /should/ do an remount
ro anyway. The whole problem comes because Linux blindly relies on the
read/write state of the block device and not of the underlying media.

> This will still misbehave, but I think it will misbehave in a sane way. You
> may get a rw mount on ro devices in corner cases, but you can't keep it.

Yes, but right not it still fails "silently" and possibly results in
data loss. The way to fix this is to have a nice shiney way to inform
Linux of this.

Ok. I'm too busy to spend much time during the week on this right now
but I will set aside some time over the weekend to split out what I
proposed before and send a few patches which implement what we've been
talking about.

Cheers,

Jon.
