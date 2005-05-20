Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVETLar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVETLar (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 07:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVETLar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 07:30:47 -0400
Received: from general.keba.co.at ([193.154.24.243]:17109 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261418AbVETLac convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 07:30:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01whenRT program dumps core]
Date: Fri, 20 May 2005 13:30:22 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F367323215@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01whenRT program dumps core]
Thread-Index: AcVcja7+nRCzdsxbSE+PWgo7dO9/eAAnf3Rg
From: "kus Kusche Klaus" <kus@keba.com>
To: "Lee Revell" <rlrevell@joe-job.com>,
       "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2005-05-19 at 10:37 -0400, Steven Rostedt wrote:
> > On Thu, 2005-05-19 at 16:23 +0200, kus Kusche Klaus wrote:
> > > Does that mean that the core dump is written 
> > > with the rt prio of the task which dumps?
> > 
> > Yes, since the process itself that crashed is what is 
> writing the core.
> > So if a RT process crashes, it writes the core as whatever it was.
> > 
> > > I'm not sure if this is a good idea: 
> > > Dumping a big core might take *ages* (at least w.r.t. realtime),
> > > especially because it usually goes to flash memory, a CF card,
> > > or some other really slow device.
> > > 
> > 
> > This is interesting, since if a RT task is dumping core, 
> that usually
> > means that it crashed, and therefore there's a bug in the 
> system.  Also,
> > unless the processes is writing to something that requires 
> a busy wait
> > (which the serial might do, and probably some flashes), 
> this shouldn't
> > effect the system.
> 
> Interesting indeed.  This could be caused by (possibly transient)
> hardware failure as well as a bug.  How do mission critical hard RT
> applications typically handle disasters like the RT process dumping
> core?  Presumably you have a hardware or software watchdog, and drop
> into some kind of safe mode.  It seems that you would need redundant
> systems if you wanted to continue to handle the RT constraint while
> recovering.
> 
> Lee

First of all, yes, we are talking about busy waits:
The CF cards run in PIO mode, i.e. the CPU polls and copies the data,
and we know from measurements that this causes 100 % CPU load and
blocks anything at lower prio for extended periods.

Of course, in some cases you are in big trouble anyway 
if some RT process in a control system dumps core,
and it will not matter any more at which prio core is dumped.

However, it might also be a non-critical part of the system,
and in this case, other parts should continue at normal rate.
If some part of the system which was designed to occupy the cpu
exclusively for let's say at most 50 microseconds suddenly 
monopolizes it for 5 seconds, that will cause surprises...

Moreover, the lowest-pri parts of a control system are usually the
graphical user interfaces. We are talking about core dump times
in the order of 5 or 10 seconds, and the operators will panic madly
if the system does not react to any user interaction and does not
update its display for that long.

Similarly, log daemons should spread word about the problem 
immediately, not 10 seconds late.

So we are not yet at the question how to recover and how to
continue. 

First of all, 
we want to survive the core dumping itself gracefully, 
we don't want to increase damage by dumping core, 
and we want to be able to inform and take action about the trouble
before the core has finished dumping.

Greetings

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
