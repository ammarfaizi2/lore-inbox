Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWBMUjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWBMUjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWBMUjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:39:11 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:35641 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S964880AbWBMUjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:39:10 -0500
Message-ID: <43F0EE30.2090409@cfl.rr.com>
Date: Mon, 13 Feb 2006 15:38:08 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602131425140.4632-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0602131425140.4632-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 20:40:01.0832 (UTC) FILETIME=[A99F1A80:01C630DD]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14266.000
X-TM-AS-Result: No--35.900000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> Okay.  Take a look at drivers/usb/core/hub.c.  The usb_resume_device()  
> routine is called when resuming either from STR or STD.  If
> CONFIG_USB_SUSPEND has been set, it calls hub_port_resume(), which in turn
> calls finish_device_resume().  Inside finish_device_resume() is a call to
> usb_get_status(), which will fail if the device has not been connected and
> powered-up throughout the entire suspend.  That failure will cause 
> hub_port_resume() to call hub_port_logical_disconnect(), which has the 
> effect of doing a logical disconnect on the device.
>   

Interesting.  How does usb_get_status() decide if the device has been 
connected or not the entire time?  And do you not agree that if it 
indicates that the device was disconnected during hibernation, when it 
in fact, was not, that is a bug?
> There are other, redundant code paths that perform this check even when 
> CONFIG_USB_SUSPEND isn't set, but they are more difficult to describe.  
> For example, look at uhci_check_and_reset_hc() in 
> drivers/usb/host/pci-quirks.c.
>
> You'll find that nowhere in the resume pathway does the kernel check
> serial numbers or anything else of that nature.  If the power session has
> not been interrupted, that's sufficient proof that the device hasn't been
> unplugged.
>
>   
And what if the entire bus was completely powered off, which some 
systems do?  I know my SCSI bus is completely powered off during 
hibernation, yet the kernel has no problem figuring out that the same 
devices are still connected after resume, so it doesn't generate a 
disconnect event. 
> It may work that way with SCSI disks or IDE disks, which are not
> hotpluggable.  But it does happen with USB disks, and it's not a bug;
> it's by design.
>   
SCSI and IDE very well can be hot pluggable.  I have hot plugged 
external SCSI devices numerous times, and even internal IDE drives a 
time or two.  Clearly if the kernel thinks you disconnected your drive 
and causes data loss, when this is not true, it is a bug.  If it is a 
flaw by design, that is still a class of bug. 
> Again, in hub.c look at hub_events().  It's a rather long routine, but at 
> some point you can see where it checks (portchange & 
> USB_PORT_STAT_C_CONNECTION).  The constant stands for "Port Status Changed 
> Connection", meaning there has been a plug/unplug event.  If the test 
> succeeds then connect_change is set to 1, causing 
> hub_port_connect_change() to be called.  One of the first things that 
> routine does is call usb_disconnect() on the port's child device.
>
>   
Interesting again.  This bit exists for each node on the bus and is 
tracked by the hardware?  If that is the case, and the hardware is 
informing the kernel that all devices were disconnected during 
hibernation when this is not the case, then this clearly is a bug in the 
hardware, and the kernel possibly should work around it knowing that the 
hardware lies. 
> You've got it exactly backwards.  The kernel doesn't need to make that 
> assumption because the hardware will _tell_ it whether anything was 
>   
Even if some hardware does, there is a lot of hardware that does not.  
If hardware that is capable of delivering this information does so in an 
unreliable manner ( i.e. it lies and says everything is disconnected 
when it isn't ) then the kernel should ignore that information. 
> disconnected.  Rather, the kernel needs to _avoid_ making the assumption 
> that the device there now is the same as the device that was there before, 
> merely because a serial number (or something equivalent) happens to match.  
> Note: many USB mass storage devices don't have serial numbers.
>
>   
If the hardware is capable of accurately and reliably informing the 
kernel about this information, then that would be useful, but if it is 
not, then seeing a device that appears to be the same as the one you 
expect to be there is good enough to decide to continue using it rather 
than force data loss.  It works fine like that for SCSI and IDE because 
the user expects the system to work properly after they suspend/resume 
when they don't mess with the hardware.  If you actually disconnect a 
device and replace it with another one that otherwise looks the same, 
but isn't really, then all bets are off. 
>>  This is how it behaves 
>> for say, SCSI disks in desktops/servers, where the controller certainly 
>> is completely powered off.  It should work the same for USB. 
>>     
>
> No it shouldn't.  USB is a different kind of bus from SCSI; it has
> different specifications and standards, and it should behave differently.
>
>   
Not if "differently" means "causes data loss when hibernating". 
> Take a look, for example, at the UHCI specification (available from 
> <http://developer.intel.com/technology/usb/uhci11d.htm>).  Section 2.1.7 
> describes the Port Status and Control register, which indicates (for each 
> port) whether a connect-change event has taken place, as well as many 
> other things.
>
>   
I'll have to read up on that.  If that is the case, then it seems the 
hardware is broken because it incorrectly indicates disconnects that did 
not actually happen. If this is a known problem, then the kernel should 
work around it to avoid data loss. 
>
> I agree that it's annoying and undesirable, but it's not a bug.  Other 
> buses would work this way too if they were hotpluggable, like USB.
>   
Other busses can be hot plugged in this way without causing incorrect 
disconnect events and data loss over hibernation.  The fact that USB 
causes data loss in the face of such a benegin event as hibernating and 
resuming ( with no actual hardware change ) is a bug.  Claiming that 
data loss is an acceptable price to pay for being able to hot plug is 
silly. 
> As I said above, SCSI isn't the same as USB.
>   
Right... which doesn't make this any less of a bug in the USB stack. 
> By the way, usb-storage in 2.4 used to work (still does, in fact) more 
> along the lines you're describing.  You could unplug a drive and the 
> kernel's disk data structures would be kept intact.  Later on, when you 
> replugged the drive it would be re-associated with those data structures, 
> using some not-go-great heuristics for trying to find a match, and you 
> could pick up where you left off.
>
> Then at some point during the 2.5 development sequence, Linus put his foot
> down.  He said that when a device goes away, it's _gone_!  That was the
> end of it.  Ever since, unplugging a USB drive (or any other kind of USB
> device) causes all its device structures to be released.
>   

If you ACTUALLY unplug the drive, that's fine... if you don't though, 
and the kernel thinks you did, that is a bug.  If the kernel can 
reasonably decide that the drive has not actually been unplugged even 
though the busted hardware indicates it has, then it should not generate 
a disconnect. 


