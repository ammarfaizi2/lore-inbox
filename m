Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTH2E0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 00:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTH2E0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 00:26:43 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:30936 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S264394AbTH2E0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 00:26:34 -0400
Date: Thu, 28 Aug 2003 21:55:33 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: kuznet@ms2.inr.ac.ru
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>, <wa@almesberger.net>,
       <quade@hsnr.de>, <linux-kernel@vger.kernel.org>
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
In-Reply-To: <200308281317.RAA20747@dub.inr.ac.ru>
Message-ID: <Pine.LNX.4.44.0308282143330.14580-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Aug 2003 kuznet@ms2.inr.ac.ru wrote:

> Hello!
> 
> > Either the tasklet_kill hangs (which will happen on UP)
> 
> Never can happen, unless you are trying to call tasklet_kill
> from softirq context, which is illegal.

If I was not explicit, I meant that tasklet_kill called from process 
context, for recursive tasklets will *always* hang on a UP machine at 
least till 2.4 when the kernel was not premptible. And yes, "always". The 
logic says that and experimentation also shows that.

> 
> 
> > So I believe that at least one (to be precise, the last one called
> before 
> > tasklet dies) tasklet_schedule is not honoured.
> 
> You cannot call tasklet_schedule while kill is called. As I said in
> previous
> mail, preventing new schedules is responsibility of callers. tasklet
> struct
> and control functions do not maintain any information about its state,
> it is
> for client to handle this in his preferred way.

So a better name would be wait_for_tasklet_completion. I think now I 
understand the
intent. If somebody is unloading a module which has scheduled a tasklet, 
the module cleanup function wants to be sure that the tasklet is not 
sitting on any CPU queue waiting to be executed (if that happens the 
tasklet might try to access the module address space and if that happens 
after the module unload we will get an OOPS). Once tasklet_kill completes 
the caller of tsaklet_kill has the responsibility to make sure that it is 
not scheduled again (if it is scheduled it will again start running 
happily as if nothing has happened)
All is fine, but the recursive tasklet problem is still there. We need 
to add another state to tasklet TASKLET_STATE_KILLED which is set once 
tasklet_kill is called. Once this is set tasklet_schedule just does not 
schedule the tasklet.

> 
> You are right when saying the name is misnomer. tasklet_kill does not
> kill,
> it waits for the moment when tasklet becomes really dead after client
> strangled it with his own hands.
> 
> Alexey
> 

Thanx for making things clear.
tomar


