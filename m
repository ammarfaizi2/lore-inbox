Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277483AbRJJWIp>; Wed, 10 Oct 2001 18:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277476AbRJJWIf>; Wed, 10 Oct 2001 18:08:35 -0400
Received: from ausxc08.us.dell.com ([143.166.99.216]:23801 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S277440AbRJJWI3>; Wed, 10 Oct 2001 18:08:29 -0400
Message-ID: <71714C04806CD51193520090272892178BD6E6@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: adilger@turbolabs.com, rgooch@ras.ucalgary.ca
Cc: torvalds@transmeta.com, alan@redhat.com, Martin.Wilck@Fujitsu-Siemens.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] EFI GUID Partition Tables
Date: Wed, 10 Oct 2001 17:08:46 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd prefer /dev/volumes/uuids/
> Similarly, if label reading code is added, I'd like to see that put in
> /dev/volumes/labels/

OK, done.  /dev/volumes/uuids it is, configured by
CONFIG_DEVFS_VOLUMES_UUIDS instead now.


> 1) Currently libblkid is only doing identification of "content" (e.g.
>    filesystems, RAID, swap, LVM, etc) and not actual 
> "partition tables".
>    Is it possible to get the GPT data when reading the actual 
> partitioned
>    device (e.g. /dev/hda1) or do you need to read the 
> whole-disk device (e.g. /dev/hda)?

No.  The partitition table sits at the beginning of the disk, with a backup
copy at the end of the disk.  There's no identifying information placed into
/dev/hda1, it's all in /dev/hda before /dev/hda1.  I've got some GPT-parsing
code included in efibootmgr (GPL'd) if that helps you get started.
http://domsch.com/linux/ia64/.

> 2) What to do with multiple identifiers for a single 
> partition?  Current
>    partitioning schemes don't have any identifiers, so I've 
> assumed that
>    there will only be one "correct" identifier for each block device.
>    With GPT, you could have a GPT GUID+LABEL and a filesystem 
> UUID+LABEL.
>    It would be nice NOT to introduce new "types" for each possible ID
>    (i.e. I have been calling all "serial number" type things 
> "UUID" and
>    all "name" type things "LABEL" to match current usage).

This does get messy, I agree.  Maybe you need partition_{uuid,label} and
fs_{uuid,label}.  Don't change /etc/fstab format at all.  Since the uuids
are supposed to be unique, simply scan through both lists.
Since the labels don't have to be unique between file system and partition
table, assume one (I'd suggest file system) is right if more than one are
encountered.  Mount does this today if you've got two file systems with the
same label: it mounts the first one found.

> Hmm, how easy to handle these as regular strings (i.e. just 
> pretend they
> are unsigned chars and never interpret)?  I was actually in 
> the process of
> adding LABEL support to swap and reiserfs, because we will 
> still be stuck
> with DOS partitions a long time.

I'd prefer not to.  I've written some efi_char_to_char(),
efi_char_from_char() functions to help out, and can put them in
lib/efichar.c.  Since the spec calls for them to be treated as unicode
characters (and really, they end up being UCS-2, simply wide characters for
all purposes I've encountered thus far), I think conversion to/from
unicode/ascii is the preferred way to treat them.  Code in efibootmgr
package does the obvious size expansion conversion, and that's GPL.


> Well, I've played with uuid_unparse() in the kernel a couple 
> of times for
> other reasons (UUID-root patch for example) so it would still 
> be useful to have.

I've made a lib/uuid.c which now includes uuid_unparse().  I'll see where
all I can remove other copies.

> It's not _important_, but given that your comments are relatively well
> formatted already, it shouldn't be more than a few minutes work to
> convert to DocBook (see Documentation/kernel-doc-nano-HOWTO.txt).

Thanks for the pointer.  I've converted my stuff to DocBook.

> I think that since the GPT struct definition is the "right" way, you
> may as well fix the genhd.h header.  By "right" I mean - it is on disk
> in fixed sized chunks, so lets not mess with the possibility 
> of breakage
> in the future becase the size of an "int" changes.  DOS 
> partitions were
> defined on x86 hardware so the struct needs to be declared with that
> in mind.

OK, done.  Need to test to make sure nothing else breaks.

> Oh, I don't disagree it should be a table, but since it can 
> be generated
> on-the-fly you may as well do so at boot time and avoid the 
> extra kernel
> size (assuming the generation code is < 1kB).  This code can be marked
> __init so it will be freed later.

OK, I see fs/jffs2/crc32.c generates this table, so I'll borrow code from
there to do it.
 
> As for the other crc32 functions, presumably they all use different
> coefficients?  There was some discussion about this last week in that
> several of these tables could also be merged between 
> different drivers.

My perusal for crc functions yielded several identical ones...
drivers/net/sbni.[ch]
drivers/net/smc9194.c
fs/jffs2/crc32.[ch]
lib/inflate.c
(and probably all zlib.h crc32 implementations)

Any objections if I make *one* crc32() function that handles all those above
(except zlib.h)?

I'll send a revised patch soon, hopefully by the end of the week.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!
