Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264941AbSJ3WpV>; Wed, 30 Oct 2002 17:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSJ3WpV>; Wed, 30 Oct 2002 17:45:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33803 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264941AbSJ3WpT>; Wed, 30 Oct 2002 17:45:19 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Are x86 trap gate handlers safe for preemption?
Date: Wed, 30 Oct 2002 22:51:10 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <appnou$jof$1@penguin.transmeta.com>
References: <15808.17731.311432.596865@kim.it.uu.se>
X-Trace: palladium.transmeta.com 1036018277 19269 127.0.0.1 (30 Oct 2002 22:51:17 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 30 Oct 2002 22:51:17 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <15808.17731.311432.596865@kim.it.uu.se>,
Mikael Pettersson  <mikpe@csd.uu.se> wrote:
>Consider an exception handler like vector 7, device_not_available:
>
>ENTRY(device_not_available)
>        pushl $-1                       # mark this as an int
>        SAVE_ALL
>        movl %cr0, %eax
>        testl $0x4, %eax                # EM (math emulation bit)
>        jne device_not_available_emulate
>        preempt_stop
>
>Since this is invoked via a trap gate and not an interrupt gate,
>what's preventing this code from being preempted and resumed on
>another CPU before the read from %cr0?

Well, since %cr0 should be stable across the task switche, that
shouldn't actually matter.

>				 Another example is the
>machine_check vector (also trap gate) whose handlers access MSRs.

This one looks like a real bug. The fix should be to make it an
interrupt gate, I suspect. Comments?

On the whole, I think it is probably a good idea to make all exceptions
be interrupt gates, and then on a case-by-case basis show why some don't
need to (ie clearly the system calls should _not_ be interrupt gates,
but we've long since made the page fault path use an interrupt gate for
similar special register stability reasons).

		Linus
