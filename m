Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbSKTMSb>; Wed, 20 Nov 2002 07:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbSKTMSb>; Wed, 20 Nov 2002 07:18:31 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:5326 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266006AbSKTMSa>; Wed, 20 Nov 2002 07:18:30 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 20 Nov 2002 04:25:28 -0800
Message-Id: <200211201225.EAA12462@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Module Refcount & Stuff mini-FAQ
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although Rusty Russell sent me a preliminary response without cc'ing
linux-kernel (I think because it was so preliminary), but I'm
re-cc'ing linux-kernel because my response explains a bit more about
my proposal to eliminate most or all try_module_get's racelessly,
which is something others might find informative or might want to
comment on.  There is obviously nothing particularly private in this
message.

Rusty Russell wrote:
>In message <200211191918.LAA11641@adam.yggdrasil.com> you [Adam Richter] write:
>> On November 18, 2002, Rusty Russell wrote:
[...]
>> 	1. try_module_get() introduces new error legs that will get
>> little testing.

>try_module_get() is exactly equivalent to try_inc_mod_count().  It's
>not actually a new thing: deprecating the other module refcount
>methods is the new thing.

	OK, s/try_module_get/try_inc_mod_count/.

	Same issue.

>I've only glanced over your locking proposal, but the most obvious
>things to me are that grabbing a rwlock strikes me as a little heavy
>for a fundmantal primitive that might be used anywhere, and secondly I
>want to grab it in a bh handler so I can modularize IPv4.

	It appears that there already is an appropriate mutex to use
in ipv4: rtnl_sem.  My code currently uses an rw_semaphore instead of
a semaphore, but it could either be changed to call a list of
arbirtrary locking functions, or, probably simpler, rtnl_sem could be
changed to an rw_semaphore.  The latter is particularly appealing,
because there already is code in the net subdirectory that seems to be
written to take advantage of this change (there are already distinct
rtnl_shlock and rtnl_exlock macros).  So, the using a locking primitive
that can lock rather than spin has already been solved apparently in ipv4.

	I run modularized ipv4 already, so it should be easy for me to
check if your module loader gets to the point where it works enough
for me to complete a boot (or I could try to patch to Keith Owen's
module system).

	As far as the "strikes me as a little heavy" phrase goes,
that's obviously not a clear identification of a cost, so I can only
try guess what costs you might be referring to talk about them.  The
memory usage of struct rwsem_chain would be 3 pointers (12 or 24
bytes) per detected device (net, char, block, etc.), file_system_type
and perhaps some other resources of which there are usually a handful
of each.  My guess is that you'd probably have under 100 allocated on
a typical computer: one for each detected network interface, one for
each detected block device, one for each detected character device,
and some elsewhere, perhaps an average of 2-3 per loaded module,
probably as much space will be saved from eliminating error paths.
The locks themselves generally generally already exist, and these
amount to one lock per type of device (per "bus_type" from a generic
driver standpoint): one lock for network devices, one lock for file
system types, etc.  It's a very small number and the locks already
exist in every case that I've seen anyhow.  So the net memory costs
should be approximately zero and it may even be a net memory savings.

	If by "a little heavy" you were referring to lock contention,
it's important to realize that this proposal sets up lists of locks,
it does not introduce new attempts to grab these locks or attempts to
hold them much longer, with the exception of the module's unload
function.  Even there, these are locks that would be taken at some
point in the unload function anyhow.  Also, these are not spin locks
and attempts to block with these rw_semaphore's held will be rare to
nonexistant.  So, the waiting on the locks should cause the CPU to
switch to something useful, not just spin.

	This change will likely eliminate bugs, simplify testing and
code walk throughs (fewer untested branches), and, more importantly,
eliminate flakey behavior that is not considered a bug from the
try_inc_mod_count perspective, but is a bug from a functional
standpoint.  For example, if you do "mount -t iso9660 /dev/cdrom
/mnt", a try_inc_mod_count implementation can generate a result like
"iso9660: unknown filesystem" on a system that has iso9660 just
because of a timing fluke, whereas under my scheme you will reliably
get the iso9660 filesystem every time.

	It is also important to realize that this change can be done
incrementally.  Under this scheme, try_inc_mod_count will just succeed
all the time for users of this facility.  Note that the restored
unconditional __MOD_INC_USE_COUNT routine could have an optional
debugging feature: it would call BUG() if the caller does not have at
least a shared lock on one of the rw_semaphore's in the module's list.
__MOD_INC_USE_COUNT is generally not called in IO paths, so it
wouldn't be that costly to turn that check on.

	If we are able to eliminate all calls to try_inc_mod_count,
then that "lock the entire computer" code can be deleted, as well as
try_inc_mod_count.  In the unlikely even that try_inc_mod_count cannot
be eliminated, I think the reliability that this change would bring to
those places that can use this facility would still be enough to
warrant keeping this facility.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
