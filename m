Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSGGXuv>; Sun, 7 Jul 2002 19:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSGGXuu>; Sun, 7 Jul 2002 19:50:50 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:57102 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316672AbSGGXut>;
	Sun, 7 Jul 2002 19:50:49 -0400
Date: Sun, 7 Jul 2002 16:51:14 -0700
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Thunder from the hill <thunder@ngforever.de>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020707235114.GE18298@kroah.com>
References: <Pine.LNX.4.44.0207071551180.10105-100000@hawkeye.luckynet.adm> <3D28C3F0.7010506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D28C3F0.7010506@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sun, 09 Jun 2002 19:34:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 03:42:56PM -0700, Dave Hansen wrote:
> BKL use isn't right or wrong -- it isn't a case of creating a deadlock 
> or a race.  I'm picking a relatively random function from "grep -r 
> lock_kernel * | grep /usb/".  I'll show what I think isn't optimal 
> about it.
> 
> "up" is a local variable.  There is no point in protecting its 
> allocation.  If the goal is to protect data inside "up", there should 
> probably be a subsystem-level lock for all "struct uhci_hcd"s or a 
> lock contained inside of the structure itself.  Is this the kind of 
> example you're looking for?

Nice example, it proves my previous points:
	- you didn't send this to the author of the code, who is very
	  responsive when you do.
	- you didn't send this to the linux-usb-devel list, which is a
	  very responsive list.
	- this is in the file drivers/usb/host/uhci-debug.c, which by
	  its very nature leads you to believe that this is not critical
	  code at all.  This is true if you look at the code.
	- it looks like you could just remove the BKL entirely from this
	  call, and not just move it around the kmalloc() call.  But
	  since I don't understand all of the different locking rules
	  inside the uhci-hcd.c driver, I'm not going to do this.  I'll
	  let the author of the driver do that, incase it really matters
	  (and yes, the locking in the uhci-hcd driver is tricky, but
	  nicely documented.)
	- this file is about to be radically rewritten, to use driverfs
	  instead of procfs, as the recent messages on linux-usb-devel
	  state.  So any patch you might make will probably be moot in
	  about 3 days :)  Again, contacting the author/maintainer is
	  the proper thing to do.
	- even if you remove the BKL from this code, what have you
	  achieved?  A faster kernel?  A very tiny bit smaller kernel,
	  yes, but not any faster overall.  This is not on _any_
	  critical
	  path.

thanks,

greg k-h
