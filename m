Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbUDFVAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264014AbUDFVAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:00:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:61946 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264021AbUDFU6v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:58:51 -0400
Message-ID: <40731A02.8090303@mvista.com>
Date: Tue, 06 Apr 2004 13:58:42 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <amitkale@emsyssoft.com>, ganzinger@mvista.com
Subject: Re: [KGDB] Make kgdb get in sync with it's I/O drivers for the breakpoint
References: <20040405233058.GV31152@smtp.west.cox.net>
In-Reply-To: <20040405233058.GV31152@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> Hello.  The following interdiff, vs current kgdb-2 CVS makes kgdb core
> and I/O drivers get in sync in order to cause a breakpoint.  This kills
> off the init/main.c change, and makes way for doing things much earlier,
> if other support exists.  What would be left, tangentally, is some sort
> of queue to register with, so we can handle the case of KGDBOE on a
> pcmcia card.  George? Amit? Comments ?

Well a simple but dumb way is to poll using the timer list, i.e. set up a timer 
at the first entry were things "might" work and if the driver is not yet, do a 
timer to come back in 1 tick, and keep doing it for each tick until it is 
available.  This puts it all on the kgdb side.

The other way is with a call back list which would be managed by common OE code. 
  This would put most of the code in that area.  I tend to like call back lists 
that one registers for by passing in a structure which contains a "list_head" 
member.  That way there is no memory allocation on either end.  The manager, on 
a register call, just puts the new structure in its call back list.  The struct 
would have the list_head member and a function member, and the function would be 
called with the struct address as its only parameter.  This allows for an 
expanded struct if more complex info is needed.
~
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

