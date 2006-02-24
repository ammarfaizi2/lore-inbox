Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWBXB2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWBXB2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWBXB2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:28:51 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:9148 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1751799AbWBXB2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:28:50 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200602240131.k1O1V7ip013435@auster.physics.adelaide.edu.au>
Subject: Re: 2.6.15-rt16: possible sound-related side-effect
To: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 24 Feb 2006 12:01:07 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org, mingo@elte.hu (Ingo Molnar)
In-Reply-To: <Pine.LNX.4.58.0602160245150.7272@gandalf.stny.rr.com> from "Steven Rostedt" at Feb 16, 2006 02:55:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys

> > > > In the last week I have updated the kernel on our laptop to 2.6.15-rt16.
> > > > By and large this worked well and had the attractive side effect of making
> > > > the clock run at the correct speed once more.
> > > >
> > > > During development of an ALSA patch I had the need to remove and reinsert
> > > > the hda-intel and hda-codec modules on numerous occasions.  Every so often
> > > > (perhaps once every 5 or 6 times on average) the initialisation sequence of
> > > > hda-intel would get hung up and the associated insmod would never return.  A
> > > > reboot was required to clear the problem.  The following messages were
> > > > written to syslog repeatedly and often:
> > > >
> > > >   Feb  5 21:36:24: ALSA sound/pci/hda/hda_intel.c:511: azx_get_response timeout
> > > >   Feb  5 21:36:26 halite last message repeated 9 times
> > > >   Feb  5 21:36:29 halite kernel: printk: 31 messages suppressed.
> > > >
> > > > I have noticed the "azx_get_response timeout" messages in earlier kernels
> > > > as well, but up until now the hda initialisation hasn't gotten hung up.
:
> > In any case, I did the above and booted with "nmi_watchdog=2 lapic".  I
> > triggered the fault but neither the soft lockup nor NMI watchdog triggered,
> > which given the above was of no surprise.
> >
> > The "azx_get_response timeout" is only produced by a single function:
> > azx_get_response() in hda_intel.c.  This in turn seems to be called from
> > only one location - azx_codec_create() in hda_intel.c.  azx_probe() calls
> 
> It's not called there. It's setup as a function pointer, so it is called
> when another fuction calls the get_response pointer.
> 
> > azx_codec_create() exactly once, and azx_probe() is the .probe method for
> > the PCI driver definition.  Given that the above call chain in hda-intel.c
> > does not contain any loops, I conclude that the PCI code is repeatedly
> > calling the probe method due (presumedly) to the repeated timeouts.  I can't
> > see how else azx_get_response() could be called repeatedly.
> 
> If you want to know where it is being called from, do add the following:
> 
> static unsigned int azx_get_response(struct hda_codec *codec)
> {
> 	azx_t *chip = codec->bus->private_data;
> 	int timeout = 50;
> 
> 	while (chip->rirb.cmds) {
> 		if (! --timeout) {
> 			snd_printk(KERN_ERR "azx_get_response timeout\n");
> +			dump_stack();
> 			chip->rirb.rp = azx_readb(chip, RIRBWP);
> 			chip->rirb.cmds = 0;
> 			return -1;
> 		}
> 		msleep(1);
> 	}
> 	return chip->rirb.res; /* the last value */
> }
> 
> that will show the call trace of the function.
:
> > Any other suggestions as to tests which might narrow down the problem's cause?
> 
> Yeah, could you just add that dump_stack to see who is calling this.  Then
> we can look into that.

I finally got around to doing this and the first two dumps are at the
end of this message.  Many many more were sent to the logs though - as 
one would expect, since we know that in the fault condition this function
is called very frequently without any end in site.

I've put the *full* dump up at

  http://www.atrad.com.au/~jwoithe/kernel/full_timeout_dump.bz2

if anyone's interested.  Similarly, I moved the dump_stack() call
outside the while() loop and obtained a dump in the case of things
working correctly.  You can grab this from

  http://www.atrad.com.au/~jwoithe/kernel/dump_loaded_ok.bz2

Oh yes, the dump_stack() call was put *before* the snd_printk() call
when I did the tests.  This makes no practical difference except that it
explains why the output from this came after the dumps.

Over the weekend I'll try to test 2.6.15-rt17 since that's recently come
out.

What next?

Regards
  jonathan

Stack dump following the first timeout:
Feb 22 21:34:15 halite kernel:  [<f8ccd22d>] azx_get_response+0x21/0x7c [snd_hda_intel] (8)
Feb 22 21:34:15 halite kernel:  [<f8d5b038>] snd_hda_codec_read+0x38/0x4a [snd_hda_codec] (12)
Feb 22 21:34:15 halite kernel:  [<f8d5b0cf>] snd_hda_get_sub_nodes+0x18/0x33 [snd_hda_codec] (16)
Feb 22 21:34:15 halite kernel:  [<f8d5c6f9>] hda_set_power_state+0x2d/0xaf [snd_hda_codec] (24)
Feb 22 21:34:15 halite kernel:  [<f8d5c7df>] snd_hda_build_controls+0x64/0x8b [snd_hda_codec] (56)
Feb 22 21:34:15 halite kernel:  [<f8cce015>] azx_mixer_create+0xf/0x11 [snd_hda_intel] (28)
Feb 22 21:34:15 halite kernel:  [<f8cce6d6>] azx_probe+0x98/0xcb [snd_hda_intel] (8)
Feb 22 21:34:15 halite kernel:  [<c021e95b>] pci_call_probe+0xf/0x12 (24)
Feb 22 21:34:15 halite kernel:  [<c021e991>] __pci_device_probe+0x33/0x47 (12)
Feb 22 21:34:15 halite kernel:  [<c021e9c4>] pci_device_probe+0x1f/0x34 (28)
Feb 22 21:34:15 halite kernel:  [<c0264893>] driver_probe_device+0x3a/0x84 (24)
Feb 22 21:34:15 halite kernel:  [<c026493d>] __driver_attach+0x0/0x34 (16)
Feb 22 21:34:15 halite kernel:  [<c0264963>] __driver_attach+0x26/0x34 (4)
Feb 22 21:34:15 halite kernel:  [<c02640d1>] bus_for_each_dev+0x4a/0x70 (20)
Feb 22 21:34:15 halite kernel:  [<c02169c0>] kobject_add+0x82/0xa1 (24)
Feb 22 21:34:15 halite kernel:  [<c0264985>] driver_attach+0x14/0x18 (20)
Feb 22 21:34:15 halite kernel:  [<c026493d>] __driver_attach+0x0/0x34 (16)
Feb 22 21:34:15 halite kernel:  [<c02644c1>] bus_add_driver+0x57/0x9f (4)
Feb 22 21:34:15 halite kernel:  [<c0264c62>] driver_register+0x4d/0x53 (24)
Feb 22 21:34:15 halite kernel:  [<c021eba7>] __pci_register_driver+0x7a/0xa9 (20)
Feb 22 21:34:15 halite kernel:  [<c021ebc5>] __pci_register_driver+0x98/0xa9 (12)
Feb 22 21:34:15 halite kernel:  [<f8c8f00f>] alsa_card_azx_init+0xf/0x12 [snd_hda_intel] (28)
Feb 22 21:34:15 halite kernel:  [<c01317c1>] sys_init_module+0xac/0x19c (12)
Feb 22 21:34:15 halite kernel:  [<c0102cad>] syscall_call+0x7/0xb (16)
Feb 22 21:34:15 halite kernel: ALSA /mnt/hd/alsa-1.0.11rc3/alsa-driver-1.0.11rc3/alsa-kernel/pci/hda/hda_intel.c:516: azx_get_response timeout

Second dump following the start of the timeouts:
Feb 22 21:34:16 halite kernel:  [<f8ccd22d>] azx_get_response+0x21/0x7c [snd_hda_intel] (8)
Feb 22 21:34:16 halite kernel:  [<f8d5b038>] snd_hda_codec_read+0x38/0x4a [snd_hda_codec] (12)
Feb 22 21:34:16 halite kernel:  [<f8d5c72f>] hda_set_power_state+0x63/0xaf [snd_hda_codec] (16)
Feb 22 21:34:16 halite kernel:  [<f8d5c7df>] snd_hda_build_controls+0x64/0x8b [snd_hda_codec] (44)
Feb 22 21:34:16 halite kernel:  [<f8cce015>] azx_mixer_create+0xf/0x11 [snd_hda_intel] (28)
Feb 22 21:34:16 halite kernel:  [<f8cce6d6>] azx_probe+0x98/0xcb [snd_hda_intel] (8)
Feb 22 21:34:16 halite kernel:  [<c021e95b>] pci_call_probe+0xf/0x12 (24)
Feb 22 21:34:16 halite kernel:  [<c021e991>] __pci_device_probe+0x33/0x47 (12)
Feb 22 21:34:16 halite kernel:  [<c021e9c4>] pci_device_probe+0x1f/0x34 (28)
Feb 22 21:34:16 halite kernel:  [<c0264893>] driver_probe_device+0x3a/0x84 (24)
Feb 22 21:34:16 halite kernel:  [<c026493d>] __driver_attach+0x0/0x34 (16)
Feb 22 21:34:16 halite kernel:  [<c0264963>] __driver_attach+0x26/0x34 (4)
Feb 22 21:34:16 halite kernel:  [<c02640d1>] bus_for_each_dev+0x4a/0x70 (20)
Feb 22 21:34:16 halite kernel:  [<c02169c0>] kobject_add+0x82/0xa1 (24)
Feb 22 21:34:16 halite kernel:  [<c0264985>] driver_attach+0x14/0x18 (20)
Feb 22 21:34:16 halite kernel:  [<c026493d>] __driver_attach+0x0/0x34 (16)
Feb 22 21:34:16 halite kernel:  [<c02644c1>] bus_add_driver+0x57/0x9f (4)
Feb 22 21:34:16 halite kernel:  [<c0264c62>] driver_register+0x4d/0x53 (24)
Feb 22 21:34:16 halite kernel:  [<c021eba7>] __pci_register_driver+0x7a/0xa9 (20)
Feb 22 21:34:16 halite kernel:  [<c021ebc5>] __pci_register_driver+0x98/0xa9 (12)
Feb 22 21:34:16 halite kernel:  [<f8c8f00f>] alsa_card_azx_init+0xf/0x12 [snd_hda_intel] (28)
Feb 22 21:34:16 halite kernel:  [<c01317c1>] sys_init_module+0xac/0x19c (12)
Feb 22 21:34:16 halite kernel:  [<c0102cad>] syscall_call+0x7/0xb (16)
Feb 22 21:34:16 halite kernel: ALSA /mnt/hd/alsa-1.0.11rc3/alsa-driver-1.0.11rc3/alsa-kernel/pci/hda/hda_intel.c:516: azx_get_response timeout
