Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVI0TgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVI0TgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 15:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVI0TgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 15:36:03 -0400
Received: from magic.adaptec.com ([216.52.22.17]:33697 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965052AbVI0TgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 15:36:02 -0400
Message-ID: <43399F17.4090004@adaptec.com>
Date: Tue, 27 Sep 2005 15:35:51 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <4339440C.6090107@adaptec.com>	 <20050927131959.GA30329@infradead.org>  <43395ED0.6070504@adaptec.com> <1127836380.4814.36.camel@mulgrave>
In-Reply-To: <1127836380.4814.36.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 19:35:59.0986 (UTC) FILETIME=[B048AD20:01C5C39A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/05 11:53, James Bottomley wrote:
>>Christoph, why diseminate FUD, when we can concentrate on the
>>_technical_ merits of SCSI and SAS instead?
> 
> 
> That's what *we* are concentrating on.  Technically, I have no problem

Nah.  You're concentrating on blocking new drivers and _innovation_
from getting into SCSI Core.

Just look, for all these years you've been "maintaining" SCSI Core
it still uses HCIL, LUNS are u32, and you think that REQUEST SENSE
clears ACA, and scsi core has no representation of targets to save
its life.

It just hurts us all.

> with the aic94xx driver being based on a domain device.  However, you
> cannot have two separate transport classes for SAS.  So these two need
> to be unified before this driver becomes includable.

Apparently you do _not_ understand what the SCSI architecture
model is, again I refer you to the _picture_ here:
http://www.t10.org/scsi-3.gif

Now,

1) MPT _gives_ you LUs -- all transport _and_ SCSI specific work
has already been done for you.

2) With MPT you export attributes by poking, in a firmware
_dependent_ way, into the firmware of the controller.

That is, _all_ the "stuff" below SAM, as you can see in the picture
link, happens in the firmware!  What the firmware _gives_ you in a
_uniform_ way is SAM/SPC objects only (via the LLDD) so you can
register the LUs with SCSI Core, etc.

None of this is true for the SAS Transport Layer and
the AIC-94xx driver and BCM8603.   That is, for those solutions
the transport (SAS) architecture is exposed right down to
the phy/link layer.

So you _need_ transport management.  And since SAS sticks
to SAM so nicely and is so very well layered, it implements right
into what you have in the SAS Transport Layer.

> It looks to me to be a fairly simple exercise to unify these two classes
> giving LSI a functional interface and you a domain device based one and
> removing all the duplication of mid-layer functionality as part of doing
> this.

Ok, I'm aware that you're well aware that very few people actually
understand indepth MPT and other architectures.

You're posting FUD here, and hope that, since no one understands things
indepth, you can post anything you want, and sound credible.

I repeat again:

Those are two *radically* _different_ and _distinct_ technologies.

What MPT does is _everything_ *below* SCSI Core in terms of 
SAS Transport Layer and AIC-94xx LLDD.

That is all the work you see done in the SAS Transport Layer
and in AIC-94xx IS DONE ALREADY IN THE FIRMWARE!

What our solution and apparently BCM9603 does is expose _all_
that.

What you need to do is:
  - Let the code in _now_, as is.
  - Let _people play_ with it as hardware comes more available.
    I said "people" not necessarily you and/or Christoph.
  - Let it evolve in the hands of the people.
  - Hear feedback from the people.
  - Accept patches.
  - Let it evolve.

IOW, do not bastardise it now when you have _no_ SAS or SCSI
expertise, or hardware (well, maybe you have some on the way
from your friends at XYZ).

>>The SAS Transport Class (your an JB's incarnation) is _not_
>>a management infrastructure, it was _never_ _intended_ to be.
> 
> 

JB's statement A:
> Actually, it was intended to be such.  The sysfs components of the
> transport class are the unified management interface to the transport.

If it was _ever_ intended to be such, then it would sit
_below_ SCSI Core _and_ SCSI Core would NEVER be aware of it.
(just as it is on the picture, see?)

Even the _name_ suggests it: SCSI transport _attributes_,
and it is a template to export _attributes_.

You *CANNOT* write a template for _all_ transports, since this
is what SCSI Core is supposed to be!  This is what
SAM/SPC _is_!  This is what SCSI Core should be striving to.

The transport management layer sits _BELOW_ SCSI Core,
and _manages_ the particular transport, just like the SAS Transport
Layer.  SCSI Core does only SAM/SPC tasks, and is _unaware_ of
the transport.  (How hard is this to understand?)

See the _pictures_ on t10.org and the "techno-gibberish" posted
there?

JB's statment B:
> No, the point of a transport class is to export the underlying
> attributes of the actual devices that are present.  This is supposed to

Exactly! And this statement B here, contradicts your statement A) above.

Note: it is a transport _class_, _not_ a management _layer_, which is
what you have with the SAS Transport Layer.

> be independent of the driver used to connect to them (and that's what
> your sas class breaks).

Mine is _not_ a class.  It is a transport layer to _manage_ and drive
SAS LLDDs.

LSI's driver is NOT, to repeat it is NOT a SAS LLDD!  It is an *MPT* LLDD.

Your "transport attribute class" provides hooks for exporting
_attributes_ from MPT-based LLDDs.

It does _NOT_ provide for a management infrastructure:
1) because there is none needed -- the LLDD is MPT and you're providing
   attribute exporting only,
2) All this is _firmware_ implemented.

I repeat again: you cannot have a single _template_ for all-protocol
_management_ as you're implying.

For the record: I think MPT is a wonderful technology in its right
and the SAS LSI's solution should've been accepted right when it
was posted, since it didn't have any SAS in it.  The only thing
it had was a few different PCI IDs, AFAIR looking at the patch.

> I've told you before, if you find something that's broken send a patch
> in to fix it.  I've already told you why the code in sas_discover can't
> work for other drivers (although I still don't have an explanation from

Nah, lets not go with this BS:  "I've already told you...", it just
doesn't work.  Be specific.  See above how much effort I put in
repeating myself over and over and over again.  And I put
the effort to actually type everything out.

> you of why scsi_scan_target can't work for sas_discover).

Why?  Because it uses HCIL?  Because LUN are represented as u32?
Because you think that a LUN is a "u64".  Because you think that
REQUEST SENSE clears ACA?

>>What needs fixing is, SCSI Core to
>>	- not use HCIL,
>>	- use 64 bit LUNs,
>>	- know about SCSI devices with Target ports,
>>	- proper representation of SCSI Domains
>>          (FC, USB, IEEE 1394, Infiniband, SAS, iSCSI)
> 
> 
> As I've already said several times you're welcome to send in a patch to
> change this as well ... as long as you either don't break every other
> driver, or fix them all with the patch.

This is complete FUD and you know it and it is just the political game
you've been playing all this time.

Proof:

1) Any patches submitted to lsml, you change and then you resubmit
yourself, unless of course they come in from a few "chosen" people.
I.e. people who do not challenge your antics.

This _policy_ disourages people from actually doing any new and
innovative work with SCSI Core.

2) You are well aware that NONE of SCSI Core is relevant as it stands
today for a new, SAM/SPC abiding architecture like SAS.  You know very
well that other than LUN scanning and some SAM/SPC tasks, one needs
very little to support SAS.

3) Your own effort on this (converting LUN to "u64") failed:
http://marc.10east.com/?l=linux-scsi&m=112664309529813&w=2

YET, you try to keep this semantically fat, overloaded with lots of
little quirks for old hardware, SCSI Core.

You have to let things in, so that they can evolve naturally.
You cannot give heart attack to 50 or so LLDDs.

> You were given a step by step
> procedure at least for the I replacement piece.

How many times do I have to tell you that this was Christoph's
reply to an email of mine _asking_ me if this were the way to do it?

And then I told him that it is not quite the way to do it?
See this link:
http://marc.theaimsgroup.com/?l=linux-scsi&m=112507133514575&w=2

> The only power of a maintainer is to say "no".  So, although I cannot
> make you fix any of the problems in your submission, I can say no until
> an acceptable submission comes along for this driver.

You see, you and I do not see eye to eye, since we do not have the same
base: T10.org.

I read books, specs, drafts, firmware, code, presentations, lectures,
etc.  It isn't easy, but necessary to do my job better and better every
day.  It is necessary so that I'm knowlegable and can provide immediate
response and help when asked to.

So I'm not sure about your point of view.  SCSI 20 years ago?

I'm not sure what kind of convicing it would take?

Maybe we can do a presentation in front of an audience of _storage_
folks?  We can both explain out points of view.

> At this point, I
> believe all the technical issues of what needs to happen are well
> understood;

Nah.  You're just saying this to manipulate the readers of this
thread.  Or maybe those "needs" are well understoood _in your head_
only?  I told you before: be _specific_.

What needs improvement is NOT the SAS Transport Layer and/or
aic94xx LLDDs.

What needs improvement, in order to _better_ _accomodate_
_new_ technologies is SCSI Core.  If not even a new SCSI Core
developed in parallel (so the old one can be config-not-compile
if one has no legacy controllers and devices and vice-versa).

SCSI Core is 20 years _behind_.  And thus _Linux_ SCSI
is 20 years behind.  Apparently no one cares.

When you get your new shiny mainboard with an AIC-94xx
chip on it (check with SuperMicro), which can handle SAS and SATA,
you do not need to compile this fat, old and semantically broken
SCSI Core, but a smaller, faster one.

> I also believe that this is an important enough piece of

Since when do you think it is important?  This is the first
time you're saying this and I think someone was talking to
you. XYZ?

> hardware that an acceptable driver will come along even if you want to
> play dog in the manger, so all I can do is wait.

So what you're saying is "my way or the highway"?

"all I can do is wait"?
James, why not just simply move out of the way?

Instead of you _waiting_ and thus do nothing, you can
move out of the way, or listen and accept _technical_ advice.

This is unfortunate.  History shows us that being
inflexible to new ideas (or technologies) becomes
one's undoing.

I wonder if SCSI Core could be Linux's undoing?  Could this
and reiser4, and OBDs (yet another new SCSI technology in the
making), show us how inflexible Linux has become?

Now its SAS and reiser4.  When OBDs come out full force it
will be the block layer, then who knows whatelse...

Is Linux going to be just as obstinate?

Why has Linux become like this?

	Luben


