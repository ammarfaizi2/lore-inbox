Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310272AbSCLBGl>; Mon, 11 Mar 2002 20:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310280AbSCLBGe>; Mon, 11 Mar 2002 20:06:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46863 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310272AbSCLBGR>; Mon, 11 Mar 2002 20:06:17 -0500
Date: Mon, 11 Mar 2002 16:51:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.3.96.1020311185647.27404G-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.33.0203111638290.26250-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Mar 2002, Bill Davidsen wrote:
>
> I think you might want to offer an opinion (or edict, mandate, whatever)
> WRT taskfile. While I think that some protective editing of commands is
> desirable, useful, etc, I'm damn sure that some form of raw access is
> required long term to allow diagmostics. I wouldn't argue if that
> interface was required for low level format and other really drastic
> operations as well.

Quite frankly, my personal opinion is that there's no point in trying to
parse the commands too much at all. The _only_ thing the kernel should try
to care about is that the buffers passed to the command are valid (ie the
actual data in/out area pointer should be a kernel buffer as far as
possible, not under user control).

Basically, there are three "modes" of operation here:

 - regular kernel access (ie the normal read/write stuff)

   parsing: none. The kernel originated the request.

 - common ioctl's that have nothing to do with IDE per se (ie all the
   stuff to open/close/lock removable media, unlocking DVD's, reading
   sound sectors etc - stuff that really exists elsewhere too, and where
   the kernel should do the translation from the generic problem space to
   the specific commands for the bus in quesion)

   Parsing: common ioctl turning stuff into common SCSI commands in the
   "struct request".

 - totally IDE-only stuff, where the kernel simply doesn't add any value,
   and only has a way of passing it down to the drive, and passing back
   the requests.

   Parsing: none. The kernel simply doesn't have anything to do with the
   request, except to synchronize it with all other requests.

The only common factor here is the "synchronize with other requests" - I
feel strongly (much more strongly than any parsing notion) that the raw
requests have to be passed down the "struct request" and NOT be done the
way they are traditionally done (ie completely outside the request stream,
with no synchronization at all with any IO currently in progress).

> I think "future new commands" is total FUD, the idea that some new command
> would come along and be so instantly popular, useful and incompatible that
> all Linux boxes would require it before the next kernel or driver update
> is silly at best, and I'm working hard to keep this on a civil plane.

It has nothing to do with "new" commands, and everything to do with
"random vendor-specific commands and the vendor-specific tools". Commands
that simply should _never_ be parsed in the kernel, because we do not want
to care about 10 different vendors 10 different revisions of their
firmware having 10 different small random special commands for that
particular drive.

In particular, a user that upgrades his hardware should never _ever_ have
to upgrade his kernel just because some random disk diagnostic tool needs
support for a disk that is new and has new diagnostics.

			Linus

