Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVGOBSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVGOBSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 21:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVGOBSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 21:18:11 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:55232 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261782AbVGOBR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 21:17:56 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <1121380637.3747.10.camel@localhost.localdomain>
References: <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	 <1121304825.4435.126.camel@mindpipe>
	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	 <1121326938.3967.12.camel@laptopd505.fenrus.org>
	 <20050714121340.GA1072@ucw.cz>
	 <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
	 <1121380637.3747.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 21:17:43 -0400
Message-Id: <1121390263.7934.4.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 23:37 +0100, Alan Cox wrote:

> In actual fact you also want to fix users of
> 
> 	while(time_before(foo, jiffies)) { whack(mole); }
> 
> to become
> 
> 	init_timeout(&timeout);
> 	timeout.expires = jiffies + n
> 	add_timeout(&timeout);
> 	while(!timeout_expired(&timeout)) {}
> 
> Which is a trivial wrapper around timers as we have them now

Or something like this:

struct timeout_timer {
	unsigned long expires;
};

static inline void timeout_set(struct timeout_timer *timer,
	unsigned int msecs)
{
	timer->expires = jiffies + msecs_to_jiffies(msecs);
}

static inline int timeout_expired(struct timeout_timer *timer)
{
	return (time_after(jiffies, timer->expires));
}

It provides a nice API for relative timeouts without adding overhead.


- Eric St-Laurent


