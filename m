Return-Path: <linux-kernel-owner+w=401wt.eu-S932603AbWLMHVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWLMHVn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 02:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWLMHVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 02:21:43 -0500
Received: from mouth.voxel.net ([69.9.180.118]:47870 "EHLO mail.squishy.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932603AbWLMHVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 02:21:43 -0500
Message-ID: <457FAA01.9010807@debian.org>
Date: Wed, 13 Dec 2006 02:21:37 -0500
From: Andres Salomon <dilinger@debian.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, warp@aehallh.com
Subject: Re: [PATCH] psmouse split
References: <457F822E.4040404@debian.org> <200612130108.19447.dtor@insightbb.com>
In-Reply-To: <200612130108.19447.dtor@insightbb.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Hi Andres,
[...]
> 
> Unfortunately I do not think this is going to work well in in default case:
> 
> 1. PS/2 probing order is important. You need to probe for intellimouse
>    explorer last otherwise you might miss that mouse supports extended
>    protocol.
> 

Sorry, I'm not sure I understand; you're saying that the intellimouse
probe will match other mice?

I originally had kept the probing order, but dropped it here:

http://dev.laptop.org/git?p=users/dilinger/psmouse-split;a=commit;h=14f352333d057c3a7a05fdab484b339b9bac2959

I can readd it if necessary.


> 2. Synaptics hardware has to be probed even if synaptics protocol is not
>    used, otherwise intellimouse probe will case trackpoint on passthrough
>    port not working.
> 


I'm aware of that, and the synaptics_hardware variable remains in the
psmouse_extensions() function as a reminder.  I just need to figure out
a clean way to do the probing; I wanted feedback about whether people
liked the broken out modules idea, first.


> 3. Doing full reset after every protocol probe will cause long delays in
>    mouse detection. 


I'm not convinced this will actually take that long, and it should only
happen during init.  With ordered detection and an additional field in
the psmouse_protocol struct, each protocol could specify whether it
should be reset or not.  However, if it's not necessary, I'd rather get
rid of it all (sounds like the detection ordering might be necessary,
though).

> 
> 4. Maxproto is still needed - psmouse base still contains several protocols
>    and sometimes users need to force "standard" protocols (Intellimouse/
>    Explorer), for example when using a KVM switch.
> 

Yes, I intended to split out the protocols into a separate module, as
mentioned in

http://dev.laptop.org/git?p=users/dilinger/psmouse-split;a=commit;h=2a19dbb884cb05b5e9469bde439ac60ed56bd48d

If a KVM requires a user to force a standard protocol, I would think
that forcing it via psmouse_attr_set_protocol would be a much nicer way
than dealing w/ max_proto.  Combine that w/ being able to rmmod specific
protocol modules (ie, rmmod psmouse-synaptics if it turns out that
detection is incorrectly seeing something synaptics-like).


> Also, splitting psmouse into several modules as opposed to having monolitic
> psmouse with an option to exclude some protocols via Kconfig does not really
> buy us anything - because protocol autoload is not possible (we do not know

It does; compiling a custom kernel for users is a pain.  However, using
a distribution kernel and being able to control specifically which
modules are loaded makes life a lot easier (users get security updates,
etc).


> what protocols port uses until we actually do the probe) distributions will
> have to compile and load everything anyway. Custom kernel users will just
> have to compile protocols they need into psmouse.
> 

Yes, distributions will have to compile and load everything anyways.
However, people who know what hardware they have can then force loading
of a specific module, rather than having a monolithic module or having
to recompile a custom kernel.


> And some comments for the patch itself:
> 
>> +               if (proto->detect(psmouse, set_properties) == 0) {
>> +                       if (proto->type == PSMOUSE_SYNAPTICS)
>> +                               synaptics_hardware = 1;
>> +                       if (!set_properties) {
>> +                               if (proto->init && proto->init(psmouse) != 0)
>> +                                       continue; 
> 
> I think you wanted if (set_properties)...
> 
>> +static void psmouse_rescan(struct serio *serio, void *data)
>> +{
>> +       if (serio->drv->driver.name == "psmouse")
>> +               serio_rescan(serio);
>> +}
> 
> This is going to crash if you encounter unconnected port
> (serio->drv == NULL).
>

Thanks!


>> +MODULE_AUTHOR("C. Scott Ananian <cananian@alumni.priceton.edu>");
>> +MODULE_DESCRIPTION("Synaptics TouchPad PS/2 mouse driver");
>> +MODULE_LICENSE("GPL");
> 
> You need to be careful with code attribution - for example Synaptics driver
> was written by Peter Osterlund. He took some code from tpconfig utility,
> that's why there is C. Scott Ananian copyright notice but _module_ author
> is still Peter.
> 

Indeed, that was among the comments I was looking for.  The copyright
attribution in each protocol file wasn't clear.  Before actually
considering this done, we'd need to go through each module and make sure
that attribution is correct.



>> +       psmouse_protocol_register(&genius_proto, 0);
>> +       psmouse_protocol_register(&imps_proto), 0;
> 
> Hmm, does this compile?
> 

Oops, that was a mispaste between what I was testing and what I'd committed.

Thanks for the feedback!

