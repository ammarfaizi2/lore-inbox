Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWBNAua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWBNAua (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWBNAua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:50:30 -0500
Received: from smtpout.mac.com ([17.250.248.87]:9980 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030225AbWBNAu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:50:29 -0500
In-Reply-To: <43F11A9D.5010301@cfl.rr.com>
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Mon, 13 Feb 2006 19:50:15 -0500
To: Phillip Susi <psusi@cfl.rr.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13, 2006, at 18:47:41, Phillip Susi wrote:
> Alan Stern wrote:
>> It doesn't decide that -- the device itself does.  If the device  
>> was connected the entire time then it will respond properly.  If  
>> it was disconnected then it will reset itself, losing its  
>> address.  Hence it will not reply to further requests at the old  
>> address.  usb_get_status() simply indicates whether or not a  
>> response was received.
>
> I see.  Then this information is unreliable and should not be  
> trusted ( when resuming from a suspend ), as it leads to incorrect  
> behavior.

No, that information is the most reliable that can be obtained.  It  
tells us that we can no longer make any guarantees about the device  
or its state.  The USB spec is quite clear on this point.

>> Note: By "disconnected", I mean that the power session was  
>> interrupted.  So even if the cable remained plugged in, if the bus  
>> suspend power wasn't present then the device was disconnected.   
>> Note also that it is impossible to tell whether the cable has been  
>> unplugged -- the hardware is capable of detecting only whether or  
>> not the power session was interrupted.
>>
>> Given those caveats, yes, I agree that the routine should not  
>> indicate the device was disconnected if in fact it wasn't.
>
> Exactly.  Yes, there is no good way to determine _for certain_ that  
> the user did no do something stupid, such as replace the drive with  
> another one just like it, or change the contents in another  
> machine, but that is no reason to assume that the user DID do  
> something like that, and break the mount, when they in fact, did  
> nothing of the sort.

Except we can't reliably decide that.  Say I plug my USB camera in,  
mount it, and download some pictures.  I then suspend the computer,  
unplug the camera after suspending, take more pictures, plug it back  
in and resume.  That's a fairly reasonable situation and the computer  
considering the camera's state to be unchanged would be a serious bug  
and probably result in data loss.  By contrast, just considering the  
camera to be spontaneously unplugged would cause no more data loss  
than actually spontaneously unplugging the flash drive.

>> Does the kernel have any problem figuring out when a _different_  
>> device of the same type is connected at the old address after resume?
>>
>> With USB, if the entire bus is powered off then every device on it  
>> is automatically disconnected.  By definition.
>
> Then the kernel needs to ignore those disconnect events ( provided  
> that the device appears to still actually be there ) because they  
> are false and lead to data loss.

This is why hardware suspend is a good thing.  When I suspend and  
resume my laptop, there are _no_ USB disconnects.  The controller  
puts all the hubs into low-power mode, but it never disconnects them  
or causes problems.

>> You are complaining because you don't like the way USB was  
>> designed.  That's fine, but it leaves you advocating a non- 
>> standardized position.
>
> No, I am complaining because the kernel interprets the notice that  
> the bus gives that the device _may_ have changed as a notice that  
> the device in fact, _has_ changed,

No, you have this wrong.  The USB spec indicates that the device  
_HAS_ changed and all old state should be thrown away (even the  
address).  There is no way around that issue.  USB was designed to  
support hardware suspend; you can put all the hardware in low-power  
mode and still be able to detect changes.

In fact, I would argue that turning off all the busses completely  
when you want to maintain a connection to a device is broken.  If you  
want to maintain the connection, you should keep the busses powered.   
Otherwise, according to the USB spec, it's the _kernel_ that is  
terminating the connection, and assuming that it exists after  
explicitly terminating it is wrong.

Cheers,
Kyle Moffett


