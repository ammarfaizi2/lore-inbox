Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbSKZBKW>; Mon, 25 Nov 2002 20:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbSKZBKW>; Mon, 25 Nov 2002 20:10:22 -0500
Received: from air-2.osdl.org ([65.172.181.6]:20399 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265898AbSKZBKV>;
	Mon, 25 Nov 2002 20:10:21 -0500
Date: Mon, 25 Nov 2002 19:10:45 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re:[BUG] sysfs on 2.5.48 unable to remove files while in use
In-Reply-To: <200211260005.gAQ05Pn15843@linux.intel.com>
Message-ID: <Pine.LNX.4.33.0211251857040.901-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Nov 2002, Rusty Lynch wrote:

> Patrick,
> 
> Sysfs (with the new subsystem_* function calls
> that your previous patch added) will crash the 
> kernel if a subsystem is unregistered with content 
> inside it.
> 
> I stumbled across this while messing with the
> noisy driver that you fixed up for proper sysfs
> usage.  To make sure that I wasn't seeing some
> side effects from kprobes, I distilled the 
> essence of the sysfs operations to a new module
> that I have attached to this email.
> 
> With sysfs mounted to /sys/, loading this module
> will cause /sys/test/ and /sys/test/ctl to be
> created.  
> 
> Test entries can be created by:
> echo "add 1 test1" > /sys/test/ctl
> 
> this will cause /sys/1/message to be created
> where message contains "test1".
> 
> This test entry can be removed by:
> echo "del 1" > /sys/test/ctl
> 
> All is fine if I create a few entries, and
> then remove them all before rmmod'ing the 
> driver, but if I create an entry and then
> attempt to rmmod the modules then my system
> freezes with a partial oops message (not 
> enough ksymoops to do anything with).

Ah yes. This is a known problem, though I do apologize for the rudeness in
the Oops. You're going to have to increment the module count whenever a 
noisy probe is registered. There is no automatic correlation between the 
subsystem refcount and the module refcount. Because that is true, there 
are some races involved between adding a probe and the module being 
unloaded. 

I recently changed the device driver mechanism for handling this. Each
driver has a semaphore that is locked when the driver is registered, and
unlocked only when the refcount reaches 0.  driver_unregister() decrements
the refcount, then waits to take the lock. If there are any users, rmmod
will block until they go away. You can try an approach like that, though 
it may not be what you want. You might just want to remove all the probes 
when someone does rmmod..

	-pat

