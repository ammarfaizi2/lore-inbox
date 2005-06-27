Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVF0QeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVF0QeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVF0Qbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 12:31:37 -0400
Received: from THUNK.ORG ([69.25.196.29]:42972 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261351AbVF0Q3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 12:29:13 -0400
Date: Mon, 27 Jun 2005 12:28:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Masover <ninja@slaphack.com>
Cc: Markus T?rnqvist <mjt@nysv.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050627162839.GA22799@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Masover <ninja@slaphack.com>, Markus T?rnqvist <mjt@nysv.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C018E5.8030805@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C018E5.8030805@slaphack.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 10:19:01AM -0500, David Masover wrote:
> > XFS has similar issues where it assumes that hardware has powerfail
> > interrupts, and that the OS can use said powerfail interrupt to stop
> > DMA's in its tracks on an power failure, so that you don't have
> > garbage written to key filesystem data structures when the memory
> > starts suffering from the dropping voltage on the power bus faster
> > than the DMA engine or the disk drives.  So XFS is a great filesystem
> > --- but you'd better be running it on a UPS, or on a system which has
> > power fail interrupts and an OS that knows what to do.
> 
> XFS, Reiser3, and Reiser4 all pass the pull-the-plug test.  Maybe I just
> haven't pushed them hard enough?

Try doing huge amounts of metadata updates while doing the
pull-the-plug test.  The problem comes when the disk drive is writing
into the inode table or other filesystem metadata at the precise
moment when power goes down.  If the disk is quiescent, you won't see
the issue.   

XFS is known to have this problem --- the problem was first told to me
by an SGI engineer, and they solved this problem in hardware, by
adding a power fail interrupt and larger capacitors to the power
supply, and then modifying Irix to frantically run around shutting
down all outstanding DMA transfer during the grace period provided by
the enlarged capacitors.  Unfortunately, PC-class hardware don't have
power fail interrupts, so....

I have seen this problem reported on ext2 filesystems, so I know it
will happen on at least some, and probably most, PC-class hardware.
Fortunately switching to ext3 solves the problem, since metadata
updates are first written to the journal first, and the recovery
replays the full block, which papers over the problem.  Unfortunately,
a filesystem which uses logical journalling doesn't have a complete
copy of the metadata block in the log (only the logical changes are
recorded in the journal).  This is more compact, and will result in
better numbers in artificial benchmarks that emphasize metadata
updates (which is not the case in most real-world workloads in my
experience).  But it the drawback is that filesystems that journal
logical updates instead of physical blocks are vulnerable to this
particular lossage mode.

> Given a choice between changing filesystems or getting a Streamload
> account, I choose Streamload.  (streamload.com)

*If* you can afford the upload bandwidth to backup over the network,
and *if* you don't mind these gems in their legal T's and C's:

	Streamload cannot warrant and does not guarantee, and You
	should not expect, that all of Your private communications and
	other personal information will never be disclosed in ways not
	otherwise described in this Privacy Policy.

	As-Is and As-Available. Neither Streamload nor any User, or
	their respective agents, warrants that the service, Private
	Content or Public Content, or Your access thereto, will be
	uninterrupted or error free, and Streamload's services and
	both Public Content and Private Content are provided on an "as
	is, as available" basis. Streamload has the right to make
	changes to its services without notice to You. Neither
	Streamload nor any User warrants that Public Content or
	Private Content will be free of viruses or similar
	contamination or destructive features. You expressly agree to
	assume any and all risk as to the use, quality, performance,
	accuracy or completeness of any Private Content, Public
	Content, or Streamload's services.

And of course, while Streamload is pretty cheap for a minimal account,
if you have say, a several hundred gigabytes of data which is lost
when your filesystem implodes, they have you over a barrel and charge
$$$ in order for you to recover it.  But if you think it's this works
for you, please, go right ahead.  Just don't come whining to us
afterwards if you get screwed.

						- Ted
