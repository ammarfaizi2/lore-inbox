Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265357AbTLRWXF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 17:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265358AbTLRWXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 17:23:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:47314 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265357AbTLRWXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 17:23:00 -0500
Date: Thu, 18 Dec 2003 14:22:33 -0800
From: Greg KH <greg@kroah.com>
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module use count & unloading
Message-ID: <20031218222233.GA3614@kroah.com>
References: <20031218150525.5504D12001E@sarkovy.koeller.dyndns.org> <20031218163756.GA20882@kroah.com> <200312182303.05024.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312182303.05024.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 11:03:04PM +0100, Thomas Koeller wrote:
> On Thursday 18 December 2003 17:37, Greg KH wrote:
> >
> > It wasn't safe to do that in 2.4 either.  That would easily unload your
> > USB controller drivers, USB keyboard and USB mouse drivers, as they all
> > do not increment their in-use count.
> 
> Thanks for your reply. I am, however, somewhat confused now. If the
> in-use count cannot be trusted, then unloading a module is a fundamentally
> unsafe operation, and a tool like 'rmmod' should not exist at all.

I agree, and so do any other kernel developers who have tried to handle
module cleanup properly :)

Some modules can't mark themselves as "busy" as there really isn't such
a operation for them (like the keyboard driver, when is it busy?  When
you are typing?)  So they allow themselves to be unloaded at any time if
you want to.

I don't think any distros have the 'rmmod cleanup' cron entry in them
anymore for this very reason.  I think that happened around the time 2.2
came out, but it might have been later...

> I also
> remember that in 2.4 periodic unloading of all unused autoloaded modules
> by a cron job used to work just fine. And finally, if module unloading is
> inherently unsafe, what is the significance of all this stuff about
> forced module unloading and its dangers?

module unload is there to help kernel developers.  Yes it does seem to
work for 99% of the time for everyone, but there's some fun races in
places that are almost impossible to fix properly.  See the various
threads in the lkml archives for more details on this (including Rusty's
proposed fix that we just never unload modules at all, but just mark the
memory as "used" and then load the next version in a different place.)

> I assumed this was a bug at first and reported it as one, because I could
> not make much sense of it. Now that I've been told that this kind of
> behavior is actually intended, I still cannot...

module unloading is tricky.  In short, if you can ever help it, don't.
It's there as a convience, and that's about it.  There's now a config
option that you have to explictly enable in order to get that "feature",
CONFIG_MODULE_UNLOAD.

Hope this helps clear things up.

greg k-h
