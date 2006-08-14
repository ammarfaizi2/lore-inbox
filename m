Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWHNQg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWHNQg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWHNQg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:36:26 -0400
Received: from galaxy.agh.edu.pl ([149.156.96.9]:3319 "EHLO galaxy.agh.edu.pl")
	by vger.kernel.org with ESMTP id S1751578AbWHNQg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:36:26 -0400
Message-ID: <44E0A69C.5030103@agh.edu.pl>
Date: Mon, 14 Aug 2006 18:36:44 +0200
From: Andrzej Szymanski <szymans@agh.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange write starvation on 2.6.17 (and other) kernels
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've encountered a strange problem - if an application is sequentially 
writing a large file on a busy machine, a single write() of 64KB may 
take even 30 seconds. But if I do fsync() after each write() the maximum 
time of write()+fsync() is about 0.5 second (the overall performance is, 
of course, degraded).

The point is, that some applications (samba+smbclient) time out after 
20s waiting for write().

Does anybody have an idea how to tune the kernel to avoid this strange 
delay in write()?

I've tried to experiment with cfq and deadline IO scheduler - without 
success. Decreasing /proc/vm/dirty_ratio to 5% helps a little.

If somebody want to test it, the tool I've written for measuring maximum 
write() time is here: http://galaxy.agh.edu.pl/~szymans/writetimer

1. Compile writetimer.c
2. Put a large background read from the disk
3. Simultaneously write 10 files 200MB each (write() without fsync())
for i in 1 2 3 4 5 6 7 8 9 0 ; do ./writetimer 200 > testfile$i & done
4. and with fsync() after each write()
for i in 1 2 3 4 5 6 7 8 9 0 ; do ./writetimer -200 > testfile$i & done
(negative file size turns on fsync())

Tested on
- 2.6.15-23 (512MB RAM, Pentium-M 1.7, Ubuntu 6.06, ATA disk)
- 2.6.17-1.2145_FC5 (512MB RAM, Pentium-M 1.7, Fedora Core 5, ATA disk)
- 2.6.12-2.3.legacy_FC3smp (2GB RAM, Fedora Core 3, software RAID 5 on 4 
ATA disks)

Thanks,
Andrzej


