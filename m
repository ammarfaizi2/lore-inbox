Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbTFRLqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 07:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbTFRLqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 07:46:44 -0400
Received: from mail.gmx.de ([213.165.64.20]:46755 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265163AbTFRLqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 07:46:38 -0400
Message-Id: <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 18 Jun 2003 14:04:45 +0200
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: O(1) scheduler starvation
Cc: davidm@hpl.hp.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1055922807.585.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:53 AM 6/18/2003 +0200, Felipe Alfaro Solana wrote:
>Hi!
>
>I've been poking around and found the following link on O(1) scheduler
>starvation problems:
>
>http://www.hpl.hp.com/research/linux/kernel/o1-starve.php
>
>The web page contains a small test program which supposedly is able to
>make two processes starvate. However, I've been unable to reproduce what
>is described in the above link. In fact, the CPU usage ratio ranges
>between 60-40% or 70-30% in the worst cases.

(you're talking about with my monotinic_clock() diff in your kernel right?)

If you examine the priorities vs cpu usage, therein lies a big fat bug.

I think the fundamental problem is that you can only execute in series, but 
can sleep in parallel, which makes for more sleep time existing than all 
execution time combined.  If you're running test-starve with my 
monotonic_clock() diff, you should notice that one task is at maximum 
priority and eating ~75% cpu, while the other is at minumum and getting the 
rest minus what top gets.  In a sane universe, that should be 
impossible.  In my current tree, this _is_ now impossible, but I haven't 
worked out some nasty kinks.

I've got thud licked (without the restricting sleep to time_slice), 
test-starve works right as well, and interactivity is up.  Tasks waking 
each other in a loop is a bitch and a half though, and need to be beaten 
about the head and shoulders.  Going to a synchronous wakeup for pipes 
(talking stock kernel now) cures irman process_load's ability to starve... 
IFF you're running it from a vt.  If you're in an xterm, it'll still climb 
up from the bottom (only place where it can't starve anybody) and starve 
via pass-the-baton wakeup DoS.  That will/does take the joy out of using 
xmms.  If xmms didn't use multiple threads, it'd be much worse... right 
now, you'll lose eye-candy [cpu hungry visualization stuff] before you lose 
sound [at next song].

>I'm running 2.5.72-mm1 with Mike Galbraith's scheduler patches and a
>small patch I made myself to improve interactivity (mainly, to stop XMMS
>from skipping by adjusting some scheduler parameters).

Please show me your xmms hack, and show me how you make xmms skip without 
doing something that puts tons of stress on the cache.  I built xmms here, 
and the only time the audio thread gets starved is when starting a new 
song.  That's because of CHILD_PENALTY when starting a new copy of xmms 
while something of prio < 20 is hogging cpu (process_load <grrrr>).  Once 
playing, it's rock solid here.

>What's going on here? Is the previous article outdated, or have the
>starvation problems been definitively fixed?

Nope, definitely not.

(if you like bean-counter diff, run contest/irman's process load:)

         -Mike 

