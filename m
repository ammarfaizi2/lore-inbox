Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161434AbWJ3Tov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161434AbWJ3Tov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161432AbWJ3Tov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:44:51 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:9417 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1161339AbWJ3Tou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:44:50 -0500
Message-ID: <45465648.3060608@cfl.rr.com>
Date: Mon, 30 Oct 2006 14:45:12 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Daniel Barkalow <barkalow@iabervon.org>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, Andrew Morton <akpm@osdl.org>,
       mikem@beardog.cca.cpqcorp.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] make kernel ignore bogus partitions
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net> <20060509124138.43e4bac0.akpm@osdl.org> <20060509224848.GA29754@apps.cwi.nl> <20060511040014.66ea16fc.akpm@osdl.org> <20060511115117.GA870@apps.cwi.nl> <Pine.LNX.4.64.0605111822320.6713@iabervon.org> <Pine.LNX.4.61.0605121223560.9918@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605121223560.9918@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2006 19:45:02.0569 (UTC) FILETIME=[E418C590:01C6FC5B]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14784.000
X-TM-AS-Result: No--30.806400-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like this patch got merged in to only warn about partitions 
going beyond the end of the device.  What still concerns me is that I ( 
and others ) get a lot of IO error kernel messages during boot because 
we boot from a raid0 and the first disk in the set appears to contain a 
valid partition table that lists partitions larger than the single disk 
( since the partitions span both disks ).  This causes the kernel to 
complain when it probes the partitions as it tries to read beyond the 
end of the device.

The arguments in this thread for not discarding such partitions out of 
hand make sense to me, but I wonder: why does the kernel complain about 
IO errors to the disk when it KNOWS it is making an invalid request ( to 
sectors beyond the end of the device )?  Attempting the IO anyhow makes 
sense in a way if sometimes the kernel can detect the size wrongly, but 
if the IO fails, maybe the error message should be suppressed if it is 
beyond the detected end of device?


Jan Engelhardt wrote:
>> Perhaps the kernel should try reading beyond the ends of disks when it 
>> detects them, so that it can determine if there's actually available 
>> storage there, and automatically increase the size if there is? Or, at 
>> least, it could check whether the medium actually goes out to the point 
>> the partition table implies, and suppress the I/O error if the disk 
>> actually ends where it claims to.
>>
> Sounds like a good idea. In fact, I had miscreated a sun disklabel on a 
> disk because it has a slightly different notion of cylinders that I am used 
> to from x86; IOW:
> 
> dmesg:
> SCSI device sdb: 35378533 512-byte hdwr sectors (18114 MB)
> 
> fdisk:
> Disk /dev/sdb (Sun disk label): 19 heads, 248 sectors, 7200 rpm
> 7508 cylinders, 2 alternate cylinders, 7510 physical cylinders
> 0 extra sects/cyl, interleave 1:1
> (should have been 7506 cyl, 2 alt, 7508 phys)
> 
> And Solaris rightfully barfs about it when scanning disks,
> because 7510*19*248 > 35378533. Linux keeps silent,
> and I am not sure if I have a silent data corruption there (currently not 
> as it seems).
> (Since it's just a test box ATM, it's not critical.)
> 
> 
> Jan Engelhardt

