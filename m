Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUFHTvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUFHTvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 15:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbUFHTvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 15:51:46 -0400
Received: from email.careercast.com ([216.39.101.233]:2961 "HELO
	email.careercast.com") by vger.kernel.org with SMTP id S263731AbUFHTvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 15:51:41 -0400
Subject: 2.6 vm/elevator loading down disks where 2.4 does not
From: Clint Byrum <cbyrum@spamaps.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086724300.5467.161.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Jun 2004 12:51:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the long email. I pruned it as much as possible...

The problem:

When we upgraded one of our production boxes (details below) to 2.6.6,
we noticed an immediate loss of 5 - 15 percent efficiency. While these
boxes usually had less than 0.5% variation through out the day, this box
was consistently doing 10% fewer searches than the others.

Upon investigation, we saw that the 2.6 box was reading from the disk
about 5 times as much as 2.4. Iin 2.4 we can almost completely saturate
the CPUs; they'll get to 90% of the real CPU's, and 15% of the virtual
CPUs. With 2.6, they never get above 60/10 because they are in io-wait
state constantly (which, under 2.4, is reported as idle IIRC). I have
not done extensive testing of the anticipatory elevator, but it did
appear slower than deadline in early tests.

The vmstat runs at the bottom of this email were done in parallel on two
machines, receiving mostly identical amounts of real traffic. Traffic is
load balanced by mod_backhand to these machines, and is directly
responsive to system load with a granularity of 2 seconds, so really,
the 2.6.6 box was actually getting somewhat *less* traffic. Notice how
much higher the 'bi' numbers are, for blocks in. As I said before,
expected variation is less tham 0.5%.

This behavior is consistent and has been observed for over a month in
production now. I'm just looking for reasons this is happening and maybe
what needs to be profiled/tuned/fixed in order to find out.

If you're still interested by this point, here is the Background:

We have a bunch of identical Dual P4 Xeon 2.8Ghz machines. Each has an
Intel i865 chipset, 1GB of DDR RAM, and 2xWDC 40GB 8MB cache drives. All
are running RedHat 8.0 with security patches from fedoralegacy.org. All
are running vanilla kernel 2.4.23 or later, except one, that runs 2.6.6.
The 2.6.6 kernel was built directly from one of the other kernel's
.config with 'make oldconfig'. Two new options were selected..  
CONFIG_4KSTACKS, and (on the cmdline) elevator=deadline. The two disks
are setup in software RAID1. There is no swap configured.
 
These machines run text searches from web requests using a proprietary
file-based database (called Texis, http://www.thunderstone.com). The
data access patterns are generally "search through index files in a
tree-walking type of manner, then seek to data records in data files."
The index files are less than 300MB, and constantly accessed. The data
files total 3GB, but the data being read is very small... at most 40kB
at a time.


And now for the real details:

---------------------VMSTAT 2.4.23-------------------------

$ free -m ; uptime ; vmstat 5 5 
             total       used       free     shared    buffers    
cached 
Mem:          1007        983         24          0         12       
812 
-/+ buffers/cache:        157        850 
Swap:            0          0          0 
 14:51:06 up 113 days, 22:22,  1 user,  load average: 0.70, 0.59, 0.64 
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu---- 
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa 
 0  0      0  25284  13284 832500    0    0     1     1    1     1 12 
2 86  0 
 1  0      0  20748  13312 832688    0    0    37    39  139    92  3 
0 97  0 
 3  0      0  16720  13348 833020    0    0    63    80  189   222 12 
2 86  0 
 0  0      0  23672  13376 833184    0    0    31    57  166   142  7 
1 92  0 
 1  0      0  16572  13412 833288    0    0    20    51  155   137  5 
1 93  0 

------------------END VMSTAT 2.4.23-------------------------

---------------------VMSTAT 2.6.6-------------------------

$ free -m ; uptime ; vmstat 5 5 
             total       used       free     shared    buffers    
cached 
Mem:          1010        990         20          0         27       
867 
-/+ buffers/cache:         95        915 
Swap:            0          0          0 
 14:51:05 up 7 days,  1:17,  1 user,  load average: 0.59, 0.66, 0.76 
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu---- 
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa 
 0  1      0  20732  28220 888556    0    0    11    12   11    14  9 
2 88  2 
 0  0      0  27552  28260 883416    0    0   223   107  198   232 19 
3 76  2 
 0  0      0  26452  28276 884420    0    0   226    33  192   217  6 
1 87  6 
 0  0      0  26388  28308 884660    0    0    36    56  154   136  4 
0 95  0 
 0  0      0  25536  28344 885236    0    0   114    62  173   186  8 
2 89  1

------------------END VMSTAT 2.6.6-------------------------

