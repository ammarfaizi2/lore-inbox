Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288342AbSAHU76>; Tue, 8 Jan 2002 15:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288334AbSAHU6z>; Tue, 8 Jan 2002 15:58:55 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:49170 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288327AbSAHU5o>; Tue, 8 Jan 2002 15:57:44 -0500
Message-ID: <3C3B5C02.9929B8@zip.com.au>
Date: Tue, 08 Jan 2002 12:52:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: Robert Love <rml@tech9.net>, David Howells <dhowells@redhat.com>,
        torvalds@transmeta.com, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt abstraction
In-Reply-To: <10940.1010511619@warthog.cambridge.redhat.com> <1010516250.3229.21.camel@phantasy>,
		<1010516250.3229.21.camel@phantasy>; from rml@tech9.net on Tue, Jan 08, 2002 at 01:57:28PM -0500 <20020108195920.A14642@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Tue, Jan 08, 2002 at 01:57:28PM -0500, Robert Love wrote:
> > Why not use the more commonly named conditional_schedule instead of
> > preempt() ?  In addition to being more in-use (low-latency, lock-break,
> > and Andrea's aa patch all use it) I think it better conveys its meaning,
> > which is a schedule() but only conditionally.
> 
> I think the choice is very subjective, but I prefer preempt().
> It's nicely short to type (!) and similar in spirit to Ingo's yield()..
> 

naah.  preempt() means preempt.  But the implementation
is in fact maybe_preempt(), or preempt_if_needed().

I use (verbosely) (simplified):

#define conditional_schedule_needed()	unlikely(current->need_resched)
#define unconditional_schedule()	do {
						__set_current_state(TASK_RUNNING)
						schedule();
					} while(0);
#define conditional_schedule()		if (conditional_schedule_needed())
						unconditional_schedule();

...

foo()
{
	...
	conditional_schedule();
	...
}

bar()
{
	...
	if (conditional_schedule_needed()) {
		spin_unlock(&piggy_lock);
		unconditional_schedule();
		spin_lock(&piggy_lock);
		goto clean_up_mess;
	}
	...
}
