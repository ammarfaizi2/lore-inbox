Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVHIDwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVHIDwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 23:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVHIDwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 23:52:05 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:35758 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932435AbVHIDwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 23:52:04 -0400
Subject: Re: [PATCH 2/4] Task notifier: Implement todo list in task_struct
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christoph Lameter <christoph@lameter.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0508081858040.32489@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
	 <Pine.LNX.4.62.0507272018060.11863@graphe.net>
	 <20050728074116.GF6529@elf.ucw.cz>
	 <Pine.LNX.4.62.0507280804310.23907@graphe.net>
	 <20050728193433.GA1856@elf.ucw.cz>
	 <Pine.LNX.4.62.0507281251040.12675@graphe.net>
	 <Pine.LNX.4.62.0507281254380.12781@graphe.net>
	 <20050728212715.GA2783@elf.ucw.cz> <20050728213254.GA1844@elf.ucw.cz>
	 <Pine.LNX.4.62.0507281456240.14677@graphe.net>
	 <1123551167.9451.5.camel@localhost>
	 <Pine.LNX.4.62.0508081858040.32489@graphe.net>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123559495.4370.87.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Aug 2005 13:51:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-08-09 at 12:01, Christoph Lameter wrote:
> On Tue, 9 Aug 2005, Nigel Cunningham wrote:
> 
> > Just to let you know that I have it working with Suspend2. One thing I
> > am concerned about is that we still need a way of determining whether a
> > process has been signalled but not yet frozen. At the moment you just
> > check p->todo, but if/when other functionality begins to use the todo
> > list, this will be unreliable.
> > 
> 
> No it wont. A process that has notifications to process should do that 
> before being put into the freezer. Only after the notification list is 
> empty will the process be notified and as long as the notification is 
> pending no second notification should happen.

Sorry I wasn't clear. I was thinking of the case where a broken process
doesn't process its todo list. (May it never be, but still...). How do
we find out which one is broken? We need to traverse the todo list of
every process, checking for outstanding freeze requests.

Your reply leads me to another issue. It seems to me that you shouldn't
wait until the todo list is empty before putting the freeze request on
the todo list. If the todo list is ever used for something where it
becomes hot, you might never see the todo list empty before your
timeout, and freezing will be unreliable. Even if you do see it empty
and insert your freeze request, it might be that more work is added
afterwards, so you may as well just add the request whether or not the
queue is empty.

Of course if you address this, you then have the problem that the
calling routine hammers on routines until they enter the fridge, you can
end up with multiple freeze requests per process. That could be
addressed by splitting it into two loops - the first adds the todo work
for each thread to be frozen, and the second wakes them until they
process the notification. I reckon that we shouldn't need to wake them
repeatedly like this, but I've never taken the time to see why a process
could need multiple wakeups. (I believe it's not bogus).

> > I'm happy to supply the patches I'm using if you want to compare. (I
> > retained the other freezer improvements, so it wouldn't just be bug
> > fixes against your patches).
> 
> I am not sure how to sort that out. I guess post the current patches that 
> you got and then we see how to continue from there.

Will do shortly. Just have to go talk to my boss first :> (Separate
issue).

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

