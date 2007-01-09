Return-Path: <linux-kernel-owner+w=401wt.eu-S932497AbXAIXFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbXAIXFo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbXAIXFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:05:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49802 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932497AbXAIXFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:05:42 -0500
Message-ID: <45A41FA6.9040605@sgi.com>
Date: Tue, 09 Jan 2007 17:05:10 -0600
From: Michael Reed <mdr@sgi.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: Michael Reed <mdr@sgi.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>, Jeremy Higdon <jeremy@sgi.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       David Chinner <dgc@sgi.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: REGRESSION: 2.6.20-rc3-git4: EIO not returned to direct i/o application
 following disk error
References: <459EBDB3.3080408@sgi.com>
In-Reply-To: <459EBDB3.3080408@sgi.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More info.

Linux duck 2.6.20-rc3-git4 #10 SMP PREEMPT Fri Jan 5 10:58:11 CST 2007 ia64 ia64 ia64 GNU/Linux

For this test I used an Emulex host adapter, but the problem is not
unique to it.  It also occurs when the targets are connected to either
LSI or QLogic adapters.

Using O_DIRECT, once the targets are removed the application fails
to terminate until it completes its write phase and then attempts
to read/verify the written data.  It then reports data miscompares.
It should get an EIO and fail instead of continuing to have the
write (and read) operations succeed.  It used to get EIO....

As this is easily reproducible, I'm happy to try any changes which might
address the problem.

duck /root# ./disktest -cvwbB -n 10 -u 16 /dev/sde1
Tue Jan  9 15:21:39 2007: ./disktest: options: c v w b B n u
./disktest: setting O_DIRECT
Tue Jan  9 15:21:39 2007: ./disktest: /dev/sde1: maxiou 4096, secsize 64
Tue Jan  9 15:21:39 2007: ./disktest: /dev/sde1: unique id is 0, random number seed is 0
Tue Jan  9 15:21:39 2007: ./disktest: /dev/sde1: starting block 0, using direct i/o.
Tue Jan  9 15:21:39 2007: ./disktest: running 10 passes.
Tue Jan  9 15:21:39 2007: ./disktest: /dev/sde1: testing 12799 i/o units, 16 sectors in length, min io size 1, pass = 1
Tue Jan  9 15:21:39 2007: ./disktest: /dev/sde1: 0xaaaaaaaaaaaa6473 - sequential writes
Tue Jan  9 15:21:42 2007: ./disktest: /dev/sde1: 0xaaaaaaaaaaaa6473 - sequential reads
Tue Jan  9 15:21:44 2007: ./disktest: /dev/sde1: 0xaaaaaaaaaaaa6473 - random writes
Tue Jan  9 15:21:44 2007: ./disktest: /dev/sde1: 0xaaaaaaaaaaaa6473 - sequential reads
Tue Jan  9 15:21:47 2007: ./disktest: /dev/sde1: 0xaaaaaaaaaaaa6473 - 256 random reads
Tue Jan  9 15:21:47 2007: ./disktest: /dev/sde1: testing 12799 i/o units, 16 sectors in length, min io size 1, pass = 2
Tue Jan  9 15:21:47 2007: ./disktest: /dev/sde1: 0xdddddddd44446473 - sequential writes
---------- portdisable ------------
Tue Jan  9 15:22:39 2007: ./disktest: /dev/sde1: 0xdddddddd44446473 - sequential reads
Tue Jan  9 15:22:39 2007: ./disktest: /dev/sde1: data compare error number 1 at 0x2c4000: word 0 of block 0 (0)
        act = bad0bad0deaddead
        exp = dddd000000000000


and from the console

duck /root# lpfc 0001:00:02.0: 0:1305 Link Down Event x2 received Data: x2 x20 x110
 rport-2:0-2: blocked FC remote port time out: removing target and saving binding
 rport-2:0-3: blocked FC remote port time out: removing target and saving binding
lpfc 0001:00:02.0: 0:0203 Devloss timeout on WWPN 10:0:0:6:2b:8:b:9c NPort x130100 Data: x2000008 x7 x5
sd 2:0:0:0: SCSI error: return code = 0x00010000
end_request: I/O error, dev sde, sector 179986
lpfc 0001:00:02.0: 0:0203 Devloss timeout on WWPN 10:0:0:6:2b:8:b:9d NPort x130000 Data: x2000008 x7 x4
scsi 2:0:0:0: rejecting I/O to dead device
scsi 2:0:0:0: rejecting I/O to dead device
scsi 2:0:0:0: rejecting I/O to dead device
scsi 2:0:0:0: rejecting I/O to dead device
scsi 2:0:0:0: rejecting I/O to dead device
(huge numbers of these occur)


I tried the same test using O_FSYNC instead of O_DIRECT and the write error
following the portdisable propagated to the test and it exited with an EIO.

Mike




Michael Reed wrote:
> Testing using 2.6.20-rc3-git4 I observed that my direct i/o test
> application no longer receives an EIO when the fc transport deletes
> a target following a fibre channel switch port disable.
> 
> With 2.6.19 EIO is returned and the application terminates.
> 
> With 2.6.20, the requested read length is returned with incorrect
> data in the buffer.
> 
> (I was playing around with an error recovery patch when I first
> discovered this, and do believe it is not limited in scope to
> targets being removed by the transport.)
> 
> This is a serious regression which puts customer data at risk.
> 
> (Is there a formal mechanism for filing a bug?)
> 
> Mike
