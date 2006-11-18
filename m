Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756379AbWKRTDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379AbWKRTDH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 14:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756383AbWKRTDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 14:03:06 -0500
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:58784 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S1756379AbWKRTDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 14:03:03 -0500
Message-ID: <455F58AC.3030801@lwfinger.net>
Date: Sat, 18 Nov 2006 13:02:04 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Ray Lee <ray-lk@madrabbit.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
       Joseph Fannin <jhf@columbus.rr.com>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Michael Buesch <mb@bu3sch.de>, Bcm43xx-dev@lists.berlios.denunk,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: bcm43xx regression 2.6.19rc3 -> rc5, rtnl_lock trouble?
References: <455B63EC.8070704@madrabbit.org> <20061118112438.GB15349@nineveh.rivenstone.net> <1163868955.27188.2.camel@johannes.berg> <455F3D44.4010502@lwfinger.net> <455F4271.1060405@madrabbit.org>
In-Reply-To: <455F4271.1060405@madrabbit.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee wrote:
> Larry Finger wrote:
>> Johannes Berg wrote:
>>> Hah, that's a lot more plausible than bcm43xx's drain patch actually
>>> causing this. So maybe somehow interrupts for bcm43xx aren't routed
>>> properly or something...
>>>
>>> Ray, please check /proc/interrupts when this happens.
> 
> When it happens, I can't. The keyboard is entirely dead (I'm in X, perhaps at
> a console it would be okay). The only thing that works is magic SysRq. even
> ctrl-alt-f1 to get to a console doesn't work.
> 
> That said, /proc/interrupts doesn't show MSI routed things on my AMD64 laptop.
> 
>>> I am convinced that the patch in question (drain tx status) is not
>>> causing this -- the patch should be a no-op in most cases anyway, and in
>>> those cases where it isn't a no-op it'll run only once at card init and
>>> remove some things from a hardware-internal FIFO.
> 
> Okay, I can buy that.
> 
>> I agree that drain tx status should not cause the problem.
>>
>> Ray, does -rc6 solve your problem as it did for Joseph?
> 
> I can't get it to repeat other than the first two times. However, I
> accidentally stopped NetworkManager from handling my wireless a few days ago,
> and haven't restarted it, so that may play into this.
> 
> Humor me one last time, I beg. Did you look at the messages file I posted? (Or
> maybe I didn't include this second bit... Damn, I need to be more careful with
> cutting and pasting...)

The locking stuff wasn't in any of the messages that I received.

> The second sysrq-t shows locking stuff going on, can you tell me if it looks
> reasonable? It still seems to me that something acquiring and not releasing
> rtnl_lock explains what I was seeing (rtnl lock is implicated in both sysrq-t
> backtraces). I don't know if that thing is bcm43xx, though.
> 
> Is this part reasonable?:
>  1 lock held by events/0/4:
>   #0:  (&bcm->mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10
>  2 locks held by NetworkManager/4837:
>   #0:  (rtnl_mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10
>   #1:  (&bcm->mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10
>  1 lock held by wpa_supplicant/5953:
>   #0:  (rtnl_mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10

I'm not an expert on locking, but it certainly looks as if bcm43xx and wpa_supplicant are OK by 
themselves, but that NetworkManager interferes. This behavior matches what I see - I don't have 
NetworkManager on my system, but I do use wpa_supplicant, with no lockups. Of course, I have i386 
architecture.

Although NetworkManager may be the catalyst to trigger the bug, I doubt that it is the cause. 
Strictly as a guess, I would suspect that the locking problem is in SoftMAC, where we know there can 
be locking difficulties, but no one is fixing them because EOL is near for that component.

Larry
