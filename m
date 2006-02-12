Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWBLQc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWBLQc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 11:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWBLQc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 11:32:57 -0500
Received: from smtpout.mac.com ([17.250.248.86]:55256 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751140AbWBLQc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 11:32:56 -0500
In-Reply-To: <43EF24C0.2040902@gmail.com>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz> <200602111136.56325.merka@highsphere.net> <B5780C33-81CE-4B8A-9583-B9B3973FCC11@mac.com> <43EEF711.2010409@gmail.com> <43833C9D-40A2-42B3-83D9-3C9D3EB7C434@mac.com> <43EF24C0.2040902@gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <47B33C16-AEC3-4036-BA05-AE235014684E@mac.com>
Cc: Jan Merka <merka@highsphere.net>, Pavel Machek <pavel@ucw.cz>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sun, 12 Feb 2006 11:32:44 -0500
To: Alon Bar-Lev <alon.barlev@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2006, at 07:06, Alon Bar-Lev wrote:
> Kyle Moffett wrote:
>> Why the hell would you even _want_ to encrypt data in RAM?  If you  
>> have a secure OS install and a passworded screensaver that starts  
>> before suspend, then there is _nothing_ an attacker could do to  
>> the contents of RAM without hard-booting, which would just  
>> completely erase it, or without extremely specialized hardware and  
>> expertise.  Picking up a machine suspended to RAM is just as  
>> secure as picking up one that is on, no more or less.
>
> I guess you are not a security aware user...  A machine that is  
> turned on is *MUCH* less secured than a machine which is turned off  
> and have its disks encrypted. We can start argue on this issue  
> too... But I won't cooperate...

Where is your proof?  This is quite true for a machine on a  
_network_, but my suspended laptop isn't.  You say that I am not a  
security aware user and that therefore you are automatically right,  
but it doesn't make it so.  What is the practical vulnerability in my  
laptop's suspend-to-ram, given that it automatically locks all VTs  
and X when sleeping?  Don't you *dare* say "somebody could attach a  
hardware debugger and read your data out of RAM", because I just  
don't see that happening in any reasonable situation, there are too  
many obstacles to doing that with a _laptop_, the first of which is  
just that it's impossible to take the damn thing apart when it's on  
without disconnecting massive amounts of critical wiring.  Even if  
that _is_ a risk-case for you, it's not the use-case we should  
optimize suspend for!

>>> And another fact: Suspend-to-RAM implementation can be derived  
>>> form suspend-to-disk but not the other way around.
>>
>> No, the two are _entirely_ independent.  Suspend-to-RAM does not  
>> need to copy memory at all, whereas suspend-to-disk requires it.   
>> That very fact means that suspend-to-RAM is orders of magnitude  
>> faster than suspend-to-disk could ever be, especially as RAM gets  
>> exponentially larger.
>
> Well... I see you already planned the implementation and have all  
> figured out... But the fact is that suspend-to-RAM can be  
> implemented by suspend-to-disk without actually store the memory to  
> external device...

Right, the process goes something like this pseudocode:

put_devices_to_sleep(); /* [1] */
if (suspend_to_ram) {
	call_firmware_suspend();
} else {
	atomically_freeze_state();
	wake_devices_up();
	store_state_to_devices(); /* [2] */
	put_devices_to_sleep();
	switch(mode) {
		SUSP_SHUTDOWN: shutdown();
		SUSP_REBOOT:   reboot();
		[.......................]
	}
}

Remind me again why we should implement suspend-to-RAM as part of  
suspend-to-disk?  Especially since the _only_ shared functionality is  
[1] which is already separated out for other reasons.  A lot of  
people also seem to want to initiate and control all of [2] in  
userspace, whereas the suspend-to-RAM case needs just one syscall.

> But hay... You can implement and maintain two separate solutions...

You still have yet to prove that suspend-to-RAM and suspend-to-disk  
have anything to gain by being wrapped in a big if statement.

>> No, suspend-to-ram is for people who need instant response times,  
>> suspend-to-disk should be an extension or simplification of  
>> "Freeze a process tree and all associated system status so we can  
>> completely give up the hardware for a while".  IMHO, the fact that  
>> both are called "suspend" is just due to historical quirk as   
>> opposed to any real similarity.
>
> Again... This is a matter of implementation... I believe that one  
> complete suspend implementation can suite both disk and RAM... The  
> only difference is if you write the state to external storage, and  
> how you play with APM. So there is a good reason why both are  
> called "suspend".
>
> I don't claim that virtualization approach is not appropriate, and  
> in the future suspend may use this in order to create its snapshot,  
> and maybe, as you say, you may get suspend-to-RAM in-kernel and  
> suspend-to-disk in user-space by dumping each process's container  
> into a file (I don't know what you do with graphics and caching...  
> but let's assume you have solution for all).
>
> Let's see what happened so far:
>
> First we had swsusp... For many people it did not work, so Suspend2  
> was developed, but was not merged mainly because it had too many UI  
> components in-kernel.

Actually, I seem to recall that even before _either_ of those were  
working decently a bunch of modern hardware had good suspend-to-RAM  
support.

> Then comes the micro-kernel approach to convert swsusp into  
> uswsusp... Suspend2 which is stable now cannot be merged since it  
> violates this idea. So users will not get a proper merged solution  
> for at least one more year.
>
> Now, you come with a different solution (virtualization), so let's  
> delay suspend feature for how long? At least two years?

Personally, I really don't care if you (or whoever) wants to merge an  
intermediate suspend-to-disk/software-suspend implementation.  I  
think it would be helpful on a lot of laptops where suspend-to-RAM  
doesn't work or chews battery.  But I _really_ don't want to see  
somebody trying to patch suspend-to-RAM/hardware-suspend into that mess.

> We need (and can get) suspend to work *NOW*,

It does work now, suspend-to-RAM/hardware-suspend has been working  
perfectly on my laptop for a long time (modulo a couple powerbook USB  
bugs that crept in recently and got removed).  IMHO, a modern laptop  
that doesn't support suspend-to-RAM is a broken design, although I  
realize that it happens all too often.

> laptops are being more and more common... People expect to have  
> this ability in a modern operating system, they don't care if it is  
> implemented in kernel or in user-space, they also don't care if you  
> change it along the way... And if in the future Linux will be pure  
> virtual machine, all will be happy.... And use it... But please  
> consider offering a working solution *NOW*.

On this I do agree, but _please_ don't muck with my suspend-to-RAM  
along the way because of some egotistical "We are new-fancy-kernel- 
software-suspend, resistance is futile" type thing, ok?  Suspend-to- 
RAM/hardware-suspend and suspend-to-disk/software-suspend are two  
_completely_ different things and should not be treated the same at all.

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



