Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWADAXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWADAXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWADAXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:23:43 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:18122 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S964971AbWADAXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:23:42 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0601032101570.9362@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de>
	 <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl>
	 <200601031629.21765.s0348365@sms.ed.ac.uk>
	 <20060103170316.GA12249@dspnet.fr.eu.org>
	 <1136312901.24703.59.camel@mindpipe> <1136316640.4106.26.camel@unreal>
	 <Pine.LNX.4.61.0601032036250.9362@tm8103.perex-int.cz>
	 <1136318187.4106.32.camel@unreal>
	 <Pine.LNX.4.61.0601032101570.9362@tm8103.perex-int.cz>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 01:23:24 +0100
Message-Id: <1136334204.4106.43.camel@unreal>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-02.tornado.cablecom.ch 32700; Body=3
	Fuz1=3 Fuz2=3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 21:06 +0100, Jaroslav Kysela wrote:

> The "plugin" (or rather conversion, routing and resampling) system in the 
> OSS emulation can be turned off using the proc interface:

Hm. IMO by including resampling and format conversion you're trying to
"unbreak" broken OSS apps in the kernel. And by having this on by
default you're rewarding writers of broken OSS apps while punishing
those that write correct apps...

But this is a sidetrack. Even though it's not optimal from the CPU usage
point of view to have two sampling rate converters in sequence, and
apart from the SNR loss by the overly simplistic linear interpolator,
soundmodem should still work with ALSA's OSS emulation. But it doesn't.
Well, it almost does: only every tenth or so bit is incorrect (which is
inacceptable for a modem, though). This leads me to suspect there's
something else wrong with the sample rate converter.

In sound/core/oss/rate.c, resample_expand, line 111:
if (src_frames1-- > 0) {

What is this test for? Similar code is also in resample_shrink.

Either it's never false, or I know why modem apps don't work with it: it
would be "inventing samples out of the blue", thereby adding lots of
jitter to the time axis...

Tom


