Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbRADWwh>; Thu, 4 Jan 2001 17:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRADWwR>; Thu, 4 Jan 2001 17:52:17 -0500
Received: from zeus.kernel.org ([209.10.41.242]:43780 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129597AbRADWwJ>;
	Thu, 4 Jan 2001 17:52:09 -0500
Date: Thu, 4 Jan 2001 22:49:46 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Stefan Traby <stefan@hello-penguin.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010104224946.C1290@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de> <20010104192104.C2034@redhat.com> <20010104220821.B775@stefan.sime.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010104220821.B775@stefan.sime.com>; from stefan@hello-penguin.com on Thu, Jan 04, 2001 at 10:08:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 04, 2001 at 10:08:21PM +0100, Stefan Traby wrote:
> On Thu, Jan 04, 2001 at 07:21:04PM +0000, Stephen C. Tweedie wrote:
> 
> > ext3 does the recovery automatically during mount(8), so user space
> > will never see an unrecovered filesystem.  (There are filesystem flags
> > set by the journal code to make sure that an unrecovered filesystem
> > never gets mounted by a kernel which doesn't know how to do the
> > appropriate recovery.)
> 
> I did not follow the ext3 development recently, how did you solve
> the "read-only mount(2) (optionally on write protected media)" issue ?
> 
> Does the mount fail, or does the code virtually replays (without writing)
> only ?

The code currently checks if the underlying media is write-protected.
If it is, it fails the mount; if not, it does the replay (so that
mounting a root fs readonly works correctly).

I will be adding support for virtual replay for root filesystems to
act as a last-chance way of recovering if you really cannot write to
the root, but journaling filesystems really do expect to be able to
write to the media so I am not sure whether it makes sense to support
this on non-root filesystems too.

> I think any other action (only replaying on rw mount and presenting
> a broken filesystem on ro) is quite fatal, at least if I think of
> a replay on -remount,rw :)

Correct.

> Also, an unconditional hidden replay even if "ro" is specified is not nice.

> This is especially critical on root filesystem

In what way?  A root fs readonly mount is usually designed to prevent
the filesystem from being stomped on during the initial boot so that
fsck can run without the filesystem being volatile.  That's the only
reason for the readonly mount: to allow recovery before we enable
writes.  With ext3, that recovery is done in the kernel, so doing that
recovery during mount makes perfect sense even if the user is mounting
root readonly.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
