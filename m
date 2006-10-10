Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWJJF1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWJJF1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 01:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWJJF1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 01:27:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:5096 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964986AbWJJF1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 01:27:30 -0400
Date: Mon, 9 Oct 2006 22:27:00 -0700
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is device_create_file __must_check?
Message-ID: <20061010052700.GB5938@kroah.com>
References: <17707.8801.395100.35054@cargo.ozlabs.ibm.com> <20061009214936.a2788702.akpm@osdl.org> <17707.11292.661824.337474@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17707.11292.661824.337474@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 03:14:04PM +1000, Paul Mackerras wrote:
> Andrew Morton writes:
> 
> > There are no super-strong reasons here, but if device_create_file() fails
> > then the required control files aren't there and the subsystem isn't
> > working as intended.  If it's in a module then we should fail the modprobe. 
> > If it's a bootup thing then best we can do is to panic.  Or at least log
> > the event.
> 
> In the case of the windfarm driver, the sysfs files are reporting
> things like cpu voltage, current, temperature etc. which can be
> interesting to know about, but the sysfs files are not essential to
> the operation of the driver.  So just some cheesy printk would do in
> that sort of situation, I guess.

Then add a cheesy printk into your driver then.  That's fine.

> > The most common cause of this is a programming error: we tried to create
> > the same entry twice.   We want to know about that.
> 
> In that case a WARN_ON inside device_create_file when the duplicate is
> detected would be better - less code, and only one place where the
> check needs to be done.  The WARN_ON will give us a backtrace so we
> can see where the second creation attempt happened.
> 
> > Because it can fail.  We need to take _some_ action if the setup failed - at
> > least report it so the user (and the kernel developers) know that something
> > is going wrong.
> 
> So we have to add printks in all sorts of places where the
> device_create_file has never failed before.  If you're that concerned,
> why not add a WARN_ON(error) in device_create_file() ?

Because it's kind of been proven that not even then are things fixed up
(by personal experience with people naming drivers the same thing, which
will cause an WARN_ON() in the kernel to happen, yet is ignored by the
developer.)

But I don't mind adding it there too, if that helps.  But again, even
then, don't ignore the return value, it's trying to tell you something.
If you have multiple sysfs files, just use an attribute group which will
be be unwound automatically if something goes wrong.

thanks,

greg k-h
