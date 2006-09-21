Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWIUHsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWIUHsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWIUHsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:48:24 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:30701
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751012AbWIUHsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:48:23 -0400
Date: Thu, 21 Sep 2006 00:48:05 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <simlo@phys.au.dk>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060921074805.GA11644@gnuppy.monkey.org>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <20060921065402.GA22089@elte.hu> <20060921071838.GA10337@gnuppy.monkey.org> <20060921071624.GA25281@elte.hu> <20060921073222.GC10337@gnuppy.monkey.org> <20060921072908.GA27280@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921072908.GA27280@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 09:29:08AM +0200, Ingo Molnar wrote:
> * Bill Huey <billh@gnuppy.monkey.org> wrote:
> > I overloaded another reaping thread that was doing largely similar 
> > functionality in that it was also reaping, so I don't think it's that 
> > bad. I did it from a cleanliness point of view with the code tree. 
> > It's the "desched_thread" in fork.c that I'm using. It seems to be the 
> > right thing to do. I'm sure Esben will follow up on this.
> 
> the reason why i added desched_thread was not because it's "more right" 
> to do this from a separate context, but simply because the resource 

I only did that because I saw it there and I assumed it the was the correct
thing to use and that's why I used it.

> freed by it is not being freed via RCU by the upstream kernel. If that 
> resource (mm_struct) were freed by RCU we'd have its rt-friendly 
> reapdown "for free" and no desched_thread would be needed at all.

Well, it's difficult to say. I can't say which is the best method. If the
upstream kernel used RCU function in a task allocation or task struct reading
in the first place then call_rcu() would be a clear choice. However, I didn't
see it used in that way (I could be wrong) so I use the next closest thing that
seems reasonable which is the thread desched_thread(). It use it to avoid
overloading the sematics of call_rcu() to be anything other than a pure RCU
callback. I suggest talking to Esben an Paul about this to get their view on
the matter.

Either method, call_rcu or desched_thread does the trick outside of the
scheduler path and fixes the problem. It's your choice.

bill

