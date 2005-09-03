Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVICXbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVICXbh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 19:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVICXbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 19:31:37 -0400
Received: from mail.dvmed.net ([216.237.124.58]:990 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751082AbVICXbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 19:31:36 -0400
Message-ID: <431A3249.9040504@pobox.com>
Date: Sat, 03 Sep 2005 19:31:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pjones@redhat.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "ATARAID (eg, Promise Fasttrak, Highpoint 370) related discussions" 
	<ataraid-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE HPA
References: <87941b4c05082913101e15ddda@mail.gmail.com>	 <87941b4c05083008523cddbb2a@mail.gmail.com>	 <1125419927.8276.32.camel@localhost.localdomain>	 <87941b4c050830095111bf484e@mail.gmail.com>	 <62b0912f0509020027212e6c42@mail.gmail.com>	 <1125666332.30867.10.camel@localhost.localdomain>	 <62b0912f05090206331d04afd3@mail.gmail.com>	 <E1EBCdS-00064p-00@chiark.greenend.org.uk>	 <62b0912f05090209242ad72321@mail.gmail.com>	 <1125680712.30867.20.camel@localhost.localdomain>	 <62b0912f05090210441d3fa248@mail.gmail.com>	 <1125684567.31292.2.camel@localhost.localdomain>	 <1125687557.30867.26.camel@localhost.localdomain>	 <1125688483.31292.20.camel@localhost.localdomain>	 <1125692578.30867.33.camel@localhost.localdomain> <1125695649.31292.45.camel@localhost.localdomain>
In-Reply-To: <1125695649.31292.45.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Jones wrote:
> So where would you envision this code to check the partition table, the
> HPA/host default disk size, and guess how things should be set up?
> 
>>From a userland perspective, it's very difficult to let users know
> they'll be screwing themselves by partitioning the entire disk, so we
> really should be leaving HPA enabled if the protected area is indeed not
> for consumption.
> 
> Also, the heuristic is harder than this -- if we reexamine the fakeraid
> case, then it's clear we have to look for raid metadata, figure out if
> the raid includes stuff inside the HPA or not, and then if it doesn't we
> don't care -- but that's assuming there _is_ raid metadata.
> 
> Long term, many people hope, possibly unrealistically, that we'll be
> able to write out raid metadata for people creating raids on cards which
> support fakeraid, and have the BIOS grok it appropriately.  So in that
> case, we may well have a blank (or garbage) disk, and we can't check the
> partition table or any raid metadata.  Correct me if I'm wrong, but I
> don't see a simple heuristic for this case.
> 
> (as a side note, I know one user who, at OLS, noticed we fail to
> re-initialize HPA after unsuspend, so on at least t40 the disk gets
> smaller when you suspend.  This may or may not be fixed, I haven't
> checked.  But it's one more sort of pain we get into by disabling it,
> whether justified or not.)

It seems to me that one should write an ATA-specific Device Mapper 
driver, which layers on top of an ATA disk.  The driver obtains the 
starting location of HPA, then exports two block devices:  one for the 
primary data area, and one for the HPA.

For situations where we want the start Linux philosophy -- Linux exports 
100% of the hardware capability -- no DM layer needs to be used.  For 
situations where its better to treat the HPA as a separate and distinct 
area, the DM driver would come in handy.

This follows the same philosophy as fakeraid (BIOS RAID):  we simply 
export the entire disk, and Device Mapper (google for 'dmraid') handles 
the vendor-proprietary RAID metadata.

	Jeff


