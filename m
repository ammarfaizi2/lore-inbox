Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272158AbRI0I4l>; Thu, 27 Sep 2001 04:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272122AbRI0I4c>; Thu, 27 Sep 2001 04:56:32 -0400
Received: from mx0.gmx.net ([213.165.64.100]:5105 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S272158AbRI0I4N>;
	Thu, 27 Sep 2001 04:56:13 -0400
Date: Thu, 27 Sep 2001 10:56:34 +0200 (MEST)
From: Bernd Harries <mlbha@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: __get_free_pages(): is the MEM really mine?
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0000450161@gmx.net
X-Authenticated-IP: [141.200.125.99]
Message-ID: <356.1001580994@www46.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is my 4th try to post to the list. I didn't see any echo, so 
I try again. Sorry if you did see the msg earlier (yesterday)..

Is __get_free_pages() not enough to allocate memory in the kernel?
Seems like something else is using the same memory. Do I have to lock the
pages I allocated? 

I began with 2.4.6 on a dual CPU x86 box with 256 MB RAM and when I saw
probs I upgraded to 2.4.10. Still unstable.

In a driver I'm writing, in the open() method, I use multiple 
__get_free_pages() to allocate a 4 MB kernel (image)buffer for DMA purposes.
The buffer I get is contiguous (I try until it is) and is freed in
close(). Order count is 9.

When I run the user appl. again after short time I mostly get the 
same chunk of physical memory (virt_to_bus is identical!)

For access from userspace I implemented mmap() which uses the nopage()
method of the VMA. The user program hexdumps 256 bytes of the beginning
of the 4 MB buffer and 256 bytes of 0x2000 above the beginning.

After the hexdump fromm userspace I trigger a DMA engine to copy 
0x8000 bytes (4 * the offset of the 2nd hexdump) from my kernelbuffer to a
'Local RAM' on a PCI card. (For now I only copy out to be sure the
buffer is not modified)

I see mostly zeroes in both of the 2 hexdumps.

If I repeat the user program within seconds, suddenly the 2nd 
256 byte dump starts to change. Sometimes I see filenames of my harddisk
within the hexdump, looking like some directory listing. (e.g.
"/etc/ppp/options" ) Sometimes I see the contents of the printk buffer of
the kernel, sometimes stuff I cannot identify.

The dump form the first page seems to stay zero all the time. 
The bus address of the Buffer is the same each time.

I wouldn't bother about the changes if the system wouldn't seem 
to become compromised by the tests. Sometimes a dump occurs on the console
when I try to buid a new version of my driver module.
Sometimes the shell in which I started the test program gets logged out.

I have a feeling that the effect only occurs if the 2nd dump is beyond the
1st page of my kernel buffer.



Here is the output of my test program:

pcma73:/home/bharries/c/apr/>aprdma_shmw 0x8000 0 1
 open('/dev/aprsc027', ) seems ok! fd = 3 
 Get fix par 
 mmio: start=$DC800000 off=$00000000 len=$00001000 
 mem1: start=$E0000000 off=$00000000 len=$02000000 
 mem2: start=$DA000000 off=$00000000 len=$02000000 

 colcon_offs=$00000000 
 fifo1_offs =$01000000 
 fifo2_offs =$01100000 
 shm_offs   =$01400000 shm_ram_size=$00400000 
 hwcsr_offs =$01A00000 

 Get var par 
 rx_pmd_adr  =$00000000 rx_msg_typ =$00000000 
 tx_pmd_adr  =$00000000 tx_msg_typ =$00000000 
 dma_bus_adr0=$00000000 contig_len0=$00000000 
 dma_bus_adr1=$03800000 contig_len1=$00400000    <-- BUS Addr

 dma0=$00000000 len=$00000000 
 dma1=$40132000 len=$00400000           <-- mmapped User Addr

Diagnose Dump Adr=$40132000

:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                  
  
Diagnose Dump Adr=$40134000

:3D 24 30 30 30 30 30 30 30 30 20 0A 53 65 70 20  =$00000000 *Sep 
:32 36 20 31 32 3A 31 35 3A 30 34 20 70 63 6D 61  26 12:15:04 pcma
:37 33 20 6B 65 72 6E 65 6C 3A 20 20 73 74 61 72  73 kernel:  star
:74 2B 6F 66 66 3D 24 43 33 38 30 30 30 30 30 20  t+off=$C3800000 
:70 61 67 65 5F 70 74 72 3D 24 63 31 30 65 30 30  page_ptr=$c10e00
:30 30 20 0A 53 65 70 20 32 36 20 31 32 3A 31 35  00 *Sep 26 12:15
:3A 30 34 20 70 63 6D 61 37 33 20 6B 65 72 6E 65  :04 pcma73 kerne
:6C 3A 20 20 61 64 64 72 65 73 73 3D 24 34 30 31  l:  address=$401
:33 34 30 30 30 20 61 64 20 2D 20 76 6D 5F 73 74  34000 ad - vm_st
:61 72 74 3D 24 30 30 30 30 32 30 30 30 20 56 4D  art=$00002000 VM
:41 5F 4F 46 46 53 45 54 3D 24 30 30 30 30 30 30  A_OFFSET=$000000
:30 30 20 0A 53 65 70 20 32 36 20 31 32 3A 31 35  00 *Sep 26 12:15
:3A 30 34 20 70 63 6D 61 37 33 20 6B 65 72 6E 65  :04 pcma73 kerne
:6C 3A 20 20 73 74 61 72 74 2B 6F 66 66 3D 24 43  l:  start+off=$C
:33 38 30 32 30 30 30 20 70 61 67 65 5F 70 74 72  3802000 page_ptr
:3D 24 63 31 30 65 30 30 38 30 20 0A 00 00 00 00  =$c10e0080 *    
   Fill DMA ioctl struct 
 Local RAM write triggered. 
 Local RAM write end. 

 Now close '/dev/aprsc027' fd = 3 ...




-- 
-- 
Bernd Harries

bha@gmx.de            http://bharries.freeyellow.com
bharries@web.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org       +49 172 139 6054 handy  | Medusa T40

GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

