Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbTL3WYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265891AbTL3WX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:23:59 -0500
Received: from intra.cyclades.com ([64.186.161.6]:12513 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265879AbTL3WXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:23:19 -0500
Date: Tue, 30 Dec 2003 20:21:25 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Daniel Tram Lux <daniel@starbattle.com>, steve@drifthost.com,
       James Bourne <jbourne@hardrock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gergely Tamas <dice@mfa.kfki.hu>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: no DRQ after issuing WRITE was Re: 2.4.23-uv3 patch set released
In-Reply-To: <Pine.LNX.4.58.0312301352570.2065@home.osdl.org>
Message-ID: <Pine.LNX.4.58L.0312302002130.23875@logos.cnet>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>
 <Pine.LNX.4.58L.0312300935040.22101@logos.cnet> <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>
 <Pine.LNX.4.58L.0312301849400.23875@logos.cnet> <Pine.LNX.4.58.0312301352570.2065@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Linus Torvalds wrote:

>
>
> On Tue, 30 Dec 2003, Marcelo Tosatti wrote:
> >
> > Small correction: people are not hitting the WAIT_READY (they are hitting
> > the problem from ide-disk.c, which uses WAIT_DRQ). But still...
>
> Ok. Do you have the full trace? In particular, if there is no locking in
> that path, and interrupts are enabled, you could possibly get not just an
> interrupt, but a preemption event. Now _that_ could blow up the timeout to
> any amount of time, and then even 100ms might not be enough.

The problem is happening in 2.4 too so I believe preemption is not the
culprit. Here are some details:

steve@drifthost.com wrote:

"Well i only just started getting them and i started with 2.4.20 and
upgraded to 2.4.21 about 6weeks or so ago (or when it came out)"

"hda: status timeout: status=0xd0 { Busy }
hda: no DRQ after issuing WRITE
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }
hda: no DRQ after issuing WRITE
ide0: reset: success"

daniel@starbattle.com wrote:

"hda: no DRQ after issuing WRITE
ide0: reset: success
hda: status timeout: status=0xd0 { Busy }

hda: no DRQ after issuing WRITE
ide0: reset: success"

(Daniel wrote the patch which got applied to 2.4, it fixed the problems
for him).

There are several other reports of "no DRQ after issuing {MULTI}WRITE",
some of them probably involved with this bug, some of them potentially
not. You can find more reports (both from 2.6 and 2.4) at:

http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=1&s=no+DRQ+after+issuing+WRITE&q=b

> Is CONFIG_PREEMPT on in the cases, and is there really no locking
> anywhere? Preempting in the middle of the data transfer phase sounds like
> a fundamentally bad idea, and maybe the code needs a few preempt
> disable/enable pairs somewhere?

>From my fast code read, there is no other locking involved.

It sounds you are right, the timeout is too small --- we need confirmation
from the people who can hit it that increasing it fixes the problem.
