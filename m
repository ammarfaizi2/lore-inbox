Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUI1GX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUI1GX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 02:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267565AbUI1GX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 02:23:28 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:38874 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S267563AbUI1GXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 02:23:25 -0400
Date: Mon, 27 Sep 2004 23:25:40 -0700
From: Hui Huang <Hui.Huang@Sun.COM>
Subject: Re: heap-stack-gap for 2.6
In-reply-to: <20040925162252.GN3309@dualathlon.random>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Message-id: <415903E4.1030808@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
References: <20040925162252.GN3309@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> This patch enforces a gap between heap and stack, both on the mmap side
> (for heap) and on the growsdown page faults for stack. the gap is in
> page units and it's sysctl configurable. Against CVS head.
> 
> This is needed for some critical app, that wants an higher degree of
> protection against potential stack overflows from the kernel. This is
> mostly a 32bit matter of course, since on 32bit those apps are using
> a few gigs of heap and they get as near as they can to the stack (but if
> something goes wrong a page fault must happen).
> 
> 
> the default value of 1 avoids userspace apps like java to break,

Ok, I'm a JVM guy and I worked on heap-stack-gap issue many moons ago.
The reason that heap-stack-gap on SuSE Linux used to crash Java is
because we are explicitly setting up a guard page to prevent heap-stack
collision (a stack guard is also required in order to throw stack
overflow exception). So in a java program, prev_vma in your patch does
not point to regular heap memory but the guard page. The hidden gap
would cause SIGSEGV to occur before the thread actually hits the guard,
that confused JVM. We had to work around it by reading the gap size from
/proc.

I'd recommend adding an extra check to see if prev_vma is read/write,
and ignoring heap-stack-gap if prev_vma is guard page. Having a hidden
gap does not offer any extra protection, it only confuses an application
if it manages stack guard.

regards,
-hui
                                                                    but
> those apps will of course set by hand in the rc.d scripts a much higher
> value. 1 is a sane default, if you want to tweak the default with
> mainline inclusion that's fine with me. the sysctl can always be
> disabled by setting it to 0 and then nobody will notice.
> 
> feature is fully enabled on x86* and ppc*. No idea about the ia64 and
> s390x layouts but they've presumably a lot more address space not to
> care about this (this is primarly needed on 32bit apps). 
> 
> I didn't check the topdown model, in theory it should be extended to
> cover that too, this is only working for the legacy model right now
> because those apps aren't going to use topdown anyways.
> 
