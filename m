Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUKJAwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUKJAwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbUKJAwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:52:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:30954 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261786AbUKJAwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:52:25 -0500
Date: Tue, 9 Nov 2004 16:40:53 -0800
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: Tejun Heo <tj@home-tj.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.10-rc1 2/5] driver-model: bus_recan_devices() locking fix
Message-ID: <20041110004052.GB8672@kroah.com>
References: <20041104185826.GA17756@kroah.com> <20041104191258.77740.qmail@web81309.mail.yahoo.com> <20041105061439.GA27541@home-tj.org> <d120d50004110508333c183cc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50004110508333c183cc1@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 11:33:37AM -0500, Dmitry Torokhov wrote:
> On Fri, 5 Nov 2004 15:14:39 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > Or maybe just adding a @write_lock argument to bus_for_each_*()
> > functions or create a new function named __bus_for_each_*() which
> > takes additional @write_lock argument.
> > 
> > However, I don't really think the get_bus/put_bus() calls are
> > necessary there.  Unless the caller already has a reference to the
> > bus, we're in trouble anyway.  get_bus() cannot synchronize with the
> > last put_bus(), we need outer synchronization to protect that
> > (individual bus drivers are expected to perform the synchronization).
> > 
> 
> Yes I think you are right.
> 
> > One thing that bothers me is all the "if (kobject_get(x))" codes.
> > Currently, it doesn't seem to do anything other than checking if x is
> > NULL or not and incrementing the reference count.  i.e. the return
> > value only represents if x is NULL or not.  I find the codes
> > misleading.  It seems like above statement can synchronize get() and
> > the last put() which isn't true.  I don't how how the using xchg in
> > kref went, but with preemtion turned on, I don't see how it's gonna
> > change the situation.
> >
> 
> I agree it is somewhat misleading. And even if _get would synchronize
> with _put taht wouldmean that the caller does not have a valid reference
> and the kernel will crash there next time callers uses the object in
> question.
> 
> I think we just have lay down the rules that one needs to get a reference
> to an object in the following cases:
> - object creation (first reference)
> - linking some other object to the object in question. Every link to the
>   object should increase reference count.
> - before passing object to another thread of execution to guarantee that
>   the object will live long enough for both threads.

The rules are defined.  See my OLS 2004 paper on krefs for details.

thanks,

greg k-h
