Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131525AbQLQBWa>; Sat, 16 Dec 2000 20:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131594AbQLQBWV>; Sat, 16 Dec 2000 20:22:21 -0500
Received: from lips.borg.umn.edu ([160.94.232.50]:23315 "EHLO
	lips.borg.umn.edu") by vger.kernel.org with ESMTP
	id <S131525AbQLQBWM>; Sat, 16 Dec 2000 20:22:12 -0500
Message-ID: <3A3C0E17.47E4F18B@thebarn.com>
Date: Sat, 16 Dec 2000 18:51:36 -0600
From: Russell Cattelan <cattelan@thebarn.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.12 i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <Pine.GSO.4.21.0012150150570.11106-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> On Thu, 14 Dec 2000, Linus Torvalds wrote:
>
> > Good point.
> >
> > This actually looks fairly nasty to fix. The obvious fix would be to not
> > put such buffers on the dirty list at all, and instead rely on the VM
> > layer calling "writepage()" when it wants to push out the pages.
> > That would be the nice behaviour from a VM standpoint.
> >
> > However, that assumes that you don't have any "anonymous" buffers, which
> > is probably an unrealistic assumption.
> >
> > The problem is that we don't have any per-buffer "writebuffer()" function,
> > the way we have them per-page. It was never needed for any of the normal
> > filesystems, and XFS just happened to be able to take advantage of the
> > b_end_io behaviour.
> >
> > Suggestions welcome.
>
> Just one: any fs that really cares about completion callback is very likely
> to be picky about the requests ordering. So sync_buffers() is very unlikely
> to be useful anyway.

Actually no,  that's not the issue.

The XFS log uses a LSN (Log Sequence Number) to keep track of log write ordering.
Sync IO on each log buffer isn't realistic; the performance hit would be to great.

I wasn't around when  most of XFS was developed, but  from I what I understand it
was discovered early on that firing off writes in a particular order doesn't
guarantee that
they will finish in that order.  Thus the implantation of a sequence number for
each log write.


One of the obstacles we ran into early on in the linux port was the fact that
linux used fixed size IO requests to any given device.
But most of XFS's meta data structures vary in size in multiples of 512 bytes.

We were also implementing a page caching / clustering layer called
page_buf which understands  primarily  pages and not necessary
disk blocks. If your FS block size happens to match your page size then things
are good,  but it doesn't....
So we added a  bit map field to the pages structure.
Each bit then represents one BASIC BLOCK eg 512 for all practical purposes

The end_io functions XFS defines updates the correct bit or the whole bit array
if the whole page is valid, thus signaling the rest of the page_buf that the io
has
completed.

Ok there is a lot more to it than what I've just described but you probably get
the idea.


>
>
> In that sense we really don't have anonymous buffers here. I seriously
> suspect that "unrealistic" assumption is not unrealistic at all. I'm
> not sufficiently familiar with XFS code to say for sure, but...
>
> What we really need is a way for VFS/VM to pass the pressure on filesystem.
> That's it. If fs wants unusual completions for requests - let it have its
> own queueing mechanism and submit these requests when it finds that convenient.
>
> Stephen, you probably already thought about that area. Could you comment on
> that?
>                                                                 Cheers,
>                                                                         Al

--
Russell Cattelan
cattelan@thebarn.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
