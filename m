Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSLEInc>; Thu, 5 Dec 2002 03:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSLEInc>; Thu, 5 Dec 2002 03:43:32 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:61857 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263039AbSLEIn1>; Thu, 5 Dec 2002 03:43:27 -0500
Date: Thu, 5 Dec 2002 09:48:52 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Bishop Brock <bcbrock@us.ibm.com>
Cc: Hollis Blanchard <hollis@austin.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk, linux-pm-devel@lists.sourceforge.net
Subject: Re: [Linux-pm-devel] Re: IBM/MontaVista Dynamic Power Management Project
Message-ID: <20021205084852.GA1222@brodo.de>
References: <OF0347E1B2.57E4ABBA-ON86256C85.000AA9B8@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0347E1B2.57E4ABBA-ON86256C85.000AA9B8@pok.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bishop,

On Tue, Dec 03, 2002 at 09:34:58PM -0600, Bishop Brock wrote:
> >So, will it basically be a "policy governor" as described in my "[RFC]"
> mail?
> >Or does it need other enhancements in the cpufreq core?
> 
> >BTW, have you noticed the premilinary patch I which implements most of the
> >DVS infrastructure mentioned in my mail to the cpufreq list yesterday?
> 
> Dominik,
> 
> I've read the RFC and am familiar with the DVFS implementation for ARM,
> but I have not been following CPUFREQ development closely.

Actually, CPUFREQ evolved from ARM DVFS.

> Our proposal (DPM) begins from the idea of an abstract, platform-specific
> "operating point", and a platform-specific driver(s) that knows how to
> move the system to that operating point.  I see CPUFREQ as that driver
> for the platforms it supports. 

CPUfreq is about providing a cross-arch interface between other kernel code,
user-space and processor drivers for static and/or dynamic frequency and
voltage scaling. The DPM proposal seems to try to be another such
"mid-layer". And while it might be possible to emulate CPUFREQ as a driver
for DPM, it will be possible in the same way to emulate DPM as a driver for
CPUFREQ. 

> For our embedded systems the sets of
> operating points will be fixed by the system designer, but DPM
> would allow operating points that were partially interpreted (e.g., the
> lowest frequency greater than X), which seems to be used in CPUFREQ.

There already was the discussion about fixed operating points and all sorts
of frequencies back in August, IIRC. If a processor driver only allows fixed
operating points, fine. But limiting the mid-layer to a few fixed operating
points seems very limiting to me. 

> The enhancement I think for CPUFREQ would be to deal with operating
> points, and not explicit voltages and frequencies.  In next-generation
> platforms there will be multiple voltages and frequencies in a single
> CPU, so we need to abstract this away now.

Multiple voltages and frequencies are already supported by current CPUfreq
drivers, e.g. longhaul.c. And I see operating points as a limitation, not as
an enhancement.
 
> Many of the things your RFC described as "events", we describe as
> "operating states", e.g., idle, running tasks, handling interrupts.
> A DPM "policy" maps system operating states to operating points.  Every
> time the kernel changes state, the current active policy defines the
> operating point the system should run in.  These aspects of the two
> proposals are very similar. As you point out, locking (and blocking)
> are problems when operating points are changing rapidly, and we've
> discussed this problem in our paper (see "Abstract Implementation").

Indeed. Duplication of code.

> My understanding of your RFC is that what you call "models" we would
> call "policies", and that CPUFREQ models are executable. In contrast,
> DPM policies are data structures that are maintained in the kernel.
> Policies are managed by user- or kernel-level tasks using a "set_policy()"
> interface. There's no restriction on what computation is used to decide
> which policy to activate, but once activated its action is automatic.

Which means that if DPM was a CPUFREQ policy model / policy governor it
could use these "data structures", offer the set-policy() call -- but
different policy governors (like a real-time DVS model) could also be used.

> DPM also includes provisions for task-specific operating points, but
> we could discuss this further once the legal questions are resolved.

Which could also be "sent through" the CPUFREQ layer to DPM as a policy
governor.

> Finally, DPM includes an idea that may not exist in CPUFREQ, and
> that is the idea that peripheral devices advertise constraints,

Been there, done that. 
cpufreq_register_notifier(*notifier, CPUFREQ_POLICY_NOTIFIER)


While Dynamic Frequency and Voltage Scaling is an important addition to the
Linux kernel, and your proposal offers many fine ideas, I see the following
limitations:

- it offers another "mid-layer" with similar functionality to the current
	cpufreq core.
- because of its incompatibility with cpufreq it seems to be a new feature
	to me. The feature freeze has been some weeks ago. So your proposal
	might only be able to be included in kernel 2.7
- it limits processor drivers to a few operating points instead of offering
	the full functionality to the user, who could then decide which
	"operating points" he uses.
- it only offers one scaling model instead of providing an interface to 
	use different models for different needs like real-time computing


So, instead of you developing a replacement to current cpufreq, I'd suggest 
doing the following:

a) cpufreq driver for IBM PowerPC 405LP
---------------------------------------
Add a cpufreq processor driver for the IBM PowerPC you use as test-bed for
your model. Non-CPU hardware limitations can be taken care of by cpufreq
policy notifiers.

b) DPM as cpufreq governor
--------------------------
The cpufreq governor interface, which is an abstraction of the current
"policy", "powersave" and "24freq" models, will be submitted for inclusion
for Linux 2.5. soon. Based on this governor interface, your DPM proposal
could offer a new feature without interfering with existing kernel code,
but by being just another "driver" for an existing feature.

If there are constraints to the current cpufreq governor model, these
implementation details can easily be talked about. For example, the locking
needs to be improved for DVS, and you might want to add a
"target_processing_bandwith" value.

This way DPM would be much more flexible - it assures that it isn't too closely
based on IBM PowerPC but is indeed cross-arch; it uses existing kernel code
(or code which will hopefully be merged soon) and it avoids code duplication.

So, I'd suggest that we work together in integrating your DPM proposal into
the existing cpufreq framework. As I said before, if any changes to the
cpufreq core are neccessary, these can easily be done as long as they don't 
reduce functionality or break existing features.

	Dominik
