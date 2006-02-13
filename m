Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWBMC0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWBMC0D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 21:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWBMC0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 21:26:03 -0500
Received: from smtpout.mac.com ([17.250.248.47]:8391 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751045AbWBMC0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 21:26:02 -0500
In-Reply-To: <43EFD806.3000904@cfl.rr.com>
References: <Pine.LNX.4.44L0.0602121147040.9971-100000@netrider.rowland.org> <43EFD806.3000904@cfl.rr.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FEF719AC-F269-49AF-8820-74FDE1A1F4F9@mac.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sun, 12 Feb 2006 21:25:55 -0500
To: Phillip Susi <psusi@cfl.rr.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2006, at 19:51, Phillip Susi wrote:
> Alan Stern wrote:
>> Both of you are missing an important difference between Suspend-to- 
>> RAM and Suspend-to-Disk. Suspend-to-RAM is a true suspend  
>> operation, in that the hardware's state is maintained _in the  
>> hardware_.  External buses like USB will retain suspend power, for  
>> instance (assuming the motherboard supports it; some don't).
>> Suspend-to-Disk, by contrast, is _not_ a true suspend.  It can  
>> more accurately be described as checkpoint-and-turn-off.  Hardware  
>> state is not maintained.  (Some systems may support a special ACPI  
>> state that does maintain suspend power to external buses during  
>> shutdown, I forget what it's called.  And I down't know whether  
>> swsusp uses this state.)
>
> I would disagree.  The only difference between the two is WHERE the  
> state is maintained - ram vs. disk.  I won't really argue it  
> though, because it's just semantics -- call it whatever you want.

 From the simple perspective, yes, that's the only difference.  On  
the other hand, from an efficiency standpoint, they are _completely_  
different, to a degree that the OS needs to treat them as such or  
performance will suck.  Software suspend (to disk, network, file,  
etc) _requires_ a copy; it's completely mandatory because RAM is  
guaranteed to go away.  It freezes everything, checkpoints the kernel  
with a lot of really complex and oft-buggy code, unfreezes things,  
stores data, and shuts off.  Hardware suspend (to RAM only)  
implicitly needs no copy.  The CPU and memory architecture itself  
supports the low-power state, so you don't have to do much of  
anything special about kernel or userspace threads, you just have to  
suspend the device tree once (already exists for per-device power  
management) and then tell the firmware to finish up.  The former is O 
(memory), the latter is O(1).

For a significant majority of people, hardware suspend is  
significantly better.  I never understood why people need graphical  
splash screens during suspend/resume... until I tried software- 
suspend.  With hardware-suspend, I close it, 2 seconds later the  
little white light on the front comes on and it's sleeping, I open  
it, 2 seconds later it's connected to wireless again and ready to  
use.  With software-suspend, it just _doesn't_ work that fast because  
of the inherent way it does things; hard disks on laptops are _slow_.

>> So for example, let's say you have a filesystem mounted on a USB  
>> flash or disk drive.  With Suspend-to-RAM, there's a very good  
>> chance that the connection and filesystem will still be intact  
>> when you resume.  With  Suspend-to-Disk, the USB connection will  
>> terminate when the computer shuts down.  When you resume, the  
>> device will be gone and your filesystem will be screwed.
>
> This is not true.  The USB bus is shut down either way, and  
> provided that you have not unplugged the disk, nothing will be  
> screwed when you resume from disk or ram.

It depends on the hardware.  For the disk case, yes, this is true.   
On the other hand, for hardware-suspend a number of devices like  
keyboards and mice may still be in a low-power suspend mode, allowing  
you to wake the computer by pushing keys or mouse buttons.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


