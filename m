Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbSKVHoj>; Fri, 22 Nov 2002 02:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266975AbSKVHoj>; Fri, 22 Nov 2002 02:44:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:24993 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266955AbSKVHoh>; Fri, 22 Nov 2002 02:44:37 -0500
Message-ID: <3DDDE1DC.3080408@us.ibm.com>
Date: Thu, 21 Nov 2002 23:50:52 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] export e820 table on x86
References: <Pine.LNX.4.44.0211211556340.5779-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>>What would you think of just adding another field to /proc/iomem which 
>>contains the e820 field type?
> 
> Actually, it's already there, to some degree. See the case statement in	
> register_memory() in arch/i386/kernel/setup.c, and see how all the e820 
> information percolates down from the e820 array into a simple 
> "request_resource()".

Ahh, I see how the E820_RAM results in "System RAM" from 
register_memory().  I was just trying to be lazy in the userspace app. 


> In other words, I would suggest you fix that 64-bit issue, remove the
> artificial limiting in setup.c, extend the "case" statement to cover any
> cases you're interested in, and test it on something with >4GB of memory
> to see that it works, and I'll be more than happy to take it.

I've been concentrating on exactly replicating the e820 table from 
when the initial boot happened.  Is this vital, or can we be a bit 
more relaxed once the kernel has already booted once?  Also, it 
appears that one of my entries has gone away by the time that I can 
"cat /proc/iomem"

from bootup:
  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff9380 (usable)
  BIOS-e820: 000000003fff9380 - 0000000040000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)

I added a " e820" onto the end of each of the cases in 
register_memory().  Where does the "00000000000e0000 - 
0000000000100000 (reserved)" entry go?  I wonder if it is vital to the 
next boot...

0000000000000000-000000000009dbff : System RAM e820
000000000009dc00-000000000009ffff : reserved e820
00000000000a0000-00000000000bffff : Video RAM area
00000000000c0000-00000000000c7fff : Video ROM
00000000000ca000-00000000000cfdff : Extension ROM
00000000000f0000-00000000000fffff : System ROM
0000000000100000-000000003fff937f : System RAM e820
   0000000000100000-000000000027c244 : Kernel code
   000000000027c245-00000000002eb71f : Kernel data
000000003fff9380-000000003fffffff : ACPI Tables e820
00000000ec3fc000-00000000ec3fffff : Alteon Networks Inc. AceNIC
00000000efbfd000-00000000efbfdfff : QLogic Corp. ISP1020 Fast-wide SC
00000000efbfe000-00000000efbfefff : Adaptec AIC-7899P U160/m (#2)
   00000000efbfe000-00000000efbfefff : aic7xxx
00000000efbff000-00000000efbfffff : Adaptec AIC-7899P U160/m
   00000000efbff000-00000000efbfffff : aic7xxx
00000000f0000000-00000000f7ffffff : S3 Inc. Savage 4
00000000feb00000-00000000feb7ffff : S3 Inc. Savage 4
00000000febfe000-00000000febfefff : ServerWorks OSB4/CSB5 USB Contro
00000000febffc00-00000000febffc1f : Advanced Micro Devic 79c970
00000000fec00000-00000000fec00fff : reserved e820
00000000fee00000-00000000fee00fff : reserved e820
00000000fff80000-00000000ffffffff : reserved e820


-- 
Dave Hansen
haveblue@us.ibm.com

