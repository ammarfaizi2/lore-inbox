Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbSIRRT3>; Wed, 18 Sep 2002 13:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267561AbSIRRT3>; Wed, 18 Sep 2002 13:19:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6042 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267545AbSIRRT2>;
	Wed, 18 Sep 2002 13:19:28 -0400
Date: Wed, 18 Sep 2002 19:31:53 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209180938590.1913-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209181857520.23619-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is not about 'PID space squeeze'. Every sane sysadmin sets pid_max to
a high enough value - but sure i'm all for auto-sizing it - i proposed
auto-sizing of the allocation bitmap so i have absolutely nothing against
it.

the fundamental problem is consecutive allocation of PIDs. It can and will
happen, no matter what. In fact if it doesnt happen in every minute only
every week or so it's even worse. The current get_pid() algorithm, if it
sees 32K consequtively allocated PIDs [the next time the PID counter
overflows and gets to the PID-range - with the new optimizations this can
happen within 1 second even for a pid_max of 1 million], then the current
algorithm goes into a 32K*32K loop, ie. a loop of 1 billion, which takes
32 seconds.

only an infinite PID space [pratically infinite would be 64 bits or 128
bits] solves this problem in the current algorithm, or the patch we are
proposing, which also solves some other pending problems so it's
apparently a step in the right direction. (And it also enable us to
compress the PID space to make it more readable for mere mortals - if that
matters.)

	Ingo

