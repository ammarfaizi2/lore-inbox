Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVANA4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVANA4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVANAyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:54:37 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:28820 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261743AbVANAv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:51:26 -0500
Message-ID: <41E71746.3090607@kolivas.org>
Date: Fri, 14 Jan 2005 11:50:14 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Matt Mackall <mpm@selenic.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050111214152.GA17943@devserv.devel.redhat.com>	<200501112251.j0BMp9iZ006964@localhost.localdomain>	<20050111150556.S10567@build.pdx.osdl.net>	<87y8ezzake.fsf@sulphur.joq.us>	<20050112074906.GB5735@devserv.devel.redhat.com>	<87oefuma3c.fsf@sulphur.joq.us>	<20050113072802.GB13195@devserv.devel.redhat.com>	<878y6x9h2d.fsf@sulphur.joq.us>	<20050113210750.GA22208@devserv.devel.redhat.com>	<1105651508.3457.31.camel@krustophenia.net>	<20050113214320.GB22208@devserv.devel.redhat.com> <87oefs9a8z.fsf@sulphur.joq.us>
In-Reply-To: <87oefs9a8z.fsf@sulphur.joq.us>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBDFF71A7C435466789AF516A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBDFF71A7C435466789AF516A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jack O'Quin wrote:
> Arjan van de Ven <arjanv@redhat.com> writes:
> 
> 
>>On Thu, Jan 13, 2005 at 04:25:08PM -0500, Lee Revell wrote:
>>
>>>The basic issue is that the current semantics of SCHED_FIFO seem make
>>>the deadlock/data corruption due to runaway RT thread issue difficult.
>>>The obvious solution is a new scheduling class equivalent to SCHED_FIFO
>>>but with a mechanism for the kernel to demote the offending thread to
>>>SCHED_OTHER in an emergency. 
>>
>>and this is getting really close to the original "counter proposal" to the
>>LSM module that was basically "lets make lower nice limit an rlimit, and
>>have -20 mean "basically FIFO" *if* the task behaves itself".
> 
> 
> Yes.  However, my tests have so far shown a need for "actual FIFO as
> long as the task behaves itself."

I should comment on this thread on lkml. After some 
investigation/discussion and testing I came up with a proposal for this 
problem. Since we are a general purpose operating system and not a hard 
rt system (although addon patches are clearly making that a future 
possibility) we need a solution that is satisfactory to a general...

There are two ways I suggested for this.

First, (and I am increasingly believing in the second) is to implement a 
new scheduling class for isochronous scheduling. This would be a class 
for unprivileged users, and behave like SCHED_RR (to avoid complications 
of QoS features we dont have infrastrucutre for) at a priority just 
above SCHED_NORMAL, but below all privileged SCHED_RR and SCHED_FIFO. 
Importantly, a soft cpu limit and rate period can be set by default for 
this scheduling class that provides good true SCHED_RR performance, and 
is configurable. Literature suggests that 70% is adequate cpu for good 
real time performance and would be starvation free. I believe setting 
70% with 10% hysteresis (dropping to say 63% on hitting limit) would be 
a good start. Beyond this, however, to satisfy the needs of those with 
more demanding setups, a simple configurable runtime setting to set both 
the cpu% and the rate period could be available to something as simple 
as proc
/proc/sys/kernel/iso_cpu
/proc/sys/kernel/iso_cpu_period
where iso_cpu is set to 70, and period to maybe 1 second. The actual 
mode of setting this tunable is not important, and could be in /sys or 
whatever

The second option is to not implement a new scheduling class at all, and 
allow unprivileged users to use either SCHED_FIFO or SCHED_RR, but to 
make the cpu constraints described for SCHED_ISO above apply to their 
use of those classes. Supporting priority settings for these could be 
possible, but in my opinion, it would work as a better class if they 
only had one priority level, as for the SCHED_ISO implementation above 
(better than any SCHED_NORMAL, but lower than privileged SCHED_RR/FIFO).

This latter approach to me seems the least invasive and most user and 
sysadmin friendly method.

What was amusing to me was that after I suggested the latter option, I 
discovered that was basically what OSX does, however being not a real 
multi-user operating system they had absurd limits for cpu at 90% by 
default. Theory suggests 70% should be a good default limit.

Cheers,
Con

--------------enigBDFF71A7C435466789AF516A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5xdIZUg7+tp6mRURAjvPAJ0RmqQEjPUXcpTNbYazQSZipcZafgCfTnkm
6AqI79Pzz/hrDss5ab+9zNc=
=zg+Z
-----END PGP SIGNATURE-----

--------------enigBDFF71A7C435466789AF516A--
