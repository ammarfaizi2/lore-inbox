Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWJEXdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWJEXdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWJEXdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:33:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41695 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932428AbWJEXde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:33:34 -0400
Message-ID: <45259679.7050804@torque.net>
Date: Thu, 05 Oct 2006 19:34:17 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
CC: Jeff Garzik <jeff@garzik.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] scsi updates for post 2.6.18
References: <1159995678.3437.80.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.60.0610052104330.6619@poirot.grange> <45255A02.2010308@garzik.org> <Pine.LNX.4.60.0610052129020.6619@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0610052129020.6619@poirot.grange>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> On Thu, 5 Oct 2006, Jeff Garzik wrote:
> 
>> Guennadi Liakhovetski wrote:
>>> On Wed, 4 Oct 2006, James Bottomley wrote:
>>>
>>>> This is (hopefully) my final batch of updates before we go -rc1.  It's
>>>> mainly code cleanups, some driver updates and the new qla4xxx iScsi
>>>> driver.
>>> James, is there a reason why you didn't include this one:
>>>
>>> http://marc.theaimsgroup.com/?l=linux-scsi&m=115974328128341&w=2
>>>
>>> Do you think it can cause problems?
>> It would be nice to get it tested, based on your "don't know if it works
>> though" comment...
> 
> Sure, it WOULD be nice, but I don't know how. The "don't know" refers to 
> the case 16MB block size, my tape supports only 16MB - 1 byte (according 
> to st report). Is there a way to test various block sizes with CDs / 
> hard-disks / ZIP / scanners?
> Would something with sg_dd work?

Interesting challenge.

In lk 2.6.19-rc1 with /dev/sda and
/dev/sg0 the same SCSI disk I can get close:

[root@sas parameters]# cd /sys/block/sda/queue/
[root@sas queue]# echo 32767 > max_sectors_kb
[root@sas queue]# cd /sys/module/sg/parameters/
[root@sas parameters]# echo 131072 > scatter_elem_sz
[root@sas parameters]# sg_dd if=/dev/sg0 of=/dev/null bs=512 bpt=32640 count=32k verbose=3
 >> Input file type: SCSI generic (sg) device
        open input(sg_io), flags=0x800
    inquiry cdb: 12 00 00 00 24 00
    /dev/sg0: SEAGATE   ST336754SS        0003  [pdt=0]
 >> Output file type: null device
    read cdb: 28 00 00 00 00 00 00 7f 80 00
      duration=180 ms
    read cdb: 28 00 00 00 7f 80 00 00 80 00
      duration=4 ms
32768+0 records in
32768+0 records out

So I got within 128 (512 byte) sectors of a 16 MB transfer
on a single command. Hmm.
This is with a adaptec 48300 HBA with the aic94xx driver
(take your pick which one).

Looks like
> it must be only sector size. Can I low-level format a disk with 16M 
> sector?:-)

No usually. Some SCSI disk can be formatted up to 528
byte sectors but that is a long way short.

> Another possibility is to limit the block size at 8MB - I can test that.

The sg driver gets around that in lk 2.6.19-rc1

Doug Gilbert
