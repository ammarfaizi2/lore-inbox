Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVI1VAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVI1VAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbVI1VAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:00:15 -0400
Received: from mail.dvmed.net ([216.237.124.58]:15846 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750859AbVI1VAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:00:13 -0400
Message-ID: <433B0457.7020509@pobox.com>
Date: Wed, 28 Sep 2005 17:00:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com> <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com> <433AFEB2.7090003@adaptec.com>
In-Reply-To: <433AFEB2.7090003@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> Ideally SATL is just a _data transformation function_ and
> getting to the ATA device is transport dependent.

Incorrect.  It needs to issue multiple ATA commands to emulate a single 
SCSI command, cache some state, and other details.  Not purely data 
transformation.


> Jeff, would you be accepting patches?

Yes.  That's what I mean when I say "submit patches".


>>>No, not true.  It _integrates_ with SCSI Core.  The sad truth
>>>is that SCSI Core knows only HCIL.
>>
>>
>>That's something that needs fixing, for SAS.
> 
> 
> Would you be accepting patches for the creation,
> and use of "struct scsi_domain_device { ... }"?
> 
> This would be a "SCSI Device with a Z Port".
> Z could be target or initiator (most likely just T).
> 
> Then for each scsi_domain_device, SCSI Core does
> REPORT LUNS and then INQUIRY for each LU it found.
> 
> The old (current) code would still say as is, unchanged,
> since it supports older, broken hardware.
> 
> Would you be accepting patches for this?

What needs to happen is that SPI-specific stuff in the SCSI core needs 
to be moved to SPI-specific transport code.

Then all transports will be at an equal level, and the SCSI core will be 
fully transport-agnostic.


>>>I repeat again that I had this code _long_ before Christoph
>>>ever dreamt up SAS.  And he got my code via James B sometime
>>>before OLS this year.  I think he got it July 12, 2005.
>>>
>>>The question is: why didn't _he_ use the solution already
>>>available?
>>
>>
>>Because it has the problems listed time and again.
> 
> 
> What problems when there was no other code around.
> 
> Look at it this way: _their_ code doesn't integrate
> with ours.  See?
> 
> I simply cannot take an argument like this:
>    "Because it has the problems listed time and again."
> 
> You have to be specific.

"time and again" means that we have been specific multiple times. 
Re-read your emails from James and Christoph :)


>>The SAS transport class is designed to support both firmware-based 
>>devices like MPT, and non-firmware devices such as Adaptec.
> 
> 
> No, it never has been.  It is an _attribute_ exporting framework
> only.
> 
> If you understood how different those architectures are,
> you'd understand what I mean.

James is wrong here.  The "transport class" in reality winds up as a 
transport lib, in addition to simply exporting attributes.

There will always be functions that are common to a transport. 
Christoph calls this "libsas", since software-driven SAS implementations 
will share this transport code, but not necessarily all SAS 
implementations (MPT, qla etc.).


>>Sure it might need patches -- send patches, work with people, rather 
>>than ignoring existing work.
> 
> 
> I do not _know_ how to consolidate the completely broken
> "design" set forth by JB and company.
> 
> It is _completely_ not to SAM spec.

Not true.  Just because SCSI core lacks an explicit "execute SCSI 
command" RPC hook, does not imply that that capability is non-existent.

Stare at the Scsi_Host_Template some more and you'll see it.


> Exporting attributes from MPT-based drivers is not the same
> as managing a transport.
> 
> I repeat again:
>   * MPT _hides_ the transport and the managment
>     of the transport from you -- so in effect there is
>     nothing to manage.
>   * MPT gives you Logical Units to work with, NOT ever domain
>     devices or anyhing domain like.
>   * MPT gives you a SAM/SPC hook to hook _right_ into SCSI Core.
> 
> _This_ is why their LLDD _can_ use the host template.
> 
> But an AIC-94xx and BCM8603 _is_ NOT a scsi_host material.  It is just
> an interface to the interconnect.

A scsi_host is simply a container.  You're being too literal.


> To convince yourself of this: take a look at the _members_ of
> the scsi host/scsi host template: nothing in that structure is
> presented in the chip -- UNLIKE old Parallel SCSI device drivers.
> 
> The scsi host template was written to cater to _old_ (then new)
> Parallel SCSI drivers!  Times have changed!  Time to evolve.

Yes.  We need to evolve the SCSI core to separate out SPI-specific 
pieces, to make it more transport-agnostic.


>>We've been over the technical stuff time and again.  That's the 
>> maintainer problem. 
> 
> 
> No we haven't been over the technical stuff time and again.
> 
> 
>>We need someone who will listen to the community.
> 
> 
> I bet you're melting people's hearts when they read this.
> 
> So to summarize for corporate management what you're saying
> here is:
>   - you're saying that I do not listen to "the community",

correct


>   - you're saying that I'm an _outsider_ to "the community",

irrelevant


>   - you're saying that I'm no good to work with you, since
>     you are part of that community but not me.

irrelevant


> That is you cannot take it that someone will tell 
> "the community" anything.  "The community" knows all and it
> knows best.
> 
> So in effect there are no good and knowlegable engineers
> anywhere but in the "Linux community".
> 
> That is there is no people with new ideas, better ideas,
> innovative ideas, more knowlege about certain subject matter,
> _anywhere_ but in the "Linux community".
> 
> So in effect, there will never be an "outsider" who will
> come in to the "linux community" and change things around,
> no fresh ideas, no better (right?) way to do things.
> 
> "The community" is not going to listen to anyone but only to
> already politically established members on _any_ subject
> matter, even technical, even from "outsiders" who work with
> the technology every day.

overreaction


>>>What _exactly_ does it mean "don't play well with others"?
>>
>>
>>It means not taking feedback, and working around rather than with the 
>>SCSI core.
> 
> 
> So does this mean, that if I submit patches "fixing" (oops,
> not meant to hurt anyone's bal^w^w^wpride) SCSI Core, they
> will be accepted.

James and Christoph have been asking you to submit patches for a long 
time now.


> Or do you want me to do "your way of SAS"?
> Maybe JB et al, should write the "Linux SAS spec" and
> then we can recommend this to T10.org, so they can scrap
> their version and use "the community's"?

You're over-reacting.


>>Then you don't understand the ->qc_{prep,issue} hooks.  That should get 
>>you 90% of the way there, if not 99%.
> 
> 
> But I have to simulate struct ata_port, Jeff.
> 
> Which isn't so bad, but speaks about the design.

You have to provide a means to submit ATA commands and receive results, 
no more or less.


>>>The code doesn't alter Linux SCSI or anyone else's behaviour.
>>>It only _provides_ SAS support to the kernel.

>>That's one of the problems: It should update the SCSI core.

> Thank you for admitting this -- you're the first and only
> member of "the community" (since I'm not a member apparently)
> to admit this.

James, Christoph and the rest of linux-scsi have been saying this over 
and over again.

You need to update the SCSI core properly, rather than working around it.

Everybody knows the SCSI core is too SPI-centric, and you have been 
given a recipe for fixing this.

	Jeff


