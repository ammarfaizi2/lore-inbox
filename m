Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVBFMpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVBFMpw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVBFMpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:45:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44190 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261201AbVBFMpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:45:39 -0500
Date: Sun, 6 Feb 2005 13:45:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206124523.GA762@elte.hu>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206120244.GA28061@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > So I rather see the patch below merged instead; it fixes the worst
> > problems (RWE not marking the heap executable) while keeping this
> > useful feature enabled.
> > 
> > Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> 
> looks good.
> 
>  Signed-off-by: Ingo Molnar <mingo@elte.hu>

tested it against BK-curr, on an NX-enabled x86 CPU, and it builds/boots
fine and works as expected. A PT_GNU_STACK RWE binary gets this layout:

 saturn:~/noexec> cat /proc/2983/maps
 00888000-0089d000 r-xp 00000000 03:41 3433999    /lib/ld-2.3.3.so
 0089d000-0089f000 rwxp 00014000 03:41 3433999    /lib/ld-2.3.3.so
 008a1000-009bf000 r-xp 00000000 03:41 3434007    /lib/tls/libc-2.3.3.so
 009bf000-009c1000 r-xp 0011d000 03:41 3434007    /lib/tls/libc-2.3.3.so
 009c1000-009c3000 rwxp 0011f000 03:41 3434007    /lib/tls/libc-2.3.3.so
 009c3000-009c5000 rwxp 009c3000 00:00 0
 08048000-08049000 r-xp 00000000 03:41 1046974    /home/mingo/noexec/test-stack
 08049000-0804a000 rwxp 00000000 03:41 1046974    /home/mingo/noexec/test-stack
 b7fe7000-b7fe8000 rwxp b7fe7000 00:00 0
 bffeb000-c0000000 rwxp bffeb000 00:00 0
 ffffe000-fffff000 ---p 00000000 00:00 0

i.e. all mappings are executable (i.e. READ_IMPLIES_EXEC effect) - the
intended change. (although i dont fully agree with PT_GNU_STACK being
about something else than the stack, from a security POV if the stack is
executable then all bets are off anyway. The heap and all mmaps being
executable too in that case makes little difference.)

	Ingo
