Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272062AbRIIQa7>; Sun, 9 Sep 2001 12:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272589AbRIIQav>; Sun, 9 Sep 2001 12:30:51 -0400
Received: from morrison.empeg.co.uk ([193.119.19.130]:16374 "EHLO
	fatboy.internal.empeg.com") by vger.kernel.org with ESMTP
	id <S272062AbRIIQ3s>; Sun, 9 Sep 2001 12:29:48 -0400
Message-ID: <3B9B9917.DA1CC12F@riohome.com>
Date: Sun, 09 Sep 2001 17:30:15 +0100
From: John Ripley <jripley@riohome.com>
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: COW fs (Re: Editing-in-place of a large file)
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu> <318476047.20010903002818@port.imtp.ilyichevsk.odessa.ua> <3B9B80E2.C9D5B947@riohome.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Ripley wrote:
> 
> VDA wrote:
> >
> > Sunday, September 02, 2001, 11:21:37 PM, Bob McElrath wrote:
> > BM> I would like to take an extremely large file (multi-gigabyte) and edit
> > BM> it by removing a chunk out of the middle.  This is easy enough by
> > BM> reading in the entire file and spitting it back out again, but it's
> > BM> hardly efficent to read in an 8GB file just to remove a 100MB segment.
> 
> > BM> Is there another way to do this?
> 
> > BM> Is it possible to modify the inode structure of the underlying
> > BM> filesystem to free blocks in the middle?  (What to do with the half-full
> > BM> blocks that are left?)  Has anyone written a tool to do something like
> > BM> this?
> 
> > BM> Is there a way to do this in a filesystem-independent manner?
> 
> > A COW fs is a far more useful and cool. A fs where a copy of a file
> > does not duplicate all blocks. Blocks get copied-on-write only when
> > copy of a file is written to. There could be even a fs compressor
> > which looks for and merges blocks with exactly same contents from
> > different files.
> >
> > Maybe ext2/3 folks will play with this idea after ext3?
> >
> > I'm planning to write a test program which will scan my ext2 fs and
> > report how many duplicate blocks with the same contents it sees (i.e
> > how many would I save with a COW fs)
> 
> I've tried this idea. I did an MD5 of every block (4KB) in a partition
> and counted the number of blocks with the same hash. Only about 5-10% of
> blocks on several filesystem were actually duplicates. This might be
> better if you reduced the block size to 512 bytes, but there's a
> question of how much extra space filesystem structures would then take
> up.

Thought I'd reply to myself with some more details :)

Scanning for duplicates gave the following results:

 512 byte blocks
----------------

/dev/sda5 - swap	-   32122 blocks,  11488 duplicates, 35.76%
/dev/sdb3 - swap	-   25297 blocks,   2302 duplicates,  9.09%
/dev/sdc5 - swap	-   34122 blocks,  10239 duplicates, 30.00%

/dev/sda6 - /tmp	-  210845 blocks,  17697 duplicates,  8.39%
/dev/sda7 - /var	-   32122 blocks,   5327 duplicates, 16.58%
/dev/sdb5 - /home	-  220885 blocks,  24541 duplicates, 11.11%
/dev/sdc7 - /usr	- 1084379 blocks, 122370 duplicates, 11.28%

4096 byte blocks
----------------

/dev/sda5 - swap	-   32122 blocks,   9799 duplicates, 30.50%
/dev/sdb3 - swap	-   26105 blocks,      0 duplicates,  0.00%
/dev/sdc5 - swap	-   34122 blocks,  10539 duplicates, 30.88%

/dev/sda6 - /tmp 	-  210845 blocks,  17880 duplicates,  8.48%
/dev/sda7 - /var	-   32122 blocks,   2816 duplicates,  8.76%
/dev/sdb5 - /home	-  220885 blocks,   8908 duplicates,  4.03%
/dev/sdc7 - /usr	- 1084379 blocks,  71778 duplicates,  6.61%

Interesting results for the swap partitions. Probably full of zeros. The
time between runs probably explains the difference in /tmp.

You can grab the program I used from
http://www.pslam.demon.co.uk/md5-stuff.tar.gz
Run with ./md5device </dev/blah

-- 
John Ripley
