Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271200AbTG1XU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271201AbTG1XU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:20:57 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:45479
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271200AbTG1XUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:20:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: as / scheduler question
Date: Tue, 29 Jul 2003 09:25:10 +1000
User-Agent: KMail/1.5.2
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org
References: <200307290908.09065.kernel@kolivas.org> <20030728160117.3f679f01.akpm@osdl.org>
In-Reply-To: <20030728160117.3f679f01.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307290925.10876.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 09:01, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > Nick
> >
> > With the sheduler work Ingo and I have been doing I was wondering if
> > there was possibly a problem with requeuing kernel threads at certain
> > intervals? Ingo's current version requeues all threads at 25ms and I just
> > wondered if this number might be a multiple or factor of a magic number
> > in the AS workings, as we're seeing a few changes in behaviour with AS
> > only. I'm planning on leaving kernel threads out of this requeuing, but I
> > thought I could also pick your brain.
>
> What does "requeues all threads at 25ms" mean?
>
> The only dependency we should have there is that kblockd should be
> scheduled promptly after it is woken.  It is reniced by -10 so it should be
> OK. Renicing it further or making it SCHED_RR/FIFO would be interesting.

Ingo introduced the concept of TIMESLICE_GRANULARITY a while ago. All 
processes currently running on the active queue get interrupted in their 
timeslice after TIMESLICE_GRANULARITY (currently set at 25ms and the subject 
of another thread), and put on the tail of the active array to continue their 
timeslice after other processes at the same priority on the active queue get 
to run, also for at most TIMESLICE_GRANULARITY. If kblockd is reniced to -10 
it wont have a problem unless something else ends up with the same dynamic 
priority which would only happen if there are interactive tasks reniced to 
-10. If it's the only process on the active array at that priority it 
_should_ run unaffected.

Con

