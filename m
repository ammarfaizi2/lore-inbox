Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVDAFTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVDAFTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 00:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVDAFTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 00:19:32 -0500
Received: from mail.naturesoft.net ([203.145.184.221]:11400 "EHLO
	naturesoft.net") by vger.kernel.org with ESMTP id S262637AbVDAFSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 00:18:18 -0500
Subject: Re: HELP: PC104 IO card driver Problem
From: saroj kumar pradhan <sarojkumarp@naturesoft.net>
To: nobin matthew <nobin_matthew@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       kernelnewbies@nl.linux.org
In-Reply-To: <20050331053744.97435.qmail@web53903.mail.yahoo.com>
References: <20050331053744.97435.qmail@web53903.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1112419475.2293.14.camel@saroj.naturesoft.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 02 Apr 2005 10:54:35 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 11:07, nobin matthew wrote:
> Dear Friends,
> 
> Can anybody Help me in this Pc104 driver Problem;
> What is the basics steps in doing read and write on
> Pc104 cards.
> 
> Deatails Given Below:
>               I am writing a Linux device driver for
> Diamond systems
> IR104 digital IO card. This is a PC104 bus device(that
> means it ISA
> bus compatible).
> The Platform is Arcom Viper borad(with support for
> PC104), This is a
> Xscale, Little endian Platform.
> 
> The Specification of PC104 interface  given in Viper
> borad manual is:
> 0x3C000000-0x3CFFFFFF PC/104 memory space(16MB)
> 0x30000000-0x300003FF PC/104 IO space(1KB)
> 
> Specification given in IR104 manual is:
> I made the jumber setting so that, the IO space
> addresses  taken by 8
> registers will be 0x300-0x307
> 
> The driver should do read and write on this
> registers(character device
> driver).
> 
> I took two approaches one is:
> i added IO space and 0x300, did inb() and oub().(IO
> space base address
> and 0x300)
> otherway i did ioremap on added result, did inb() and
> oub().

  /* Remap a not (necessarily) aligned port region */
void *short_remap(unsigned long phys_addr)
{
    /* The code comes mainly from arch/any/mm/ioremap.c */
    unsigned long offset, last_addr, size;

    last_addr = phys_addr + SHORT_NR_PORTS - 1;
    offset = phys_addr & ~PAGE_MASK;
    
    /* Adjust the begin and end to remap a full page */
    phys_addr &= PAGE_MASK;
    size = PAGE_ALIGN(last_addr) - phys_addr;
    return ioremap(phys_addr, size) + offset;
}

/* Unmap a region obtained with short_remap */
void short_unmap(void *virt_add)
{
    iounmap((void *)((unsigned long)virt_add & PAGE_MASK));
}

> 
> In the second method:
> I did same procedures using IO memory space
  Here Use ioremap to get a base address in the     
  region(0x3C000000-0x3CFFFFFF).
  Suppose ISA_BEGIN = 0x3C000000, ISA_END = 0x3CFFFFFF
  void *base;
  base = ioremap(ISA_BEGIN, ISA_END - ISA_BEGIN);
  base = base - ISA_BEGIN; /* offset */
  
  Use these base address to read and write the IO region.
  
  

  For more details go to http://www.xml.com/ldd/chapter/book/ch08.html
to get more info.


> 
> both methods are giving errors, i think that is
> related to paging. i think
> there is a need for disabling paging in this space.
> 
> Please help regarding this. How to solve this.
> 
> Nobin Mathew
> 
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> Take Yahoo! Mail with you! Get it on your mobile phone. 
> http://mobile.yahoo.com/maildemo
> 
> --
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
> 
> 

