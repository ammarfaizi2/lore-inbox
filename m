Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266854AbSLDD2g>; Tue, 3 Dec 2002 22:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266859AbSLDD2g>; Tue, 3 Dec 2002 22:28:36 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:1483 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266854AbSLDD2f>;
	Tue, 3 Dec 2002 22:28:35 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [Linux-pm-devel] Re: IBM/MontaVista Dynamic Power Management Project
To: Dominik Brodowski <linux@brodo.de>
Cc: Hollis Blanchard <hollis@austin.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk, linux-pm-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF0347E1B2.57E4ABBA-ON86256C85.000AA9B8@pok.ibm.com>
From: "Bishop Brock" <bcbrock@us.ibm.com>
Date: Tue, 3 Dec 2002 21:34:58 -0600
X-MIMETrack: Serialize by Router on D01ML068/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 12/03/2002 10:35:09 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Dominik Brodowski <linux@brodo.de> on 12/03/2002 02:00:19 PM
> > > A paper describing the proposal can be obtained from
> > >
> > > http://www.research.ibm.com/arl/projects/dpm.html
> > >

>So, will it basically be a "policy governor" as described in my "[RFC]"
mail?
>Or does it need other enhancements in the cpufreq core?

>BTW, have you noticed the premilinary patch I which implements most of the
>DVS infrastructure mentioned in my mail to the cpufreq list yesterday?

Dominik,

I've read the RFC and am familiar with the DVFS implementation for ARM,
but I have not been following CPUFREQ development closely. Given that
background, I'll try to be brief on describing the two proposals as I
understand them.

Our proposal (DPM) begins from the idea of an abstract, platform-specific
"operating point", and a platform-specific driver(s) that knows how to
move the system to that operating point.  I see CPUFREQ as that driver
for the platforms it supports.  For our embedded systems the sets of
operating points will be fixed by the system designer, but DPM
would allow operating points that were partially interpreted (e.g., the
lowest frequency greater than X), which seems to be used in CPUFREQ.
The enhancement I think for CPUFREQ would be to deal with operating
points, and not explicit voltages and frequencies.  In next-generation
platforms there will be multiple voltages and frequencies in a single
CPU, so we need to abstract this away now.

Many of the things your RFC described as "events", we describe as
"operating states", e.g., idle, running tasks, handling interrupts.
A DPM "policy" maps system operating states to operating points.  Every
time the kernel changes state, the current active policy defines the
operating point the system should run in.  These aspects of the two
proposals are very similar. As you point out, locking (and blocking)
are problems when operating points are changing rapidly, and we've
discussed this problem in our paper (see "Abstract Implementation").

My understanding of your RFC is that what you call "models" we would
call "policies", and that CPUFREQ models are executable. In contrast,
DPM policies are data structures that are maintained in the kernel.
Policies are managed by user- or kernel-level tasks using a "set_policy()"
interface. There's no restriction on what computation is used to decide
which policy to activate, but once activated its action is automatic.

DPM also includes provisions for task-specific operating points, but
we could discuss this further once the legal questions are resolved.

Finally, DPM includes an idea that may not exist in CPUFREQ, and
that is the idea that peripheral devices advertise constraints,
e.g., bus bandwidth requirements (through the Linux Device Model),
and these constraints are used to select the best operating point
that satisfies all of the constraints.  We believe this will be
important for aggressively power-managed embedded CPUs with many
on-board peripherals.  This feature falls out easily where it
is not required, however.

Bishop




