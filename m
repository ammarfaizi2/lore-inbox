Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTDUVXY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbTDUVXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:23:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:27794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262482AbTDUVXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:23:22 -0400
Date: Mon, 21 Apr 2003 14:35:35 -0700
From: Dave Olien <dmo@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DAC960 open with O_NONBLOCK
Message-ID: <20030421213535.GB27126@osdl.org>
References: <20030421190111.GA27126@osdl.org> <200304212014.h3LKEiE00854@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304212014.h3LKEiE00854@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I looked briefly at the source code for libhd.  It consists of two
applications: hwinfo and hwscan, and a supporting library.  It has
compiled into it knowledge of all "possible" device drivers, including
the DAC960.  It has a unique of probe routine for each "possible"
device driver.  It collects information about the devices, such as disk
geometry and partition sizes.

Some of this information is collected using ioctl().  John indicated my
patch to linux 2.4's DAC driver worked.  But I think my patch makes it
only "mostly" worked, and is better because it doesn't leave the driver
in a broken state.

I think this problem needs to be fixed correctly.  I'll try to
put together a fix first for linux 2.5, and then backport it to linux 2.4.

I'll first try to get the Mylex "Global Array Manager" (GAM) software working
on a system around here.  I'll make certain it is using the pass-through
commands.  Then, I'll either try to reverse-engineer the pass-through
commands, or I'll try Christoph's suggestion of moving the
pass-through ioctl's to a new char device, and try writing a LD_PRELOAD
wrapper.

I've looked at Christoph's DAC960 patch fixing up the open method, removing
the release method and adding a media change method.  It looks OK.
I'll apply it to my local source, and begin changes from there.

I'll see if I can get something in about a week.

On Mon, Apr 21, 2003 at 04:14:44PM -0400, Alan Cox wrote:
> 
> > John Kamp has run across a libhd applcation from Suse that hit this bug.
> > It's some kind of hardware detection application.  It opens devices with
> > O_NONBLOCK.  But, it doesn't in fact use the DAC960 pass-through commands.
> 
> It should be checking major/minor first - rightfully or wrongly (I'd 
> favour wrongly) open has side effects on multiple devices.
> 
> > The difficulty is that the Mylex application is available only in binary
> > form.  Mylex is very secretive about its controller commands.
> > It would be nice to be able to create a library that an application
> > could call to perform high-level operations, and the library would
> > construct the pass-through commands and pass them to the driver.
> > Then, anyone could write their own GUI.
> 
> Or someone could just stick a command dumper in the driver. Thats how I
> wrote ps and a few other utils for my aacraid 8)
