Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277973AbRJIVEM>; Tue, 9 Oct 2001 17:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277977AbRJIVED>; Tue, 9 Oct 2001 17:04:03 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:57340 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277973AbRJIVDw>; Tue, 9 Oct 2001 17:03:52 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 9 Oct 2001 15:03:16 -0600
To: Matt Domsch <mdomsch@Dell.com>
Cc: torvalds@transmeta.com, alan@redhat.com,
        "'Martin.Wilck@Fujitsu-Siemens.com'" 
	<Martin.Wilck@Fujitsu-Siemens.com>,
        "'viro@math.psu.edu'" <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EFI GUID Partition Tables
Message-ID: <20011009150316.E6348@turbolinux.com>
Mail-Followup-To: Matt Domsch <mdomsch@Dell.com>, torvalds@transmeta.com,
	alan@redhat.com,
	"'Martin.Wilck@Fujitsu-Siemens.com'" <Martin.Wilck@Fujitsu-Siemens.com>,
	"'viro@math.psu.edu'" <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110091210080.6027-100000@tux.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110091210080.6027-100000@tux.us.dell.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 09, 2001  12:15 -0500, Matt Domsch wrote:
> +/dev/guid support (EXPERIMENTAL)
> +CONFIG_DEVFS_GUID
> +  Say Y here if you would like to access disks and partitions by
> +  their Globally Unique Identifiers (GUIDs) which will appear as
> +  symbolic links in /dev/guid.

Would it be possible to put this somewhere else and/or rename it?  It
appears that GUIDs are really DCE UUIDs (which are used by other things
like ext2, XFS, MD RAID, etc) so if we are "advertising" UUIDs from the
kernel, we may as well make it "sensible" for other users.  How about
"/dev/dis[ck]s/uuid", unless there are other users of UUID identifiers?

On a side note, I have a user-space library which locates/identifies
devices by UUID/LABELs as well.  It is likely to become part of e2fsprogs
and mount as a way to consolidate all of the fs identification code,
but it could easily to partition identification also (hasn't been possible
until now).

I haven't released it yet because I wanted to port "mount" over to the
library first to ensure the API is at least functional enough to work
outside the confines of e2fsprogs.  I've put it online at (for viewing):

http://www-mddsp.enel.ucalgary.ca/People/adilger/e2fsprogs-1.25-0.src.rpm

Given that 2.5 will likely push a lot of stuff out to user-space, does
it make sense to add something to the kernel which could just as easily
be done in userspace?


Another question, does GPT support user-defined names/LABELs for partitions?

> +#define GUID_UNPARSED_LEN 36
> +static void
> +uuid_unparse_1(efi_guid_t *guid, char *out)
> +{
> +	sprintf(out, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
> +		guid->data1, guid->data2, guid->data3,
> + 		guid->data4[0], guid->data4[1], guid->data4[2], guid->data4[3],
> +		guid->data4[4], guid->data4[5], guid->data4[6], guid->data4[7]);
> +}

If this is going into the kernel, it should first of all just be called
"uuid_unparse()" to match the equivalent function in user-space, it
should be exported and not static (maybe put into "lib/" or similar),
and it is also very useful for it to return "out" so you can use it like
"Dprintk("UUID is", uuid_unparse(uuid, buf));" and have the whole thing
disappear if you are not compiling with debugging on (which otherwise
requires an extra "#ifdef DEBUG" around the uuid_unparse().

> +/************************************************************
> + * foo()
> + * Requires:
> + *  - bar is a pointer to a legacy bar structure
> + * Modifies: nothing
> + * Returns:
> + *  1 on true
> + *  0 on false
> + ************************************************************/

Have you looked at the DocBook stuff?  It would be desirable (not that
I'm complaining about ANY documentation, mind you) if the comments were
in DocBook format (as some parts of the kernel are moving).

> +#define PARTITION_SYSTEM_GUID \
> +((efi_guid_t) { 0xC12A7328, 0xF81F, 0x11d2, { 0xBA, 0x4B, 0x00, 0xA0, 0xC9, 0x3E, 0xC9, 0x3B }})
> +#define LEGACY_MBR_PARTITION_GUID \
> +    ((efi_guid_t) { 0x024DEE41, 0x33E7, 0x11d3, { 0x9D, 0x69, 0x00, 0x08, 0xC7, 0x81, 0xF3, 0x9F }})
> +#define PARTITION_BASIC_DATA_GUID \
> +    ((efi_guid_t) { 0xEBD0A0A2, 0xB9E5, 0x4433, { 0x87, 0xC0, 0x68, 0xB6, 0xB7, 0x26, 0x99, 0xC7 }})
> +#define PARTITION_LINUX_RAID_GUID \
> +    ((efi_guid_t) { 0xa19d880f, 0x05fc, 0x4d3b, { 0xa0, 0x06, 0x74, 0x3f, 0x0f, 0x84, 0x91, 0x1e  }})
> +#define PARTITION_LINUX_SWAP_GUID \
> +    ((efi_guid_t) { 0x0657fd6d, 0xa4ab, 0x43c4, { 0x84, 0xe5, 0x09, 0x33, 0xc8, 0x4b, 0x4f, 0x4f  }})
> +#define PARTITION_LINUX_LVM_GUID \
> +    ((efi_guid_t) { 0xe6d6d379, 0xf507, 0x44c2, { 0xa2, 0x3c, 0x23, 0x8f, 0x2a, 0x3d, 0xf9, 0x28 }})

I take it these are verbose ways of defining a "partition type"?  If this
is the case (i.e. single GUID defined for RAID/LVM/SWAP) then the whole
concept of the "U" in GUID = "Unique" is broken, and this format is useless,
as how could you use it in /proc/guid to point to a single disk?

> +typedef struct _PartitionRecord_t {
> +	u8 BootIndicator;	/* Not used by EFI firmware. Set to 0x80 to indicate that this
> +				   is the bootable legacy partition. */
> +	u8 StartHead;		/* Start of partition in CHS address, not used by EFI firmware. */
> +	u8 StartSector;		/* Start of partition in CHS address, not used by EFI firmware. */
> +	u8 StartTrack;		/* Start of partition in CHS address, not used by EFI firmware. */
> +	u8 OSType;		/* OS type. A value of 0xEF defines an EFI system partition.
> +				   Other values are reserved for legacy operating systems, and
> +				   allocated independently of the EFI specification. */
> +	u8 EndHead;		/* End of partition in CHS address, not used by EFI firmware. */
> +	u8 EndSector;		/* End of partition in CHS address, not used by EFI firmware. */
> +	u8 EndTrack;		/* End of partition in CHS address, not used by EFI firmware. */
> +	u32 StartingLBA;	/* Starting LBA address of the partition on the disk. Used by
> +				   EFI firmware to define the start of the partition. */
> +	u32 SizeInLBA;		/* Size of partition in LBA. Used by EFI firmware to determine
> +				   the size of the partition. */
> +} PartitionRecord_t;

How is this different than a "struct partition" in <linux/genhd.h> (aside
from the fact that "struct partition" should use fixed-sized types because
it is referring to on-disk data)?

> diff -burNp linux-2.4.11-pre5/lib/crc32.c linux-2.4.11-pre5.gpt/lib/crc32.c
> --- linux-2.4.11-pre5/lib/crc32.c	Wed Dec 31 18:00:00 1969
> +++ linux-2.4.11-pre5.gpt/lib/crc32.c	Mon Oct  8 15:17:57 2001
> @@ -0,0 +1,125 @@
> +/*
> + * Dec 5, 2000 Matt Domsch <Matt_Domsch@dell.com>
> + * - Copied crc32.c from the linux/drivers/net/cipe directory.
> + * - Now pass seed as an arg
> + * - changed unsigned long to u32, added #include<linux/types.h>
> + * - changed len to be an unsigned long
> + * - changed crc32val to be a register
> + * - License remains unchanged!  It's still GPL-compatable!
> + */

Are there not already plenty of crc32 functions in the kernel, or does
this one have different coefficients?

> +  /*      The table can be generated at runtime if desired; code to do so  */
> +  /*      is shown later.  It might not be obvious, but the feedback       */
> +  /*      terms simply represent the results of eight shift/xor opera-     */
> +  /*      tions for all combinations of data and CRC register values.      */

That might be nice, to avoid a static 1kB table in the kernel...

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

