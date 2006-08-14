Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWHNSOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWHNSOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWHNSOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:14:45 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:14212 "EHLO
	ns1.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751688AbWHNSOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:14:44 -0400
Message-ID: <44E0C4F1.4010209@wolfmountaingroup.com>
Date: Mon, 14 Aug 2006 12:46:09 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrzej Szymanski <szymans@agh.edu.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
References: <44E0A69C.5030103@agh.edu.pl>
In-Reply-To: <44E0A69C.5030103@agh.edu.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Szymanski wrote:

> Hi,
>
> I've encountered a strange problem - if an application is sequentially 
> writing a large file on a busy machine, a single write() of 64KB may 
> take even 30 seconds. But if I do fsync() after each write() the 
> maximum time of write()+fsync() is about 0.5 second (the overall 
> performance is, of course, degraded).
>
> The point is, that some applications (samba+smbclient) time out after 
> 20s waiting for write().
>
> Does anybody have an idea how to tune the kernel to avoid this strange 
> delay in write()?
>
> I've tried to experiment with cfq and deadline IO scheduler - without 
> success. Decreasing /proc/vm/dirty_ratio to 5% helps a little.
>
> If somebody want to test it, the tool I've written for measuring 
> maximum write() time is here: 
> http://galaxy.agh.edu.pl/~szymans/writetimer
>
> 1. Compile writetimer.c
> 2. Put a large background read from the disk
> 3. Simultaneously write 10 files 200MB each (write() without fsync())
> for i in 1 2 3 4 5 6 7 8 9 0 ; do ./writetimer 200 > testfile$i & done
> 4. and with fsync() after each write()
> for i in 1 2 3 4 5 6 7 8 9 0 ; do ./writetimer -200 > testfile$i & done
> (negative file size turns on fsync())
>
> Tested on
> - 2.6.15-23 (512MB RAM, Pentium-M 1.7, Ubuntu 6.06, ATA disk)
> - 2.6.17-1.2145_FC5 (512MB RAM, Pentium-M 1.7, Fedora Core 5, ATA disk)
> - 2.6.12-2.3.legacy_FC3smp (2GB RAM, Fedora Core 3, software RAID 5 on 
> 4 ATA disks)
>
> Thanks,
> Andrzej
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Sounds like a problem with the elevator code.  As often as the memory 
management gets rewritten and busted, no telling where the condition is 
coming from.  I have not seen this problem on released kernels with the 
distros, but I have seen on on post 2.6.14 kernels, which is why I am 
not using them.  Seems related to user space memory usage in some way, 
and not the actual elevator code.    Try an older kernel and see if it 
goes away.

Jeff
