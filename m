Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVI1UgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVI1UgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVI1UgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:36:14 -0400
Received: from magic.adaptec.com ([216.52.22.17]:47502 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750808AbVI1UgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:36:13 -0400
Message-ID: <433AFEB2.7090003@adaptec.com>
Date: Wed, 28 Sep 2005 16:36:02 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com> <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com>
In-Reply-To: <4339F9A8.2030709@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2005 20:36:12.0032 (UTC) FILETIME=[43A4E800:01C5C46C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/05 22:02, Jeff Garzik wrote:
> Luben Tuikov wrote:
> 
>>On 09/27/05 17:55, Jeff Garzik wrote:
>>
>>
>>>* Avoids existing SAS code, rather than working with it.
> 
> 
>>No, it's the _other_ way around.  There is NO existing
>>SAS code.
> 
> 
> Incorrect, just look in the latest upstream kernel.

Yes, because it was Christoph's code submitted right after
I submitted and JB took his code right in.

Again, I had the infrastructure ready _before_ OLS.

> libata-scsi.c is the SAT translation layer.

Not quite.

It has potential to become SATL but at its current
form it cannot be:

int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
{
	struct ata_port *ap;
	struct ata_device *dev;
	struct scsi_device *scsidev = cmd->device;

	ap = (struct ata_port *) &scsidev->host->hostdata[0];

If I want to use that I have to _simulate_ ata_port.
Furthermore, scsidev->host->hostdata may not point
to ata_port for SATA devices over a different transport.

Ideally SATL is just a _data transformation function_ and
getting to the ATA device is transport dependent.

Jeff, would you be accepting patches?

>>No, not true.  It _integrates_ with SCSI Core.  The sad truth
>>is that SCSI Core knows only HCIL.
> 
> 
> That's something that needs fixing, for SAS.

Would you be accepting patches for the creation,
and use of "struct scsi_domain_device { ... }"?

This would be a "SCSI Device with a Z Port".
Z could be target or initiator (most likely just T).

Then for each scsi_domain_device, SCSI Core does
REPORT LUNS and then INQUIRY for each LU it found.

The old (current) code would still say as is, unchanged,
since it supports older, broken hardware.

Would you be accepting patches for this?

>>I repeat again that I had this code _long_ before Christoph
>>ever dreamt up SAS.  And he got my code via James B sometime
>>before OLS this year.  I think he got it July 12, 2005.
>>
>>The question is: why didn't _he_ use the solution already
>>available?
> 
> 
> Because it has the problems listed time and again.

What problems when there was no other code around.

Look at it this way: _their_ code doesn't integrate
with ours.  See?

I simply cannot take an argument like this:
   "Because it has the problems listed time and again."

You have to be specific.

> The SAS transport class is designed to support both firmware-based 
> devices like MPT, and non-firmware devices such as Adaptec.

No, it never has been.  It is an _attribute_ exporting framework
only.

If you understood how different those architectures are,
you'd understand what I mean.

> Sure it might need patches -- send patches, work with people, rather 
> than ignoring existing work.

I do not _know_ how to consolidate the completely broken
"design" set forth by JB and company.

It is _completely_ not to SAM spec.

Exporting attributes from MPT-based drivers is not the same
as managing a transport.

I repeat again:
  * MPT _hides_ the transport and the managment
    of the transport from you -- so in effect there is
    nothing to manage.
  * MPT gives you Logical Units to work with, NOT ever domain
    devices or anyhing domain like.
  * MPT gives you a SAM/SPC hook to hook _right_ into SCSI Core.

_This_ is why their LLDD _can_ use the host template.

But an AIC-94xx and BCM8603 _is_ NOT a scsi_host material.  It is just
an interface to the interconnect.

To convince yourself of this: take a look at the _members_ of
the scsi host/scsi host template: nothing in that structure is
presented in the chip -- UNLIKE old Parallel SCSI device drivers.

The scsi host template was written to cater to _old_ (then new)
Parallel SCSI drivers!  Times have changed!  Time to evolve.

> We've been over the technical stuff time and again.  That's the 
>  maintainer problem. 

No we haven't been over the technical stuff time and again.

> We need someone who will listen to the community.

I bet you're melting people's hearts when they read this.

So to summarize for corporate management what you're saying
here is:
  - you're saying that I do not listen to "the community",
  - you're saying that I'm an _outsider_ to "the community",
  - you're saying that I'm no good to work with you, since
    you are part of that community but not me.

That is you cannot take it that someone will tell 
"the community" anything.  "The community" knows all and it
knows best.

So in effect there are no good and knowlegable engineers
anywhere but in the "Linux community".

That is there is no people with new ideas, better ideas,
innovative ideas, more knowlege about certain subject matter,
_anywhere_ but in the "Linux community".

So in effect, there will never be an "outsider" who will
come in to the "linux community" and change things around,
no fresh ideas, no better (right?) way to do things.

"The community" is not going to listen to anyone but only to
already politically established members on _any_ subject
matter, even technical, even from "outsiders" who work with
the technology every day.

>>What _exactly_ does it mean "don't play well with others"?
> 
> 
> It means not taking feedback, and working around rather than with the 
> SCSI core.

So does this mean, that if I submit patches "fixing" (oops,
not meant to hurt anyone's bal^w^w^wpride) SCSI Core, they
will be accepted.

Or do you want me to do "your way of SAS"?
Maybe JB et al, should write the "Linux SAS spec" and
then we can recommend this to T10.org, so they can scrap
their version and use "the community's"?

I hear there was such a suggestion on the mailing lists
for ATA and T13.org, but I'm sure I'm misunderstanding
something here as usual.

> Then you don't understand the ->qc_{prep,issue} hooks.  That should get 
> you 90% of the way there, if not 99%.

But I have to simulate struct ata_port, Jeff.

Which isn't so bad, but speaks about the design.

>>What you need to do is to write a SATL layer, just as you can
>>see in SAT-r6, page 2, Figure 3.  I'm on top of this already.
> 
> Re-read libata-scsi.c, and submit any patches you feel are needed.

Will do.

>>The code doesn't alter Linux SCSI or anyone else's behaviour.
>>It only _provides_ SAS support to the kernel.
> 
> 
> That's one of the problems: It should update the SCSI core.

Thank you for admitting this -- you're the first and only
member of "the community" (since I'm not a member apparently)
to admit this.

	Luben

