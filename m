Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWBMXsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWBMXsn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWBMXsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:48:43 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:22098 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1030301AbWBMXsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:48:42 -0500
Message-ID: <43F11A9D.5010301@cfl.rr.com>
Date: Mon, 13 Feb 2006 18:47:41 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 23:49:37.0639 (UTC) FILETIME=[26217F70:01C630F8]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14266.000
X-TM-AS-Result: No--29.200000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> It doesn't decide that -- the device itself does.  If the device was
> connected the entire time then it will respond properly.  If it was
> disconnected then it will reset itself, losing its address.  Hence it will
> not reply to further requests at the old address.  usb_get_status() simply
> indicates whether or not a response was received.
>   

I see.  Then this information is unreliable and should not be trusted ( 
when resuming from a suspend ), as it leads to incorrect behavior. 
> Note: By "disconnected", I mean that the power session was interrupted.  
> So even if the cable remained plugged in, if the bus suspend power wasn't
> present then the device was disconnected.  Note also that it is impossible
> to tell whether the cable has been unplugged -- the hardware is capable of
> detecting only whether or not the power session was interrupted.
>
> Given those caveats, yes, I agree that the routine should not indicate the 
> device was disconnected if in fact it wasn't.
>
>   
Exactly.  Yes, there is no good way to determine _for certain_ that the 
user did no do something stupid, such as replace the drive with another 
one just like it, or change the contents in another machine, but that is 
no reason to assume that the user DID do something like that, and break 
the mount, when they in fact, did nothing of the sort. 
> Does the kernel have any problem figuring out when a _different_ device 
> of the same type is connected at the old address after resume?
>
> With USB, if the entire bus is powered off then every device on it is
> automatically disconnected.  By definition.
>
>   
Then the kernel needs to ignore those disconnect events ( provided that 
the device appears to still actually be there ) because they are false 
and lead to data loss. 
> Have you tried unplugging a SCSI or IDE drive while it was mounted and the 
> system was suspended, and then plugging in a different drive in its place?
>   
No, because that would be a foolish user error. 
> No.  A bug is unintentional whereas a design flaw is intentional.
>   
It doesn't matter if it is broken by design, or broken by 
implementation; it's still broken. 
> You are ignoring the question of how the kernel can tell whether two 
> devices are in fact the same.  There is no safe way to do this, other than 
> having the hardware verify that the device was connected the whole time.
>
>   
If there is no better way to tell for sure that the device that is now 
there is not the same as the one that was there, then the kernel must 
assume the user did not do something stupid and continue to use the 
device as if it was not disconnected ( because odds are, it in fact, was 
not ).  In other words, which is more safe?  ALLWAYS loosing data 
because you can't be absolutely sure that the device is the same, or 
only loosing data if the user does something as foolish as swapping 
drives while suspended, and you can't tell they did?
> It's a matter of definition.  By definition, "disconnected" means 
> essentially the same thing as "power interrupted".  If you use the wrong 
> definition, of course you will think that the hardware lies.
>
>   
And that appears to be exactly what the kernel is doing; interpreting 
the hardware "power interrupted" flag as "disconnected", which leads to 
broken behavior and data loss. 
>
> But it is very reliable.  And all USB hardware does it; it's part of the 
> specification.
>   

Except when the bus is powered down, in which case, using that flag as 
an indicator that the device has in fact changed, is not reliable. 
> It works both ways.  What about "causes data loss when a different device 
> is plugged in"?
>
>   
Again, that's user error, not normal operation.  You shouldn't go 
changing devices around while suspended because it _might_ confuse the 
kernel.  The way things are now, the kernel _will_ get confused when the 
user does nothing wrong. 
> You are complaining because you don't like the way USB was designed.  
> That's fine, but it leaves you advocating a non-standardized position.
>   
No, I am complaining because the kernel interprets the notice that the 
bus gives that the device _may_ have changed as a notice that the device 
in fact, _has_ changed, and causes data loss when nothing is actually 
wrong, and this could easily be avoided. 
> Can you suggest a _reliable_ way to tell if the USB device present at a 
> port after resuming is the same device as was there before suspending?
>
> Alan Stern
>   
Again, if it appears to be the same as best you can tell, there is no 
reason to require absolute certainty that it actually is; you can assume 
that the user did not do foolish things while suspended.  This is a much 
safer assumption than always assuming that they DID because that always 
leads to data loss, whereas assuming they didn't ( which they won't most 
of the time ) doesn't lead to data loss when they didn't. 


