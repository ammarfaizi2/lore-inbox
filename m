Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbVHJNfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVHJNfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbVHJNfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:35:45 -0400
Received: from go4.ext.ti.com ([192.91.75.132]:20621 "EHLO go4.ext.ti.com")
	by vger.kernel.org with ESMTP id S965108AbVHJNfo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:35:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-pm] Re: PowerOP 0/3: System power operating point managementAPI
Date: Wed, 10 Aug 2005 08:35:03 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A501852767@dlee02.ent.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] Re: PowerOP 0/3: System power operating point managementAPI
Thread-Index: AcWdk2z+2vAVBHr7SwKKFkDi+r3wPAAEgUwQ
From: "Woodruff, Richard" <r-woodruff2@ti.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Todd Poynor" <tpoynor@mvista.com>
Cc: <linux-pm@lists.osdl.org>, <linux-kernel@vger.kernel.org>,
       <cpufreq@www.linux.org.uk>
X-OriginalArrivalTime: 10 Aug 2005 13:35:07.0316 (UTC) FILETIME=[52756F40:01C59DB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Depending on the ability of the hardware to make software-controlled
> > power/performance adjustments, this may be useful to select custom
> > voltages, bus speeds, etc. in desktop/server systems.  Various
embedded
> > systems have several parameters that can be set.  For example, an
XScale
> > PXA27x could be considered to have six basic power parameters
(mainly
> > cpu run mode and memory and bus dividers) that for the most part
> > should
> 
> This scares me a bit. Is table enough to handle this? I'm afraid that
> table will get very large on systems that allow you to do "almost
> anything".

You have use something abstract enough such that multiple systems can
use it.  If turns out to be big, another more user friendly/generic
layer would probably need to be built atop it.  In a closed system this
table is generally small and just describes a fundamental set of
parameters.


One why which this is handled for an entire system in the DPM case might
be:

You can flexibly create operating point sets in user space which are
appropriate for the underlying platform which the in kernel platform
specific back end knows how to interpret. This list of tuples in theory
might be big, but in practice it is not so large.

Now, to keep higher level user space code from having to understand all
the details of the architecture specific tuple list, DPM allows you to
create states which can be consistent across platforms (if you choose).
Each state will map to that lower architecture specific list.  The
policy manager sets the state to arch specific table list.

States : (fast->c0, mid->c1, slow->c2, idle->c2, off->s1)

Arch table: [["c0", a, b, c, e, f]
		 ["c1", a, b, c, e, f]
             ["c2", a, b, c, e, f]
		 ["t1", a, b, c, e, f]
		 ["t7", a, b, c, e, f]
		 ["s1", a, b, c, e, f]
		 ["s2", a, b, c, e, f]]

Now, how you move from state to state is up to the policy manager.  In
DPM you can set things up such that the kernel scheduler drives state
transitions or if that doesn't make sense you for your system, you can
control the change from else where, this can be from user state or
kernel state.  In any case the state to arch table mapping is done by
the policy manager best in user space.

To have fine grained control you probably need to make state changes at
the kernel level as there are timing realities.  If something a bit
coarser grained if desired it can all be done from user space.

By describing a very simple state diagram which just knows
fast/slow/idle you can potentially save a lot of power.  More elaborate
states can be built but that becomes very application specific. 

It seems Todd's PowerOP idea is a good one in that it allows multiple
mechanisms to be used.  Whether that is the current or evolved CPUFREQ
one, a DPM one, or some other one.

Regards,
Richard Woodruff
