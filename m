Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbULCL4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbULCL4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 06:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbULCL4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 06:56:21 -0500
Received: from bluebox.CS.Princeton.EDU ([128.112.136.38]:56708 "EHLO
	bluebox.CS.Princeton.EDU") by vger.kernel.org with ESMTP
	id S262174AbULCLzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 06:55:52 -0500
From: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
To: "Gerrit Huizenga" <gh@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <riel@redhat.com>, <mason@suse.com>,
       <ckrm-tech@lists.sourceforge.net>,
       "Larry Peterson" <llp@CS.Princeton.EDU>,
       "Andy Bavier" <acb@CS.Princeton.EDU>,
       "Mark Huang" <mlhuang@CS.Princeton.EDU>,
       "Steve Muir" <smuir@CS.Princeton.EDU>
Subject: RE: [ckrm-tech] Re: [PATCH] CKRM: 0/10 Class Based Kernel Resource Management
Date: Fri, 3 Dec 2004 06:54:54 -0500
Message-ID: <NIBBJLJFDHPDIBEEKKLPMEBMCOAA.mef@cs.princeton.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <E1CYu5M-00015C-00@w-gerrit.beaverton.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and Gerrit,

I integrated CKRM with the kernel used by PlanetLab (www.planet-lab.org),
and I believe we (PlanetLab) are the first to use CKRM in a production
setting.  Our kernel is deployed on roughly 100 machines worldwide and we
intend to upgrade all of our machines (roughly 400) over the next few weeks.
Our kernel uses linux-vservers to create rather thin "virtual machines" (for
the lack of a better name), but uses CKRM to provide for performance
isolation between each vserver.  The integration between CKRM and vservers
was easy!

PlanetLab is used by tons of researchers.  The software of each research is
placed into a vserver, and each PlanetLab machine typically has anywhere
from 20-40 actively running vservers running at a constant load of roughly
20.  Some of the services running on PlanetLab have been discussed on
Slashdot.

Gerrit mentioned that PlanetLab uses a more featureful version of CKRM.
This is true.  For each vserver we create a corresponding CKRM class, and
then use the rule-based classification engine (RBCE) to automatically
classify vserver processes to the appropriate CKRM class.  We are itching to
deploy the CKRM memory controller and IO controller, but unfortunately those
have not been ready for prime time.  For now, we've only deployed a variant
of CKRM's cpu scheduler.  We currently do not leverage the hierarchical
support provided by CKRM, but envision a use for it in the future.

Unlike the posted CKRM patchset, the CPU, IO, and Memory controller make
more invasive modifications to various kernel subsystems.  I suspect that
the CPU and IO controllers can be completely modularized into the pluggable
CPU and IO framework that Con and Jens posted earlier, if that's the
direction that mainline is heading.  The CKRM memory controller makes a few
choice modifications to mm/vmscan.c, which I suspect will rouse a fair
amount of dicussion on LKML when the day arrives.

Hope this helps.

Cheers,
Marc

ps. our kernel is based on FC2 1.521 (2.6.8.1) and is available via anon
cvs.
cvs -d :pserver:anon@cvs.planet-lab.org:/cvs co linux-2.6

> -----Original Message-----
> From: ckrm-tech-admin@lists.sourceforge.net
> [mailto:ckrm-tech-admin@lists.sourceforge.net]On Behalf Of Gerrit
> Huizenga
> Sent: Monday, November 29, 2004 5:34 PM
> To: Andrew Morton
> Cc: linux-kernel@vger.kernel.org; riel@redhat.com; mason@suse.com;
> ckrm-tech@lists.sourceforge.net
> Subject: [ckrm-tech] Re: [PATCH] CKRM: 0/10 Class Based Kernel Resource
> Management
>
>
>
> On Mon, 29 Nov 2004 12:23:58 PST, Andrew Morton wrote:
> > Gerrit Huizenga <gh@us.ibm.com> wrote:
> > >
> > > The following ten patches add the core of CKRM (Class Based Resource
> > > Management) to Linux.
> >
> > How useful is this code at present?  What are its limitations?
> And what is
> > the plan for future enhancements?
>
> This set of code alone allows for creation of classes which include
> per-class resource accounting (including delay accounting), basic
> task management for memory, CPU and disk IO, limited socket & listener
> queue management for networking, and the related rules based
> infrastructure.
>
> So, in short, it is a useful set of code to work with to demonstrate
> real utility with CKRM.  However, this submission is not as full featured
> as is being used by those on the ckrm-tech list, such as the PlanetLab
> work.  There are also things in SLES9 that are more featureful than
> this set although those will be worked into here in time.
>
> It does not have the full memory management and scheduler support that
> other versions do and I'm not yet convinced that those are ready to
> submit.  Future enhancements will start with the cleanups as recommended
> by lkml so far (thanks all ;-) followed by more work on the scheduler
> and memory management side in the short term.  There are also ways
> to hook in additional resource controllers for any exhaustible resource,
> e.g. file handles. setrlimit style resources, etc.
>
> Most of the next level of changes will build on these and are based
> on work currently in progress on the ckrm-tech list.  However, this is
> a stripped down set of code which is believed to be stable (tested on
> IA32, x86-64, PPC64) with a variety of config options using both
> standard regression suites (e.g. LTP, kernbench, the ckrm tests, etc.).
>
> gerrit

