Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSGVSs7>; Mon, 22 Jul 2002 14:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317361AbSGVSs7>; Mon, 22 Jul 2002 14:48:59 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26380 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317165AbSGVSs5>; Mon, 22 Jul 2002 14:48:57 -0400
Message-ID: <3D3C5307.2090404@evision.ag>
Date: Mon, 22 Jul 2002 20:46:31 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: martin@dalecki.de, Richard Gooch <rgooch@ras.ucalgary.ca>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 devfs
References: <Pine.GSO.4.21.0207221412240.7619-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Mon, 22 Jul 2002, Marcin Dalecki wrote:
> 
> 
>>Richard Gooch wrote:
>>
>>>Marcin Dalecki writes:
>>>
>>>
>>>>Kill two inlines which are notwhere used and which don't make sense
>>>>in the case someone is not compiling devfs at all.
>>>
>>>
>>>Rejected. Linus, please don't apply this bogus patch. External patches
>>>and drivers rely on the inline stubs so that #ifdef CONFIG_DEVFS_FS
>>>isn't needed.
>>
>>Dare to actually *name* one of them?
> 
> 
> [snip]
> 
> OK, that's enough.  Martin, kindly stay the fsck away from that pile of
> garbage for a couple of weeks.
> 
> _All_ partition-related code is getting rewritten and the last thing
> we need right now is additional clutter in the neighborhood.  And
> devfs_fs_kernel.h, shite as it is, qualifies.

No problem as long as long somebody cares.
That part stuff needs treatment as well is obvious if one looks at the 
extensive allocation fallback chains I have in my small sand pille...
Would you dare to keep the following botch in mind as well please:

/*
  * Returns the (struct ata_device *) for a given device number.  Return
  * NULL if the given device number does not match any present drives.
  */
struct ata_device *get_info_ptr(kdev_t i_rdev)
{
	unsigned int major = major(i_rdev);
	int h;

	for (h = 0; h < MAX_HWIFS; ++h) {
		struct ata_channel *ch = &ide_hwifs[h];
		if (ch->present && major == ch->major) {
			int unit = DEVICE_NR(i_rdev);
			if (unit < MAX_DRIVES) {
				struct ata_device *drive = &ch->drives[unit];
				if (drive->present)
					return drive;
			}
			break;
		}
	}
	return NULL;
}

This get's feed to the revalidate method.

struct block_device_operations ide_fops[] = {{
         .owner =                THIS_MODULE,
         .open =                 ide_open,
         .release =              ide_release,
         .ioctl =                ata_ioctl,
         .check_media_change =   ide_check_media_change,
         .revalidate =           ata_revalidate
}};

and the following ide_xlate_1024(kdev_t i_rdev botch.

I would love to go the bdev way there too :-).
But then please keep in mind that the georgeous random number
device is using the major number of a device all over the kernel...
and it's feeding the following ugly global array:

void add_blkdev_randomness(int major)
{
         if (major >= MAX_BLKDEV)
                 return;

         if (blkdev_timer_state[major] == 0) {
                 rand_initialize_blkdev(major, GFP_ATOMIC);
                 if (blkdev_timer_state[major] == 0)
                         return;
         }

         add_timer_randomness(blkdev_timer_state[major], 0x200+major);
}

Which should of course look more like:

void add_blkdev_randomness(struct block_device *ptr)
{
         add_timer_randomness(((unsigned long) ptr) %
                               SOME_REASONABLE_VALUE, 0x200);
}

Simple couldn't resist:

1.  Enabled devfs... system printed far too long
incomprehensive device names and didn't reboot.

2. I disabled automatic devfs mount... system didn't find root part either.

The only single expirence in my life, where I thought that naming disks
C: D: E: Z: isn't the worst thing that can happen.

I went curious and looked there... and *cry*.

