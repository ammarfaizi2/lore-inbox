Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262404AbSJPMKF>; Wed, 16 Oct 2002 08:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSJPMKF>; Wed, 16 Oct 2002 08:10:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65402 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262404AbSJPMKD>; Wed, 16 Oct 2002 08:10:03 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org, mochel@osdl.org,
       rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210151952.MAA04189@adam.yggdrasil.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Oct 2002 06:13:22 -0600
In-Reply-To: <200210151952.MAA04189@adam.yggdrasil.com>
Message-ID: <m1ptua37kt.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

[snip details on a lot of hot plug code]

No major comment except that I know for compact pci you can just
walk up and unplug it.  As we have several compact pci boards here
at work.

But thank you for the clarification that a only on badly designed
hardware a newly plugged in device will

> 	Besides, you have not identified a safe way that a combined
> ->remove() function can detect such situations more reliably than
> separate ->quiet() and ->removed(), which at least have the benefit of
> knowing what the kernel currently thinks the situation is.  So, you
> really have no basis for saying "Splitting ->remove() into quiet() and
> ->removed() will be racy."

O.k. Let me attempt a clarification, of what I was thinking.
Currently pseudo code for remove does:

remove() {
	if (device_present()) {
		device_be_quiet()
	}
	device_free(device_strucutres);
}

The way I imagined the split up:
if (device->present()) {
        device->be_quiet();
}
device->free_resources();

Doing device_be_quiet() without the device_present() check is racy,
because devices can be physically removed at arbitrary times.  It
is unreasonable for the generic code to make the strong assumption
about being able to tell a device driver if the device is still
present.  So any splitting of the device_present() check and the
device_be_quiet() code would have to be done, very carefully, and
would require bus specific code.  And it would be complexity without a
real payoff.

So if things are split it can at most be:
device->be_quiet(); /* With the possibility the device has been removed */
device->free_resources();

I cannot imagine freeing data structures will noticeably slow a reboot
down, so unless we actually need to tell a device to be quiet for
other reasons besides driver removal, and machine reboot I do not see
a point in adding complexity by changing the interface.  There may be
a valid argument in the suspend to swap case, but I will cross that
bridge when i come to it. 

For my thinking on how this should be handled:

Except in some very select special instances, I do not know
of a single device where it is safe to assume the hardware is in a
sane state at any random given moment when we decide to reboot.  And
in no common case I know of does linux immediately trigger a machine
level reset which would render this issue moot.  Therefore asking all
of the device drivers to be quiet on a reboot sounds very reasonable.

Further the only way I know to make solid code is to put all of your
eggs in one basket, and just make certain it is a good basket.
Meaning the more often a function is run with the same requirements
the more likely it is to be correct.  So running the device ->remove()
method on reboot and module remove will greatly enhance the chance the
method is both fast and correct, because it is run often enough that
people will complain if it is not.

As for the semantic change in ->remove() from 2.4 it feels to me like
more of a clarification than a real change, in particular ->remove() is
the opposite of ->probe(), and ->probe() does both allocation and
device state initialization, and  any code that works correctly with
the 2.5 clarification should also work in 2.4.   Having to check to
see if the device is already present has to be done for correctness,
and that was the only thing that felt to me like the ->remove()
routine was being really overloaded.

For 2.5 calling remove on reboot may not fix any issues, but it is
certainly a correct thing to do.  And even if it does not fix issues
today, it allows bugs to be fixed, as the come up.  And it allows
the code to be tested by just doing a modular build and inserting
and removing the module.

Eric
