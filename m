Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVGGVyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVGGVyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVGGVwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:52:10 -0400
Received: from isilmar.linta.de ([213.239.214.66]:1989 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261344AbVGGVvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:51:35 -0400
Date: Thu, 7 Jul 2005 23:51:34 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: st3@riseup.net, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: enhanced intel speedstep feature was Re: speedstep-centrino on dothan
Message-ID: <20050707215134.GA25660@isilmar.linta.de>
Mail-Followup-To: st3@riseup.net, Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
References: <20050706112202.33d63d4d@horst.morte.male> <42CC37FD.5040708@tmr.com> <20050706211159.GF27630@redhat.com> <20050706235557.0c122d33@horst.morte.male> <20050707220027.413343d4@horst.morte.male> <20050707200648.GA29142@redhat.com> <20050707222225.5b3113e0@horst.morte.male> <20050707205117.GB10635@digitasaru.net> <20050707210823.GA24774@isilmar.linta.de> <20050707213414.GF16702@digitasaru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707213414.GF16702@digitasaru.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 04:34:14PM -0500, Joseph Pingenot wrote:
> >From Dominik Brodowski on Thursday, 07 July, 2005:
> >On Thu, Jul 07, 2005 at 03:51:17PM -0500, Joseph Pingenot wrote:
> >> >Just a latest question: can be p4-clockmod used together with
> >> >speedstep-centrino? If not, would it make any sense to patch
> >> >speedstep-centrino to use this feature too?
> >> I'm a little confused.  How is this different from the ACPI CPU throttling
> >>   states (/proc/acpi/processor/CPUn/limit to set, throttling to see all
> >>   T-states available)?
> >T-states _tend_ to be utilized using chipset logic, while p4-clockmod is
> >done in-CPU.
> >> On my 1.5-year-old Pentium-M, frequency scaling and T-states are different
> >>   beasties, and act entirely differently.  I'm currently in the process of
> >>   rewriting my governor's brain to deal with the two more intelligently.
> >In your case, I would care about throttling. In very most cases it actually
> >increases energy consumption, as the state being entered is technically the
> >same to ACPI C2 (IIRC), so it is only "forced" idling and only useful if
> >"forced" idling is needed to not need active cooling.
> 
> Why would this cause more energy consumption?

Let's say a specific computing task needs 1s to run at 100% CPU load. The
CPU consumes 22 W at normal operation, and 7.3 W when in ACPI C2 state which
is technically equivalent to throttling. [note: these are _real_ values from
a real datasheet for a real CPU you see in common usage]

If you're at 0% CPU throttling rate, you need 	22 Ws for this computing task,
if you're at 25%				24 Ws,
	  at 50%				29 Ws,
      and at 75%			that is 44 Ws for this computing task.

So for any sepcific computing task the energy consumption increases largely.

But what if the system idle otherwise?
If the CPU is put into an idle state the other time (e.g. there is no
other computing task for the CPU to do in a four-second span), it depends on
the idle state being used: if it is C2, these four seconds mean 44Ws of
energy being used; if it is C3, the CPU only needs 5.1Ws, so at 0% CPU
throttling you get 37 Ws; if it is C4, the CPU only needs 0.55Ws, so you
only get 24 Ws which is much less than the 44Ws you have at 75% throttling.

Please note that the weak spot in this calculation is the idle state the
CPU is forced to when doing idling. My investigations lead to the assumption
that it is the "Stop Grant" state on CPUs manufactored by Intel, which is
most often described by the ACPI C2 state ("Stop-Grant state"), while C3 is
"Deep Sleep State" or "Sleep State", and C4 is "Deeper Sleep State".

	Dominik
