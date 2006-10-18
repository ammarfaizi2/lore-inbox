Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbWJRQ0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWJRQ0N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWJRQ0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:26:12 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:61963 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1422641AbWJRQ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:26:11 -0400
Date: Wed, 18 Oct 2006 12:26:10 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Paolo Ornati <ornati@fastwebnet.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M"
 from card reader
In-Reply-To: <4535F47D.4060009@aitel.hist.no>
Message-ID: <Pine.LNX.4.44L0.0610181211050.7542-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Helge Hafting wrote:

> Alan Stern wrote:
> > Verbose usb-storage debugging messages would help more 
> > (CONFIG_USB_STORAGE_DEBUG and CONFIG_USB_DEBUG).  If the kernel hangs very 
> > badly you might need to use a serial console to capture all the logging 
> > information.
> >   
> Version information first: This is 2.6.19-rc1, not mm1.  I apparently
> forgot to apply the mm1 patch before compiling it.
> 
> I got a BUG, which I could write down by getting X out of the way first.
> It is repeatable, just ask if I omitted something cruical. On bootup,
> the verbose debugging complains about read errors on sdc,
> I guess the kernel tries to get the partition table.  I have no idea
> why there is read errors - that shouldn't hang anything though.

That's why I asked for the USB debugging logs (which you forgot to include
here).

> To bring it down:
> 
> dd if=/dev/sdc of=sdc.dump bs=1M
> 
> sd 0:0:0:2 ioctl_internal_command return code: 8000002
>  :Current: Sense key: Hardware Error
>   Additional Sense: End_of_data detected
> cut here----
> Kernel BUG at [Verbose debugging unavailable]
> invalid opcode: 0000 [#1]
> cpu:0
> EIP: 0060:[<c031f823>] Not tainted VLI
> Eflags: 00010002  (2.6.16-rc1 #16)

Hmmm.  Well, a recent patch affecting that area was just reverted because 
it added some problems.  Maybe you're seeing those same problems.  
Although I don't think they involved invalid opcode errors...

You're the second person I've seen report invalid opcode errors in the
recent kernels.  The other report involved uhci-hcd, not ehci-hcd.  See
here:

http://marc.theaimsgroup.com/?l=linux-usb-users&m=115942141207661&w=2

It's possible that both of these are caused by something unrelated 
overwriting kernel memory.

By the way, what happens if you add a "skip=" argument to dd so that the 
copy begins near the end of the device?  Does the oops then occur that 
much sooner?

Oh, and the next time this happens, could you copy down all of the code
bytes from the oops message?  And also provide the section from "objdump
-d drivers/usb/host/ehci-hcd.o" for the start_unlink_async routine?

Alan Stern

