Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261572AbUJYG6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbUJYG6y (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 25 Oct 2004 02:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbUJYG6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:58:54 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:56978 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261572AbUJYG6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:58:50 -0400
Subject: Re: 2.6.9-mm1 : compile error & question
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Remi Colinet <remi.colinet@free.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
        suparna bhattacharya <suparna@in.ibm.com>,
        vara prasad <varap@us.ibm.com>,
        Hariprasad Nellitheertha <hari@in.ibm.com>
In-Reply-To: <417C2619.7060808@free.fr>
References: <417C2619.7060808@free.fr>
Content-Type: text/plain
Organization: 
Message-Id: <1098688622.2563.16.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Oct 2004 12:47:02 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Remi,

On Mon, 2004-10-25 at 03:30, Remi Colinet wrote:

> Sections:
> Idx Name          Size      VMA       LMA       File off  Algn
>  0 .text         0037d80e  c0100000  00100000  00001000  2**12         
> <-- something wrong here for LMA used to be 0xc010 000


This has been changed so that LMA (Load memory address) reflects the
physical address where sections shall be loaded. This is required to
make sure that a kexec boot can load a vmlinux image.



>                  CONTENTS, ALLOC, LOAD, DATA
> 26 .bss          0006dfa0  c06c6000  c06c6000  005c7000  2**12     <-- 
> somthing wrong with LMA for .bss.
>                  CONTENTS, ALLOC, LOAD, DATA
> 27 .comment      0000c36f  00000000  00000000  00634fa0  2**0
>                  CONTENTS, READONLY
> 28 .debug_line   0021497b  00000000  00000000  0064130f  2**0
> ...
> 
> This is very strange. The .text LMA of the vmlinux file is at 0x__0__010 
> 0000 whereas, it used to be at  0x__c__010 0000.  But then, the .bss LMA 
> of the vmlinux file suddenly jump at 0x__c__06c 6000 instead of 
> 0x__0__06c 6000 which would have seemed more natural -0).  What can 
> cause this offset? I have look for the .bss section content. It contains 
> .bss data and .bss.page_aligned. The later seems to be the root of the 
> .bss LMA offset.  .bss.page_aligned contains then empty_zero_page and 
> the  swapper_pg_dir.

This looks like a problem with the older binutils package. I had faced
similar problem on one of the machines but it was resolved as soon as I
switched to a newer binutils package.


> I finally succeded to compile the kernel, using  the following 
> OBJCOPYFLAGS in arch/i386/Makefile.
> 
> OBJCOPYFLAGS    := -O binary --change-section-lma .bss-0xc0000000 -R 
> .note -R .comment -S
> 
> I haven't yet tried to boot it.
> 
> Any idea to fix this objcopy error otherwise?

Switching to latest binutils package should help.

> Why is the .text LMA set at 0x0010 0000 instead of 0xc010 0000 as it 
> used to be?

To reflect the physical address where .text section shall be loaded. As
mentioned earlier, vmlinux booting using kexec requires this.

Thanks
Vivek



