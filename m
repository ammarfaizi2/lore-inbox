Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbUKQPzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbUKQPzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 10:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUKQPzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 10:55:12 -0500
Received: from dummy.cluj.astral.ro ([193.230.240.25]:30887 "EHLO
	cnn.astral.ro") by vger.kernel.org with ESMTP id S262352AbUKQPyg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 10:54:36 -0500
Date: Wed, 17 Nov 2004 17:54:32 +0200
From: Catalin Muresan <catalin.muresan@astral.ro>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bogdan.luca@astral.ro
Subject: High sys load on 2xOpteron 1.8Ghz
Message-ID: <20041117155432.GA6809@astral.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.9-k1 i686
Organization: ASTRAL Telecom
X-NCC-RegID: ro.dnt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

	We have an 2xOpteron 244 system, 1G RAM, 2x Broadcom BCM5704 GE net
cards, doing traffic shaping with HTB (incoming interface eth1, outgoing -
limited - eth2). Both interfaces are in a bridge so the shaping is
transparent. Vmstat show the following:

[root@firelog tmp]# vmstat 1 5
procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0      0 368936 131420 127932    0    0     1     8   69    29  1 77 22 0
 0  0      0 368936 131420 127932    0    0     0    48 15058   517  0 88 12 0
 2  0      0 368936 131420 127932    0    0     0     0 16767   503  0 88 12 0
 1  0      0 368936 131420 127932    0    0     0     0 15441   512  0 89 11 0
 1  0      0 368936 131420 127932    0    0     0     0 19753   625  0 84 16 0

	traffic is from 80 to 150mbps through the bridge, top shows the following:

top - 15:03:23 up 1 day,  5:31,  1 user,  load average: 1.32, 0.98, 0.88
Tasks:  43 total,   3 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 11.1% id,  0.0% wa,  1.5% hi, 87.4% si
Mem:   1027120k total,   637808k used,   389312k free,   131412k buffers
Swap:        0k total,        0k used,        0k free,   116040k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                                
    3 root      35  19     0    0    0 R 83.9  0.0 751:39.34 ksoftirqd/0                                            
    5 root      34  19     0    0    0 R  8.3  0.0 133:12.10 ksoftirqd/1                                            
    6 root       5 -10     0    0    0 S  1.0  0.0   0:32.02 events/0                                               
 3340 root      16   0 37296 2260  33m S  0.7  0.2   0:01.49 sshd                                                   
 3485 root      16   0  5928 1108 5700 R  0.3  0.1   0:00.08 top                                                    
(rest of the tasks removed)

	and a few hours later the load shifts:

top - 17:44:59 up 1 day,  8:12,  1 user,  load average: 0.85, 0.62, 0.54
Tasks:  43 total,   5 running,  38 sleeping,   0 stopped,   0 zombie
 Cpu0 :  0.7% us,  0.2% sy,  0.0% ni, 17.2% id,  0.0% wa,  1.7% hi, 80.2% si
 Cpu1 :  1.9% us,  0.6% sy,  0.0% ni, 26.5% id,  0.1% wa,  2.4% hi, 68.5% si
Mem:   1027120k total,   657608k used,   369512k free,   131420k buffers
Swap:        0k total,        0k used,        0k free,   127932k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                                      
    5 root      35  19     0    0    0 R 58.4  0.0 198:37.77 ksoftirqd/1                                                  
    3 root      34  19     0    0    0 S  9.5  0.0 791:29.23 ksoftirqd/0                                                  
 3340 root      16   0 37296 2312  33m R  1.6  0.2   0:10.38 sshd                                                         
 3921 root      15   0  5928 1104 5700 R  1.6  0.1   0:00.03 top                                                          
    1 root      16   0  3480  156 3304 S  0.0  0.0   0:12.05 init                                                         
(rest of the tasks removed)

	where we can see high si (softinterrupts?) load on both cpus, and
ksoftirqd eating up a lot of cpu time. 

[root@firelog tmp]# cat /proc/interrupts 
           CPU0       CPU1       
  0:   85568875   30499894    IO-APIC-edge  timer
  1:        214          8    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          0          0    IO-APIC-edge  rtc
 14:          1         13    IO-APIC-edge  ide0
 24:   93363786 1395294442   IO-APIC-level  ioc0, eth1
 25:  914715643   32650125   IO-APIC-level  ioc1, eth2
 28:     206992     114047   IO-APIC-level  eth0
NMI:      96529      86093 
LOC:  116040676  116040542 
ERR:          0
MIS:          0

	there are around 12000 htb classes on in/out respectively:

[root@firelog tmp]# tc class show dev eth1 | wc -l
12010
[root@firelog tmp]# tc class show dev eth2 | wc -l
12010

	can anyone give me an explanation for this load? what else can i
test/do? Please CC: me as I'm not on the list. thanks.

-- 
catalin
