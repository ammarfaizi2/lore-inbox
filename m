Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319630AbSIMN2E>; Fri, 13 Sep 2002 09:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319635AbSIMN2E>; Fri, 13 Sep 2002 09:28:04 -0400
Received: from dsl-213-023-022-092.arcor-ip.net ([213.23.22.92]:398 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319630AbSIMN2C>;
	Fri, 13 Sep 2002 09:28:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Raceless module interface
Date: Fri, 13 Sep 2002 15:34:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <20020913080709.9026B2C054@lists.samba.org>
In-Reply-To: <20020913080709.9026B2C054@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pqaz-000891-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 08:51, Rusty Russell wrote:
> If you split registration interfaces into reserve (can fail) and
> use (can't fail), then you do:
> 
> 	int my_module_init(void)
> 	{
> 		int ret;
> 		ret = reserve_foo();
> 		if (ret != 0)
> 			return ret;
> 		ret = reserve_bar();
> 		if (ret != 0)
> 			unreserve_foo();
> 		return ret;
> 	}
> 
> 	void my_module_start(void)
> 	{
> 		use_foo();
> 		use_bar();
> 	}

Why is that different from:

 	int my_module_init(void)
 	{
 		int ret;
 		ret = reserve_foo();
 		if (ret != 0)
 			return ret;
 		ret = reserve_bar();
 		if (ret != 0) {
 			unreserve_foo();
	 		return ret;
		}
 		use_foo();
 		use_bar();
		return 0;
 	}

> Note the symmetry here with the exit case: noone can actually use the
> module until my_module_start is called, so even if the reserve_bar()
> fails, we're safe.

And in my example above, nobody can actually use the module until
use_foo().  What's the difference?

> > Sure, I know it's not going to change, but I'd like to know what the
> > thinking was, and especially, if there's a non-bogus reason, I'd
> > like to know it.
> 
> You should probably start playing with my code if you're really
> interested.

Of course, and you might consider actually reading my [RFC].  We still
disagree on whether your fat interface or my thin one is the right way
to go.  Don't forget that the Unix way has traditionally been to use
the simplest interface that will do the job; if you propose a fat
interface you need to prove that the thin one cannot do the job.

-- 
Daniel
