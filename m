Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268502AbTBWPw4>; Sun, 23 Feb 2003 10:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268503AbTBWPw4>; Sun, 23 Feb 2003 10:52:56 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:51986 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268502AbTBWPwy>; Sun, 23 Feb 2003 10:52:54 -0500
Date: Sun, 23 Feb 2003 17:02:29 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <kuznet@ms2.inr.ac.ru>,
       <kronos@kronoz.cjb.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <20030219231710.Y2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302212202020.1336-100000@serv>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org>
 <20030218042042.R2092@almesberger.net> <Pine.LNX.4.44.0302181252570.1336-100000@serv>
 <20030218111215.T2092@almesberger.net> <20030218142257.A10210@almesberger.net>
 <Pine.LNX.4.44.0302191454520.1336-100000@serv> <20030219231710.Y2092@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Feb 2003, Werner Almesberger wrote:

> Roman Zippel wrote:
> > Sleeping is not a good general solution, as you have to be very careful 
> > not to hold any important locks, otherwise it's easy to abuse.
> 
> Sleeping has many problems, but it also has one great advantage:
> it's relatively easy to understand and doesn't need much extra
> code (if any) in the user.

Uninterruptable sleep should generally be avoided at kernel level, either 
it should be possible to interrupt it or it should at least include a 
timeout, but then you have to deal with failure again.
OTOH if you have callbacks, you can easily implement sleeping yourself.

> Also, I wouldn't expect lock interdependencies to be a major
> problem at the level of something removing all traces of itself
> (e.g. a driver module unregistering itself). Or would you happen
> to know some example where such problems are happening ?

Imagine you want to remove a device structure, if you manage to block 
this somehow, you might completely block the creation and removeal of 
other devices.

> > Now I need a bigger example to put this into a context, a nice example is 
> > scsi_unregister.
> 
> Nicely illustrates the problem of the "can look around one corner,
> but not two" property of things like try_module_get, yes.

Thanks, it seems I didn't cause too much confusion yet, so I can go on 
with the next part. I think we can agree that the module locking only 
protects a special case and as hotpluggable devices become more and more 
important, we should rather get it right in the general case.

Anyway, this alone would be not reason enough to change the module 
interface, but another module interface would give us more flexibility and 
reduce the locking complexity. To make it easy for Rusty I take an example 
he is familiar with - netfilter.
Let's assume we had an interface which allows exit to fail, how would that 
help? First, struct nf_hook_ops gets a reference count (struct module does 
the job), now with a small change to nf_unregister_hook:

 void nf_unregister_hook(struct nf_hook_ops *reg)
 {
 	br_write_lock_bh(BR_NETPROTO_LOCK);
-	list_del(&reg->list);
+	list_del_init(&reg->list);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 }

we can do the following from module_exit:

int foo_exit()
{
	nf_unregister_hook(&foo_ops);
	return module_refcount(THIS_MODULE) ? -EBUSY : 0;
}

to get a reference to the module this would be enough:

static inline void __module_get(struct module *module)
{
	local_inc(&module->ref[smp_processor_id()].count);
}

releasing the reference is as simple:

static inline void __module_put(struct module *module)
{
	local_dec(&module->ref[smp_processor_id()].count);
}

This probably needs a bit of explanation:
1. more flexibility: The driver has better the knowledge about how the 
module can be stopped and especially only the driver knows which events 
should prevent the shutdown of the module.
There is an important difference between stopping the module and actually 
removing the module. Any reference to the module must prevent the module 
removal, but not everything needs to stop the module from shutting down. 
For example an incoming network packet doesn't need to prevent the 
shutdown, so we can just remove the hook above independent of the 
reference count and just wait for the reference to become zero.
On the other hand this means the module could be in a disabled state, but 
this can rather be compared with lazy unmount (via "umount -l") - after 
the last user is gone the module can be removed without problems, but the 
module could also be reenabled.

2. reduced locking complexity: Above demonstrates how it could look like, 
if we can get rid of the live state (at least outside of the generic 
module code). I explained the theory behind this before and posted the 
link already a few times:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104284223130775&w=2
This live state isn't needed most of the time and if some module should 
really need this, it can easily implement that itself.

To help understanding this it maybe helps to clear up a common 
misconception: modules are no special objects and they are not different 
to other objects which can be removed while the kernel is running. Even 
Rusty confuses this issue (http://lwn.net/Articles/15404/). The question 
should rather be: how can I safely access an object which I don't own? 
There are exactly two rules:
- The user has to lock out the owner.
- When the user wants to access the object outside the lock, he has to 
  tell that the owner, usually done via a reference count.
One of these conditions must be true (no exception), otherwise we have a 
problem.
Applied to netfilter this means as long as we hold the netproto brlock we 
can safely access any netfilter hook and only if we need a reference to 
the hook outside of this lock, we had to call try_module_get(). This also 
means that we don't have to try to get a reference for every packet, 
instead e.g. it would be enough to do this once per connection.
(Why now an atomic counter wasn't sufficient for this and why Rusty had to 
mess up the module code for this, will probably stay one of the big 
mysteries...)

bye, Roman

