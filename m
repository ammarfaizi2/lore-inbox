Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTEQDsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 23:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTEQDsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 23:48:14 -0400
Received: from mail.casabyte.com ([209.63.254.226]:56326 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S261193AbTEQDsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 23:48:08 -0400
From: "Robert White" <rwhite@casabyte.com>
To: <ranty@debian.org>, "Oliver Neukum" <oliver@neukum.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>,
       "Simon Kelley" <simon@thekelleys.org.uk>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, "Greg KH" <greg@kroah.com>,
       <jt@hpl.hp.com>, "Pavel Roskin" <proski@gnu.org>
Subject: RE: request_firmware() hotplug interface, third round.
Date: Fri, 16 May 2003 21:00:43 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGIEABCMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030517005910.GA3808@ranty.ddts.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A good bit of this is moot.

All updateable devices fall into one of three categories:

1) "Flashable", they will remember the image data until that image data is
displaced by another image.  (we are generally not talking about this kind
of device here, but they deserve a nod for completeness.)

2) "Loadable && Suspendable", such a device will retain its firmware during
a suspend, either because it will not actually be powered off, or because of
some "magical" means (like a battery backup on-board activated by a
please-suspend yourself call.) or, if it doesn't retain its whole firmware,
it will at least retain enough internal state that it can pick up where it
left off when the firmware is reloaded.  (...which actually puts it mostly
in the next case if the firmware comes from the kernel side as opposed to
the device side...)

3) "Reload Only", such a device will lose its firmware and internal state
completely when the device is suspended.

Given this simple reality, programs in session with the (almost exclusively
existent) type three devices are simply going to lose their state across a
suspend/resume.  This is just like suspending your laptop with a telnet
session open.  When the resume happens, the telnet session will still be
there, but the first time you use it, or it uses itself, it will see the
socket is gone and eat itself.


Moving into the twilight zone of theoretical analysis.... (it's ok to stop
reading here, the below is NOT cannon by any means, and is actually a little
vague 8-)

Type one devices will do whatever they do.

In the case of type two devices, the magic will magically keep you covered.

If no programs are using the device, regardless of type, then there is no
hurry regardless of intent.

Ok, that sounded a little fatuous, but frankly, any firmware-loadable device
is going to come up out-of-state.  Period.  Definition of the box.  Loading
the firmware will bring it into state, sure.  But the driver is going to
have to be able to recognize the out-of-stateness of the device until after
the load happens no matter what.  Anything else is an oops waiting to
happen.

So the person who writes the driver for a reloadable device will already
have to have a way to park the driver until the firmware is loaded.  That
being said you now have an "infinite" amount of time to load the driver, and
you, by definition, *can* now wait for enough user-space initialization to
take place to handle the issues for you because all access will be blocked
within the driver and the programs dependent on that driver will be hung
waiting.

Remember that all your type-3 firmware-load-targets are small computers
that, by definition, can't be suspended, if they suspended themselves they'd
be type two, so "getting all in a hurry" to reboot them during system resume
is valueless.

The only time this *couldn't* be the case is if you actually "suspend to"
something behind a type-three device.  *That* could only be resolved by
keeping the firmware image in preserved ram.  That would also be a very dumb
thing to do for these self-same reasons.

Let's face it, the Type-3 devices are hideously peripheral anyway.  Mouse
touch-pads, serial dongles, second tier hubs, Ethernet cards that have
already dropped all their connections and will have to be re-bound into the
stack anyway.  etc.

Firmware-able devices are slow external devices, with wait-states and
protocols and firmware-loading interfaces.  As the system comes to life the
things created by the logic in the firmware won't exist to be interacted
with until the firmware is (reloaded.  (by definition there, proof by
induction omitted for brevity... 8-).  That says outright that you have a
lot of dependency-order tasking to do during resume, which in turn means
that a driver that doesn't park itself in stages, and which isn't operating
in a context where waits and yields are ok (say user context or
kernel-thread context), will either be NP complete with respect to its
dependencies on other devices in the system, or it will crash and burn
"sometimes" "for no apparent reason".  So any such device, to be both
firmware-loadable and resumable, will need to be designed to resume only
after user context is available.

Once the resumeable firmware-load-safe driver has been constructed for the
device, you can easily wait for user context.  Any attempt to have a driver
without that park-and-wait feature will likely oops anyway when it wanders
naively onto the CPU and access features that don't exist yet.

Sadly, each such loadable device will suffer under the burden of the unique
demands of its design, so it will be up to the driver writer for each device
do meet those demands.  Building unknown protections for as-yet non-existent
devices into the kernel is not practical.

If you disagree, look again.  Even something as simple as a serial port UART
will need to have its baud-rate latch restored.  If that serial port UART is
an abstraction that exists solely because of a firmware image (Which is how
FPGAs work for example) then if the driver for the serial port "wakes up"
and tries to reload that divisor before the driver for the firmware load,
you will oops, or at least hang or not ever really restore the state of the
logical UART.

The furthest the kernel can go "safely and reasonably" to deal with these
issues is (in vague abstract-o-vision theoretical terms):

1) Create a mid-transaction layer where the kernel is "just about" to call
the file_ops structure members.

2) Define a well defined signal/means to wake a driver and have it go above
that layer a la return -ERESTARTSYS and guarantee that this signal will be
sent to every thread-of-control before a resume

3) Strongly urge device driver programmers to use and obey Number 2.

4) Provide a latch in number 1 that "parks" the request before being
restarted, said latch to be set to park before the signal in number 2 is
sent.

5) Add an optional driver entry point and callback interface that will let a
driver control the un-park of its own operations, and check the parkedness
of other drivers (for those cases when dependencies exist and can be
determined before sleeping or as waking)

5a) Add a well defined all-bets-are-off interface that will error out
some/all of calls on some/all of the parked threads when/if things become
recognizably hopeless.  (Say the USB serial port was unplugged, and not
plugged back in, during the sleep.)

6) Provide a kernel thread (or threads) to give an independent user-context
to the call-ins created in number 5.

(and so forth)

Some programmers will keep/move their firmware in/into ram.  Some will
arrange to allow for some user-space utility to reload the firmware (which
is really for the best).  Some will let the resume oops.  Expecting a
generic kernel mechanism to do the reload instead is paying the price of
bloat for one throw at a constantly moving target.

===

So now, many drivers resume themselves because they are just data based
abstractions.  (see the entire VFS 8-)

Lots of drivers wake up, reinitialize their devices, and then carry on
because their state was internally persistent. (see any block device beneath
the VFS 8-)

Once the block devices are alive again, you can restart the virtual memory
system.  Once the VM system is up you can use paged memory for your resume
data (firmware) anyway.

One quick non-blocking pass ought to be made through the Number-5's of the
system to let the first order dependencies disappear.

It is now safe to wake the user contexts.

The theorized special kernel thread(s), which are user contexts,  just keep
calling the resume tasklets until the list is empty.  From that vantage,
just about any user-space program (a-la hotplug) can be called at leisure.

Any driver that expects to resume itself before the block devices (and
virtual memory system) are ready bares the onus on itself to make sure it
will be able to before things go to sleep.  The only case where this
actually has any point, is the case where the firmwareable device is a block
device with a swap file/partition.  And such a block device is evil anyway.


Wow, two rants in one night... 8-)

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Manuel Estrada
Sainz
Sent: Friday, May 16, 2003 5:59 PM
To: Oliver Neukum
Cc: LKML; Simon Kelley; Alan Cox; Downing, Thomas; Greg KH;
jt@hpl.hp.com; Pavel Roskin
Subject: Re: request_firmware() hotplug interface, third round.


On Sat, May 17, 2003 at 12:22:29AM +0200, Oliver Neukum wrote:
>
> > > How and what is the benefit? If you go low on battery you have to
> > > suspend, there's no choice. This means that you have to have it in RAM
> > > always.
> >
> >  If the device losses the firmware upon suspend, the driver will have to
> >  reinitialize it as if it just got plugged, which somehow makes all
> >  devices hotplugable.
>
> So all firmware has to be permanently in RAM anyway?

 If you really can't access the filesystem on wakeup, you could pull the
 required firmware into ram upon suspend and remove it after wakeup.
 Then while the system is running it will not use kernel memory.

> >  If the driver uses request_firmware(), it doesn't need to handle any
> >  special case, just initialize as usual and it will get the firmware
> >  when it needs it.
>
> How or precisely, how do you know that it gets it when it needs
> it? Are you planning to have a gray area where the kernel generates
> a special user space before everything else gets woken?

 For this I proposed fwfs (a kernel friendly filesystem on top of
 ramfs), but it didn't get a good acceptance. And after reading Greg's
 recent post initramfs should be able to fill that gap.

> >  If the device is needed to access the filesystem, some kind of
> >  persistence will be needed, so the required firmware is already in
> >  kernel space. But the driver doesn't need to care, it will just ask for
> >  the firmware as usual.
> >
> >  Which brings me to another issue, the same device can be required to
> >  access the filesystem or not:
> > 	- In a diskless client, it is the network card
> > 	- In a live-cd it is the cdrom drive
> > 	- In a multi disk system just one of them will be holding
> > 	  required firmware.
> >  So you can not decide at coding time, the latest at compile time, and
> >  ideally at runtime (which is what I am trying to do).
>
> How? You cannot page out memory during resumption.
> You must not cause any access to disk during resumption.

 You will have to make sure that the firmware is copied into RAM before
 suspension, either via fwfs, initramfs or whatever persistence method
 gets implemented.

> >  OK, how about:
> >
> >   int request_firmware_nowait (
> >   		struct module *module,
> >  		const char *name, const char *device, void *context,
> >  		void (*cont)(const struct firmware *fw, void context)
> >   );
> >
> >   request_firmware code will try_module_get/module_put as needed.
> >
> >   Would that fix the issue?
>
> No, still no good. It means that you get a memory leak if you unload
> a driver before firmware is provided. You need the ability to explicitely
> cancel a request for firmware.

 The driver will not unload if request_firmware_nowait() has called
 try_module_get() on it.

 But the device could get disconnected and in that case the firmware
 load should be canceled. I'll add request_firmware_cancel().

> > > >  Would a patch to wait for hotplug termination and provide
termination
> > > >  status be accepted?
> > >
> > > No, you must not wait for user space.
> >
> >  And to get notified when userspace is done?
>
> Not with that interface.
> You'd need drivers to register both with their subsystem and
> a firmware subsystem.

 Why?, the current interface already provides termination notification.

> But you cannot make device discovery wait for user space.

 Why not?

 And anyway, request_firmware_nowait() could be used if that is an
 issue.

> You'd have to rewrite the probe method of all drivers that need
> firmware.

 Keep in mind that the "firmware in a header" method is not allowed
 any more. Drivers needing firmware will have to get their probe method
 modified to get the firmware from userspace anyway.

 Using request_firmware() if they can sleep (USB probe callbacks can
 sleep) is trivial, and using request_firmware_nowait() if they can't
 sleep is just a matter of splitting probe in two pieces.

 So, what alternative are you proposing to get the firmware?

 If your proposal is just keeping the firmware in a header so you just
 have it there all the time, you should discuss it with Alan, Greg,
 Jeff, et all, not me.

 Thanks

 	Manuel


--
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

