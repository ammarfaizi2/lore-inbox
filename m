Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274675AbRJJEZB>; Wed, 10 Oct 2001 00:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274681AbRJJEYw>; Wed, 10 Oct 2001 00:24:52 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:27389 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274675AbRJJEYh>; Wed, 10 Oct 2001 00:24:37 -0400
Date: Tue, 9 Oct 2001 22:23:59 -0600
From: Andreas Dilger <adilger@turbolabs.com>
To: Matt_Domsch@Dell.com
Cc: rgooch@ras.ucalgary.ca, torvalds@transmeta.com, alan@redhat.com,
        Martin.Wilck@Fujitsu-Siemens.com, viro@math.psu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EFI GUID Partition Tables
Message-ID: <20011009222359.M6348@turbolinux.com>
Mail-Followup-To: Matt_Domsch@Dell.com, rgooch@ras.ucalgary.ca,
	torvalds@transmeta.com, alan@redhat.com,
	Martin.Wilck@Fujitsu-Siemens.com, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <71714C04806CD51193520090272892178BD6DB@ausxmrr502.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71714C04806CD51193520090272892178BD6DB@ausxmrr502.us.dell.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 09, 2001  22:01 -0500, Matt_Domsch@Dell.com wrote:
> > Would it be possible to put this somewhere else and/or rename it?  It
> > appears that GUIDs are really DCE UUIDs (which are used by 
> > other things
> > like ext2, XFS, MD RAID, etc) so if we are "advertising" 
> > UUIDs from the
> > kernel, we may as well make it "sensible" for other users.  How about
> > "/dev/dis[ck]s/uuid", unless there are other users of UUID 
> > identifiers?
> 
> Yes, UUIDs and GUIDs are the same thing, fortunately.
> I'll have to defer this to the author of this piece of code.  Martin, any
> reason why it shouldn't be renamed?  Richard, any preferred name?

Well, the "common" usage is in /etc/fstab, where we allow "UUID=" and
"LABEL=", so it would be nice to stick with "uuid" or "UUID".

> > On a side note, I have a user-space library which locates/identifies
> > devices by UUID/LABELs as well.  It is likely to become part 
> > of e2fsprogs
> > and mount as a way to consolidate all of the fs identification code,
> > but it could easily to partition identification also (hasn't 
> > been possible until now).
> 
> This would be great!  How can I help?

Hmm.  I was originally thinking it would be a no-brainer to add in GPT
support for libblkid (add a "magic" field, and then extract the UUID/LABEL
from each partition).  Some questions pop up:

1) Currently libblkid is only doing identification of "content" (e.g.
   filesystems, RAID, swap, LVM, etc) and not actual "partition tables".
   Is it possible to get the GPT data when reading the actual partitioned
   device (e.g. /dev/hda1) or do you need to read the whole-disk device
   (e.g. /dev/hda)?
2) What to do with multiple identifiers for a single partition?  Current
   partitioning schemes don't have any identifiers, so I've assumed that
   there will only be one "correct" identifier for each block device.
   With GPT, you could have a GPT GUID+LABEL and a filesystem UUID+LABEL.
   It would be nice NOT to introduce new "types" for each possible ID
   (i.e. I have been calling all "serial number" type things "UUID" and
   all "name" type things "LABEL" to match current usage).

> > Another question, does GPT support user-defined names/LABELs 
> > for partitions?
> 
> Yes.  36 efi_char_t (Unicode, really UCS-2, 72 bytes) per partition name
> field. :-)  No relying on the file system (e.g. swap doesn't support names).

Hmm, how easy to handle these as regular strings (i.e. just pretend they
are unsigned chars and never interpret)?  I was actually in the process of
adding LABEL support to swap and reiserfs, because we will still be stuck
with DOS partitions a long time.

> Happy to.  I haven't done an extensive grep for other uuid uses in the
> kernel (besides knowing they're used for ext2).  If lib/ is a better place
> to combine them, I'll do that.

Well, I've played with uuid_unparse() in the kernel a couple of times for
other reasons (UUID-root patch for example) so it would still be useful
to have.

> 
> > Have you looked at the DocBook stuff?  It would be desirable (not that
> > I'm complaining about ANY documentation, mind you) if the 
> > comments were
> > in DocBook format (as some parts of the kernel are moving).
> 
> No, I haven't looked at DocBook.  I can do that if it's important.

It's not _important_, but given that your comments are relatively well
formatted already, it shouldn't be more than a few minutes work to
convert to DocBook (see Documentation/kernel-doc-nano-HOWTO.txt).

> I prefer to think of it as "partition content type", with a single type for
> all normal file systems (ext2, ext3, etc), and different types for different
> content uses (LVM, RAID, SWAP should be grouped in with normal file systems,
> but for historical reasons isn't).
> 
> Each disk and each partition also includes a UniquePartitionGUID which is
> what /proc/guid points to, separate from the PartitionTypeGUID.

Ah, I missed the distinction there.  This makes more sense.

> > How is this different than a "struct partition" in 
> > <linux/genhd.h> (aside
> > from the fact that "struct partition" should use fixed-sized 
> > types because
> > it is referring to on-disk data)?
> 
> Same thing, but I didn't want to go mucking about with struct partition in
> exactly that way, as it's used in a variety of places across the kernel, and
> I didn't want this GPT patch to be so invasive.

I think that since the GPT struct definition is the "right" way, you
may as well fix the genhd.h header.  By "right" I mean - it is on disk
in fixed sized chunks, so lets not mess with the possibility of breakage
in the future becase the size of an "int" changes.  DOS partitions were
defined on x86 hardware so the struct needs to be declared with that
in mind.

> > Are there not already plenty of crc32 functions in the kernel, or does
> > this one have different coefficients?
> 
> Yes, in fact I grabbed this one out of the CIPE kernel patch and put it in
> lib/ for that reason.  CIPE had it as a table (it needs to be fast as it's
> processing network packets at that point), so I wanted to have a single 1KB
> array that both use.  There are other crc32 functions in the kernel, but
> this happens to be the one that Intel is using in their firmware (despite
> what their spec says).

Oh, I don't disagree it should be a table, but since it can be generated
on-the-fly you may as well do so at boot time and avoid the extra kernel
size (assuming the generation code is < 1kB).  This code can be marked
__init so it will be freed later.

As for the other crc32 functions, presumably they all use different
coefficients?  There was some discussion about this last week in that
several of these tables could also be merged between different drivers.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

