Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVA2ApJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVA2ApJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 19:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVA2ApJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 19:45:09 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45198 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262831AbVA2Aof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 19:44:35 -0500
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20050128091143.GA6199@elte.hu>
References: <20050124125814.GA31471@elte.hu>
	 <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us>
	 <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us>
	 <1106782165.5158.15.camel@npiggin-nld.site> <20050128080802.GA2860@elte.hu>
	 <871xc62bot.fsf@sulphur.joq.us> <20050128084049.GA5004@elte.hu>
	 <87vf9i0vx3.fsf@sulphur.joq.us>  <20050128091143.GA6199@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 28 Jan 2005 19:44:33 -0500
Message-Id: <1106959474.3051.68.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 10:11 +0100, Ingo Molnar wrote:
> * Jack O'Quin <joq@io.com> wrote:
> 
> > > thus after a couple of years we'd end up with lots of desktop apps
> > > running as SCHED_FIFO, and latency would go down the drain again.
> > 
> > I wonder how Mac OS X and Windows deal with this priority escalation
> > problem?  Is it real or only theoretical?
> 
> no idea. Anyone with MacOSX/Windows application writing experience? :-|
> 

Here's the description from Apple.
(from
http://developer.apple.com/documentation/Darwin/Conceptual/KernelProgramming/scheduler/chapter_8_section_4.html):

However, according Stéphane Letz who ported JACK to OSX, this does NOT
describe the reality of the current implementation - it's not a real
deadline scheduler.  "period" and "constraint" are ignored, RT tasks are
scheduled round robin, and the scheduler just uses "computation" as the
timeslice.  If an RT task repeatedly uses its entire timeslice without
blocking, the scheduler can demote the task to SCHED_NORMAL.

Audio apps do not normally set these parameters directly, the CoreAudio
backend handles it.

(quoting Stéphane Letz)

> For example in CoreAudio, the computation value is directly related 
> to the audio buffer size in the following way:
> 
> buffer size   computation
> 
> 64 frames     500 us
> 128           300 us
> >= 256        100 us
> 
> The idea is that threads with smaller buffer size will get a larger  
> computation slice so that there is a chance they can complete their  
> jobs. Threads with larger buffer size are more interruptible. The  
> CoreMidi thread (to handle incoming Midi events) also has a 
> computation value of 500 us.

> Other RT threads like Firewire and various system threads computation  
> value are also carefully chosen.

(This was from a private mail thread, that lead to Con's SCHED_ISO patches, 
if all the participants agree I will post a link to the full thread because 
it answers many questions that are sure to come up on LKML)

So this system *requires* an app to tell the kernel in advance what its
RT constraints are, then revokes isochronous scheduling privileges if
the task lied.  This would require a new API.  Furthermore I suspect
that these "System" threads aren't subject to having their RT privileges
revoked, and that the GUI gets special treatment, etc.

The upshot is while the OSX system works in that environment, it's
largely due to Apple controlling the kernel and a lot of userspace.  OSX
is useful as a model of what a good API for soft realtime support in a
desktop OS would look like.  But we are a general purpose OS so we
certainly need a more general solution.

Lee

