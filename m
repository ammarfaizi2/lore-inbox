Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbSKSTLL>; Tue, 19 Nov 2002 14:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267146AbSKSTLL>; Tue, 19 Nov 2002 14:11:11 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:22747 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267128AbSKSTLH>; Tue, 19 Nov 2002 14:11:07 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 19 Nov 2002 11:18:03 -0800
Message-Id: <200211191918.LAA11641@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Module Refcount & Stuff mini-FAQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 18, 2002, Rusty Russell wrote:
>[ Suggestions welcome ]
>
>Golden Rule: If you are calling though a function pointer into a
>(different) module, you must hold a reference to that module.
>Otherwise you risk sleeping in the module while it is unloaded.

Although it is addressed in your subsequent questions, I think people
might read this and think that they should pepper their code with
unneccessary try_module_get()'s, often for their own module.  I'd
recommend demoting this "golden rule to just another FAQ entry."
Otherwise, there is some implication that if you remember just the
"golden rule", that will be constructive, but I can see attempting to
apply this "golden rule" without following the rest other FAQ entries
as harmful in common cases.  If you really like the "golden rule"
format, perhaps you could add a couple of others based on issues that
you addresss later in your FAQ, such as the following.

"Golden Rule": Do not call try_module_get() unnecessarily.  In most
cases, you know that the module reference count cannot drop to zero
because some higher level facility is holding a reference and will
not release that reference until you return, such as reference count
from an open file descriptor or network interface.

Another "Golden Rule": If you find yourself explicitly calling
try_module_get() and module_put() for a common type of module, then
probably some higher level facility really should be taking care of
this for you.  This is addressed under your question "Do I really need
to put try_module_get() before every function ptr call?", but I want
phrase this as something you should proactively look for.

Perhaps there ought to be a module pointer in struct device_driver.
{,un}register_{device,driver}() would *not* modify the counts (that
would prevent module removal entirely), but it would eliminate the
need to sprinkle module pointers from most places that have them and
may allow a little bit of code consolidation in places.

>Q: How do I get a reference to a module?
>A: Usually, a successful call to try_module_get(owner).  You don't
>   need to check for owner != NULL, BTW.
>
>Q: When does try_module_get(owner) fail?
>A: When the module is not ready to be entered (ie. still in
>   init_module) or it is being removed.  It fails to prevent you
>   entering the module as it is being discarded (init might fail, or
>   it's being removed).

	1. try_module_get() introduces new error legs that will get
little testing.

	2. try_module_get() introduces new failures that other software
has to anticipate.  For example, if I try to mount an ext3 file system
and it happens that ext3 was being automatically removed (for lack of
use) at this time, the attempt to get the ext3 filesystem can fail
without request_module() being called to reload it.

	3. try_module_get() introduces yet another "most fundamental"
lock type.  We have a bunch of facilities vying to do that, and I
think it's going to be a source of bugs.  It would be better to avoid
introducing a new layer of locking if possible.

	4. This kind of race is not really specific to modules, although
they may be the only example that comes up in practice.

	I agree that this approach is worth these costs if it is
the only way to avoid module remove races, or if it is the best way.
However, I think there may be potentially better alternatives.

	Here is what I have in mind.  Basically, a module's module_init
function could register an rwsem (not sure what the difference is with
rwlock; I just it because there is already one in struct bus_type).
sys_delete_module take an exclusive lock it before checking the
reference count, and it would remain held in the the module_exit
routine, which would be responsible for releasing the lock.  Just to
enable modules that register and unregister multiple things, it
would be possible to register more than one such lock, although it
is important that these locks normally not be held simultaneously
for any other reason (otherwise there might be deadlock).

	Anyhow, here is some pseudo-code.  The change to delete_module
is most relevant.  I don't know whether I should by using rwsem or rwlock
for this, by the way.  With the example of get_fs_type and using the
generic driver layer, there is no module unload race, there is no
failure path for mod_inc_use_count, and there is no situation where
attempting to get a filesystem that is in the midst of being unloaded
will result in failure (instead, the access will wait until the filesystem
has been unregistered, and the modprobe will reload it).  Under this
scheme, there is no need for a new kind of locking primitive, and much of
this facility is not tied to modules.


struct rwsem_chain {
	struct rw_semaphore *rwsem;
	struct list_head list;
};

/* Adds the rwsem in _sorted_ order, by, say, address of rwsem. */
void rwsems_add_sorted(struct list_head *head, struct rwsem_chain *element);

/* Gets an exclusive lock on every semaphore in the chain, but duplicate
   semaphores on the list are acquired only once. */
void rwsems_wlock(struct list_head *head);

/* Remove element from the list and then release its rwsem *if* there
   are no duplicate rwsem's on the list. */
void rwsems_element_release(struct rwsem_chain *element);

struct module {
	...
	/* If this list is non-empty, then callers to MOD_INC_REF_COUNT
	   must hold one of the locks on this list (it can be a shared
	   hold). */
	struct list_head	rwsems;
};

/* in kernel/module.c: */
asmlinkage long
sys_delete_module(const char *name_user, unsigned int flags) {
	...
	rwsem_chain_wlock(mod->rwsems);
        if ((flags & O_NONBLOCK) && module_refcount(mod) != 0) {
		...
	}
	...
	free_module(mod);/*Destroy routine is responsible for releasing locks*/
	...
}


/* Here is an example of using this facility.  Let's port the generic device
   layer. */

struct device_driver {
	...
	struct module		*module;
	struct rwsem_chain	rwsem_chain;
};

int driver_register(struct device_driver * drv)
{
	...
	if (drv->module) {
		drv->rwsem_chain.rwsem = &drv->bus->rwsem;
		rwsems_add_sorted(&module->rwsems, &drv->rwsem_chain);
	}
}



void put_driver(struct device_driver * drv)
{
	...
	rwsems_element_release(&drv->rwsem_chain);
}

struct device_driver *
get_driver_by_name(struct bus_type *bus_type, const char *name)
{
	down_read(&bus->rwsem);
	list_for_each(node,&bus_type->drivers) {
		struct driver * dev = get_device(to_drv(node));
		if (strcmp(dev->name, name) == 0) {
			MOD_INC_REF_COUNT(drv->module);
			up_read(&bus->rwsem);
			return drv;
		}
	}
	up_read(&bus->rwsem);
	return NULL;
}

struct device_driver *
get_driver_by_name_modprobe(struct bus_type *bus_type, const char *name)
{
	struct device_driver *result = get_driver_by_name(bus_type, name);
	
	if (!result && request_module(name) == 0)
		return get_driver_by_name(bus_type, name);
	else
		return result;
}	



/* You could port the file system list interface to file system
   by having every file system do

   rwsems_add_sorted(&THIS_MODULE->rwsems, &local_rwsems_element);

   ...or you could embed a struct device_driver in struct file_system_type
   and a struct device in struct super_block.

   Either way, you would then a have raceless get_fs_type does not
   return failure when the file system being sought is in the midst
   of being unloaded. */

struct bus_type fs_bus_type;

int register_filesystem(struct file_system_type * fs)
{
	...
	down_write(&fs_bus_type.rwsem);
	...
	fs->driver.module = fs->module;
	fs->driver.bus_type = &fs_bus_type;
	register_driver(&fs->driver);
	...
	up_write(&fs_bus_type.rwsem);
}


struct file_system_type *get_fs_type(const char *name)
{
	struct device_driver *driver = get_driver_by_name_modprobe(name);

	if (driver == NULL)
		return NULL;

	return container_of(driver, struct file_system_type, driver);
}



	I may comment further on your FAQ later, especially the stuff
about having the module loader in the kernel, but I have to go now, and
that's a separate topic anyhow.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
