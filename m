Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUBEQdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 11:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266395AbUBEQdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 11:33:21 -0500
Received: from mailgate.wolfson.co.uk ([194.217.161.2]:9197 "EHLO
	wolfsonmicro.com") by vger.kernel.org with ESMTP id S266364AbUBEQdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 11:33:18 -0500
Subject: Re: [BUG] unsafe reset in ac97_codec.c
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <40216306.2010602@pobox.com>
References: <1075822947.5204.506.camel@cearnarfon>
	 <40216306.2010602@pobox.com>
Content-Type: text/plain
Message-Id: <1075998717.5204.1003.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 05 Feb 2004 16:31:57 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 21:24, Jeff Garzik wrote:

> In general it's important for Linux to be able to reset a device 
> reliable.  Where in Other Operating Systems one must reboot the 
> computer, Linux users can just re-load the driver quite often.
> 
> So I think there are two comments here:
> 
> * I can certainly see -probing- being unreliable (but not necessarily reset)

I agree, but I think we need to be aware of the codec type before we do
a register reset. This type of codec is now becoming popular in PDA's.

> 
> * If the default state for some devices is power-down, the driver should 
> be aware of that -anyway-, and we should power up on startup or on-demand.
> 

I can see another problem with the current probe implementation.
Currently it sends the register reset command without first checking the
codec ready bit. This assumes that the AC97 link is up and completely
working before probe is called.

I would like to suggest some changes to probe:-

1. We have a new flag AC97_DEFAULT_POWER_OFF in ac97_codec_ids[] to mark
codecs that have a default power state of "off".

2. Probe checks the codec ready bit (or waits 10uS) first before doing
anything else.

3. Probe reads the codec ID (hardwired codec registers) and if the codec
is of type AC97_DEFAULT_POWER_OFF then goes to step 6. In this case the
code that calls probe will have done a warm reset to wake the codec in
the first place.

4. Send register reset to codec.

5. wait for codec ready bit. 

6. carry on as original probe, by reading register AC97_RESET

I'll implement this if it's acceptable as I can test it on both types of
codec.

Liam



