Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268916AbRHaSlC>; Fri, 31 Aug 2001 14:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268926AbRHaSkw>; Fri, 31 Aug 2001 14:40:52 -0400
Received: from unused ([12.150.234.220]:33789 "EHLO one.isilinux.com")
	by vger.kernel.org with ESMTP id <S268916AbRHaSkk>;
	Fri, 31 Aug 2001 14:40:40 -0400
Message-ID: <3B8FDA36.5010206@interactivesi.com>
Date: Fri, 31 Aug 2001 13:40:54 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: kernel hangs in 118th call to vmalloc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing a driver for the 2.4.2 kernel.  I need to use this kernel 
because this driver needs to be compatible with a stock Red Hat system. 
  Patches to the kernel are not an option.

The purpose of the driver is to locate a device that exists on a 
specific memory chip.  To help find it, I've written this routine:

#define CLEAR_BLOCK_SIZE 1048576UL        // must be a multiple of 1MB
#define CLEAR_BLOCK_COUNT ((PHYSICAL_HOP * 2) / CLEAR_BLOCK_SIZE)

void clear_out_memory(void)
{
     void *p[CLEAR_BLOCK_COUNT];
     unsigned i;
     unsigned long size = 0;

     for (i=0; i<CLEAR_BLOCK_COUNT; i++)
     {
         p[i] = vmalloc(CLEAR_BLOCK_SIZE);
         if (!p[i])
             break;
         size += CLEAR_BLOCK_SIZE;
     }

     while (--i)
         vfree(p[i]);

     printk("Paged %luMB of memory\n", size / 1048576UL);
}

What this routine does is call vmalloc() repeatedly for a number of 1MB 
chunks until it fails or until it's allocated 128MB (CLEAR_BLOCK_COUNT 
is equal to 128 in this case).  Then, it starts freeing them.

The side-effect of this routine is to page-out up to 128MB of RAM. 
Unfortunately, on a 128MB machine, the 118th call to vmalloc() hangs the 
system.  I was expecting it to return NULL instead.

Is this a bug in vmalloc()?  If so, is there a work-around that I can use?

