Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315911AbSEGRYR>; Tue, 7 May 2002 13:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315912AbSEGRYQ>; Tue, 7 May 2002 13:24:16 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:8355 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S315911AbSEGRYK>;
	Tue, 7 May 2002 13:24:10 -0400
Message-Id: <200205071724.g47HO4P26841@tinman.seitzassoc.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
Subject: host mastered 64 bit wide transfers to 64 bit PCI slot?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 May 2002 10:24:04 -0700
From: Galen Seitz <galens@seitzassoc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a custom 64 bit wide PCI card installed in a 64 bit slot.  The card has 
an 8 MB prefetchable memory window available via BAR 0.  Memory accesses work 
(/dev/mem and mmap), but I'm not seeing 64 bit wide transfers (req64, ack64 
aren't toggling).  How can I get the host/northbridge to generate 64 bit wide 
transfers?  

I'm currently trying to do my testing from user space.  Here's a snippet
of code.  The code leading up to this just reads from /proc/bus/pci/devices
to get the BAR info.  I run this code while holding a scope probe on /REQ64.
Note that this is strictly a question about the width of data transfers.
I'm not doing 64 bit addressing (no DAC cycles).  Host info follows the
code.

TIA,
galen


  if ((memfd = open("/dev/mem", O_RDWR)) < 0)
    perror("open /dev/mem");
  
  function = 0;
  i = 0;
  pmem = mmap(0, size[function][i], PROT_READ | PROT_WRITE, MAP_SHARED, memfd,
       bar[function][i] & PCI_BASE_ADDRESS_MEM_MASK);
  if (pmem == MAP_FAILED)
    perror("mmap");
  else
    printf("pmem = %08x\n", pmem);

  memset(pmem, 0, size[function][i]);
  if (msync(pmem,  size[function][i], MS_SYNC))
    perror("msync");

  for (offset = 0; offset < size[function][i]; offset += 8)
    {
      *(unsigned long long *)(pmem + offset) = offset;
    }

  if (msync(pmem,  size[function][i], MS_SYNC))
    perror("msync");

  for (offset = 0; offset < size[function][i]; offset += 8)
    {
      if (*(unsigned long long *)(pmem + offset) != offset)
	{
	  printf("Error at %04x\n", offset);
	  exit(1);
	}
    }

  if (msync(pmem,  size[function][i], MS_SYNC))
    perror("msync");

  if (munmap(0, size[function][i]))
    perror("munmap");

  if (close(memfd))
    perror("close");


The host is an ASUS A7M266-D motherboard (AMD 762 chipset) with a single
800 MHz Duron, and 256 MB DDR.

oz:/home/galens/jobs/45th/sw/pci# cat /proc/version 
Linux version 2.4.9-13 (bhcompile@stripples.devel.redhat.com) (gcc version 
2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Tue Oct 30 19:32:27 EST 2001

oz:/home/galens/jobs/45th/sw/pci# /sbin/lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 (rev 04)
00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441 (rev 
04)
00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
00:09.0 Memory controller: Galileo Technology Ltd.: Unknown device 6430 (rev 
10)
00:09.1 Memory controller: Galileo Technology Ltd.: Unknown device 6430 (rev 
10)
00:09.2 Memory controller: Galileo Technology Ltd.: Unknown device 6430 (rev 
10)
00:09.3 Memory controller: Galileo Technology Ltd.: Unknown device 6430 (rev 
10)
00:09.4 Memory controller: Galileo Technology Ltd.: Unknown device 6430 (rev 
10)
00:09.5 Memory controller: Galileo Technology Ltd.: Unknown device 6430 (rev 
10)
00:09.6 Memory controller: Galileo Technology Ltd.: Unknown device 6430 (rev 
10)
00:09.7 Memory controller: Galileo Technology Ltd.: Unknown device 6430 (rev 
10)
00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448 (rev 04)
01:05.0 VGA compatible controller: S3 Inc. Trio 64 3D (rev 01)
02:08.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] 
(rev 04)



