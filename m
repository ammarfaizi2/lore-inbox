Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263666AbVBCSF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbVBCSF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbVBCR6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:58:15 -0500
Received: from bl5-237-131.dsl.telepac.pt ([82.154.237.131]:65453 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S263571AbVBCRkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:40:21 -0500
Message-ID: <42026207.4090007@vgertech.com>
Date: Thu, 03 Feb 2005 17:40:23 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Godin <Ian.Godin@lowrydigital.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Drive performance bottleneck
References: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>
In-Reply-To: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Godin wrote:
> 
>   I am trying to get very fast disk drive performance and I am seeing 
> some interesting bottlenecks.  We are trying to get 800 MB/sec or more 
> (yes, that is megabytes per second).  We are currently using PCI-Express 
> with a 16 drive raid card (SATA drives).  We have achieved that speed, 
> but only through the SG (SCSI generic) driver.  This is running the 
> stock 2.6.10 kernel.  And the device is not mounted as a file system.  I 
> also set the read ahead size on the device to 16KB (which speeds things 
> up a lot):

I was trying to reproduce but got distracted by this:
(use page down, if you just want to see the odd result)

puma:/tmp/dd# sg_map
/dev/sg0  /dev/sda
/dev/sg1  /dev/sdb
/dev/sg2  /dev/scd0
/dev/sg3  /dev/sdc
puma:/tmp/dd# time sg_dd if=/dev/sg1 of=/tmp/dd/sg1 bs=64k count=1000
Reducing read to 64 blocks per loop
1000+0 records in
1000+0 records out

real    0m0.187s
user    0m0.001s
sys     0m0.141s
puma:/tmp/dd# time dd if=/dev/sdb of=/tmp/dd/sdb bs=64k count=1000
1000+0 records in
1000+0 records out
65536000 bytes transferred in 1.203468 seconds (54455956 bytes/sec)

real    0m1.219s
user    0m0.001s
sys     0m0.138s
puma:/tmp/dd# ls -l
total 128000
-rw-r--r--  1 root root 65536000 Feb  3 17:16 sdb
-rw-r--r--  1 root root 65536000 Feb  3 17:16 sg1
puma:/tmp/dd# md5sum *
ec31224970ddd3fb74501c8e68327e7b  sdb
60d4689227d60e6122f1ffe0ec1b2ad7  sg1
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

See? dd from sdb is not the same as sg1! Is this supposed to happen?

About the 900MB/sec:
This same sg1 (= sdb, which is a single hitachi sata hdd) performes like 
this:

puma:/tmp/dd# time sg_dd if=/dev/sg1 of=/dev/null bs=64k count=1000000 
time=1
Reducing read to 64 blocks per loop
time to transfer data was 69.784784 secs, 939.12 MB/sec
1000000+0 records in
1000000+0 records out

real    1m9.787s
user    0m0.063s
sys     0m58.115s

I can assure you that this drive can't do more than 60MB/sec sustained.

My only conclusion is that sg (or sg_dd) is broken? ;)

Peace,
Nuno Silva
