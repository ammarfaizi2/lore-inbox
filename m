Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267899AbUHESnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267899AbUHESnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267892AbUHESmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:42:33 -0400
Received: from fmr12.intel.com ([134.134.136.15]:29385 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267922AbUHESkf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:40:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Date: Thu, 5 Aug 2004 11:37:48 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F93C8@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Thread-Index: AcR685jc/8R0hr+zQ+W0e6Xcg41oaAAJuJhg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Ulrich Drepper" <drepper@redhat.com>
X-OriginalArrivalTime: 05 Aug 2004 18:39:27.0785 (UTC) FILETIME=[89B46190:01C47B1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ingo Molnar [mailto:mingo@elte.hu]
> 
> * Perez-Gonzalez, Inaky <inaky.perez-gonzalez@intel.com> wrote:
> 
> > Fusyn aims to provide primitives to solve a bunch of gaps in POSIX
> > compliance related to mutexes, conditional variables and semaphores,
> > POSIX Advanced real-time support as well as adding mutex robustness
> > (to dying owners) and deep deadlock checking.
> 
> the sched.c bits look clean enough.

The bit that scares me is the hook into effective_prio() in the
scheduler fast-path for the prio boost. It is a minimal op, but I know
how cautious are you guys on poking there.

> but, couldnt there be more sharing between futex.c and fusyn.c? In
> particular on the API side, why arent all these ops done as an extension
> to sys_futex()? 

That's what I did initially and many people barked at me because it made
sys_futex even uglier. Somebody [I can't remember the thread and I cannot
find it] said that sys_futex() should have been split in a number of syscalls
from the beginning, not multiplexing--and that they should do that in 2.7
to ease up a transition.

As well, I need to take different arguments [flags for the fulocks, for example].
For the sys_ufuqueue_*(), it makes sense to do a redirection for simplification,
emulating the sys_futex() thingies, but for fulocks, they are completely 
different beasts. It makes little sense, it is a locking interface, not a 
waitqueue interface. 

> That would keep the glibc part much simpler (and more
> compatible) as well. You'd still get all the glory of implementing true

I'll work on the sys_futex() redirection to ufuqueues during today [let's
see if I can get something done before taking off on vacation] and as soon
as I come back, but for the ufulocks...the interface is too different. I
think it makes more sense to clean up the glibc implementation, make a truly
layered set of calls redirecting the lll_ stuff at compile time [and run
time where needed/desired] that would allow the user to select what he wants
to do (when in the know) and default to the best combination for the general
public.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
