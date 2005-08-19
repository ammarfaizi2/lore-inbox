Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVHSWhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVHSWhl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 18:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbVHSWhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 18:37:41 -0400
Received: from magic.adaptec.com ([216.52.22.17]:10396 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932326AbVHSWhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 18:37:40 -0400
Message-ID: <43065F29.8000001@adaptec.com>
Date: Fri, 19 Aug 2005 18:37:29 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata error handling
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org> <430556BF.5070004@pobox.com> <4306290B.6080608@adaptec.com> <20050819193853.GA1549@us.ibm.com> <43063B03.8050008@adaptec.com> <20050819201121.GA2523@us.ibm.com> <4306447D.7090204@adaptec.com> <20050819211008.GA3032@us.ibm.com>
In-Reply-To: <20050819211008.GA3032@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2005 22:37:30.0418 (UTC) FILETIME=[95607920:01C5A50E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19/05 17:10, Patrick Mansfield wrote:
> Luben -
> 
> On Fri, Aug 19, 2005 at 04:43:41PM -0400, Luben Tuikov wrote:
> 
>>On 08/19/05 16:11, Patrick Mansfield wrote:
> 
> 
>>>I was changing it to wakeup the eh even while other IO is outstanding, so
>>>the eh can wakeup and cancel individual commands while other IO is still
>>>using the HBA.
>>
>>Hmm, if you want to do this, then SCSI Core needs to know about:
>>	- Domain,
>>	- Domain device and
>>	- LU.
> 
> 
> Not really, scsi core is just asking the LLDD to cancel or release the scmd.

Hi Patrick,

If you want to call any kind of eh, *without* stalling IO to the host, you have
to know the context: LU or Domain Device or Domain,  in order to stall IO
to the context object only.

> That is really all we do in the eh today, and then if the LLDD can't
> cancel the scmd, we take other sometimes less than useful steps.

But remember, eh_timed_out and eh_strategy_handler point to
functions in the driver, so they can do more or less, depending.

BTW, you may be able to implement an _instantaneous_ canceling of
a command in the LLDD from any context, but this would bloat the
LLDD so much, that is is not a viable solution, plus it _cannot_
always be done (physically).

This is why eh_timed_out + eh_strategy_handler is a best current bet
for transport LLDD. (Given the current SCSI Core infrastructure.)

As far as the upper layers are concerned:
	- the command is either finished with status,
	- or the LU or the Device or the Domain had problems.
The above list is exhaustive, because if the task was never
able to be sent via the service delivery subsystem you'd
get a response, but the task will not "sit" in the LLDD.

Most importantly to remember is that a timed out command _cannot_
be returned instantaneously to SCSI Core, unless it is "complete"
in the SAM sense of the meaning.  If the task is out on the domain,
the respective eh needs to be invoked.

> The LLDD could start any error handling scheme it wants, independent of
> scsi core action.

True, but this will bloat LLDD very much, and all you want of a
transport LLDD is access to the delivery subsystem as described in SAM.

> We don't initiate error handling in scsi core for other error cases, why
> should a timeout be any different?

Think of eh_timed_out as a replacement of the transport timeout
plus some delta.  Even if you had implemented it internally,
which you don't need to, you'd still get a timer to fire off
and you'd be in interrupt context.

As I mentioned earlier, if you've properly set the timeout value at
slave_configure, you shouldn't be getting SCSI Core calling your
eh_timed_out _unless_ the transport time out has kicked in, which
*you* set at slave configure time.

If, OTOH, SCSI Core _did_ call your eh_timed_out routine, this means
that the timeout which *you* set has kicked in and action needs
to be taken.  At that time, as per protocol, your task is either
complete or you need to go and find it and take the appropriate
action.

>>The reason, is that you do not know why a task timed out.
>>Is it the LU, is it the device, is it the domain?
> 
> Right, so in scsi core allow a simple method that can cancel commands
> while the HBA is still in use.

Yes, you can do this.  But in order to do this you'll need to know
_why_ the command failed.  Is it the LU or is it the Device or
is it the Domain.

The only one who can tell you this is the LLDD who talks to the
transport.

*Unless*, the LLDD exports SAM TMFs and SCSI Core knows what to call
and how, which is currently not the case.

>>>So, for EH_NOT_HANDLED, do you add the scmd to a LLDD list in your
>>>eh_timed_out, then wait for the eh to run?
>>
>>No, no Patrick, I don't.  The SCSI Core does this for me, and then
>>calls my eh_strategy routine and all the commands are on the list.
> 
> 
> Oh right ... I was not thinking straight.
> 
> But I don't see how that gains much, if you sometimes still wait for scsi
> core to quiesce IO and wakeup the eh.

Yes, you're completely right, the SCSI Core eh infrastructure is
incomplete. (I never mentioned I was gaining anything, I was merely
working around the current infrastructure. ;-) )

With the current infrastructure you cannot fine grain stalling
IO to the different storage objects, simply because SCSI Core
has _no representation for them_.

	Luben

