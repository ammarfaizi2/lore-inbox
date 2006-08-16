Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWHPUzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWHPUzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 16:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWHPUy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 16:54:59 -0400
Received: from galaxy.agh.edu.pl ([149.156.96.9]:4833 "EHLO galaxy.agh.edu.pl")
	by vger.kernel.org with ESMTP id S932104AbWHPUy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 16:54:59 -0400
Message-ID: <44E38620.8020005@agh.edu.pl>
Date: Wed, 16 Aug 2006 22:54:56 +0200
From: Andrzej Szymanski <szymans@agh.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Grant Coady <gcoady.lk@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
References: <44E0A69C.5030103@agh.edu.pl>
In-Reply-To: <44E0A69C.5030103@agh.edu.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on your comments I've made some more tests with different kernels,
schedulers and ext3 options (yes, I'm using ext3).

Using ext3 with data=writeback against data=ordered doesn't help,
sometimes makes things even slightly worse

Changing the kernel version from 2.6.9 to 2.6.17 has minor effect on
write delay.

Different schedulers (CFQ and deadline) on different disks and
especially with different kinds of software RAID give huge differences:

Machine 1: PIV 3GHz 2GB RAM (kernel 2.6.11)

- (4 x ATA 7200 RPM 120GB):
   - software RAID5: deadline 10-30s, CFQ 10-36s (I guess the killer are
the reads required to compute XOR)
   - software RAID10: deadline 3-6s, CFQ 4-14s
- software RAID0  (2xSCSI 15000 RPM 36GB): deadline 1-3s, CFQ 2-10s

Machine 2: PIV 3.2GHz 512MB RAM (kernels 2.6.9, 2.6.11, 2.6.12, 2.6.17)
- single disk ATA 7200RPM 60GB: deadline: 3-8s, CFQ: 10-20s

Laptop: Pentium-M 1.7, 512MB RAM (kernel 2.6.17)
- single 2,5" 5400RPM 80GB ATA disk: deadline 6-23s, CFQ 6-17s

The time is the max write() time (64KB) I have observed for different
simultaneously writing threads (the numbers are just from one pass with
a specific load, so they are not statistically valid).

Just for comparison on Machine 1, RAID5, deadline scheduler writes with
fsync() after each write last max. 1.1 - 1.7s.

I've also made a single test with xfs filesystem - the problem remains
the same, so it doesn't seem to be connected with ext3.

For me it seems that linux has somehow hardcoded minimum expectations
about disk performance (maybe the number of pages flushed at once),
since with SCSI everything is OK, with 7200 RPM ATA more or less OK,
with 5400 ATA much worse and with ATA RAID5 terrible.

Based on that I have moved the data disks on my server from RAID5 to
RAID10, and set scheduler to deadline, so my main problem with samba
timeouts is (hopefully) resolved right now.

Thanks for help!
Andrzej.


