Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291054AbSBLN7e>; Tue, 12 Feb 2002 08:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291061AbSBLN71>; Tue, 12 Feb 2002 08:59:27 -0500
Received: from [195.63.194.11] ([195.63.194.11]:25357 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291054AbSBLN7O>; Tue, 12 Feb 2002 08:59:14 -0500
Message-ID: <3C691F9C.10303@evision-ventures.com>
Date: Tue, 12 Feb 2002 14:58:52 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com> <20020212135701.A16420@suse.cz> <3C6915FC.2020707@evision-ventures.com> <20020212144300.A18431@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>On Tue, Feb 12, 2002 at 02:17:48PM +0100, Martin Dalecki wrote:
>
>>So the conclusions is that not just the read_ahead array is bogous now.
>>The max_readahead array can be killed entierly from the kernel as well ;-).
>>
>>The answer is: I'm now confident that you can just remove all the
>>max_readahead initialization from the ide code.
>>
>
>Since I've come to the same conclusion, here is the patch. It removes
>read_ahead, max_readahead, BLKRAGET, BLKRASET, BLKFRAGET and BLKFRASET
>completely.
>
Welcome the the "Write Only Variable" haters club ;-).

Please note that the lvm code is playing mental  with himself on the 
lv_read_ahead struct member as well.
This member get's set saved preserved,  but it's never used nowhere there:

./include/linux/lvm.h:  uint lv_read_ahead;
./include/linux/lvm.h:  uint32_t lv_read_ahead; /* HM */

>diff -urN linux-2.5.4/drivers/block/ll_rw_blk.c linux-2.5.4-readahead/drivers/block/ll_rw_blk.c
>--- linux-2.5.4/drivers/block/ll_rw_blk.c	Thu Jan 31 16:45:20 2002
>+++ linux-2.5.4-readahead/drivers/block/ll_rw_blk.c	Tue Feb 12 14:27:32 2002
>@@ -56,8 +56,6 @@
> 
> /* This specifies how many sectors to read ahead on the disk. */
> 
>-int read_ahead[MAX_BLKDEV];
>-
>

You did miss the comment by shooting  above!

>diff -urN linux-2.5.4/include/linux/fs.h linux-2.5.4-readahead/include/linux/fs.h
>--- linux-2.5.4/include/linux/fs.h	Tue Feb 12 12:22:54 2002
>+++ linux-2.5.4-readahead/include/linux/fs.h	Tue Feb 12 14:32:32 2002
>@@ -173,10 +173,6 @@
> #define BLKRRPART  _IO(0x12,95)	/* re-read partition table */
> #define BLKGETSIZE _IO(0x12,96)	/* return device size /512 (long *arg) */
> #define BLKFLSBUF  _IO(0x12,97)	/* flush buffer cache */
>-#define BLKRASET   _IO(0x12,98)	/* Set read ahead for block device */
>-#define BLKRAGET   _IO(0x12,99)	/* get current read ahead setting */
>-#define BLKFRASET  _IO(0x12,100)/* set filesystem (mm/filemap.c) read-ahead */
>-#define BLKFRAGET  _IO(0x12,101)/* get filesystem (mm/filemap.c) read-ahead */
> #define BLKSECTSET _IO(0x12,102)/* set max sectors per request (ll_rw_blk.c) */
> #define BLKSECTGET _IO(0x12,103)/* get max sectors per request (ll_rw_blk.c) */
> #define BLKSSZGET  _IO(0x12,104)/* get block device sector size */
>@@ -1490,8 +1486,6 @@
>

I would rather suggest to to #if  0 ... #endif instead with a note about 
those values beeing no longer used.

>diff -urN linux-2.5.4/mm/filemap.c linux-2.5.4-readahead/mm/filemap.c
>--- linux-2.5.4/mm/filemap.c	Tue Feb 12 12:22:54 2002
>+++ linux-2.5.4-readahead/mm/filemap.c	Tue Feb 12 14:29:58 2002
>@@ -1131,13 +1131,6 @@
>  *   64k if defined (4K page size assumed).
>  */
> 
>-static inline int get_max_readahead(struct inode * inode)
>-{
>-	if (kdev_none(inode->i_dev) || !max_readahead[major(inode->i_dev)])
>-		return MAX_READAHEAD;
>-	return max_readahead[major(inode->i_dev)][minor(inode->i_dev)];
>-}
>-
> static void generic_file_readahead(int reada_ok,
> 	struct file * filp, struct inode * inode,
> 	struct page * page)
>@@ -1146,7 +1139,7 @@
> 	unsigned long index = page->index;
> 	unsigned long max_ahead, ahead;
> 	unsigned long raend;
>-	int max_readahead = get_max_readahead(inode);
>+	int max_readahead = MAX_READAHEAD;
>

This wonders me a bit, why you didn't just propagate the constant deeper.

