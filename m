Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVIRVxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVIRVxm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVIRVxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:53:41 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:42413 "HELO
	develer.com") by vger.kernel.org with SMTP id S932220AbVIRVxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:53:40 -0400
Message-ID: <432DE1C9.5050809@develer.com>
Date: Sun, 18 Sep 2005 23:53:13 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Arjan van de Ven <arjanv@redhat.com>,
       Development discussions related to Fedora Core 
	<fedora-devel-list@redhat.com>,
       Nalin Dahyabhai <nalin@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: RFA: Changing scheduler quantum (Was: REQUEST: OpenLDAP 2.3.7)
References: <432B9F4A.6070805@develer.com> <20050918110524.GA23910@devserv.devel.redhat.com> <432D517F.2000604@develer.com> <200509182144.50571.kernel@kolivas.org>
In-Reply-To: <200509182144.50571.kernel@kolivas.org>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Sun, 18 Sep 2005 21:37, Bernardo Innocenti wrote:

>>The DEF_TIMESLICE of 400ms looks a bit too gross for
>>most applications and the maximum 800ms is just
>>ridicolously high.
> 
> Not quite.
> 
> The default timeslice of nice 0 tasks is 100ms. The timeslice is not altered 
> the way you have read sched.c. It is altered thus:
> 1. For 'nice' levels it varies from 5ms at nice 19 to 800ms at nice -20.
> 2. For interactive tasks, it is cut up into smaller pieces down to 10ms and 
> round robins with other tasks at the same dynamic priority, but still is 
> based on the nice levels for the full length of cpu time before expiration 
> overall.

I see.  Then there must be something else to explain
the behavior I'm observing with slapd.

Each and every call to sched_yield() makes the process
sleep for over *50ms* while a "nice make bootstrap" is
running in the background:

[pid  8780]      0.000033 stat64("gidNumber.dbb", 0xb7b3ebcc) = -1 EACCES (Permission denied)
[pid  8780]      0.000059 pread(20, "\0\0\0\0\1\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\2\0\344\17\2\3"..., 4096, 4096) = 4096
[pid  8780]      0.000083 pread(20, "\0\0\0\0\1\0\0\0\4\0\0\0\3\0\0\0\0\0\0\0\222\0<\7\1\5\370"..., 4096, 16384) = 4096
[pid  8780]      0.000078 time(NULL)    = 1124322520
[pid  8780]      0.000066 pread(11, "\0\0\0\0\1\0\0\0\250\0\0\0\231\0\0\0\235\0\0\0\16\0000"..., 4096, 688128) = 4096
[pid  8780]      0.000241 write(19, "0e\2\1\3d`\4$cn=bernie,ou=group,dc=d"..., 103) = 103
[pid  8780]      0.000137 sched_yield( <unfinished ...>
      ...zzzz...
[pid  8781]      0.050020 <... sched_yield resumed> ) = 0
[pid  8780]      0.000025 <... sched_yield resumed> ) = 0
[pid  8781]      0.000060 futex(0x925ab20, FUTEX_WAIT, 33, NULL <unfinished ...>
[pid  8780]      0.000026 write(19, "0\f\2\1\3e\7\n\1\0\4\0\4\0", 14) = 14
[pid  8774]      0.000774 <... select resumed> ) = 1 (in [19])


Actually, I'm now noticing that several slapd threads were
involved here.  Depending how strace handles relative
timestamps of multiple processes, it may mean both 8780 and
8781 slept too much or just 8781 did and 8780 was quick.

Any idea?  I'm planning to patch my kernel to print the
time_slice value in /proc/*/stat.  This way I can check
it's being computed as intended for both slapd and gcc.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

