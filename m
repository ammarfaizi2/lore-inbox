Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWFMMm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWFMMm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 08:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFMMm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 08:42:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7344 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750746AbWFMMm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 08:42:27 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.2
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: ak@suse.de, mingo@elte.hu, michal.k.k.piotrowski@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2 
In-reply-to: Your message of "Tue, 13 Jun 2006 04:45:32 MST."
             <20060613044532.29e10a31.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Jun 2006 22:41:33 +1000
Message-ID: <21427.1150202493@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (on Tue, 13 Jun 2006 04:45:32 -0700) wrote:
>On Tue, 13 Jun 2006 15:08:40 +1000
>Keith Owens <kaos@sgi.com> wrote:
>
>> Andi Kleen (on Tue, 13 Jun 2006 06:56:45 +0200) wrote:
>> >
>> >> I have previously suggested a lightweight solution that pins a process
>> >> to a cpu 
>> >
>> >That is preempt_disable()/preempt_enable() effectively
>> >It's also light weight as much as these things can be.
>> 
>> The difference being that preempt_disable() does not allow the code to
>> sleep.  There are some places where we want to use cpu local data and
>> the code can tolerate preemption and even sleeping, as long as the
>> process schedules back on the same cpu.
>
>It would be easy to use this mechanism wrongly:

Agreed.

>	thread 1 on CPU N		thread 2 on CPU N
>
>	foo = per_cpu(...)
>	<preempt>
>					foo = per_cpu(...);
>					foo++;
>					per_cpu(...) = foo;
>					<unpreempt>
>	foo++;
>	per_cpu(...) = foo;	// whoops
>
>
>In which scenarios did you envisage it being used?

There are not many scenarios where this makes any sense.  One is where
the code is working on a collection of related cpu data and the whole
collection is protected by a per cpu mutex.  Taking the mutex stops
your race.  I doubt if we have any code like that yet.

The other possibility is to allow work to preempt the current process
while it spins in udelay().  This is a problem on systems that use the
cycle counter (TSC, ITC) and different cpus run at different rates.
See http://marc.theaimsgroup.com/?l=linux-ia64&m=113460274218885&w=2

I am not going to be too persistent about this facility.  If it seems
too risky or of too little use, then forget it.

