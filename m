Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWBNEJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWBNEJQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWBNEJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:09:16 -0500
Received: from smtpout.mac.com ([17.250.248.47]:50112 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030341AbWBNEJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:09:15 -0500
In-Reply-To: <43F13BDF.3060208@cfl.rr.com>
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com> <43F13BDF.3060208@cfl.rr.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Mon, 13 Feb 2006 23:09:07 -0500
To: Phillip Susi <psusi@cfl.rr.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13, 2006, at 21:09, Phillip Susi wrote:
> Kyle Moffett wrote:
>> No, that information is the most reliable that can be obtained.   
>> It tells us that we can no longer make any guarantees about the  
>> device or its state.  The USB spec is quite clear on this point.
>
> That is what it says but the kernel is interpreting it as "this  
> device HAS been removed" rather than "this device MAY have been  
> removed".  That is wrong and should be fixed.

No, that's _exactly_ what the spec says (well, not verbatim but close  
enough).  When you disconnect, both the master and slave devices are  
perfectly free to assume that the connection is completely broken and  
no state is maintained.  Anything that breaks that assumption is  
against the spec and likely to break in odd scenarios.

> [multiple data-loss arguments]

Which causes worse data-loss, writing out cached pages and filesystem  
metadata to a filesystem that has changed in the mean-time (possibly  
allocating those for metadata, etc) or forcibly unmounting it as  
though the user pulled the cable?  Most filesystems are designed to  
handle the latter (it's the same as a hard-shutdown), whereas _none_  
are designed to handle the former.

A good set of suspend scripts should handle the hardware-suspend with  
no extra work because hardware supporting hardware-suspend basically  
inevitably supports USB low-power-mode, and handle software-suspend  
by either forcibly syncing and unmounting USB filesystems or by  
failing the suspend and asking the user to.  You also could patch the  
kernel to fail a powerdown software suspend if some USB device is  
mounted or otherwise unremovably in-use.

>> In fact, I would argue that turning off all the busses completely  
>> when you want to maintain a connection to a device is broken.  If  
>> you want to maintain the connection, you should keep the busses  
>> powered.  Otherwise, according to the USB spec, it's the _kernel_  
>> that is terminating the connection, and assuming that it exists  
>> after explicitly terminating it is wrong.
>
> Yes, assuming that it exists is wrong.  Probing the hardware and  
> seeing that it exists and is _probably_ the same device is entirely  
> different.  In that case it is preferable to assume the probable  
> case rather than the improbable one because it will lead to less  
> data loss.

Except that would make Linux broken with respect to the USB spec.  It  
is fallacious to assume that a USB device that the kernel has told to  
disconnect will still have the same state when the kernel tries to  
reconnect, even _if_ you could reliably identify it (which you can't  
because there is no serial number of any sort on a lot of devices.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


