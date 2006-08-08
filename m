Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWHHLTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWHHLTQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWHHLTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:19:15 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:32848 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S964851AbWHHLTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:19:14 -0400
Message-ID: <44D8732C.2060207@tls.msk.ru>
Date: Tue, 08 Aug 2006 15:19:08 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Alexandre Oliva <aoliva@redhat.com>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: modifying degraded raid 1 then re-adding other members is bad
References: <or8xlztvn8.fsf@redhat.com> <17624.29070.246605.213021@cse.unsw.edu.au>
In-Reply-To: <17624.29070.246605.213021@cse.unsw.edu.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Tuesday August 8, aoliva@redhat.com wrote:
>> Assume I have a fully-functional raid 1 between two disks, one
>> hot-pluggable and the other fixed.
>>
>> If I unplug the hot-pluggable disk and reboot, the array will come up
>> degraded, as intended.
>>
>> If I then modify a lot of the data in the raid device (say it's my
>> root fs and I'm running daily Fedora development updates :-), which
>> modifies only the fixed disk, and then plug the hot-pluggable disk in
>> and re-add its members, it appears that it comes up without resyncing
>> and, well, major filesystem corruption ensues.
>>
>> Is this a known issue, or should I try to gather more info about it?
> 
> Looks a lot like
>    http://bugzilla.kernel.org/show_bug.cgi?id=6965
> 
> Attached are two patches.  One against -mm and one against -linus.
> 
> They are below.
> 
> Please confirm if the appropriate one help.
> 
> NeilBrown
> 
> (-mm)
> 
> Avoid backward event updates in md superblock when degraded.
> 
> If we
>   - shut down a clean array,
>   - restart with one (or more) drive(s) missing
>   - make some changes
>   - pause, so that they array gets marked 'clean',
> the event count on the superblock of included drives
> will be the same as that of the removed drives.
> So adding the removed drive back in will cause it
> to be included with no resync.
> 
> To avoid this, we only update the eventcount backwards when the array
> is not degraded.  In this case there can (should) be no non-connected
> drives that we can get confused with, and this is the particular case
> where updating-backwards is valuable.

Why we're updating it BACKWARD in the first place?

Also, why, when we adding something to the array, the event counter is
checked -- should it resync regardless?

Thanks.

/mjt
