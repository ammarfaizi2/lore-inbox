Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261776AbSJNACp>; Sun, 13 Oct 2002 20:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261778AbSJNACp>; Sun, 13 Oct 2002 20:02:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34679 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261776AbSJNACo>; Sun, 13 Oct 2002 20:02:44 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: rmk@arm.linux.org.uk, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210132359.QAA01092@adam.yggdrasil.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 18:07:15 -0600
In-Reply-To: <200210132359.QAA01092@adam.yggdrasil.com>
Message-ID: <m1of9xlw7g.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> Russell King wrote:
> >On Sun, Oct 13, 2002 at 04:10:01PM -0700, Adam J. Richter wrote:
> >>       I have no objection to replacing or supplementing the reboot
> >> notifier chain with a method in struct device_driver, but let's not
> >> overload these methods with ambiguous semantics.  I do not want to
> >> call thirty functions that primarily return memory to various memory
> >> allocators, mark a bunch of inodes as invalid, and otherwise arrange
> >> things so that the kernel can smoothly continue to run user level
> >> programs when, in fact, we just want to pull the reset line on the
> >> computer.
> >
> >And what about setups where you can't pull the reset line from software.
> >I have several machines here like that.  And one of them needs software
> >to talk to the cards to put them back into a sane state before rebooting.
> >
> >"rebooting" in this particular case is "turn MMU off, jump to location 0"
> 
> As I send in my response Eric Biederman,
> 
> |        If you have a platform where, for example, somehow PCI devices
> | are able to continue jabbering away after the computer has been reset,
> | then that could probably be done more consistently for most drivers by
> | having machine_restart on that platform walk the PCI bus and shut down
> | everything (drivers that need to do something really special would
> | still use the reboot notifier).
> |
> |         I could even see calling device_shutdown from machine_restart
> | on that platform only, [...]
> 
> 
> >And I never said anything about needing to allocate memory to do this.
> >I agree with you that suspending devices on reboot _is_ silly.  However,
> >that's not what I was proposing.
> 
> 	Then you've started a new thread of discussion, because
> device_shutdown is defined in drivers/base/power.c as:
> 
> void device_shutdown(void)
> {  
>         device_suspend(4, SUSPEND_POWER_DOWN);
> }
> 
> 
> 	Perhaps device_suspend ought to be renamed device_power_down.
> 
> 	However, I'm not trying to quash what you want to discuss.
> I'd be interested in hearing about clarifications and perhaps
> extensions of the struct device_driver methods, which I think is what
> you're getting at, perhaps here or on linux-hotplug.  It's just that,
> for this thread, I'm trying to focus on my patch that eliminates the
> software suspend on reboot (pros and cons, alternatives to it, etc.).

The 2.5.41 variant is below.  The bug is reusing the old enumeration value
as was previously mentioned.

/**
 * device_shutdown - queisce all the devices before reboot/shutdown
 *
 * Do depth first iteration over device tree, calling ->remove() for each
 * device. This should ensure the devices are put into a sane state before
 * we reboot the system.
 *
 * device_shutdown - call device_suspend with status set to shutdown, to 
 * cause all devices to remove themselves cleanly 
 */
void device_shutdown(void)
{
       struct list_head * node, * next;
       struct device * prev = NULL;

       printk(KERN_EMERG "Shutting down devices\n");

       spin_lock(&device_lock);
       list_for_each_safe(node,next,&global_device_list) {
               struct device * dev = get_device_locked(to_dev(node));
               if (dev) {
                       spin_unlock(&device_lock);
                       if (dev->driver && dev->driver->remove)
                               dev->driver->remove(dev);
                       if (prev)
                               put_device(prev);
                       prev = dev;
                       spin_lock(&device_lock);
               }
       }
       spin_unlock(&device_lock);
       if (prev)
               put_device(prev);
}

Eric
k
