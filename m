Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317454AbSGIX1R>; Tue, 9 Jul 2002 19:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317455AbSGIX1Q>; Tue, 9 Jul 2002 19:27:16 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:44806 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317454AbSGIX1P>;
	Tue, 9 Jul 2002 19:27:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driverfs updates 
In-reply-to: Your message of "Tue, 09 Jul 2002 09:56:55 MST."
             <Pine.LNX.4.33.0207090947140.961-100000@geena.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Jul 2002 09:29:45 +1000
Message-ID: <31410.1026257385@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002 09:56:55 -0700 (PDT), 
Patrick Mochel <mochel@osdl.org> wrote:
>On Tue, 9 Jul 2002, Keith Owens wrote:
>> struct device_driver * get_driver(struct device_driver * drv)
>> {
>>         if (drv && drv->owner)
>>                 if (!try_inc_mod_count(drv->owner))
>>                         return NULL;
>>         return drv;
>> }
>> 
>> is racy.  The module can be unloaded after if (drv->owner) and before
>> try_inc_mod_count.  To prevent that race, drv itself must be locked
>> around calls to get_driver().
>> 
>> The "normal" method is to have a high level lock that controls the drv
>> list and to take that lock in the register and unregister routines and
>> around the call to try_inc_mod_count.  drv->bus->lock is no good,
>> anything that relies on reading drv without a lock or module reference
>> count is racy.  I suggest you add a global driverfs_lock.
>
>This race really sucks. 
>
>Adding a high level lock is no big deal, but I don't think it will solve 
>the problem. Hopefully you can educate me a bit more. 
>
>If you add a driver_lock, you might have something like:
>
>	struct device_driver * d = NULL;
>
>	spin_lock(&driver_lock);
>	if (drv && drv->owner)
>		if (try_inc_mod_count(drv->owner))
>			d = drv;
>
>	spin_unlock(&driver_lock):
>	return d;

That code is not quite correct, you need something like this.

	spin_lock(&driver_lock);
	drv = scan_driver_list();	
	if (drv && drv->owner)
		if (!try_inc_mod_count(drv->owner))
			drv = NULL;
	spin_unlock(&driver_lock);	/* either failed or protected by use count */
	if (drv && drv->open)
		drv->open();

>...but, what if someone has unloaded the module before you get to the if 
>statement? The memory for the module has been freed, including drv itself. 

It is assumed that the module unload routine will call
driver_unregister() which will also take the driver_lock.  The
interaction between driver_lock in your code and the unregister routine
via module unload, together with the interaction between unload_lock in
sys_delete_module and try_inc_mod_count will prevent races, provided
you code it right.  And provided that your code that does
try_inc_mod_count is in built in code, not in the module itself.

An alternative to driver_lock is BKL, provided you do not have high
activity on your open routine.

open:
	lock_kernel();
	drv = scan_driver_list();	
	if (drv && drv->owner)
		if (!try_inc_mod_count(drv->owner))
			drv = NULL;
	unlock_kernel();
	if (drv && drv->open)
		drv->open();

That works because sys_delete_module(), including all the module clean
up code, runs under BKL.  The module_cleanup routine will unregister
from driver_list under BKL so it cannot race with the open code.

use:
	drv->func();	/* protected by non-zero mod use count */

You only need to lock drv and do try_inc_mod_count() if the use count
might be 0 at the start of the call.  IOW, you only need that code on a
drv->open() or equivalent function.  Once the use count is non-zero,
the module is locked down; it is assumed that drv belongs to the module
and is also protected.

close:
	if (drv->owner)	/* protected by non-zero mod use count */
		__MOD_INC_USE_COUNT(drv->owner);
	drv->close();
	if (drv->owner)
		__MOD_DEC_USE_COUNT(drv->owner);

There is a very small race on close where the module does
MOD_DEC_USE_COUNT() which can take the count to 0 but the close routine
has not returned from the module yet.  Bumping the use count around the
close call closes that race.

Preventing module unload races with the current infrastructure is
complex and fragile.  But I've said that before :).

ps.  I am going to be off the net for a few days.

