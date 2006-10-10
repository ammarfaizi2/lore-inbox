Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030525AbWJJVsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbWJJVsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030516AbWJJVsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:48:12 -0400
Received: from tla.xelerance.com ([193.110.157.130]:61201 "EHLO
	tla.xelerance.com") by vger.kernel.org with ESMTP id S1030515AbWJJVrf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:47:35 -0400
Date: Tue, 10 Oct 2006 23:50:59 +0200 (CEST)
From: Paul Wouters <paul@xelerance.com>
To: Michael Buesch <mb@bu3sch.de>
cc: linux-kernel@vger.kernel.org, Gabor Gombas <gombasg@sztaki.hu>,
       fedora-xen@redhat.com
Subject: Re: more random device badness in 2.6.18 :(
In-Reply-To: <200610102313.02783.mb@bu3sch.de>
Message-ID: <Pine.LNX.4.63.0610102334470.27986@tla.xelerance.com>
References: <Pine.LNX.4.63.0610101944010.21866@tla.xelerance.com>
 <20061010205051.GB14865@boogie.lpds.sztaki.hu> <Pine.LNX.4.63.0610102257100.27986@tla.xelerance.com>
 <200610102313.02783.mb@bu3sch.de>
X-Message-Flag: You should stop using Outlook and switch to Thunderbird
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-From: paul@xelerance.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Michael Buesch wrote:

> > > Why should Openswan touch /dev/hw_random directly?
> >
> > Because using /dev/random whlie /dev/hw_random is available does not always
> > work (eg with padlock)
>
> Oh, wait wait. I don't really understand your sentence.
> Why can't you use /dev/random?

We have noticed in the past that on VIA's with the padlock, that
/dev/random stopped working when hw_random got loaded, while we could
get random from /dev/hw_random. So we assumed that was the design.

> /dev/hw_random should never be touched by anything else than rngd.

Seems like a good argument to keep this state hidden in the kernel then.

> rngd takes the data from /dev/hw_random, _verifys_ it and puts it into
> the normal /dev/random pools.
> The verification step is really important.

I understand the use of a FIPS compliant hardware random.

> So I would like to ask the other way around. Why should be put this code
> into the kernel, while it works in userspace as good (or, some people may
> argue it is even better in userspace, because it can more easily be exchanged,
> debugged and configured. Whatever)

If only a single process should ever touch a device, I wonder why it is
a device visible to all of userland. For one, it confuses stupid people
like me. Second, it seems that perhaps the reason the VIA hardware random
was "broken" was becaus I and others were unaware of the requirement of
rngd with hw_random. I am obviously not the only one, since Fedora Core
6 test 3 autoloads the hardware random module, but does not come with
the rng-tools package to fix /dev/random to actually use /dev/hw_random.

At least I do feel better now about all the device renames. rngd
uses "hwrandom" per default, which no longer exists. Then there is
hw_random, which seems to be something obsolete for hwrng judging by
the softlink. And I can stop worrying that /dev/hw_random cannot be
read without root permission on default modprobe. I'm happy to hear I
no longer need to worry about all those devices, and I can go back and
remove the code that deals with /dev/hw_random, after I verify that the
VIA systems still have a functional /dev/random if someone modprobe's
hw_random without running rngd. But if not running rngd breaks /dev/random,
then we'll be forced to keep an eye out for those /dev/hw* devices.

Paul
