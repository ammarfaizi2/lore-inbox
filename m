Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263662AbVBCSMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbVBCSMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbVBCSMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:12:01 -0500
Received: from netblock-66-218-40-30.dslextreme.com ([66.218.40.30]:51404 "EHLO
	mail.lowrydigital.com") by vger.kernel.org with ESMTP
	id S263662AbVBCSIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 13:08:21 -0500
Mime-Version: 1.0 (Apple Message framework v619.2)
In-Reply-To: <42026207.4090007@vgertech.com>
References: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com> <42026207.4090007@vgertech.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ef0635f8b4257d18fad10882a2c79f64@lowrydigital.com>
Content-Transfer-Encoding: 7bit
From: Ian Godin <Ian.Godin@lowrydigital.com>
Subject: Re: Drive performance bottleneck
Date: Thu, 3 Feb 2005 10:08:24 -0800
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 3, 2005, at 9:40 AM, Nuno Silva wrote:

> Ian Godin wrote:
>>   I am trying to get very fast disk drive performance and I am seeing 
>> some interesting bottlenecks.  We are trying to get 800 MB/sec or 
>> more (yes, that is megabytes per second).  We are currently using 
>> PCI-Express with a 16 drive raid card (SATA drives).  We have 
>> achieved that speed, but only through the SG (SCSI generic) driver.  
>> This is running the stock 2.6.10 kernel.  And the device is not 
>> mounted as a file system.  I also set the read ahead size on the 
>> device to 16KB (which speeds things up a lot):
>
> I was trying to reproduce but got distracted by this:
> (use page down, if you just want to see the odd result)
>
> puma:/tmp/dd# sg_map
> /dev/sg0  /dev/sda
> /dev/sg1  /dev/sdb
> /dev/sg2  /dev/scd0
> /dev/sg3  /dev/sdc
> puma:/tmp/dd# time sg_dd if=/dev/sg1 of=/tmp/dd/sg1 bs=64k count=1000
> Reducing read to 64 blocks per loop
> 1000+0 records in
> 1000+0 records out
>
> real    0m0.187s
> user    0m0.001s
> sys     0m0.141s
> puma:/tmp/dd# time dd if=/dev/sdb of=/tmp/dd/sdb bs=64k count=1000
> 1000+0 records in
> 1000+0 records out
> 65536000 bytes transferred in 1.203468 seconds (54455956 bytes/sec)
>
> real    0m1.219s
> user    0m0.001s
> sys     0m0.138s
> puma:/tmp/dd# ls -l
> total 128000
> -rw-r--r--  1 root root 65536000 Feb  3 17:16 sdb
> -rw-r--r--  1 root root 65536000 Feb  3 17:16 sg1
> puma:/tmp/dd# md5sum *
> ec31224970ddd3fb74501c8e68327e7b  sdb
> 60d4689227d60e6122f1ffe0ec1b2ad7  sg1
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> See? dd from sdb is not the same as sg1! Is this supposed to happen?
>
> About the 900MB/sec:
> This same sg1 (= sdb, which is a single hitachi sata hdd) performes 
> like this:
>
> puma:/tmp/dd# time sg_dd if=/dev/sg1 of=/dev/null bs=64k count=1000000 
> time=1
> Reducing read to 64 blocks per loop
> time to transfer data was 69.784784 secs, 939.12 MB/sec
> 1000000+0 records in
> 1000000+0 records out
>
> real    1m9.787s
> user    0m0.063s
> sys     0m58.115s
>
> I can assure you that this drive can't do more than 60MB/sec sustained.
>
> My only conclusion is that sg (or sg_dd) is broken? ;)
>
> Peace,
> Nuno Silva
>

   Definitely have been able to repeat that here, so the SG driver 
definitely appears to be broken.  At least I'm glad I am not going 
insane, I was starting to wonder :)

   I'll run some more tests with O_DIRECT and such things, see if I can 
figure out what the REAL max speed is.

  Thanks for the help everyone,
    Ian.

