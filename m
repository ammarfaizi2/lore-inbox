Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTIKCm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 22:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTIKCm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 22:42:57 -0400
Received: from dp.samba.org ([66.70.73.150]:15020 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264259AbTIKCmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 22:42:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module 
In-reply-to: Your message of "Wed, 10 Sep 2003 16:06:14 MST."
             <20030910230614.GB5758@kroah.com> 
Date: Thu, 11 Sep 2003 12:33:00 +1000
Message-Id: <20030911024252.BA10C2C07F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030910230614.GB5758@kroah.com> you write:
> On Wed, Sep 10, 2003 at 06:07:35PM +1000, Rusty Russell wrote:
> > In message <20030910041122.GE9760@kroah.com> you write:

> Why are you detaching the kobject from struct module?
> In my patch I accounted for the kobject's reference count in the module
> reference count (just not the count exported to userspace, as to not
> break the userspace tools.)  So if a user has a module sysfs file open
> (like the "refcount" file), the module reference count is incremented
> and the module is not allowed to be unloaded until that count drops.
> This removes any race condition with the kobject being in use when the
> module structure is freed.

Sorry, my bad.  This is related to another bug: you unregistered the
kobject before checking the reference count.  This is bad, because the
remove can fail, and you don't re-register the kobject.  Even if we
re-register, now there's a spurious failure as the kobject vanishes
for a moment and reappears.  And let's not think about what happens if
trying to re-register the kobject fails 8(

So I think we really do want to unregister the kobject as part of the
cleanup, which makes things a little more complicated: my immediately
previous patch which should do what we want.  If it's still not clear,
then I'm obviously doing a really crappy job of explaining...

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
