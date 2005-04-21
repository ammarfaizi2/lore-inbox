Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVDUOcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVDUOcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 10:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVDUOcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 10:32:10 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:55558 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261391AbVDUObt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 10:31:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tMwRLhgSdHguLl0jlKlSYq0ZvPFNvQrOPB+/9O38HQGnQSpXxX9H39jrZyvMKw/1XljfV1sv5wZrreYC9yXap3LEFZ9yaaPqAT7LsmGGYukmdGe3YijBS0yUkHzL5k571RE5YeyKQi7cWbiPILOOgUOremJN6GpYLXcHxxvB9Jk=
Message-ID: <d120d50005042107314cbacdea@mail.gmail.com>
Date: Thu, 21 Apr 2005 09:31:44 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <1114089504.29655.93.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeniy,

On 4/21/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Thu, 2005-04-21 at 02:07 -0500, Dmitry Torokhov wrote:
> > Hi,
> 
> Hello, Dmitry.
> 
> > I happened to take a look into drivers/w1 and found there bunch of thigs
> > that IMO should be changed:
> >
> > - custom-made refcounting is racy
> 
> Why do you think so?
> Did you find exactly the place which races against something?
> 
> > - lifetime rules need to be better enforced
> 
> Hmm, I misunderstand you.
>

Consider thie following:

451         while (atomic_read(&sl->refcnt)) {
452                 printk(KERN_INFO "Waiting for %s to become free:
refcnt=%d.\n",
453                                 sl->name, atomic_read(&sl->refcnt));
454 
455                 if (msleep_interruptible(1000))
456                         flush_signals(current);
457         }
458 
459         sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
460         device_remove_file(&sl->dev, &sl->attr_name);
461         device_remove_file(&sl->dev, &sl->attr_val);
462         device_unregister(&sl->dev);
463         w1_family_put(sl->family);
.. And caller does kfree(sl);

Now, if application opens slave's sysfs attribute while other thread
exited the loop and is about to remove attributes, then you will kfree
object that is in use and who knows what will happen. This is example
of both refcounting being racey and lifetime rules being violated.

> > - family framework is insufficient for many advanced w1 devices
> 
> No, family framework is just indication which family is used.
> Feel free to implement additional methods for various devices
> and store them in driver's private areas like ipaq does.
>

OK, that is what I am aying. But why do you need that attribute with
variable name and a bin attribute that is not really bin but just a
dump for all kind of data (looks like debug one).
 
> > - custom-made hotplug notification over netlink should be removed in favor
> >   of standard hotplug notification
> 
> It is not hotplug, and your changes broke it completely.
> I'm waiting for connector to be included or discarded, so I can move
> w1 on top of it's interface or move connector's bits into the w1
> subsystem.
>

You will not be able to cram all 1-wire devices into unified
interface. You will need to build classes on top of it and you might
use connector (I am not sure) bit not on w1 bus level.
...
> > w1-slave-attr-group.patc
> >    Add 2 default attributes "family" and "serial" to slave devices, every
> >    1-Wire slave has them. Use attribute_group to handle. The rest of slave
> >    attributes are left as is - will be dealt with later.
> 
> Serial number is already there in bus_id, family is there too.
> Why do you need separate files?

Yeah, could probably drop them.
...
> > w1-drop-owner.patch
> >    Drop owner field from w1_master and w1_slave structures. Just having it
> >    there does not magically fixes lifetime rules.
> 
> They do not even pretend, I still do not understand what is "lifetime
> rules"?

So there is no point in having them, right? 

> 
> > w1-bus-ops.patch
> >    Cleanup bus operations code:
> >    - have bus operatiions accept w1_master instead of unsigned long and
> >      drop data field from w1_bus_master so the structure can be statically
> >      allocated by driver implementing it;
> >    - rename w1_bus_master to w1_bus_ops to avoid confusion with w1_master;
> >    - separate master registering and allocation so drivers can setup proper
> >      link between private data and master and set useable master's name.
> 
> I strongly object against such changes.
> 1. w1 was designed in the way that w1 bus master drivers do not
> know about other w1 world. It is very simple and very low-level
> abstraction,
> that only understands how to do low-level functions. It is not needed
> do know about w1_master structure and even about it's existence.

Well, it does need to know about w1_bus_master structure, which is
pretty much the same. And it allows having static bus_ops allocation
and removes need for casting from unsigned longs...

> 2. All renaming are superfluous, I'm not against it, but completely do
> not
> understand it's merits.

Because now it represents operations only, data field has been
dropped. I my head hurt when I see w1_master and w1_bus_muster
together as 2 separate objects both representing the same piece of
hardware.

> 3. You broke netlink allocation routing - it may fail and it is not
> fatal.

Because it is going away in later patcehs ;)

> 
> > w1-fold-w1-int.patch
> >    Fold w1_int.c into w1.c - there is no point in artificially separating
> >    code for master devices between 2 files.
> 
> w1_int.c was created to store external interface implementation,
> why do you want to move it into w1 core code?
> It will only soil the code...

Because I do not understand why code creating master devices is
separate from code creating master device's attributes.

> 
> > w1-drop-netlink.patch
> >    Drop custom-made hotplug over netlink notification from w1 core.
> >    Standard hotplug mechanism should work just fine (patch will follow).
> 
> netlink notification was not created for hotplug.
> Also I'm against w1 hotplug support, since hotplug is quite rarely used
> in embedded platforms where the majority of w1 devices live.

kobject_uevent does notification over netlink so I do not understand
why custom approach is better. You don't really need to use script.

> > w1-drop-control-thread.patch
> >    Drop control thread from w1 core, whatever it does can also be done in
> >    the context of w1_remove_master_device. Also, pin the module when
> >    registering new master device to make sure that w1 core is not unloaded
> >    until last device is gone. This simplifies logic a lot.
> 
> Why do you think master can be removed in safe context only?

Can you show me example where you remove master from an interrupt
context or a tasklet? I doubt you will ever see one.
 
> I have feature requests for both adding/removing and exporting
> master devices and slaves to the external world.

External as in userspace? It (user thread) can wait just fine...

> Control thread is also the place in which we kick all devices
> when we need it, but not only when we need to remove w1 core module.

Define kicking for me please...

> 
> > w1-move-search-to-io.patch
> >    Move w1_search function to w1_io.c to be with the rest of IO code.
> 
> w1_search() is high-level protocol method, w1_io.c only contains
> calls for low-level methods like bite/byte banging, reset, HW search and
> so on.

Well it does bit banging and completely foreign to the rest of w1
code. It may be high-level operation as fas as 1-wire on-wire protocol
goes, but it surely does not belong with kernel's W1 bus
implementattion code.

> > w1-master-attr-cleanup.patch
> >    Clean-up master attribute implementation:
> >    - drop unnecessary "w1_master" prefix from attribute names;
> >    - do not acquire master->mutex when accessing attributes;
> >    - move attribute code "closer" to the rest of master code.
> 
> Ok, but slave count and slaves attributes itself requires that mutex.

They are gone. You can scan sysfs to get your slaves and count. Kernel
does not need to do that.

> > w1-master-scan-interval.patch
> >    More master attributes changes:
> >    - rename timeout parameter/attribute to scan_interval to better
> >      reflect its purpose;
> >    - make scan_timeout be a per-device attribute and allow changing
> >      it from userspace via sysfs;
> >    - allow changing max_slave_count it from userspace as well.
> 
> I like that change, but why do you ned to change the name?

Because nothing times out (as in error). It defines interval between
scans -> scan_interval.

> > w1-master-cleanup.patch
> >    Clean-up master device implementation:
> >    - get rid of separate refcount, rely on driver model to enforce
> >      lifetime rules;
> >    - use atomic to generate unique master IDs;
> >    - drop unused fields.
> 
> That patch is very broken.
> I completely against it:
> 1. it breaks process logic - searching can be interrupted and stopped,
> thread will exit on signals.

Interrupted/stopped from userspace?

> 2. Your changes will break master/slave structure exporting.

-ENEEDMOREDATA.

> 
> > w1-slave-cleanup.patch
> >    Clean-up slave device implementation:
> >    - get rid of separate refcount, rely on driver model to enforce
> >      lifetime rules;
> >    - pin w1 module until slave device is registered with sysfs to make
> >      sure W1 core stays loaded.
> >    - drop 'name' attribute as we already have it in bus_id.
> 
> The same and even worse.

You need to fix lifetime rules.

> > w1-family-cleanup.patch
> >    Clean-up family implementation:
> >    - get rid of w1_family_ops and template attributes in w1_slave
> >      structure and have family drivers create necessary attributes
> >      themselves. There are too many different devices using 1-Wire
> >      interface and it is impossible to fit them all into single
> >      attribute model. If interface unification is needed it can be
> >      done by building cross-bus class hierarchy.
> >    - rename w1_smem to w1_sernum because devices are called Silicon
> >      serial numbers, they have address (ID) but don't have memory
> >      in regular sense.
> >    - rename w1_therm to w1_thermal.
> 
> smem == simple memory id, it is official name AFAIR.
> Renames are superfluous, family_ops contains a "must have" operations,
> driver writer can easily add it's own if it is needed.

What is so "must have" about 2 attributes? smem does not need anything
for exampe...

> > w1-family-is-driver.patch
> >    Convert family into proper device-model drivers:
> >    - embed driver structure into w1_family and register with the
> >      driver core;
> >    - do not try to manually bind slaves to familes, leave it to
> >      the driver core;
> >    - fold w1_family.c into w1.c
> 
> Why do you break it?
> They were separated intentionally - it simplifies code review,
> it is completely different logical models, family processing
> is not hte same as slave.

Masters, slaves and families are all objects of W1 kernel bus. With
cutting a bunch of fat from family code it does not make sense to keep
them separate anymore.

> 
> Thank you very much for your changes and ideas,
> but as you can see I'm against several of it.
> The main reason is why dig into the driver model in a such way?
> It will complicate strucutre exporting too much.

Because it is the standard for implementing devies and drivers in
linux kernel. You need to explain about exporting structure since the
rest of the system seem to be doing just fine.

> Existing locking/refcnt schema is very flexible and allows device
> manipulation while it "holds" the reference counter,

It is also racy and buggy.

> and it will not be possible if one just blindly gets/puts module's
> refcnt.

Only wire.ko is pinned. You are still free to remove family drivers or
master drivers (or killing their objects somehow). It is only core
that is pinned to make sure that release functions are available when
object finally goes away.
 
> Object has reference counter which is incremented and decremented when
> object is in use, not the whole module reference counter,
> one may remove and add separate objects without knowledge of
> what family or bus master driver handles that.

> Your changes mix low-level driver logic with w1 core.
> You have removed netlink notification and replace it with hotplug,
> but it can not be used for systems without shell userspace support.

kobject_uevent does not requere a sehll account.

Thank you for reviewing the patchset.

-- 
Dmitry
