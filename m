Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318014AbSHaTzL>; Sat, 31 Aug 2002 15:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSHaTzL>; Sat, 31 Aug 2002 15:55:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49423 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318014AbSHaTzK>;
	Sat, 31 Aug 2002 15:55:10 -0400
Message-ID: <3D7122F4.3FE3BD07@zip.com.au>
Date: Sat, 31 Aug 2002 13:11:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dementiev@mpi-sb.mpg.de
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Multi disk performance (8 disks), limit 230 MB/s
References: <3D7104D5.8AD2086B@mpi-sb.mpg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Dementiev wrote:
> 
> Hi all,
> 
> I have been doing some benchmarking experiments on kernel 2.4.19 with 8
> IDE disks. Due to poor performance of 2 disks at 1 IDE channels we have
> bought 4 Promise Ultra 100 TX2 (32-bit 66 Mhz) controllers and to avoid
> bus saturation Supermicro P4PDE motherboard with multiple PCI buses
> (64-bit 66 Mhz) and 2-Xeons. I submitted already PCI slot placing
> problems to the mailing list. But theoretically I can live with the
> current IDE condrollers->PCI slots assighnment.
> 
> The assignment is the following: 3 IDE controllers are connected to the
> one PCI 64-bit Hub with bandwidth 1 GByte/s and  4th controller is on
> another hub with the same characteristics.
> 
> Theoretically with 6 IBM disks (47 MB/s from the first cylinders) I
> should achieve a number about  266 MB/s (32 bit X 66 Mhz) < 6*47. AND
> 2*47 = 94 MB/s < 266 MB/s from the last two disks. Thus the rate should
> be 94 + 266 = 360 MB/s.
> 
> BUT no matter from which set of the disks I read or write I have got the
> 
> following parallel read/write rates (raw access):
> 
>          write (MB/s) read (MB/s) systime (top)  real/user/sys(time) (s)
> 
> 1 disk :        48    45          3  %           3.0 / 0.1 / 0.4
> 2 disks:        83    94          10 %           3.5 / 0.1 / 0.6
> 4 disks:        131   189         21 %           4.3 / 0.4 / 2.8
> 5 disks:        172   233                        4.5 / 0.5 / 4.5
> 6 disks:        197   234 ?       30 %           5.2 / 0.6 / 6.6
> 7 disks:        209 ? 230 ?                      5.9 / 0.6 / 8.8
> 8 disks:        214 ? 229 ?       40 %           6.7 / 0.8 /10.8
> 

raw access in 2.4 isn't very good - it uses 512-byte chunks.  If
you can hunt down the `rawvary' patch that might help, but I don't
know if it works against IDE.

Testing 2.5 would be interesting ;)

Try the same test with O_DIRECT reads or writes against ext2 filesystems.
That will use 4k blocks.

Be sceptical about the `top' figures. They're just statistical and
are subject to gross errors under some circumstances - you may have
run out of CPU (unlikely with direct IO).

direct IO is synchronous: the kernel waits for completion of each
IO request before submitting the next.  You _must_ submit large
IO's.  That means passing 128k or more to each invokation of the
read and write system calls.   See the bandwidth-versus-request size
numbers I measured for O_DIRECT ext3:
http://www.geocrawler.com/lists/3/SourceForge/7493/0/9329947/
