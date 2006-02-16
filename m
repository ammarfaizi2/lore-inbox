Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWBPHz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWBPHz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 02:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWBPHz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 02:55:27 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:32139 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932510AbWBPHz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 02:55:26 -0500
Date: Thu, 16 Feb 2006 02:55:17 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rt16: possible sound-related side-effect
In-Reply-To: <200602152339.k1FNdVIO021090@auster.physics.adelaide.edu.au>
Message-ID: <Pine.LNX.4.58.0602160245150.7272@gandalf.stny.rr.com>
References: <200602152339.k1FNdVIO021090@auster.physics.adelaide.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2006, Jonathan Woithe wrote:

> Hi Steve
>
> > > In the last week I have updated the kernel on our laptop to 2.6.15-rt16.
> > > By and large this worked well and had the attractive side effect of making
> > > the clock run at the correct speed once more.
> > >
> > > During development of an ALSA patch I had the need to remove and reinsert
> > > the hda-intel and hda-codec modules on numerous occasions.  Every so often
> > > (perhaps once every 5 or 6 times on average) the initialisation sequence of
> > > hda-intel would get hung up and the associated insmod would never return.  A
> > > reboot was required to clear the problem.  The following messages were
> > > written to syslog repeatedly and often:
> > >
> > >   Feb  5 21:36:24: ALSA sound/pci/hda/hda_intel.c:511: azx_get_response timeout
> > >   Feb  5 21:36:26 halite last message repeated 9 times
> > >   Feb  5 21:36:29 halite kernel: printk: 31 messages suppressed.
> > >
> > > I have noticed the "azx_get_response timeout" messages in earlier kernels
> > > as well, but up until now the hda initialisation hasn't gotten hung up.
> > >
> > > The latching up of the hda-intel initialisation does not appear to occur
> > > when doing the same thing under a non-RT 2.6.15 kernel.  Furthermore, I have
> > > had an instance where the lockup occured while cold-booting an unmodified
> > > 2.6.15-rt16, which rules out any changes I made to ALSA as the cause of the
> > > problem.  In any case the changes I was making to ALSA don't affect the
> > > initialisation code.
> > >
> > > Prior to this kernel I was running an unmodified 2.6.14-rt21 kernel and
> > > while these messages did occur they didn't cause hda-intel to lock up.
> > >
> > > Any suggestions as to what might be causing this and/or of further tests
> > > which might help narrow down the cause?
> >
> > Could you turn on nmi_watchdog as well as softlockup_detect.
> >
> > nmi_watchedog:
> >   make sure CONFIG_X86_LOCAL_APIC is set, and then pass in the command
> >   line "nmi_watchdog=2 lapic"  (lapic may or may not be needed, but should
> >   not hurt to include it).
> >
> > softlockup_detect:
> >   set CONFIG_DETECT_SOFTLOCKUP.
> >
> > these may point out better what is locked up.
>
> The NMI watchdog triggers only when the kernel as a whole locks up.  That
> isn't what's happening here.  What is occuring is that the HDA side of
> things is entering a seemingly endless loop, but the rest of the kernel
> continues to function normally.

Sorry, I was thinking your kernel locked up, not just the insmod.  OK,
forget about what I asked.


>
> In any case, I did the above and booted with "nmi_watchdog=2 lapic".  I
> triggered the fault but neither the soft lockup nor NMI watchdog triggered,
> which given the above was of no surprise.
>
> The "azx_get_response timeout" is only produced by a single function:
> azx_get_response() in hda_intel.c.  This in turn seems to be called from
> only one location - azx_codec_create() in hda_intel.c.  azx_probe() calls

It's not called there. It's setup as a function pointer, so it is called
when another fuction calls the get_response pointer.

> azx_codec_create() exactly once, and azx_probe() is the .probe method for
> the PCI driver definition.  Given that the above call chain in hda-intel.c
> does not contain any loops, I conclude that the PCI code is repeatedly
> calling the probe method due (presumedly) to the repeated timeouts.  I can't
> see how else azx_get_response() could be called repeatedly.

If you want to know where it is being called from, do add the following:

static unsigned int azx_get_response(struct hda_codec *codec)
{
	azx_t *chip = codec->bus->private_data;
	int timeout = 50;

	while (chip->rirb.cmds) {
		if (! --timeout) {
			snd_printk(KERN_ERR "azx_get_response timeout\n");
+			dump_stack();
			chip->rirb.rp = azx_readb(chip, RIRBWP);
			chip->rirb.cmds = 0;
			return -1;
		}
		msleep(1);
	}
	return chip->rirb.res; /* the last value */
}

that will show the call trace of the function.

>
> As mentioned in the original post, other kernels display the timeout
> message.  However, they do not loop endlessly and the driver load succeeds
> (presumedly on the second attempt, since only one timeout message was ever
> seen at a time).  Applying rt16 to 2.6.15 seems to change something which
> causes the endless timeouts.  The condition doesn't exist all the time; once
> it does exist however it persists until reboot.  Note too that the condition
> seems to only affect the HDA side of things - all other components of the
> kernel appear to function correctly.
>
> The machine in question is an i915-based laptop using PCI-express internally.
>
> Any other suggestions as to tests which might narrow down the problem's cause?
>

Yeah, could you just add that dump_stack to see who is calling this.  Then
we can look into that.

Thanks,

-- Steve
