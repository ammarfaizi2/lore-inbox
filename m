Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272287AbRI0KGl>; Thu, 27 Sep 2001 06:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272270AbRI0KGc>; Thu, 27 Sep 2001 06:06:32 -0400
Received: from mx0.gmx.de ([213.165.64.100]:41050 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S272287AbRI0KGW>;
	Thu, 27 Sep 2001 06:06:22 -0400
Date: Thu, 27 Sep 2001 12:06:44 +0200 (MEST)
From: Bernd Harries <mlbha@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
MIME-Version: 1.0
Subject: Re: __get_free_pages(): is the MEM really mine?
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0000450161@gmx.net
X-Authenticated-IP: [141.200.125.99]
Message-ID: <30756.1001585204@www46.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Ingo.

> perfectly legal - but there is no guarantee you will succeed getting two
> nearby 2 MB pages. You will get it if your driver initializes during

Yes, I try until I have enough (2 in 2.4.x, 32 in 2.2.x) contig chunks and
free the rest again. But statistically I do get 2 contig chunks immediately
quite often if the X11 is not already running. 256 MB is in the box

> > When I run the user appl. again after short time I mostly get the same
> > chunk of physical memory (virt_to_bus is identical!)
> 
> have you perpahs freed that page?

Yes, as expected.

> printk every occasion of
> allocating/freeing a 2 MB buffer and i'm sure you'll see the problem.
> (Perhaps it's the close() implicitly done by exit() that frees the
> buffer?)

Yes, that is definitely the case and I expect it. 

> >  Now close '/dev/aprsc027' fd = 3 ...

The test program does a close and on the console 

But I tend to conclude from getting the same phys address again after some
time that noone else uses much memory inbetween. Plus, the first page of the
area stays Zero all the time while the higher pages seem to be used by
someone. I know that this is no prove that the 1st page was really not used
otherwise but... And I know it is also legal that other procs use the very same RAM.
But the prob is that the system gets unstable. And it doesn't get unstable if
order count is 0, which i use in minor 0..23 to allocate a small kernel
buffer. Only minor 26 and 27 allocate a 4 MB contig buffer in open() and mmap
that buffer to user space, while minor 28 and 29 only allocate a small buffer to
write the FIFOs and mmap the 32 MB PCI area of the card.

The impression I have is that only large allocations behave strangely. But
the instability is not visible immediately. Too bad. Only after some time do I
see strange behaviour of the system. But I think I don't see them if I only
use the functionality of the minors with smaller buffers.

could my nopage() method be inmplemented wrongly?
I read Alessandro Rubini's book I learned how to implement it:

  chn_ptr = (struct RSC_SOFTC *)vma_ptr->vm_private_data;
  card_ptr = chn_ptr->card_ptr;
  minor = chn_ptr->minor;
  card_chn = minor & APRSC_CARD_CHNS_MASK;

  page_ptr = NOPAGE_SIGBUS;
  
  Iprintf(" address=$%08lX ad - vm_start=$%08lX VMA_OFFSET=$%08lX \n",
    address,
    address - vma_ptr->vm_start,
    vma_ptr->vm_pgoff << PAGE_SHIFT);
  
  offset = address - vma_ptr->vm_start + (vma_ptr->vm_pgoff << PAGE_SHIFT);

  if(card_chn == APRSC_DEV_PER_CARD - 6)  /* Bild 1 Ch 26 dieser Karte */
  {
    if(offset > card_ptr->contig_len0)
    {
      return(page_ptr);
    }
    /*endif()*/
    start = (ULONG)card_ptr->dma_mem0;
  }
  else if(card_chn == APRSC_DEV_PER_CARD - 5)  /* Bild 2 Ch 27 dieser Karte
*/
  {
    if(offset > card_ptr->contig_len1)
    {
      return(page_ptr);
    }
    /*endif()*/
    start = (ULONG)card_ptr->dma_mem1;
  }
  else
  {
    return(page_ptr);
  }
  /*endif(card_chn == APRSC_DEV_PER_CARD - [(>=7), (<=4)] usw.)*/
  page_ptr = virt_to_page(start + offset);
  Iprintf(" start+off=$%08lX page_ptr=$%8p \n",
    start + offset,
    page_ptr);
  get_page(page_ptr);
  
  return(page_ptr);



Here is the console output of my driver during the test program:

Sep 27 11:43:28 pcma73 kernel: rsc_open() minor=$1B 
Sep 27 11:43:28 pcma73 kernel:  DMA blk 0 at KV:$CE800000 BUS:$0E800000 
Sep 27 11:43:28 pcma73 kernel:  DMA blk 1 at KV:$CE600000 BUS:$0E600000
contig < 
Sep 27 11:43:28 pcma73 kernel:  Max Buffer Frag at BUS:$0E600000 len
$00400000 bytes 
Sep 27 11:43:28 pcma73 kernel:  Collected DMA Buffer1 at KS:$0000CE600000
BUS:$0E600000 len $00400000 bytes 
Sep 27 11:43:28 pcma73 kernel: rsc_ioctl()
Sep 27 11:43:28 pcma73 kernel:  RSC_IOC_GET_FIX: copy_to_user() returned $0 
Sep 27 11:43:28 pcma73 kernel: rsc_ioctl()
Sep 27 11:43:28 pcma73 kernel: rsc_mmap()  minor=$1B  offset=$00000000 
Sep 27 11:43:28 pcma73 kernel: rsc_vma_open()
Sep 27 11:43:28 pcma73 kernel: rsc_nopage()
Sep 27 11:43:28 pcma73 kernel:  address=$40132000 ad - vm_start=$00000000
VMA_OFFSET=$00000000 
Sep 27 11:43:28 pcma73 kernel:  start+off=$CE600000 page_ptr=$c1398000 
Sep 27 11:43:28 pcma73 kernel: rsc_nopage()
Sep 27 11:43:28 pcma73 kernel:  address=$40134000 ad - vm_start=$00002000
VMA_OFFSET=$00000000 
Sep 27 11:43:28 pcma73 kernel:  start+off=$CE602000 page_ptr=$c1398080 
Sep 27 11:43:28 pcma73 kernel: rsc_ioctl()
Sep 27 11:43:28 pcma73 kernel:  RSC_IOC_DMA_OUT
Sep 27 11:43:28 pcma73 kernel: rsc_vma_close()
Sep 27 11:43:28 pcma73 kernel: rsc_close()
Sep 27 11:43:28 pcma73 kernel:  PCIRSC: DMA0CSR=$10 ok.
Sep 27 11:43:28 pcma73 kernel:  PCIRSC: DMA1CSR=$10 ok.
Sep 27 11:43:28 pcma73 kernel:  PCIRSC: PCISR=$0290 ok.
Sep 27 11:43:28 pcma73 kernel:  Free DMA blk 0 at KS:$CE800000 
Sep 27 11:43:28 pcma73 kernel:  Free DMA blk 1 at KS:$CE600000 


Thank you very much for your help!

-- 
Bernd Harries

bha@gmx.de            http://bharries.freeyellow.com
bharries@web.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org       +49 172 139 6054 handy  | Medusa T40

GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

