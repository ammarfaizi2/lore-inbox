Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270921AbTGPOrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270922AbTGPOrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:47:52 -0400
Received: from vdp171.ath01.cas.hol.gr ([195.97.116.172]:46751 "EHLO
	pfn1.pefnos") by vger.kernel.org with ESMTP id S270921AbTGPOrb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:47:31 -0400
From: "P. Christeas" <p_christ@hol.gr>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] Reproducible deadlock w. alsa/maestro3 when sleeping (ACPI,) 2.6.0-test1
Date: Wed, 16 Jul 2003 18:03:48 +0300
User-Agent: KMail/1.5
Cc: lkml <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
References: <200307141917.22813.p_christ@hol.gr> <s5h7k6i1yoa.wl@alsa2.suse.de> <200307161718.50464.p_christ@hol.gr>
In-Reply-To: <200307161718.50464.p_christ@hol.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307161803.48574.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Takashi Iwai wrote:
> > At Mon, 14 Jul 2003 19:17:22 +0300,
> >
> > P. Christeas <p_christ@hol.gr> wrote:
> > > I have been experiencing some fully reproducible deadlock when waking
> > > from sleep, using artsd over ALSA.
> > > The scenario is:
> > > I use ALSA, with the maestro3 device and everything else compiled as
> > > modules. From userspace, I launch artsd, which uses its native ALSA
> > > support to connect to /dev/pcmXXXXX .
> > > I only have a custom script, which sleeps the machine by a 'echo 1>
> > > /proc/acpi/sleep' . It does NOT stop alsa .
> >
> > could you check whether m3_suspend() and m3_resume() in
> > sound/pci/maestro3.c are really called?
> >
> >
> > Takashi
>
> OK, I did that.  I put two messages in both functions of the maestro3
> driver. I suspended/resumed the machine. Both functions had been called.
>
> This time, I did NOT have 'artsd' (i.e. the client) loaded. What happened
> was that the module was properly restored and I could load (and use) artsd
> even after the resume.
> That brings me to the first assumption/question I have made: is there
> something wrong if we suspend two parts (one module and a userspace
> process), while they inter-communicate through the /dev/* interface?
>
>
In a second test, I have also added messages at the end of these functions. 
They surely don't exit early indeed.

Has anybody else managed to reproduce the bug?
Does it happen with other drivers (say, PCI cards w. pcm interface)?

procedure:
	(read the last step first; it is a warning)
	1. load the sound module, like 'modprobe snd-maestro3'
	2. load the client ("artsd" should be the one, others may eventually release 
the descriptor. If you want, you could give them a try as well.) 
	3. Suspend, S1, NOT with an all-capable script. The script you use must not 
try to bring down ALSA.
	4. Resume.
	5. Check the state of the "artsd" (or equivalent) process.

	W. Note that if the process is waiting for I/O, you can do nothing but 
reboot.


