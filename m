Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262151AbSJNUB1>; Mon, 14 Oct 2002 16:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262156AbSJNUB0>; Mon, 14 Oct 2002 16:01:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:889 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262151AbSJNUBD>; Mon, 14 Oct 2002 16:01:03 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210141841.LAA19982@baldur.yggdrasil.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Oct 2002 14:05:25 -0600
In-Reply-To: <200210141841.LAA19982@baldur.yggdrasil.com>
Message-ID: <m1n0pgkcqi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For why 2.5.xx does as it does talk to the people who
introduced are working on the driver model. 

Docs are in Documentation/driver-model.
I am satisfied that there is some uniform policy in place
that device drivers can uniformly tap into.

As for just using the reboot notifier.  There are other times
the same code should be called, like in the rmmod path so I don't
think it should have a special case just for reboot.

For myself I am happy that someone introduced 
device_shutdown and it has reasonable semantics.

As for halting the system, we currently have two cases:


	case LINUX_REBOOT_CMD_HALT:
		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
		system_running = 0;
		device_shutdown();
		printk(KERN_EMERG "System halted.\n");
		machine_halt();
		do_exit(0);
		break;

	case LINUX_REBOOT_CMD_POWER_OFF:
		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
		system_running = 0;
		device_shutdown();
		printk(KERN_EMERG "Power down.\n");
		machine_power_off();
		do_exit(0);
		break;

And quite possibly we should have a third:
	case LINUX_REBOOT_CMD_SOFTWARE_POWER_OFF:
		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
		system_running = 0;
                suspend_device(SUSPEND_POWER_OFF);
                device_shutdown();
		printk(KERN_EMERG "Power down.\n");
		machine_halt();
		do_exit(0);
		break;
                        
Yes there is a bug in 2.5.42 that maps SUSPEND_POWER_OFF to
SUSPEND_SHUT_DOWN, but with that fixed you get a case that does what
you want trivially.

More capable halt functions have been in the kernel.  Please
let's enhance the halt path instead of denuding the reboot path.

> 	You do not understand.  The fundamental problem is that
> sys_reboot in linux-2.5.42/kernel/sys.c makes exactly the same power
> management call for a reboot and for a halt (device_shutdown()).  I
> want my IDE, SCSI, USB, and FireWire hard disks to spin down if I do a
> halt.  I do not want them to do that when I reboot.  I also do not
> want my reboot to wait for an interrupt from a sound card because
> remove() needs to determine if it is being called because the device
> had just been unplugged.  It is not just about IDE disk drives.

If detecting hot-plug removal is non-trivial that makes the
work remove does not suitable for a reboot.  However all of the hot-plug
layers I am aware of give an interrupt when a device is removed so
that should be trivially fixable by simply passing that information.
Though I would expect a simple pci_read_config_byte to be just as good.

Do you seriously have a hot-plug sound card, that waits for an
interrupt to be certain the card is plugged in during remove?

If there is non-trivial work to detect if a card is present it
probably makes sense to factor remove into
->quiet() and ->remove()
Where quiet would put the device into a quiescent state, and
remove would simply clean up the driver state.

But for the most part my impression is that we need to get devices
drivers behaving properly in the 2.5.x   And that the basic model
is o.k.  It just needs some pounding on the rough spots.

Eric
