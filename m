Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWIOVvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWIOVvS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWIOVvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:51:18 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:8109 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932148AbWIOVvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:51:17 -0400
Date: Fri, 15 Sep 2006 17:46:04 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: "Jose R. Santos" <jrs@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915214604.GB18958@Krystal>
References: <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com> <1158320406.29932.16.camel@localhost.localdomain> <Pine.LNX.4.64.0609151339190.6761@scrub.home> <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <450AEC92.7090409@us.ibm.com> <20060915194937.GA7133@Krystal> <450B1309.9020800@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <450B1309.9020800@us.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 17:29:47 up 23 days, 18:38,  2 users,  load average: 0.16, 0.20, 0.18
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose,

* Jose R. Santos (jrs@us.ibm.com) wrote:
> >My goal with LTTng is to provide a reentrant data serialisation mechanism 
> >that
> >can be called from anywhere in the kernel (ok, the vmalloc path of the page
> >fault handler is _the_ exception) that does not use any lock and can 
> >therefore
> >trace code paths like NMI handlers.
> >  
> 
> One of the things that I've notice from this thread that neither you or 
> Karim sees to have answer is why is LTTng needed if a suitable 
> replacement can be developed using SystemTap with static markers.  I am 
> personally interested in this answer as well.  If all the things that 
> LTT is proposing can be implemented in SystemTap, what then is the 
> advantage of accenting such an interface into the kernel.
> 

Well, last time I have checked, SystemTAP did not have a reentrant serialisation
mechanism to write the information to the buffers. Also, the goals of the
projects differ : SystemTAP finds acceptable to suffer from the kprobe
performance hit while it is unacceptable for LTTng.

> I don't really care which method is used as long as its the right tool 
> for the job.  I see several idea from LTT that could be integrated into 
> SystemTap in order to make it a one stop solution for both dynamic and 
> static tracing.  Would you care to elaborate why you think having 
> separate projects is a better solution?

I think that each projet focus on their own different goals but that there is
much to gain in reusing the strenghts of each.

SystemTAP is good at dynamic instrumentation.
LTTng is good at data serialisation under a fully reentrant kernel.
LTTng provides logging primitives for any data type, including SystemTAP text
output.

Is someone willing to try to create a small facility that will dump SystemTAP's
output in LTTng ? It is nearly trivial : if I wasn't completing my debugfs port,
I would probably be doing it right now.

> Trace event headers are very similar between both LTT and LKET which is 
> good in other to get some synergy between our projects.  One thing that 
> LKET has on each trace event that LTT doesn't is the tid and CPU id of 
> each event.  We find this extremely useful for post-processing.  Also, 
> why have the event_size on every event taken?  Why not describe the 
> event during the trace header and remove this redundant information from 
> the event header and save some trace file space.
> 

A standard event header has to have only crucial information, nothing more, or
it becomes bloated and quickly grow trace size. We decided not to put tid and
CPU id in the event header because tid is already available with the schedchange
events at post-processing time and CPU id is already available too, as we have
per CPU buffers.

The event size is completely unnecessary, but in reality very, very useful to
authenticate the correspondance between the size of the data recorded by the
kernel and the size of data the viewer thinks it is reading. Think of it as a
consistency check between kernel and viewer algorithms.


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
