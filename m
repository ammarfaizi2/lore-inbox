Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130453AbRCCMuY>; Sat, 3 Mar 2001 07:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbRCCMuN>; Sat, 3 Mar 2001 07:50:13 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:62985 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S130453AbRCCMuB>;
	Sat, 3 Mar 2001 07:50:01 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200103031249.f23Cn4R01208@flint.arm.linux.org.uk>
Subject: gettimeofday question
To: linux-kernel@vger.kernel.org
Date: Sat, 3 Mar 2001 12:49:04 +0000 (GMT)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed that one of my machines here suffers from the "time going
backwards problem" and so started thinking about the x86 solution.

I've come to the conclusion that it has a hole which could cause it
to return the wrong time in one specific case:

- in do_gettimeofday(), we disable irqs (read_lock_irqsave)
- the ISA timer wraps, but we've got interrupts disabled, so no update
  of xtime or jiffies occurs
- in do_slow_gettimeoffset(), we read the timer, which has wrapped
- since jiffies_p != jiffies, we do not apply any correction
- our idea of time is now one jiffy slow.

Further more, while do_gettimeofday() is still within the
read_lock_irqsave, we spin_unlock(&i8253_lock) in do_slow_gettimeoffset()
and _re-enable_ interrupts!  This means when we later read xtime, we're
doing it with interrupts enabled.

This applies to both 2.2.18 and 2.4.2.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

