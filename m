Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRA2R07>; Mon, 29 Jan 2001 12:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRA2R0t>; Mon, 29 Jan 2001 12:26:49 -0500
Received: from [213.95.15.193] ([213.95.15.193]:27408 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129051AbRA2R0f>;
	Mon, 29 Jan 2001 12:26:35 -0500
Date: Mon, 29 Jan 2001 18:26:33 +0100
From: Andi Kleen <ak@suse.de>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Message-ID: <20010129182633.A2522@gruyere.muc.suse.de>
In-Reply-To: <3A7459AA.84CDCF7B@colorfullife.com> <Pine.GSO.4.10.10101281949200.13259-100000@zeus.fh-brandenburg.de> <Ys3tl.A.KcH.rHad6@dinero.interactivesi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Ys3tl.A.KcH.rHad6@dinero.interactivesi.com>; from ttabi@interactivesi.com on Mon, Jan 29, 2001 at 11:01:31AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 11:01:31AM -0600, Timur Tabi wrote:
> What makes it more frustrating is that some people on this list talk as if
> things things are common knowledge.  I've been following this mailing list for
> months, and until today I had no idea sleep_on was bad.  All the documentation
> I've read to date freely uses sleep_on in the sample code.  In fact, I still

When Linux documentation uses sleep_on it is probably broken and should be 
fixed. Unix (not linux) documentation uses sleep_on commonly, but Unix has
different wait queue semantics and it is usually safe there. 

You're probably reading the wrong documentation, e.g. Rusty's 
kernel hacking HOWTO describes it correctly (and a lot of the other rules) 

> don't even know WHY it's bad.  Not only that, but what am I supposed to use
> instead? 

You can miss wakeups. The standard pattern is:

	get locks

	add_wait_queue(&waitqueue, &wait);
	for (;;) { 
		if (condition you're waiting for is true) 
			break; 
		unlock any non sleeping locks you need for condition
		__set_task_state(current, TASK_UNINTERRUPTIBLE); 
		schedule(); 
		__set_task_state(current, TASK_RUNNING); 
		reaquire locks
	}
	remove_wait_queue(&waitqueue, &wait); 

When you want to handle signals you can check for them before or after the
condition check. Also use TASK_INTERRUPTIBLE in this case.

When you need a timeout use schedule_timeout().

For some cases you can also use the wait_event_* macros which encapsulate
that for you, assuming condition can be tested/used lockless. 

An alternative is to use a semaphore, although that behaves a bit differently
under load.

> This is what I find most frustrating about Linux.  If I were a Windows driver
> programmer, I could walk into any bookstore and pick up any of a dozen books
> that explains everything, leaving no room for doubt.

Just why are Windows drivers so buggy then?


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
