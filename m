Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVAFSDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVAFSDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVAFR4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:56:05 -0500
Received: from cantor.suse.de ([195.135.220.2]:65229 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262943AbVAFRxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:53:44 -0500
Date: Thu, 6 Jan 2005 18:53:42 +0100
From: Andi Kleen <ak@suse.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, greg@kroah.com
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106175342.GA28889@wotan.suse.de>
References: <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106163559.GG5772@vana.vc.cvut.cz> <20050106165715.GH1830@wotan.suse.de> <20050106172613.GI5772@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106172613.GI5772@vana.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc list trimmed]

On Thu, Jan 06, 2005 at 06:26:13PM +0100, Petr Vandrovec wrote:
> > Why are you issuing 64bit ioctls from 32bit applications? 
> 
> There are three reasons (main reason is that vmware is 32bit app, but it is how
> things are currently laid out; even if there will be 64bit app, 32bit versions are
> already in use and people wants to use them on 64bit kernels):
> 
> * USB.  usbfs API is written in a way which does not allow you to safely wrap
> it in "generic" 32->64 layer, and attempts to do it in non-generic way in usbfs
> code itself did not look feasible year ago.  Even on current 64bit kernels it is not
> possible to issue raw USB operations from 32bit apps, and I do not believe that
> it is going to change - after all, just issuing ioctl through 64bit path from application
> which is aware of 64bit kernel is quite simple, much simpler than any attempt to
> make kernel dual-interface.

Agree that's a problem. We just need an alternative interface here
or I try to come up with an x86-64 specific hack (I think it's possible
to do the compatibility x86-64 specific, just not in compat code for
all architectures who have truly separated user/kernel address spaces) 

I hope the USB people will eventually add a better interface here.
Greg?

> 

> * parport interface, serial port:  not all APIs were implemented in kernel.  Current
> kernels do wrap all APIs vmware needs, but older kernels do not, and so we had to find
> some solution for older kernels too.  Not so surprisingly, solution we had in place for
> USB works for them too...

But that's a non issue for the new kernels affected by the new ioctl 
interface.

> 
> * floppy:  it is actually different from examples above, as FDRAWCMD command is
> supported by 32->64 layer, but it is supported incorrectly.  Due to this all above
> started, as we had to make application aware of kernel it runs on, as FDRAWCMD on 32bit
> kernel returns 80 byte structure, while 104 byte on 64bit kernel, and you do not now
> which one you'll get until you call this ioctl...  And once we had code in place,
> it was reused for USB and later for ppdev & serial.

Did you submit a patch for that?  If not you should.

> So we added simple wrapper to vmmon which just gets {64bit-ioctl-number, 64bit-arg-argument}
> and passes it down to 64bit sys_ioctl:

The magic 64bit interface isn't a very good interface, don't expect
that to be supported in the future.

-Andi
