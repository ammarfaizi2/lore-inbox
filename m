Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVBPXFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVBPXFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVBPXFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:05:23 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:54053 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262116AbVBPXE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:04:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jjrZ8kgXNrN7WVrikNR/DCpeKepjKRtoI6h1K1yJPe7PK8jQlx/KPsfukiPtZxIA6NygqfffWGvjoajPmb/czdbvxFwRZHFp5Cnb3NaPCY4mJG4KcNDHjYpJpJoaeoYG4AavP/W8qCsBorQl9UenwY9e7Xps5OyFNDMFgFsnNRU=
Message-ID: <170fa0d20502161504f8db91b@mail.gmail.com>
Date: Wed, 16 Feb 2005 16:04:57 -0700
From: Mike Snitzer <snitzer@gmail.com>
Reply-To: Mike Snitzer <snitzer@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: dm perf scales poorly with 2.6.x kernel
In-Reply-To: <170fa0d205021520083b24c1b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <170fa0d205021520083b24c1b6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

figured I'd open this up to a wider audience in that I've not gotten a
reply on dm-devel.

---------- Forwarded message ----------
From: Mike Snitzer <snitzer@gmail.com>
Date: Tue, 15 Feb 2005 21:08:00 -0700
Subject: dm perf scales poorly with 2.6.x kernel
To: dm-devel@redhat.com


I have seen a _serious_ read performance bottleneck in what seems to
be the DM I/O path.  Read I/O to the block layer decreases
significantly once a DM device is added.  In speaking with Kevin Corry
on #evms he didn't have a system that could match the muscle of my
test system (specs listed below) but he used a single disk on his test
system to see if the performance degradation is realized once a DM
layer is introduced.

In our initial discussion, Kevin said "the issue seems to obviously be
in DM, if that's the only extra layer it's going through."  He also
offered: I wonder if it's a memory allocation issue....DM clones every
incoming bio, which may slow down the processing more than we
expected.

The simple test performed with Kevin's single disk and my system is
just sequential reads using dd from the raw block layer.

Kevin's single disk results were performed on a regular dos partition:
1) about 30.3 MB/s without DM
2) about 26.1 MB/s with DM (using an EVMS compatibility volume; which
generates one DM device)

With Kevin's minimal hardware configuration he saw a 13% performance
hit once a linear DM device was introduced.  I can't speak to which
Linux kernel Kevin was using but I'm sure he'll volunteer that info
should it be required.

All that said, here are my system specs:
8 7200rpm raid edition SATA drives, 1 3ware 9500S controller, and 2
EM64T cpus w/ 2GB of DDR2.  The storage is an 8 disk Linux MD raid5
with a linear LV on the raid5 (lvm2 volume as created with EVMS).

The throughput of the raw MD raid5 device is 289 MB/s and this raw
performance was realized with both a SUSE 2.6.5-7.145 kernel and
kernel.org 2.6.11-rc4.  The following results are from using a SUSE
sles9 2.6.5-7.145.  But I know that is not an acceptible data point
for bringing this type of issue to the greater dm/linux community so I
reran the test using 2.6.11-rc4 and in doing so the DM read
performance went from 118MB/s (listed below) to roughy 50MB/s!  Using
the SUSE kernel I'm seeing a 60% performance hit with DM introduced;
and with 2.6.11-rc4 there is hit of 80+%!?

===
blockdev --setra 8192 /dev/md0_

$ sync; /usr/bin/time dd if=/dev/md0 of=/dev/null bs=1024k count=10000

10000+0 records in
10000+0 records out

10485760000 bytes transferred in 34.578472 seconds (303245325
bytes/sec (289MB/s)
0.03user 31.83system 0:34.57elapsed 92%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+393minor)pagefaults 0swaps
---
NOW VOLUME0 (DM via EVMS's lvm2 support) _on MD0_

$ sync; /usr/bin/time dd if=/dev/evms/volume0 of=/dev/null bs=1024k count=10000

10000+0 records in
10000+0 records out

10485760000 bytes transferred in 103.464303 seconds (101346645
bytes/sec (96MB/s))
0.02user 90.19system 1:43.46elapsed 87%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+393minor)pagefaults 0swaps

$ blockdev --setra 8192 /dev/evms/volume0
$ sync; /usr/bin/time dd if=/dev/evms/volume0 of=/dev/null bs=1024k count=10000

10000+0 records in
10000+0 records out

10485760000 bytes transferred in 84.278222 seconds (124418382
bytes/sec (118MB/s)
0.02user 82.05system 1:24.27elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+393minor)pagefaults 0swaps
===

Ultimately there appears to be a disproportionate increase in the DM
performance hit as the IO throughput capability of the underlying
block device increases (I'm obviously using a limited sampling so...).
 But given the current results it is clear there will be a performance
hit associated with using DM; but having that hit be fixed as the
throughput scales would be ideal.

regards,
Mike
