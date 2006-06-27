Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422710AbWF0W4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbWF0W4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161343AbWF0W4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:56:49 -0400
Received: from blargh.com ([24.234.115.147]:28807 "EHLO blargh.com")
	by vger.kernel.org with ESMTP id S1161342AbWF0W4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:56:48 -0400
From: 7091@blargh.com
To: linux-kernel@vger.kernel.org
Subject: Data corruption on SiI 3114?
Date: Tue, 27 Jun 2006 15:56:32 -0700
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <courier.44A1B7A0.00000A99@blargh.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all. 

The short version first:  I'm having problems with data corruption on a 
software raid5 partition that is using 4 SATA drives hanging off of an addon 
SiI 3114 card.  This has been going on for a couple months now, with my 
thinking some action has fixed it and having to wait to see that it doesn't. 
I recently started using iozone (source from 
http://www.iozone.org/src/current/iozone3_263.tar) which generally triggers 
it fairly quickly: 

Test #1:
./iozone -R -g 4G -a -+d > ~/iozone.report
(blahblahblah)
         524288    8192   75582   88670   141979   142247  141863  116981  
142000  135012  142464    69620    77813  142197   142480
         524288   16384   81263   93395   142279   142543  142399  114740  
142307  135391  141962    70295    92522  141945   142090
        1048576      64   81280   88546 

Error in file: Position 0 0 0
Error in file: Position 93847552
Record # 1432 Record size 64 kb
(dropped the Char line since it has high ASCII)
Found pattern: Hex >>ffffffff<< Expecting >>fffffffb<< 

Test #2:
         262144    8192   64311  110685   136845   126089  125882   69296  
137398  101758  138808    68244    73281  137469   138596
         262144   16384   73250   87237   137979   138027  127386   69802  
130037   65369  133270    74445    90564  123972   102779
         524288      64   74796  142936 

Error in file: Position 1664 0 0
Error in file: Position 473616384
Record # 7226 Record size 64 kb
(dropped the Char line since it has high ASCII)
Found pattern: Hex >>ffffffff<< Expecting >>fffffffb<< 

Other tests I've done:
memtest86 and mprime both run for a couple days without showing problems.
iozone running on other partitions does not error. 

I'm trying to troubleshoot to see what portion of hardware/software is 
flakey, but having a difficult time doing so.  This same server has a pair 
of parallel ATA drives hanging off the motherboard, running software raid1, 
that do not expose the problem.  This would seem to eliminate everything not 
directly associated with the raid5 setup, and leaves the raid5 driver, the 
sata_sil driver, the SATA card itself, drive cabling, or the drives.  But 
the raid5 driver should catch errors from the sata_sil driver on down.  This 
leaves either a memory/CPU problem (which memtest86 or mprime didn't find) 
or a bug in raid5 (which I can't believe, as commonplace as it is). 

Any suggestions, what-have-you to troubleshoot this is appreciated.  My key 
problem is I can't really afford to lose the data on the raid5 partition - 
I've backed up all the absolutely critical things, but I just don't have the 
backup capacity for it all, and would rather not lose it. 

System details:
Motherboard: Tyan Tiger MPX (S2466N), with 2 AMD Athlon MP 2000+ processors, 
and 1 gig of RAM
Kernel: A number of different kernels, ranging from Debian-packaged 2.6.8-1, 
grsec 2.6.14-1, up through the currently-installed 2.6.17.1 downloaded from 
kernels.org.
Drive configuations:
SiI 3114 card using sata_sil driver, with 4 ST3300831AS drives connected.  
These 4 drives are combined using the Linux raid5 driver to make a single 
826GiB partition, mounted as /home.
Onboard IDE with 2 ye-ol generic 40G drives.  5 seperate raid1 instances, 
providing /, /tmp, /usr, /var, and /chroot.
All partitions are using ext3. 


