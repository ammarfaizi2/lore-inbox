Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137084AbRAHMGy>; Mon, 8 Jan 2001 07:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143492AbRAHMGo>; Mon, 8 Jan 2001 07:06:44 -0500
Received: from zeus.kernel.org ([209.10.41.242]:27842 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S137084AbRAHMG1>;
	Mon, 8 Jan 2001 07:06:27 -0500
Date: Mon, 8 Jan 2001 12:02:49 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Stefan Traby <stefan@hello-penguin.com>,
        Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010108120249.J9321@redhat.com>
In-Reply-To: <20010104224946.C1290@redhat.com> <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de> <20010104192104.C2034@redhat.com> <20010104220821.B775@stefan.sime.com> <20010104224946.C1290@redhat.com> <1628.978695936@redhat.com> <20010106205726.A9664@cerebro.laendle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010106205726.A9664@cerebro.laendle>; from pcg@goof.com on Sat, Jan 06, 2001 at 08:57:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 06, 2001 at 08:57:26PM +0100, Marc Lehmann wrote:
> On Fri, Jan 05, 2001 at 11:58:56AM +0000, David Woodhouse <dwmw2@infradead.org> wrote:
> > You mount it read-only, recover as much as possible from it, and bin it.
> > 
> > You _don't_ want the fs code to ignore your explicit instructions not to
> > write to the medium, and to destroy whatever data were left.
> 
> The problem is: where did you give the explicit instruction? Just that you
> define "read-only" as "the medium should not be written" does not mean
> everybody else thinks the same.
> 
> actually, I regard "ro" mainly as a "hey kernel, I won't handle writes
> now, so please don't try it", like for cd-roms or other non-writeale
> media, and please filesystem stay in a clean state.

Right.  There are two distinct meanings:

1) Do not write to this medium, ever (physical readonly); and

2) Do not allow modifications to the filesystem (logical readonly).

The fact is that the kernel confuses the two, but that just isn't
always legitimate.  Filesystems may want to do things like garbage
collection or defragmentation in the background even when there is no
appplication write activity.

We just don't have a way of specifying these two things independently.
A journaled filesystem can only be dirty if it was in the middle of
write activity, so mounting an unclean filesystem physically readonly
is not much different from suddenly making the underlying media
readonly during active service: of _course_ the filesystem is going to
get upset!

> That ro means "the medium is never written" is an assumption that does not
> hold for most disks anyway and is, in the case of journlaing filesystems,
> often impossible to implement. You simply can't salvage data without a log
> reply. Sure, you can do virtual log replays, but for example the reiserfs
> log is currently 32mb. Pinning down that much memory for a virtual log
> reply is not possible on low-memory machines.

You don't have to: it is theoretically possible to scan the journal
and create a mapping from physical blocks on the rest of the
filesystem to journal entries.  The filesystem can then read from the
log whenever a replayable block is accessed.

However, this imposes a lookup cost on all accesses in the filesystem
even when we aren't in this virtual translating mode, so it's not a
cost I'd want to add unnecessarily.

The bottom line is that journaling and recovery both require write
access for now.  I might implement an emergency readonly mount mode,
but I'm not going to make it particularly streamlined at the cost of
slowing down normal mounts.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
