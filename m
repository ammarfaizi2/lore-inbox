Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVAVDxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVAVDxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 22:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVAVDxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 22:53:34 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:8367 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262658AbVAVDxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 22:53:23 -0500
Message-ID: <41F1CE11.6010307@kolivas.org>
Date: Sat, 22 Jan 2005 14:52:49 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: utz lehmann <lkml@s2y4n2c.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com, joq@io.com,
       CK Kernel <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>,
       alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft	rt	scheduling
References: <41EEE1B1.9080909@kolivas.org>	 <1106350245.4442.5.camel@segv.aura.of.mankind> <41F194DC.40603@kolivas.org> <1106353715.4442.20.camel@segv.aura.of.mankind>
In-Reply-To: <1106353715.4442.20.camel@segv.aura.of.mankind>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2DE1BE14B02E6F336082C8ED"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2DE1BE14B02E6F336082C8ED
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

utz lehmann wrote:
> On Sat, 2005-01-22 at 10:48 +1100, Con Kolivas wrote:
> 
>>utz lehmann wrote:
>>
>>>Hi
>>>
>>>I dislike the behavior of the SCHED_ISO patch that iso tasks are
>>>degraded to SCHED_NORMAL if they exceed the limit.
>>>IMHO it's better to throttle them at the iso_cpu limit.
>>>
>>>I have modified Con's iso2 patch to do this. If iso_cpu > 50 iso tasks
>>>only get stalled for 1 tick (1ms on x86).
>>
>>Some tasks are so cache intensive they would make almost no forward 
>>progress running for only 1ms.
> 
> 
> Ok. The throttle duration can be exceed.
> What is a good value? 5ms, 10ms?

It's architecture and cpu dependant. Useful timeslices to avoid cache 
trashing vary from 2ms to 20ms. Also HZ varies between architectures and 
setups, and almost certainly will vary in some dynamic way in the future 
altering substantially the accuracy of such a setup.

>>>Fortunately there is a currently unused task prio (MAX_RT_PRIO-1) [1]. I
>>
>>Your implementation is not correct. The "prio" field of real time tasks 
>>is determined by MAX_RT_PRIO-1-rt_priority. Therefore you're limiting 
>>the best real time priority, not the other way around.
> 
> 
> Really? The task prios are (lower value is higher priority):
> 
> 0
> ..			For SCHED_FIFO/SCHED_RR (rt_priority 99..1)
> 98	MAX_RT_PRIO-2
> 
> 99	MAX_RT_PRIO-1 	ISO_PRIO (rt_priority 0)	
> 
> 100	MAX_RT_PRIO
> ..			For SCHED_NORMAL
> 139	MAX_PRIO-1
> 
> ISO_PRIO is between the SCHED_FIFO/SCHED_RR and the SCHED_NORMAL range.

I wan't debating that fact. I was saying that decreasing the range of 
priorities you can have for real time will lose the highest priority ones.

	if (SCHED_RT(policy))
		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;

>>Throttling them for only 1ms will make it very easy to starve the system 
>>  with 1 or more short running (<1ms) SCHED_NORMAL tasks running. Lower 
>>priority tasks will never run.

can I also comment on:
+	while (!list_empty(queue)) {
+		next = list_entry(queue->next, task_t, run_list);
+		dequeue_task(next, active);
+		enqueue_task(next, expired);
+	}

O(n) functions are a bad idea in critical codepaths, even if they only 
get hit when there is more than one SCHED_ISO task queued.

Apart from those, I'm not really sure what advantage this different 
design has. Once you go over the cpu limit the behaviour is grey and 
your design basically complicates what is already simple - to make an 
unprivileged task starvation free you run it SCHED_NORMAL. I know you 
want it back to high priority as soon as possible, but I fail to see how 
this is any better. They're either real time or not depending on what 
limits you set in either design.

As for priority support, I have been working on it. While the test cases 
I've been involved in show no need for it, I can understand why it would 
be desirable.

Cheers,
Con

--------------enig2DE1BE14B02E6F336082C8ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8c4RZUg7+tp6mRURAqu/AKCG8ptI1HF+ZmiMMiybefe9ZePjhwCeIvFF
ubXxIkWB8sTRaKvSxcet22A=
=h7M1
-----END PGP SIGNATURE-----

--------------enig2DE1BE14B02E6F336082C8ED--
