Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUCDFBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUCDFBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:01:18 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:18117 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261439AbUCDFBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:01:11 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Date: Thu, 4 Mar 2004 10:31:00 +0530
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
References: <20040302213901.GF20227@smtp.west.cox.net> <20040303160409.GT20227@smtp.west.cox.net> <40467999.8000106@mvista.com>
In-Reply-To: <40467999.8000106@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403041031.00316.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Mar 2004 6:04 am, George Anzinger wrote:
> Tom Rini wrote:
> > On Wed, Mar 03, 2004 at 04:51:06PM +0100, Pavel Machek wrote:
> >>Hi!
> >>
> >>>>>More precisely:
> >>>>>http://lkml.org/lkml/2004/2/11/224
> >>>>
> >>>>Well, that just says Andrew does not care too much. I think that
> >>>>having both serial and ethernet support *is* good idea after all... I
> >>>>have few machines here, some of them do not have serial, and some of
> >>>>them do not have supported ethernet. It would be nice to use same
> >>>>kernel on all of them. Also distribution wants to have "debugging
> >>>>kernel", but does _not_ want to have 10 of them.
> >>>
> >>>But unless I'm missing something, supporting eth or 8250 at all times
> >>>doesn't work right now anyhow, as eth if available will always take
> >>> over.
> >>
> >>Well, that can be fixed. [Probably if kgdbeth= is not passed, ethernet
> >>interface should not take over. So user selects which one should be
> >>used by either passing kgdbeth or kgdb8250. That means that 8250
> >>should not be initialized until user passes kgdb8250=... not sure how
> >>you'll like that].
> >
> > At this point, I'm going to give up on killing kgdb_serial, and pass
> > along some comments from David Woodhouse on IRC as well (I was talking
> > about this issue, and the init/main.c change):
> > (Tartarus == me, dwmw2 == David Woodhouse)
> >
> > <Tartarus> dwmw2, the problem is how do you deal with all of the
> > possibilities of i/o (8250, kgdboe, or other serial) and do you allow
> > for passing 'gdb' on the command line to result in kgdb not being dropped
> > into?  You can always break in later on of course
> > <dwmw2> parse command line early for 'gdb=' argument specifying which
> > i/o device to use. init kgdb core early. init each i/o device as early
> > as possible for that i/o device. Start the selected i/o device as soon
> > as it becomes available.
> > <dwmw2> just like console could, if we looked for console= a little bit
> > earlier. (forget all the earlyconsole shite, it's not necessary)
> > <dwmw2> Tartarrus, do the __early_setup() thing to replace __setup() for
> > selected args. We can use that for console= too.
> > <dwmw2> since 'console=' on the command line _already_ remembers its
> > arguments, and starts to use the offending device as soon as it gets
> > registered with register_console().
> > <Tartarus> dwmw2, __early_setup() ?
> > <dwmw2> See __setup("gdb=", gdb_setup_func);
> > <dwmw2> Replace with __early_setup(...)
> > <Tartarus> where is __early_setup ?
> > <dwmw2> before we normally parse the command line
> > <dwmw2> in my head
> >
> > So perhaps someone can take these ideas and fix both problems... :)
> > (I've got some other stuff I need to work on today).
>
> Well, __early_setup could mean the fist setup call and if so that would be
> what we do in -mm.  It is done by putting the code in the first module ld
> sees, not nice, but it works.

I would prefer something that modifies start_kernel itself, rather than 
depending on ld. It will split start_kernel command line parsing into early 
parse and late parse, but that's the price we have to pay to do special 
parsing of kgdb arguments.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

