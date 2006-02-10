Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWBJVWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWBJVWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWBJVWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:22:52 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:44067 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751382AbWBJVWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:22:51 -0500
Message-ID: <43ED03F1.4010308@cfl.rr.com>
Date: Fri, 10 Feb 2006 16:21:53 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Molle Bestefich <molle.bestefich@gmail.com>
CC: device-mapper development <dm-devel@redhat.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Support HDIO_GETGEO on device-mapper volumes
References: <43EBEDD0.60608@us.ibm.com>  <20060210145348.GA12173@agk.surrey.redhat.com>  <43ECAD5B.9070308@cfl.rr.com> <62b0912f0602101227q719e712bq40da5b2f0c5422c5@mail.gmail.com>
In-Reply-To: <62b0912f0602101227q719e712bq40da5b2f0c5422c5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2006 21:23:36.0632 (UTC) FILETIME=[40ECAB80:01C62E88]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14260.000
X-TM-AS-Result: No--5.900000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> It would be better to make the decision once and for all, in one place.
>
> It would be even better for the HDIO_GETGEO call to return the same
> geometry that the BIOS uses, so that Grub is handed numbers that
> actually mean *something*.
>   

The problem is that the numbers don't actually mean anything, even to 
the bios.  They are only there for backward compatibility with real mode 
software that makes int 13 calls.  The bios just fakes the geometry 
anyway so it can emulate something, but there really is no meaning to 
the geometry; it's just smoke and mirrors. 

In the case of dm, which geometry should it report?  In some cases it 
might make sense to pass up the values from the bios, but in most, there 
is no sensible way to choose what to report, and any value you do report 
is meaningless gibberish anyhow, so why bother at all?  Just bring the 
apps still using it ( grub, lilo ) into the 21st century and have them 
stop using these meaningless values in the first place.  LBA has been 
around for a good 10 years now, so I think it is safe to no longer 
require these made up values to support CHS addressing. 
> When 'dmraid' has assembled an array, it should find the matching BIOS
> drive in /proc/bios/int13_dev* and then it should tell device-mapper
> to present that geometry to whomever asks via HDIO_GETGEO.
>   
dmraid is only one client of the kernel device mapper.  It has numerous 
uses that have nothing to do with hardware fakeraid, including LVM.  In 
the special case of dmraid there is a bios int13 dev for the raid that 
provides some geometry, but why hack dm for this special case when it is 
totally unnecessary in the first place?
> And while we're at it, <some component> should do the same for eg.
> /dev/hd?.  It's very annoying trying to fix up a harddrive's partition
> table when the numbers you see in Linux is different to the numbers
> you'll see when rebooting into DOS, or Windows XP, or whatever it is
> that's on the disk you're trying to fix.
> -
>   

