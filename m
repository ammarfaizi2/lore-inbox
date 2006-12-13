Return-Path: <linux-kernel-owner+w=401wt.eu-S932333AbWLMOMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWLMOMO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 09:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWLMOMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 09:12:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:52811 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932333AbWLMOMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 09:12:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aHsCdXbx6qdEUAZCQJFnsKt7QL1r3nVhlQA5qnFDBkcDFaWMHDUtHweb83uXSBJJaqsRsIvHX1uJVS2Uz+so7fy62MVwLpJFcHPTytBwSGuINSlLDRsYkwBqGtmG6IPtEYCbIoKVPQ9uFnfZeg/FC60Xs/ZA/zVRwZtzSu7FAe8=
Message-ID: <d120d5000612130612v5d12adc0uc878b8307770d79@mail.gmail.com>
Date: Wed, 13 Dec 2006 09:12:12 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Andres Salomon" <dilinger@debian.org>
Subject: Re: [PATCH] psmouse split
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, warp@aehallh.com
In-Reply-To: <457FAA01.9010807@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457F822E.4040404@debian.org>
	 <200612130108.19447.dtor@insightbb.com> <457FAA01.9010807@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Andres Salomon <dilinger@debian.org> wrote:
> Dmitry Torokhov wrote:
> > Hi Andres,
> [...]
> >
> > Unfortunately I do not think this is going to work well in in default case:
> >
> > 1. PS/2 probing order is important. You need to probe for intellimouse
> >    explorer last otherwise you might miss that mouse supports extended
> >    protocol.
> >
>
> Sorry, I'm not sure I understand; you're saying that the intellimouse
> probe will match other mice?
>

Yes, for example many Logitech mice supporting PS2++ will respond to
intellimouse and explorer probes. Some versions of synaptics firmware
support intellimouse protocol as well. I am pretty sure ALPS does too.

> I originally had kept the probing order, but dropped it here:
>
> http://dev.laptop.org/git?p=users/dilinger/psmouse-split;a=commit;h=14f352333d057c3a7a05fdab484b339b9bac2959
>
> I can readd it if necessary.
>
>
> > 2. Synaptics hardware has to be probed even if synaptics protocol is not
> >    used, otherwise intellimouse probe will case trackpoint on passthrough
> >    port not working.
> >
>
>
> I'm aware of that, and the synaptics_hardware variable remains in the
> psmouse_extensions() function as a reminder.  I just need to figure out
> a clean way to do the probing; I wanted feedback about whether people
> liked the broken out modules idea, first.
>

OK.

>
> > 3. Doing full reset after every protocol probe will cause long delays in
> >    mouse detection.
>
>
> I'm not convinced this will actually take that long, and it should only
> happen during init.  With ordered detection and an additional field in
> the psmouse_protocol struct, each protocol could specify whether it
> should be reset or not.  However, if it's not necessary, I'd rather get
> rid of it all (sounds like the detection ordering might be necessary,
> though).
>

Resets are needed. We used not to have it but that confused some mice.

> >
> > 4. Maxproto is still needed - psmouse base still contains several protocols
> >    and sometimes users need to force "standard" protocols (Intellimouse/
> >    Explorer), for example when using a KVM switch.
> >
>
> Yes, I intended to split out the protocols into a separate module, as
> mentioned in
>
> http://dev.laptop.org/git?p=users/dilinger/psmouse-split;a=commit;h=2a19dbb884cb05b5e9469bde439ac60ed56bd48d
>
> If a KVM requires a user to force a standard protocol, I would think
> that forcing it via psmouse_attr_set_protocol would be a much nicer way
> than dealing w/ max_proto.  Combine that w/ being able to rmmod specific
> protocol modules (ie, rmmod psmouse-synaptics if it turns out that
> detection is incorrectly seeing something synaptics-like).
>

That requires changing your init scripts and such. In many instances
specifying psmouse.max_proto on kernel command line is the easiest
way.

>
> > Also, splitting psmouse into several modules as opposed to having monolitic
> > psmouse with an option to exclude some protocols via Kconfig does not really
> > buy us anything - because protocol autoload is not possible (we do not know
>
> It does; compiling a custom kernel for users is a pain.  However, using
> a distribution kernel and being able to control specifically which
> modules are loaded makes life a lot easier (users get security updates,
> etc).
>
>
> > what protocols port uses until we actually do the probe) distributions will
> > have to compile and load everything anyway. Custom kernel users will just
> > have to compile protocols they need into psmouse.
> >
>
> Yes, distributions will have to compile and load everything anyways.
> However, people who know what hardware they have can then force loading
> of a specific module, rather than having a monolithic module or having
> to recompile a custom kernel.
>

I would consider this module juggling way over the head for average
user. I want to have the ability to exclude some protocols from
psmouse module via Kconfig option, but I want it to be hidden under
CONFIG_EMBEDDED for everything except very raretic protocols (like
OLPC).

-- 
Dmitry
