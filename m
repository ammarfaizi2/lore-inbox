Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276717AbRJBVuR>; Tue, 2 Oct 2001 17:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276718AbRJBVuI>; Tue, 2 Oct 2001 17:50:08 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:22502 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S276717AbRJBVtx>; Tue, 2 Oct 2001 17:49:53 -0400
Message-ID: <71714C04806CD51193520090272892178BD678@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
Date: Tue, 2 Oct 2001 16:49:48 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander:

In the IA-64 port lives the EFI GUID Partition Table (GPT) partitioning
code.  It's not yet merged into the mainline kernel tree.  I've made a
first-stab at a patch to make the GPT code use the page cache, and I'd
appreciate you taking a look.

Start with 2.4.10
apply 2.4.11-pre1
apply your latest partition patch (partition-d-S11-pre1 I think)
apply latest ia64 patch
 (there's one rejection in include/linux/genhd.h that's easy to fix)
apply http://domsch.com/linux/patches/linux-2.4.10-gpt-20011001.patch
apply
http://domsch.com/linux/patches/linux-2.4.10-gpt-pagecache-20011001.patch

The GPT code is in fs/partition/efi.[ch].  I'm concerned about reading a
page or partial page at the end of a disk, particularly an odd-sized disk.
In the pagecache patch I remove the set_blocksize() stuff, as it's not clear
if it's still needed, or if a disk with sectors % PAGE_CACHE_SIZE != 0 can
even read those last sectors.

Reading even the first few sectors fails with these patches, where if I
remove your partition patch and my pagecache patch, it works fine.  I'm
certain it's a bug in my read_lba() code, which could use to be optimized
also.

static size_t
read_lba(struct gendisk *hd, struct block_device *bdev, u64 lba, u8 *buffer,
size_t count)
{

        size_t totalreadcount = 0, bytesread;
        int i, blockstoread, blocksize;
        Sect sect;
        unsigned char *data=NULL;

        if (!hd || !buffer || !count) return 0;

        blocksize = get_hardsect_size(to_kdev_t(bdev->bd_dev));
        blockstoread = count / blocksize;
        if (count % blocksize) blockstoread += 1;
        for (i=0; i<blockstoread; i++) {
                data = read_dev_sector(bdev, lba, &sect);
                if (!data) {
                        put_dev_sector(sect);
                        return totalreadcount;
                }

                bytesread = (count > 512 ? 512 : count);
                memcpy(buffer, data, bytesread);
                put_dev_sector(sect);

                buffer += bytesread;         /* Advance the buffer pointer
*/
                totalreadcount += bytesread; /* Advance the total read count
*/
                count -= bytesread;         /* Subtract bytesread from count
*/
        }

        return totalreadcount;
}

I'd appreciate your pointers.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!
