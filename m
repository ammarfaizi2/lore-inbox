Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVILQ41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVILQ41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVILQ41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:56:27 -0400
Received: from magic.adaptec.com ([216.52.22.17]:9415 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932076AbVILQ40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:56:26 -0400
Message-ID: <4325B333.3070301@adaptec.com>
Date: Mon, 12 Sep 2005 12:56:19 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 2/14] sas-class: README
References: <4321E4DD.7070405@adaptec.com> <43238C16.4010709@torque.net>
In-Reply-To: <43238C16.4010709@torque.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 16:56:24.0695 (UTC) FILETIME=[E8C4F870:01C5B7BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/05 21:44, Douglas Gilbert wrote:
> Luben Tuikov wrote:
> 
>>Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>
> 
> 
> <snip>
> 
> An interesting document. 

Hi Doug, how are you?

If there is something wrong with the document in general,
please point it out.

Your "An interesting document" sounds like James's
"Aside from all other problems".

> I have a small quibble here (and a larger
> one about the SMP user space access that I will elaborate on
> in a day or so).

Ok.

(Thinking to myself: I wonder, if he's got a problem with
SMP user space access, why not post it now?  Why in a day
or so?)

>>+Port events, passed on a _phy_:
>>+	PORTE_BYTES_DMAED,      (M)
>>+	PORTE_BROADCAST_RCVD,   (E)
>>+	PORTE_LINK_RESET_ERR,   (C)
>>+	PORTE_TIMER_EVENT,      (C)
>>+	PORTE_HARD_RESET.
> 
> 
> Link layer broadcasts don't only come from expanders
> (i.e. BROADCAST(CHANGE) ); SAS 1.1 (sas1r09e.pdf) defines

I'm aware of what the spec says.

> BROADCAST(SES) coming from a target port associated with

I'm aware of this primitive.

> an enclosure device (SES peripheral type). It is not
> clear to me how the associated primitive is conveyed back
> with the broadcast.

As you can see the message is "PORTE_BROADCAST_RCVD".
The _type_ of BROADCAST is encoded in phy->sas_prim.

See sas_port.c::void sas_porte_broadcast_rcvd(struct sas_phy *phy).

This function decides what to do depending on the type of
BROADCAST received.

Currently there have been no requests for handling of
BROADCAST(SES).

When there's such a request, we handle it there, telling
the Discover code of a SES event.

Currently only BROADCAST(CHANGE) is handled _by default_.

I.e. we search the domain for the expander and phy which
generated it, and act on it.  If we find no expander and
phy which generated it, in case we processed a different
BROADCAST or an expander has broken firmware, we return.
This is all in the code.

BROADCAST filtering is also present in the LLDD, i.e.
notify on such and such BROADCAST or primitive in general.
This is done by the hardware itself (no firmware) so it
is very fast.
 
> If it is not conveyed back then perhaps that broadcast define
> could be expanded to:
>      PORTE_BROADCAST_CHANGE   (E)
>      PORTE_BROADCAST_SES      (Target)

I can add this event if you want.
The questiong is _what_ to do on this event.  This is a complex
answer and I'd rather have a _SES_ layer (or at least a logical
module/library) to handle those as storage vendors want this,
_right now_.

In fact, I've some patches to submit regarding SES devices
on the domain, but I wanted to _trim *down*_ the politics,
_not_ escalate them.

Also this patch was "SAS support", not "SES device support".

> and a note inserted that BROADCAST(RESERVED CHANGE 0) and
> BROADCAST(RESERVED CHANGE 1) be mapped to PORTE_BROADCAST_CHANGE
> by the LLDD as per table 79 of sas1r09e.pdf .

They already are Doug.

> BTW table 70 indicates an initiator can originate a BROADCAST(CHANGE),
> not just an expander.

I hope this isn't going to be a thread about
	* pointing out the obvious, or
	* some kind of competion of who's read the spec the most.

All in all, you could've just asked "How about BROADCAST(SES)?".

   Luben

