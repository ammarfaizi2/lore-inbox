Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbSKZGmj>; Tue, 26 Nov 2002 01:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbSKZGmi>; Tue, 26 Nov 2002 01:42:38 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:64701 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266199AbSKZGmg>; Tue, 26 Nov 2002 01:42:36 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 25 Nov 2002 22:49:35 -0800
Message-Id: <200211260649.WAA22216@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Modules with list
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In message <200211260406.UAA22079@adam.yggdrasil.com> you write:
>> Rusty Russell wrote:
>> >In message <200211252211.OAA02085@baldur.yggdrasil.com> you write:
>> [...]
>> >> 	4. failureless raceless module unloading by the module->rwsem_list
>> >> 	   system that I described toward the bottom of this message:
>> >> 	   http://marc.theaimsgroup.com/?l=linux-kernel&m=103773401411324&w=2
>> 
>> >OK, I've read this in detail now.  It's a fine scheme, but the devil
>> >is inside here:
>> 
>> >struct device_driver *
>> >get_driver_by_name(struct bus_type *bus_type, const char *name)
>> >{
>> >	down_read(&bus->rwsem);
>> 
>> >Now, that's perfectly fine for drivers, but try doing that on every
>> >network packet.
>> 
>> 	You're looking up a driver by name or incrementing a module
>> reference count on every network packet?  Where?  Show me, please.

>TCP for example, sets the destructor function for the skb.  It can be
>called an arbitrary time later.  Netfilter modules do a similar thing,
>for similar reasons.  You'd better grab a reference to *something*.

	The ->remove() function of a network device driver will
not return until it has freed all receive skb's that it allocated
and all transmit skb's that were passed to its transmit function.

	Why would setting skb->destructor attempt to increment the use
count on a module?  As far as I can tell, it's own incremented in
dev_open().


[...]
>> 	With your scheme, you really do have unnecessary failures.
>> For example, the system really can tell you that the iso9660
>> filesystem is not found when, in fact, there is a module for it
>> (because you asked at just the wrong moment, when it was being
>> unloaded).

>This would only happen if someone says "rmmod --wait".

	No.  Let's walk through an example of get_fs_type in
fs/filesystems.c, starting at line 229:

struct file_system_type *get_fs_type(const char *name)
{
        struct file_system_type *fs;

        read_lock(&file_systems_lock);
        fs = *(find_filesystem(name));
        if (fs && !try_inc_mod_count(fs->owner))
                fs = NULL;
        read_unlock(&file_systems_lock);
        if (!fs && (request_module(name) == 0)) {
                read_lock(&file_systems_lock);
                fs = *(find_filesystem(name));
                if (fs && !try_inc_mod_count(fs->owner))
                        fs = NULL;
                read_unlock(&file_systems_lock);
        }
        return fs;
}


A: "mount -t iso9660 /dev/cdrom /mnt".

B: invoked from cron, does "modprobe --remove" to remove stale
B: modules.  isofs is stale right now, so it does
B: sys_delete_module("isofs").
B: sys_delete_module does stop_refcounts(), which returns 0
B: clears mod->live, calls restart_refcounts(), does up(&module_mutex).
B: Has not yet called mod->exit().

A: calls get_fs_type("iso9660") (fs/filesystems.c line 226)
A: read_lock(&file_systems_lock) succeeds
A: finds the iso9660 filesystem entry
A: calls try_inc_mod_count, which fails, sets fs to NULL
A: get_fs_type releases lock, calls request_module("iso9660")
A: iso9660 module load fails because there is already a module by that name
A: (even if module load were to succeed, register_filesystem would fail
A: because there already is a filesystem with that name)
A: Because request_module() failed, get_fs_type returns NULL.
A: The user sees mount fail with "Unknown filesystem type or bad superblock."

	   
[...]

>> >Your code here seems flawed.  You grab the write sem(s) in the remove
>> >code to prevent anyone bumping the refcount.  If someone is recursing
>> >(trying to grab another refcount while already holding one), you
>> >*must* fail them, otherwise you'll deadlock.
>> 
>> 	No, the point is that these rwsem's do not just lock the
>> try_module_get() call.  They lock a slightly larger section of code,
>> so that the other process will block when it attempts to look up the
>> resource containing the module pointer by name.  In your example, the
>> module unload will complete, the other process will then be allowed to
>> continue, and it will discover that whatever driver it was asking
>> about is not currently loaded (for example, the iso9660 filesystem is
>> not found, and it will run modprobe to reload it).

>Process A calls "get_driver_by_name("foo")" successfully.  Module
>reference count now 1.

>Process B calls sys_delete_module: grabs sem in write mode, finds
>refcount not 0, waits because --wait is specified (I assume that's
>what the ... there does?).

	"--wait" is your own addition.  Elminating the race that I
described above is much more important for reliability than your
new "--wait" feature.

	For what it's worth, I think "--wait" could work to some
degree under my scheme by changing the up(&module_mutex) call in
sys_delete_module to release all of the locks and then having it go
back to the top of sys_delete_module after schedule() returns, with no
guarantee that it will not block again because someone else has added
a reference count in the meantime (since try_get_module never fails
under my scheme).

	Anyhow, so under my scheme, sys_delete_module() would fail
if we do not support the "--wait" function.  If we support it as
described in the previous paragraph, sys_delete_module blocks.


>Process A calls "get_driver_by_name("foo")" again.

	Because sys_delete_module released the module locks before
calling schedule(), process A's get_deriver_by_name("foo") call
succeeds.  The reference count for the underlying module is now 2.
The "rmmod --wait" process continues to wait.

[...]
>Yes, filesystems are basically fairly clean already (nothing really
>changed for them).  Filesystems are easy.  Devices are easy.

>Networking is *hard*, which is why Dave and Alexey never merged any
>"modularize ip" patches,

	I think of people would consider it to be progress to have
non-removable modular IP, which what I run, but I digress again.

>and why I keep my own reference counts and
>spin (potentially forever!) in ip_conntrack's cleanup code 8(

	I do not see where any of this code increments a module
reference count except in dev_open.  For that one, I would add an
rwsem that dev_ifsioc would down_read() before calling __dev_get_by_name
and which it would hold through the return of dev_change_flags (which
does the call to dev_open).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
