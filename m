Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287769AbSBLNSU>; Tue, 12 Feb 2002 08:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290616AbSBLNSL>; Tue, 12 Feb 2002 08:18:11 -0500
Received: from [195.63.194.11] ([195.63.194.11]:9485 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S287769AbSBLNSC>;
	Tue, 12 Feb 2002 08:18:02 -0500
Message-ID: <3C6915FC.2020707@evision-ventures.com>
Date: Tue, 12 Feb 2002 14:17:48 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com> <20020212135701.A16420@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>On Tue, Feb 12, 2002 at 01:45:10PM +0100, Martin Dalecki wrote:
>
>>>>The first does control an array of values, which doesn't make sense in 
>>>>first place. I.e. changing it doesn't
>>>>change ANY behaviour of the kernel.
>>>>
>
>>>Actually HFS uses it ...
>>>
>
>>Please note that the use in HFS is inappriopriate. It's supposed to
>>optimize the read throughput there, which is something that shouldn't
>>be done at the fs setup layer at all. The usage of read_ahead there
>>can be just removed and everything should be fine (modulo the fact
>>that in current state the HFS filesystem code is just non-working
>>obsolete code garbage anyway ;-).
>>
>
>Yes; I just commented on that it does change some behavior of the
>kernel.
>
>>>>The second of them is trying to control a file-system level constant
>>>>inside the actual block device driver. This is a blatant violation of
>>>>the layering principle in software design, and should go as soon as
>>>>possible.
>>>>
>
>>>Yes. But still block device drivers allocate the array ...
>>>
>
>>Well if we do:
>>
>>find ./ -name "*.c" -exec grep max_readahead /dev/null {} \;
>>
>>One can already easly see that apart from ide, md, and acorn drivers
>>this has been already abstracted away one level up at the block device
>>handling as well. My suspiction is that there is now already *double*
>>initialization of the sub-slices of this array there. Anyway ide
>>should be adapted here to the same way as it's done now for scsi.
>>
>>Will you look after this or should me? (I can't until afternoon,
>>becouse I'm at my "true live" job now and have other things to do...)
>>
>
>Am I understanding you correctly that we can just remove the
>max_readahead references in IDE (and possibly also md and acorn)?
>

Yes they can certailny be killed there. However please note that I'm not 
quite sure whatever some other
adjustments may be needed. I  suggest to double check with the way the 
scsi driver middle layer
deals with them.

OK. I can't resist. Let's have a closer look together:

~/tmp/trans/linux-2.5.4# find ./ -name "*.[ch]" -exec grep max_readahead 
/dev/null {} \;
./drivers/acorn/block/mfmhd.c:          max_readahead[major][minor] = arg;
./drivers/acorn/block/mfmhd.c:          return 
put_user(max_readahead[major][minor], (long *) arg);

1. ^^^^ Here apparently no additional allocation is needed.

./drivers/block/blkpg.c:                        if (!(iptr = 
max_readahead[major(dev)]))
./drivers/block/blkpg.c:                        if (!(iptr = 
max_readahead[major(dev)]))

2. ^^^^ This is just read out to the user space through ioctl()..

./drivers/block/ll_rw_blk.c:int * max_readahead[MAX_BLKDEV];
./drivers/block/ll_rw_blk.c:    memset(max_readahead, 0, 
sizeof(max_readahead));

3. ^^^^ This is just initialisation.

./drivers/ide/ide-probe.c:      max_readahead[hwif->major] = max_ra;
./drivers/ide/ide-disk.c:       ide_add_setting(drive,  "fi ....      
1024,   &max_readahead[major][minor],   NULL);
./drivers/ide/ide-floppy.c:     ide_add_setting(drive,  "....,   
&max_readahead[major][minor],   NULL);
./drivers/ide/ide-cd.c: ide_add_setting(drive,  "file_readahead",. ... , 
&max_readahead[major][minor],   NULL);
./drivers/ide/ide.c:    kfree(max_readahead[hwif->major]);
./drivers/ide/ataraid.c:        max_readahead[ATAMAJOR] = NULL;

4. ^^^^ Still just initialization.

./drivers/md/md.c:      max_readahead[MAJOR_NR] = md_maxreadahead;
./include/linux/blkdev.h:extern int * max_readahead[MAX_BLKDEV];
./include/linux/blkdev.h:       max_readahead[major] = NULL;

5. Still no true usage.

./mm/filemap.c:static inline int get_max_readahead(struct inode * inode)
./mm/filemap.c: if (kdev_none(inode->i_dev) || 
!max_readahead[major(inode->i_dev)])
./mm/filemap.c: return 
max_readahead[major(inode->i_dev)][minor(inode->i_dev)];
./mm/filemap.c: int max_readahead = get_max_readahead(inode);
./mm/filemap.c:         if (filp->f_ramax > max_readahead)
./mm/filemap.c:                 filp->f_ramax = max_readahead;
./mm/filemap.c: int max_readahead = get_max_readahead(inode);
./mm/filemap.c:         if (filp->f_ramax > max_readahead)
./mm/filemap.c:                 filp->f_ramax = max_readahead;
./mm/filemap.c: ra_window = 
get_max_readahead(vma->vm_file->f_dentry->d_inode);

6. Hmm I wonder how the above is working in case somebody didn't care 
about this array.

Let's have a closer look at it there (mm/filemap.c).

If max_readahead array is not set at all, the filemap code just assumes 
a constant
MAX_READAHEAD value. max_readahead is an upper bound value  for the number
for consecutive file sectors read at once.

static inline int get_max_readahead(struct inode * inode)
{
    if (kdev_none(inode->i_dev) || !max_readahead[major(inode->i_dev)])
        return MAX_READAHEAD;
    return max_readahead[major(inode->i_dev)][minor(inode->i_dev)];
}

Other then this we have the following code in nopage_sequention_readahead:

    ra_window = get_max_readahead(vma->vm_file->f_dentry->d_inode);
    ra_window = CLUSTER_OFFSET(ra_window + CLUSTER_PAGES - 1);

Obviously the first file of the two can be just killed without any harm.

So the conclusions is that not just the read_ahead array is bogous now.
The max_readahead array can be killed entierly from the kernel as well ;-).

The answer is: I'm now confident that you can just remove all the
max_readahead initialization from the ide code.


