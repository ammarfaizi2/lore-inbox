Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264607AbUDVRhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbUDVRhw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUDVRhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:37:52 -0400
Received: from sark.cc.gatech.edu ([130.207.7.23]:56277 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP id S264607AbUDVRht
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:37:49 -0400
Date: Thu, 22 Apr 2004 13:37:48 -0400
From: rm <async@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: OOPS in input subsystem
Message-ID: <20040422173747.GD16075@tokyo.cc.gatech.edu>
References: <20040421203724.GB16075@tokyo.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421203724.GB16075@tokyo.cc.gatech.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 04:37:24PM -0400, rm wrote:
> [2.] Full description of the problem/report:
> 
> I can reliably get an oops if i do the following: 
> 1. plug in a ibm USB numeric keypad
> 1.  cat /dev/input/event1  (which corresponds to the keypad)
> 2.  unplug the keypad (leaving the cat in 1 running)
> 3. run another cat /dev/input/event1
> 
> NOTE: the first instance of cat doesn't get any sort of end of file or
> 	file error (which i believe was the old behaviour ~2.4). 


	so upon further investigation, it seems like the event
device's disconnect handler is called, and if the device is open it
calls input_close_device.  

	since the file is still open, you can't release it then. so to
prevent someone else from opening the now non existent device, it
seems like evdev open should specifically check to make sure the
handle is still valid, before letting the user open it.

	although, the process that is holding the device open should
receive an error when it is disconnected, but i don't know how to
notify it of this error.  shouldn't input_close_device perform this?  

	does anyone have any thoughts on the correct solution to this?

	thanks, 
	rob

> oops:
> Call Trace:
>  [<c0277d81>] input_accept_process+0x31/0x40
>  [<cf91736f>] evdev_open+0x5f/0x100 [evdev]
>  [<c01d166e>] file_alloc_security+0x3e/0xb0
>  [<c02789ee>] input_open_file+0x7e/0x170
>  [<c0173a67>] chrdev_open+0x117/0x300
>  [<c01691b9>] get_empty_filp+0x79/0x120
>  [<c0167170>] dentry_open+0x130/0x1e0
>  [<c0167038>] filp_open+0x68/0x70
>  [<c01675ab>] sys_open+0x5b/0x90
>  [<c010975d>] sysenter_past_esp+0x52/0x71

----
Robert Melby
Georgia Institute of Technology, Atlanta Georgia, 30332
uucp:     ...!{decvax,hplabs,ncar,purdue,rutgers}!gatech!prism!gt4255a
Internet: async@cc.gatech.edu
