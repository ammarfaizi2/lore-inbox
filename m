Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755214AbWKRR1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214AbWKRR1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 12:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755210AbWKRR1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 12:27:16 -0500
Received: from tapsys.com ([72.36.178.242]:37310 "EHLO tapsys.com")
	by vger.kernel.org with ESMTP id S1755208AbWKRR1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 12:27:15 -0500
Message-ID: <455F4271.1060405@madrabbit.org>
Date: Sat, 18 Nov 2006 09:27:13 -0800
From: Ray Lee <ray-lk@madrabbit.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       Joseph Fannin <jhf@columbus.rr.com>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       John Linville <linville@tuxdriver.com>, Michael Buesch <mb@bu3sch.de>,
       Bcm43xx-dev@lists.berlios.denunk, Adrian Bunk <bunk@stusta.de>
Subject: Re: bcm43xx regression 2.6.19rc3 -> rc5, rtnl_lock trouble?
References: <455B63EC.8070704@madrabbit.org> <20061118112438.GB15349@nineveh.rivenstone.net> <1163868955.27188.2.camel@johannes.berg> <455F3D44.4010502@lwfinger.net>
In-Reply-To: <455F3D44.4010502@lwfinger.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Finger wrote:
> Johannes Berg wrote:
>> Hah, that's a lot more plausible than bcm43xx's drain patch actually
>> causing this. So maybe somehow interrupts for bcm43xx aren't routed
>> properly or something...
>>
>> Ray, please check /proc/interrupts when this happens.

When it happens, I can't. The keyboard is entirely dead (I'm in X, perhaps at
a console it would be okay). The only thing that works is magic SysRq. even
ctrl-alt-f1 to get to a console doesn't work.

That said, /proc/interrupts doesn't show MSI routed things on my AMD64 laptop.

>> I am convinced that the patch in question (drain tx status) is not
>> causing this -- the patch should be a no-op in most cases anyway, and in
>> those cases where it isn't a no-op it'll run only once at card init and
>> remove some things from a hardware-internal FIFO.
>

Okay, I can buy that.

> I agree that drain tx status should not cause the problem.
> 
> Ray, does -rc6 solve your problem as it did for Joseph?

I can't get it to repeat other than the first two times. However, I
accidentally stopped NetworkManager from handling my wireless a few days ago,
and haven't restarted it, so that may play into this.

Humor me one last time, I beg. Did you look at the messages file I posted? (Or
maybe I didn't include this second bit... Damn, I need to be more careful with
cutting and pasting...)

The second sysrq-t shows locking stuff going on, can you tell me if it looks
reasonable? It still seems to me that something acquiring and not releasing
rtnl_lock explains what I was seeing (rtnl lock is implicated in both sysrq-t
backtraces). I don't know if that thing is bcm43xx, though.

Is this part reasonable?:
 1 lock held by events/0/4:
  #0:  (&bcm->mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10
 2 locks held by NetworkManager/4837:
  #0:  (rtnl_mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10
  #1:  (&bcm->mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10
 1 lock held by wpa_supplicant/5953:
  #0:  (rtnl_mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10

(So locks A, A&B, B)

...of the below...

 Showing all locks held in the system:
 1 lock held by events/0/4:
  #0:  (&bcm->mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10
 1 lock held by getty/4224:
  #0:  (&tty->atomic_read_lock){--..}, at: [mutex_lock_interruptible+9/16]
mutex_lock_interruptible+0x9/0x10
 1 lock held by getty/4225:
  #0:  (&tty->atomic_read_lock){--..}, at: [mutex_lock_interruptible+9/16]
mutex_lock_interruptible+0x9/0x10
 1 lock held by getty/4226:
  #0:  (&tty->atomic_read_lock){--..}, at: [mutex_lock_interruptible+9/16]
mutex_lock_interruptible+0x9/0x10
 1 lock held by getty/4227:
  #0:  (&tty->atomic_read_lock){--..}, at: [mutex_lock_interruptible+9/16]
mutex_lock_interruptible+0x9/0x10
 1 lock held by getty/4228:
  #0:  (&tty->atomic_read_lock){--..}, at: [mutex_lock_interruptible+9/16]
mutex_lock_interruptible+0x9/0x10
 1 lock held by getty/4229:
  #0:  (&tty->atomic_read_lock){--..}, at: [mutex_lock_interruptible+9/16]
mutex_lock_interruptible+0x9/0x10
 2 locks held by NetworkManager/4837:
  #0:  (rtnl_mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10
  #1:  (&bcm->mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10
 1 lock held by wpa_supplicant/5953:
  #0:  (rtnl_mutex){--..}, at: [mutex_lock+9/16] mutex_lock+0x9/0x10
 1 lock held by less/29492:
  #0:  (&tty->atomic_read_lock){--..}, at: [mutex_lock_interruptible+9/16]
mutex_lock_interruptible+0x9/0x10
 1 lock held by bash/9871:
  #0:  (&tty->atomic_read_lock){--..}, at: [mutex_lock_interruptible+9/16]
mutex_lock_interruptible+0x9/0x10

 =============================================

Regardless, I'm going to withdraw my regression report until I can reproduce
this. I can't justify holding anything up if we can't even finger a culprit to
look at. In the meantime I'll try running with rc6.

Ray
