Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSILIfV>; Thu, 12 Sep 2002 04:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSILIfV>; Thu, 12 Sep 2002 04:35:21 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:31644 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314138AbSILIfV> convert rfc822-to-8bit; Thu, 12 Sep 2002 04:35:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Daniel Phillips <phillips@arcor.de>, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Raceless module interface
Date: Thu, 12 Sep 2002 11:10:47 +0200
User-Agent: KMail/1.4.1
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209101201280.8911-100000@serv> <E17pCKQ-0007Sz-00@starship>
In-Reply-To: <E17pCKQ-0007Sz-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209121110.47246.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> To make this work, we rely on the rule that no module code may
> sleep/schedule unless it first increments a counter.  The counter
> incremented will, at present, be the module->count, but that is entirely
> up to the module itself; module.c will no longer care how it keeps
> track, as long as it does.
>
> With config_preempt code, we must additionally disable preemption until
> the module quiescence test has completed.  I'm not going to go further
> into this, because this is deep scheduling-fu, and I haven't got working
> code to show yet.  Suffice to say that we have the technology to build a
> magic_wait_for_quiescence, and we must now proceed to do that.  (Robert,
> are you reading?)  A noncounting module uses the test as follows, in its
> cleanup_function:
>
> 	unregister_callpoints(...);
> 	magic_wait_for_quiescence();
> 	return cleanup_foo(...);

Please correct me if I am wrong, but ...

Task A					Task B					counter
call_module()										+1
schedule()											still 1
						unregister_callpoints()		still 1
						magic_wait_for_quiescence();	still 1
call_module_second_func() -> Won't work

So by trying to unregister a module you make a module unusable
for an unspecified amount of time.

	Regards
		Oliver


