Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbTK3RWe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264964AbTK3RWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:22:31 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:43545 "EHLO
	mwinf0103.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264961AbTK3RWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:22:05 -0500
Date: Sun, 30 Nov 2003 18:22:03 +0100
To: John Bradford <john@grabjohn.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Arjan van de Ven <arjanv@redhat.com>,
       Andrew Clausen <clausen@gnu.org>, Apurva Mehta <apurva@gmx.net>,
       Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031130172203.GA6052@iliana>
References: <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk> <20031129223103.GB505@gnu.org> <1070182676.5214.2.camel@laptop.fenrus.com> <200311301040.hAUAePk6000149@81-2-122-30.bradfords.org.uk> <20031130112419.GA2920@iliana> <200311301348.hAUDmuOd000169@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200311301348.hAUDmuOd000169@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 01:48:56PM +0000, John Bradford wrote:
> Quote from Sven Luther <sven.luther@wanadoo.fr>:
> > On Sun, Nov 30, 2003 at 10:40:25AM +0000, John Bradford wrote:
> > > * All partition information stored in one partition table
> > > 
> > > Linked lists make re-arranging partitions, and backing up the
> > > partition table more difficult.
> > 
> > I don't agree here. You just follow the linked list and make the backup,
> > which is one more reason for having the save/restore mechanism in the
> > per partition table code, which knows how to read/write the partition
> > table anyway. Also, mostly the linked list is found in a chunk of the
> > disk which you can easily backup with dd. The amiga scheme has both
> > information about the number of sectors which can be used in the linked
> > list, as well as the last used sector.
> 
> I must admit, I haven't looked at every single partitioning scheme we
> support in detail.
> 
> Also, my method of working may not be typical, in that I don't
> generally partition all of the space on a disk, just because it's
> there.  This came up on LKML a few months ago, in a discussion about
> re-sizing filesystems in which I noted that the common case of wanting
> to shrink a partition containing a filesytem with free space on it,
> just to allow experimentation with a new filesystem, can be completely
> avoided in many cases, simply by partitioning only the space you
> expect to need from the begining.

Sure, but you don't always know about this at the begining.

> > Also, with a linked list, you can maintain two or more partition tables
> > on disk, thus making an on-disk backup easy. When you write a new
> > partition table, you write it on other sectors than the first one, and
> > then update the root pointer. You can then later go back to the old
> > partition table by just restoring the root pointer or something such.
> 
> I can see that linked-list partition tables have uses, but I think
> that their disadvantages outweigh their advantages here - if some
> partitioning data is stored at non-fixed locations on the disk,
> overwriting a partition can destroy partitioning data for several
> other partitions, whereas a dedicated area for partition data isn't
> vulnerable to this.

Well, i don't know about macos, or other linked partition tables, but in
the amiga case, you just use a chunk of the disk at the begining to
store the partition entries in (each partition correspond to a 512 byte
sector). The RDB (the root of the partition tree) contains information
about what sector are allocated to the partition table, and what can be
used for other stuff. In the libparted case, i just made the partition
table not available to put partitions in it, and there can not be
possible overwriting, either by parted or by kernel access, since both
respect the reserved space. Furthermore the RDB can be found in any of
the 16 first sectors of the disk, and i put it in sector 2 by default,
so as to not loose it when someone stupidly writes an MBR on top of it
(like i did when playing with beta debian-installer and evil autopartkit
and a messed up console). Historicaly there were also other stuff stored
in the linked list on amigaos, like a badblock list, as well as
filesystem drivers.

> > Also, it allow you flexibility with the amount of partitions you can
> > use, as you could have potentially have any number of partitions you
> > like (upto 2^30 or such).
> 
> Again, I can see that large numbers of partitions might have uses, but
> in my experience 4 is a real limitation, whereas 8 or 16 wouldn't be.

I routinely have more than 8 partitions in any case. With the large
disks we have today, i guess it would be quite easy to have more than 16
of them too, altough i don't remember having them (i had an hda15
though).

> Where, say > 128 partitions are needed, linked-lists are probably a
> win, but my requirements are for a simple, reliable partitioning
> scheme which supports large partitions, and allows us to completely
> remove CHS code from the kernel.  I don't think we currently support
> one.

What has linked lists to do with CHS ? These are fully orthogonal
issues.

And consider the simplest of linked list, the one were the next block is
the block immediately after the current one. You would have a root block
with details about the disk, information about the area reserved and
such, and then a simple 0xffffffff (or whatever) terminated array or
something. You could even keep the linked list scheme for flexibility, but
make it linear. Ideally, you would have two lists (or more) for backup,
and the root block would contain the extent of sectors reserved for this
usage (128Ko on larger disks maybe ?) as well as the highest used block
of this, so you can easily back it up with dd or something.

Alternatively you could have replications of this table at regular
intervals of the disks or something.

Friendly,

Sven Luther
