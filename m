Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbTBQIXx>; Mon, 17 Feb 2003 03:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTBQIXx>; Mon, 17 Feb 2003 03:23:53 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:14495
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266953AbTBQIXv>; Mon, 17 Feb 2003 03:23:51 -0500
Date: Mon, 17 Feb 2003 03:32:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Richard Henderson <rth@twiddle.net>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Protect smp_call_function_data w/ spinlocks on
 Alpha
In-Reply-To: <20030217001544.A13101@twiddle.net>
Message-ID: <Pine.LNX.4.50.0302170316500.18087-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140634000.3518-100000@montezuma.mastecende.com>
 <20030214175332.A19234@jurassic.park.msu.ru>
 <Pine.LNX.4.50.0302141158070.3518-100000@montezuma.mastecende.com>
 <20030217001544.A13101@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Richard Henderson wrote:

> On Fri, Feb 14, 2003 at 12:16:12PM -0500, Zwane Mwaikambo wrote:
> > Ok the reason being is that the lock not only protects the 
> > smp_call_function_data pointer but also acts as a lock for that critical 
> > section. Without it you'll constantly be overwriting the pointer halfway 
> > through IPI acceptance (or even worse whilst a remote CPU is assigning the 
> > data members).
> 
> Really.  Show me the sequence there? 

/* Acquire the smp_call_function_data mutex.  */
if (pointer_lock(&smp_call_function_data, &data, retry))
	return -EBUSY;

say we remove the pointer lock there and do a single atomic assignment

...

if (atomic_read(&data.unstarted_count) > 0) {
	...
}

we got at least one IPI 

/* We either got one or timed out -- clear the lock. */
mb();
smp_call_function_data = 0;

We clear smp_call_function_data

...

cpuX receives the IPI

case IPI_CALL_FUNC:
{
	struct smp_call_struct *data;
	void (*func)(void *info);
	void *info;
	int wait;

	data = smp_call_function_data;
	func = data->func;
	info = data->info;
...

Assigns whatever the pointer happens to be at the time, be it NULL or the 
next incoming message call.

Therefore we'd need a lock to protect both the variable and critical 
section.

> I happen to like the pointer_lock a lot, and think we should
> make more use of it on systems known to have cmpxchg.  It
> saves on the number of cache lines that have to get bounced
> between processors.

I have to agree there, it would save on locked operations per 
'acquisition' which can be a win on a lot of systems.

	Zwane
-- 
function.linuxpower.ca
