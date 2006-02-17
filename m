Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWBQBnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWBQBnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWBQBnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:43:11 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:27830 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1750721AbWBQBnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:43:10 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200602170145.k1H1j9xj017172@auster.physics.adelaide.edu.au>
Subject: Re: 2.6.15-rt16: possible sound-related side-effect
To: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 17 Feb 2006 12:15:09 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org, mingo@elte.hu (Ingo Molnar)
In-Reply-To: <Pine.LNX.4.58.0602160245150.7272@gandalf.stny.rr.com> from "Steven Rostedt" at Feb 16, 2006 02:55:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

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
> > > >
> > > > The latching up of the hda-intel initialisation does not appear to occur
> > > > when doing the same thing under a non-RT 2.6.15 kernel.  Furthermore, I have
> > > > had an instance where the lockup occured while cold-booting an unmodified
> > > > 2.6.15-rt16, which rules out any changes I made to ALSA as the cause of the
> > > > problem.  In any case the changes I was making to ALSA don't affect the
> > > > initialisation code.
> > > >
> > > > Prior to this kernel I was running an unmodified 2.6.14-rt21 kernel and
> > > > while these messages did occur they didn't cause hda-intel to lock up.
> > > >
> > > > Any suggestions as to what might be causing this and/or of further tests
> > > > which might help narrow down the cause?
:
> Sorry, I was thinking your kernel locked up, not just the insmod.  OK,
> forget about what I asked.

No problem.

> > The "azx_get_response timeout" is only produced by a single function:
> > azx_get_response() in hda_intel.c.  This in turn seems to be called from
> > only one location - azx_codec_create() in hda_intel.c.  azx_probe() calls
> 
> It's not called there. It's setup as a function pointer, so it is called
> when another fuction calls the get_response pointer.

Yep, you're right - I misread the code the other day, probably because I
was in a hurry.  My turn to be sorry. :)

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
> :
> > Any other suggestions as to tests which might narrow down the problem's cause?
> 
> Yeah, could you just add that dump_stack to see who is calling this.  Then
> we can look into that.

No problem.  I'll do this sometime over the weekend and report the findings
early next week.

Regards
  jonathan
