Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUCDAe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUCDAe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:34:58 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:39413 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261253AbUCDAel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:34:41 -0500
Message-ID: <40467999.8000106@mvista.com>
Date: Wed, 03 Mar 2004 16:34:33 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net> <20040302223143.GE1225@elf.ucw.cz> <20040302230018.GL20227@smtp.west.cox.net> <20040302233512.GJ1225@elf.ucw.cz> <20040303152226.GS20227@smtp.west.cox.net> <20040303155106.GB12769@atrey.karlin.mff.cuni.cz> <20040303160409.GT20227@smtp.west.cox.net>
In-Reply-To: <20040303160409.GT20227@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Wed, Mar 03, 2004 at 04:51:06PM +0100, Pavel Machek wrote:
> 
>>Hi!
>>
>>
>>>>>More precisely:
>>>>>http://lkml.org/lkml/2004/2/11/224
>>>>
>>>>Well, that just says Andrew does not care too much. I think that
>>>>having both serial and ethernet support *is* good idea after all... I
>>>>have few machines here, some of them do not have serial, and some of
>>>>them do not have supported ethernet. It would be nice to use same
>>>>kernel on all of them. Also distribution wants to have "debugging
>>>>kernel", but does _not_ want to have 10 of them.
>>>
>>>But unless I'm missing something, supporting eth or 8250 at all times
>>>doesn't work right now anyhow, as eth if available will always take over.
>>
>>Well, that can be fixed. [Probably if kgdbeth= is not passed, ethernet
>>interface should not take over. So user selects which one should be
>>used by either passing kgdbeth or kgdb8250. That means that 8250
>>should not be initialized until user passes kgdb8250=... not sure how
>>you'll like that].
> 
> 
> At this point, I'm going to give up on killing kgdb_serial, and pass
> along some comments from David Woodhouse on IRC as well (I was talking
> about this issue, and the init/main.c change):
> (Tartarus == me, dwmw2 == David Woodhouse)
> 
> <Tartarus> dwmw2, the problem is how do you deal with all of the
> possibilities of i/o (8250, kgdboe, or other serial) and do you allow
> for passing 'gdb' on the command line to result in kgdb not being dropped
> into?  You can always break in later on of course
> <dwmw2> parse command line early for 'gdb=' argument specifying which
> i/o device to use. init kgdb core early. init each i/o device as early
> as possible for that i/o device. Start the selected i/o device as soon
> as it becomes available.
> <dwmw2> just like console could, if we looked for console= a little bit
> earlier. (forget all the earlyconsole shite, it's not necessary)
> <dwmw2> Tartarrus, do the __early_setup() thing to replace __setup() for
> selected args. We can use that for console= too.
> <dwmw2> since 'console=' on the command line _already_ remembers its
> arguments, and starts to use the offending device as soon as it gets
> registered with register_console().
> <Tartarus> dwmw2, __early_setup() ?
> <dwmw2> See __setup("gdb=", gdb_setup_func);
> <dwmw2> Replace with __early_setup(...)
> <Tartarus> where is __early_setup ?
> <dwmw2> before we normally parse the command line
> <dwmw2> in my head
> 
> So perhaps someone can take these ideas and fix both problems... :)
> (I've got some other stuff I need to work on today).

Well, __early_setup could mean the fist setup call and if so that would be what 
we do in -mm.  It is done by putting the code in the first module ld sees, not 
nice, but it works.


> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

