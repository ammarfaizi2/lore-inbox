Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270835AbTGPOBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270837AbTGPOBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:01:43 -0400
Received: from vdp001.ath11.cas.hol.gr ([195.97.127.2]:61854 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S270835AbTGPOBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:01:42 -0400
From: "P. Christeas" <p_christ@hol.gr>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] Reproducible deadlock w. alsa/maestro3 when sleeping (ACPI,) 2.6.0-test1
Date: Wed, 16 Jul 2003 17:18:50 +0300
User-Agent: KMail/1.5
Cc: lkml <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
References: <200307141917.22813.p_christ@hol.gr> <s5h7k6i1yoa.wl@alsa2.suse.de>
In-Reply-To: <s5h7k6i1yoa.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307161718.50464.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Mon, 14 Jul 2003 19:17:22 +0300,
>
> P. Christeas <p_christ@hol.gr> wrote:
> > I have been experiencing some fully reproducible deadlock when waking
> > from sleep, using artsd over ALSA.
> > The scenario is:
> > I use ALSA, with the maestro3 device and everything else compiled as
> > modules. From userspace, I launch artsd, which uses its native ALSA
> > support to connect to /dev/pcmXXXXX .
> > I only have a custom script, which sleeps the machine by a 'echo 1>
> > /proc/acpi/sleep' . It does NOT stop alsa .
>
> could you check whether m3_suspend() and m3_resume() in
> sound/pci/maestro3.c are really called?
>
>
> Takashi

OK, I did that.  I put two messages in both functions of the maestro3 driver. 
I suspended/resumed the machine. Both functions had been called.

This time, I did NOT have 'artsd' (i.e. the client) loaded. What happened was 
that the module was properly restored and I could load (and use) artsd even 
after the resume.
That brings me to the first assumption/question I have made: is there 
something wrong if we suspend two parts (one module and a userspace process), 
while they inter-communicate through the /dev/* interface?



static void m3_suspend(m3_t *chip)
{
	snd_card_t *card = chip->card;
	int i, index;

	snd_printk("m3 suspend");
	if (chip->suspend_mem == NULL)
		return;
	if (card->power_state == SNDRV_CTL_POWER_D3hot)
		return;
	...

static void m3_resume(m3_t *chip)
{
	snd_card_t *card = chip->card;
	int i, index;

	snd_printk("m3 resume");

	if (chip->suspend_mem == NULL)
		return;
	...
