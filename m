Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVARIUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVARIUX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVARIUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:20:22 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:24845 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261177AbVARIUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:20:12 -0500
Message-ID: <41ECC8AF.9020404@hist.no>
Date: Tue, 18 Jan 2005 09:28:31 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Daniel Drake <dsd@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       Joseph Fannin <jhf@rivenstone.net>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>,
       William Park <opengeometry@yahoo.ca>
Subject: Re: [PATCH] Wait and retry mounting root device (revised)
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net> <41EC7A60.9090707@gentoo.org> <20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk> <41EC5207.3030003@osdl.org>
In-Reply-To: <41EC5207.3030003@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> Al Viro wrote:
>
>> On Tue, Jan 18, 2005 at 02:54:24AM +0000, Daniel Drake wrote:
>>
>>> Retry up to 20 times if mounting the root device fails.  This fixes 
>>> booting
>>> from usb-storage devices, which no longer make their partitions 
>>> immediately
>>> available.
>>
>>
>>
>> Sigh...  So we can very well get device coming up in the middle of a 
>> loop
>> and get the actual attempts to mount the sucker in wrong order.  How 
>> nice...
>>
>> Folks, that's not a solution.  And kludges like that really have no
>> business being there - they only hide the problem and make it harder
>> to reproduce.
>
>
> Is there a solution other than initrd/initramfs ?

There is a solution that seems obvious to me, so obvious that it ought to
be the first solution to try.  And it is guaranteed to not mess up raid 
or anything
else too.  So perhaps there is something wrong with it, or someone would 
have done this
already?  Here it is:

Apparently, USB devices doesn't appear immediately (after powerup?  after
USB bus initialization?)  We know this - therefore the USB block driver 
should know this.
The USB block driver should know that 10s (or whatever) hasn't yet 
passed, and simply
block any attempt to access block devices (or scan for them) knowing 
that it will
not work yet, but any device will be there after the pause. A root mount 
on USB will
then succeed at the _first_ try everytime, so no need for retries.

This solution is guaranteed to not mess up raid or anything else, 
because the fix is done
in the driver for the "odd" devices, not in the upper layer trying to 
use the device as a
root fs.

Surely someone must have thought of this before - is there any reason 
why this
won't work well?

The only thing I can think of is that partition scanning will cause a delay
on every system with USB block devices compiled-in, but this could be
postponed when root isn't on usb.
Partition scanning is moving to "early userspace" anyway, isn't it?  In 
the meantime,
people without USB root that don't want a bootup delay can use modular 
usb and load
the module later in some boot script.

Helge Hafting
