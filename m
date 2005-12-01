Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVLACvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVLACvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 21:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVLACvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 21:51:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38360 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751353AbVLACvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 21:51:47 -0500
Date: Thu, 1 Dec 2005 03:51:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
Subject: Re: [patch 25/43] Create ktimeout.h and move timer.h code into it
Message-ID: <20051201025145.GA26349@elte.hu>
References: <20051130231140.164337000@tglx.tec.linutronix.de> <1133395428.32542.468.camel@tglx.tec.linutronix.de> <20051201023619.GU31395@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201023619.GU31395@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> On Thu, Dec 01, 2005 at 01:03:48AM +0100, Thomas Gleixner wrote:
> > plain text document attachment (ktimeout-h.patch)
> > - introduce ktimeout.h and move the timeout implementation into it, as-is.
> > - keep timer.h for compatibility
> >...
> 
> If you do this, you should either immediately remove timer.h or add a
> #warning to this file.
> 
> Both cases imply changing all in-kernel users (which is anyway a good 
> idea if we really want to rename this header).

agreed, but we didnt want to be this drastic - we just wanted to 
demonstrate that a smooth transition (short of an overnight changeover) 
is possible as well.

also, we are very interested in suggestions to further improve the
ktimeout APIs. The perfect time is when there are no direct users of it
yet.

e.g. there's an interesting thought that Roman demonstrated in his 
ptimer queue: the elimination of the .data field from struct ktimer. An 
analogous thing could be done for timeouts as well: we do not actually 
need a .data field in a fair number of cases - the position of any 
data-context information can be recovered via container_of():

void timer_fn(struct ktimeout *kt)
{
	struct my_data *ptr = container_of(kt, struct my_data, timer);
	...
}

for compatibility we could provide a "struct ktimeout_standalone" that 
embedds a .data field and a struct timeout - which would be equivalent 
to the current "struct ktimeout".

the advantage would be data-structure size reduction of one word per 
embedded ktimeout structure. We'd also have one less word per standalone 
timer that needs no data field. For standalone timeouts which do need a 
data field there would be no impact.

one downside is that it's not as straightforward to code as the current 
.data field.

	Ingo
