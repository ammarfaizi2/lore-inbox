Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262308AbRERMdN>; Fri, 18 May 2001 08:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262309AbRERMdE>; Fri, 18 May 2001 08:33:04 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:17936 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S262308AbRERMcz>;
	Fri, 18 May 2001 08:32:55 -0400
Date: Fri, 18 May 2001 08:32:33 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
X-X-Sender: <bart@localhost>
To: sebastien person <sebastien.person@sycomore.fr>
cc: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: [newbie] timer in module
In-Reply-To: <20010518135441.59bab0ce.sebastien.person@sycomore.fr>
Message-ID: <Pine.LNX.4.33.0105180814170.18504-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001, sebastien person wrote:

> I have a network module that need to regularly get data from network
> adaptater.
> But I don't know if it safe to do a loop with a timer in the module.

First off you have to decide where you want to run your 'get data'.  There
are three context you can pick from: user priority or from the kernel.  If
you run the loop below from a user context then you will have a very
unresponsive system but at least other things will still run.  If you run
that from a kernel context nothing else will run... unless you explicitly
call the scheduler.

> My aim is to do a get data call every x seconds (x is variable).

You mentioned a timer... it runs in kernel context but at least it
will not end up hanging your system up.  This is how you would use one:

struct tq_struct timer;
init_timer(&timer);
timer.routine = func;
timer.data = something;
mod_timer(&timer, 5*HZ); // 5 seconds from now

void func( unsigned long something ) {
	get_data( something );
	mod_timer(&timer, 5*HZ); // again in 5 seconds
}

Make sure you call 'del_timer_sync' once you are done.

> Is it better to let an external program executing timer call and get data
> call via ioctl ?

Since you are getting data every 5 seconds you may as well use a user
space program.  It does not seem like you are looking for phenomenal
responsiveness here.

Bart.

-- 
	WebSig: http://www.jukie.net/~bart/sig/

