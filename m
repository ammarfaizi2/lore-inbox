Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbUDGGMH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 02:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264111AbUDGGMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 02:12:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:408 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264105AbUDGGMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 02:12:00 -0400
Date: Tue, 6 Apr 2004 23:11:46 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Brian King <brking@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: call_usermodehelper hang
Message-ID: <20040407061146.GA10413@kroah.com>
References: <4072F2B7.2070605@us.ibm.com> <20040406172903.186dd5f1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406172903.186dd5f1.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 05:29:03PM -0700, Andrew Morton wrote:
> Brian King <brking@us.ibm.com> wrote:
> >
> > I have been running into some kernel hangs due to call_usermodehelper. Looking
> > at the backtrace, it looks to me like there are deadlock issues with adding
> > devices from work queues. Attached is a sample backtrace from one of the
> > hangs I experienced. My question is why does call_usermodehelper do 2 different
> > things depending on whether or not it is called from the kevent task? It appears
> > that the simple way to fix the hang would be to never have call_usermodehelper
> > use a work_queue since it must be called from process context anyway, or
> > am I missing something?
> > 
> 
> swapper is running call_usermodehelper() while holding
> down_write(&bus->subsys.rwsem); via bus_add_driver().
> 
> Meanwhile, keventd is blocked on the same lock in bus_add_device().
> 
> I'd say that the bug lies in the kobject code - we should not call
> call_usermodehelper() while holding any locks which keventd may ever
> acquire.

How is keventd calling sysfs code?  Is scsi using it to drive device
detection somehow?  I don't see how the kobject core code itself can do
this on its own.

thanks,

greg k-h
