Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUCFRdl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 12:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUCFRdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 12:33:41 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:28055 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261355AbUCFRdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 12:33:37 -0500
Message-ID: <404A0AB7.5020603@pacbell.net>
Date: Sat, 06 Mar 2004 09:30:31 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>	<20031028013013.GA3991@kroah.com>	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>	<3FA12A2E.4090308@pacbell.net>	<16289.29015.81760.774530@napali.hpl.hp.com>	<16289.55171.278494.17172@napali.hpl.hp.com>	<3FA28C9A.5010608@pacbell.net>	<16457.12968.365287.561596@napali.hpl.hp.com>	<404959A5.6040809@pacbell.net> <16457.38721.119739.816533@napali.hpl.hp.com>
In-Reply-To: <16457.38721.119739.816533@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:

> Here is patch #3.  It also Works For Me.  I was wondering whether it

I've had several "Works For Me" patches too, but then if the
silicion got kicked a bit differently it'd not behave... :(


> it is really safe to mess with the OHCI control registers the way
> ed_deschedule() does at a time the OHCI is running.  To test this

It must be, or we'd not have had a driver working for several
years now!

The quick stop/restart cycles haven't seemed to be a problem
with any OHCI silicion in the way they are with, for example,
VIA EHCI.


> theory, I delayed the ed_deschedule() handling to finish_unlinks(), as
> shown in the patch below.  I don't know whether this is really safe as
> far as the host's lists are concerned, but it does avoid the crashes.

My suspicions have been focussing on finish_unlinks().

That's really the only place the HCD does anything
that could corrupt the ED queues, which is what looks
to be happening.

Your change doesn't actually _unlink_ in the same way;
interesting change, I'll have to think about it.  It
certainly changes timings.


> What's the argument as to why it's safe to update the OHCI control
> registers in ed_deschedule() at the time start_ed_unlink() is running?

It's always safe to update those registers, except
that some silicon doesn't support that while the
controller is suspended.

- Dave


