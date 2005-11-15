Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbVKORkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbVKORkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVKORkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:40:13 -0500
Received: from smtp9.clb.oleane.net ([213.56.31.31]:56548 "EHLO
	smtp9.clb.oleane.net") by vger.kernel.org with ESMTP
	id S1751462AbVKORkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:40:11 -0500
Message-ID: <437A1D6E.4060302@aie-etudes.com>
Date: Tue, 15 Nov 2005 18:39:58 +0100
From: sej <trash@aie-etudes.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DMA transfer with kiobuf, kernel 2.4.21
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I allocate a big chunck of memory from user space with :

#define MEM_SIZE_DMA (128*1024*1024)
// allocate 128MB of memory
void *_pVirtualMem = memalign(sysconf(_SC_PAGESIZE), MEM_SIZE_DMA);

// Reserve memory
memset(_pVirtualMem, 0, MEM_SIZE_DMA);

// Lock memory
if (!mlock(_pVirtualMem, MEM_SIZE_DMA ))
{
free(_pVirtualMem);
return false;
}

Then I call an IOCTL from my driver (DmaMapDescrpImg) to create a DMA
scatter gather list.
This solution works when I have 1GB of memory. If I put 2GB of memory,
it won't work because I can't resolve the physical address of my User
memory area.

My configuration is a Redhat enterprise 3.3 SMP on Xeon 3.2GHz.
The kernel is configured for 64GB support.
So the kernel only have access to LOW part of memory.
How can I force my User allocation in LOW part, or how can I replace
map_user_from_kiobuf() to support this memory ?
With kiobuf, I make DMA scatter gather list at the opening of the card
and then I use it to perform DMA transfer. With get_user_pages(), I must
make a scatter gather list for each transfer, and make pages dirty after
each transfer ?
I am not sure that get_user_pages() is the good solution.
Is there another method to perform my DMA transfer.
I must allocate my memory in user space, and I can't copy it from kernel
to user because I'll have a big overhead.

Regards.
Sebastien


Kernel IOCTL :

int DmaMapDescrpImg (int board_num, u32 arg)
{
struct kiobuf *iobuf;

// get parameters
get_user ( ... );

// Create kiovec into decriptor pointer registers
// Map kiovec into descriptor pointer register
result = alloc_kiovec(1, &iobuf);
if (result)
{
  TRACE_ERR("alloc_kiovec failed\n");
  return 1;
}

result = map_user_kiobuf(READ,
          iobuf, // struct kiobuf
          arg,   // user addr (buffer passed from user)
          iSize);// size
if (result)
{
  TRACE_ERR("map_user_kiobuf failed\n");
  free_kiovec(1, &iobuf);
  return 1;
}


// ************************* Build descriptors
transfer = &(pdx[board_num].ReadTransfer);

// Number of descriptor needed
nbDescrpImg = iSize/PAGE_SIZE + ((iSize%PAGE_SIZE) ? 1 : 0);
// Index of the first descriptor in transfer->Descript[]
idxDescrpImg = nImage * nbDescrpImg;


transfer->image[nImage].Descript = &(transfer->Descript[idxDescrpImg]);
transfer->imageInfo->flag[nImage] = IMG_UNUSED; //IMG_UNLOCK;

for(i=idxDescrpImg, idxIobuf = 0 ; i < idxDescrpImg + nbDescrpImg - 1
; i++, idxIobuf++)
{
  transfer->Descript[i].size = PAGE_SIZE;
  transfer->Descript[i].pciaddr = (ULONG)
virt_to_phys(page_address(iobuf->maplist[idxIobuf]));
transfer->Descript[i].localaddr = localaddr;
transfer->Descript[i].next = (ULONG)
virt_to_phys(&(transfer->Descript[i+1])) | PLX_PCI | PLX_READ;

}

// End Of Chain

transfer->Descript[i].size        = PAGE_SIZE;
transfer->Descript[i].pciaddr    = (ULONG)
virt_to_phys(page_address(iobuf->maplist[idxIobuf]));
transfer->Descript[i].localaddr    = localaddr;
transfer->Descript[i].next        = PLX_PCI | (bRead ? PLX_READ :
PLX_WRITE)
| PLX_EOC;

// ******************************************
// unmap and free kiobuf
unmap_kiobuf(iobuf);
free_kiovec(1, &iobuf);
return 0;
}


