Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135840AbRD2RXf>; Sun, 29 Apr 2001 13:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135846AbRD2RX0>; Sun, 29 Apr 2001 13:23:26 -0400
Received: from elin.scali.no ([195.139.250.10]:59660 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S135840AbRD2RXH>;
	Sun, 29 Apr 2001 13:23:07 -0400
Message-ID: <3AEC4F91.D8E5139E@scali.no>
Date: Sun, 29 Apr 2001 12:29:53 -0500
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17-16enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Kiobufs and userspace memory
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm writing a device driver for a shared memory adapter from which I plan to
support DMA directly from userspace memory (zero copy). I have already
implemented a version which I think works, but I'm not sure if I get the IO
addresses calculated correctly. The case is as follows :

The userspace application has allocated some memory with malloc() and use write
to the device's /dev entry.

The drivers write() function looks something like this :

ssize_t my_write(struct file* file, char* userbuf, size_t len, loff_t* poff)
{
  struct kiobuf * iobuf;
  size_t size;
  struct my_sglist *sglist = NULL;
  int i, err;

  /* Pin user memory */
  err = alloc_kiovec(1, &iobuf);
  if (err)
    return err;

  err = map_user_kiobuf(WRITE, userbuf, len);
  if (err)
    goto out;

  /* Traverse the iobuf to get the IO address for each page,
   * building up the SG table for my DMA machine */

  sglist = kmalloc(sizeof(struct my_sglist) * iobuf->nr_pages, GFP_ATOMIC)
  if (!sglist)
    goto out_unmap;

  totlen = 0;
  for (i = 0; i < iobuf->nr_pages; ++i)
  {
    struct page *page = iobuf->maplist[i];
    void *vaddr = page_address(page) + iobuf->offset;
    unsigned long ioaddr = virt_to_bus(vaddr);

    sglist[i].start = ioaddr;

    if ((totlen + PAGE_SIZE) > len)
      sglist[i].len = len - totlen;
    else
      sglist[i].len = PAGE_SIZE;

    totlen + = PAGE_SIZE;
  }

  /* Start the synchronous DMA engine */
  my_start_dma(sglist);
  kfree(sglist);

 out_unmap:
  /* Unpin user memory */
  unmap_kiobuf(iobuf);

 out:
  free_kiovec(1, &iobuf);
}

Is this use of kiobufs sensible to you ? If not, what should I really be doing
in order to acheive zero copy DMA ?

I also have a question regarding a DMA read to userspace memory :

If the application didn't initialize the buffer by memset or anything, all the
pages maps to the same page (the zero page) right ? So if a map_user_kiobuf()
call is made on this buffer, will it sort this out and map the pages to real
ones ?


Any response greatly appreciated,
-- 
 Steffen Persvold                        Systems Engineer
 Email  : mailto:sp@scali.com            Scali AS (http://www.scali.com)
 Norway : Tel  : (+47) 2262 8950         Olaf Helsets vei 6
          Fax  : (+47) 2262 8951         N-0621 Oslo, Norway

 USA    : Tel  : (+1) 713 706 0544       10500 Richmond Avenue, Suite 190
                                         Houston, Texas 77042, USA
