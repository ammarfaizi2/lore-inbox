Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318414AbSGaRf6>; Wed, 31 Jul 2002 13:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318415AbSGaRf5>; Wed, 31 Jul 2002 13:35:57 -0400
Received: from deming-os.org ([63.229.178.1]:32779 "EHLO deming-os.org")
	by vger.kernel.org with ESMTP id <S318414AbSGaRf5>;
	Wed, 31 Jul 2002 13:35:57 -0400
Message-ID: <3D482061.5010109@deming-os.org>
Date: Wed, 31 Jul 2002 10:37:37 -0700
From: Russell Lewis <spamhole-2001-07-16@deming-os.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: "'linux-ia64@linuxia64.org'" <linux-ia64@linuxia64.org>
Subject: Re: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
References: <200207302248.g6UMmax29450@ishark.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Griffin wrote:

>
>Mr. Lewis' solution fails to address the scenario of recursively
>taken read locks.  Since in that case, the thread taking the lock
>already holds the lock, running some nops doesn't really give
>another thread the possibility of acquiring the write lock.  So
>it works out to be the same situation only with a bunch of nops
>executed in the critical path.
>
>
>-Sean Griffin
>
Right.  It's not a very good solution, just one of many hacks that might 
work :(

What if we kept a value (in per-CPU or per-thread memory) that was a 
pointer to the last r/w lock we'd gained?  When we release ANY r/w lock, 
we could blindly initialize the "lastLock" pointer back to NULL.  Then 
we have a very quick (i.e. not very good) heuristic for detecting 
recursive locks; if the "lastLock" pointer equals the pointer to the 
thing you're about to try to lock, then you know that you already hold 
it and are about to grab it recursively...otherwise, you fall back to 
other routines.

If you really wanted, you could keep multiple pointers per CPU (exact 
number tunable by a kernel #define), and on release only clear the one 
you are actually releasing.  Most builds, I imagine, wouldn't need more 
than just a single pointer, though.

