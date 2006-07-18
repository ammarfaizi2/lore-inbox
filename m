Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWGRFVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWGRFVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 01:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWGRFVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 01:21:18 -0400
Received: from [213.184.169.121] ([213.184.169.121]:58122 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751254AbWGRFVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 01:21:17 -0400
From: Al Boldi <a1426z@gawab.com>
To: Paulo Marques <pmarques@grupopie.com>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Date: Tue, 18 Jul 2006 08:21:45 +0300
User-Agent: KMail/1.5
Cc: Arjan van de Ven <arjan@infradead.org>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
References: <200607112257.22069.a1426z@gawab.com> <200607151709.45870.a1426z@gawab.com> <44BBB1AA.3050703@grupopie.com>
In-Reply-To: <44BBB1AA.3050703@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607180821.45346.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> Al Boldi wrote:
> >[...] > void fn() {
> >
> > 	long i = 9999999;
> > 	double x,y;
> >
> > 	elapsed(1);
> > 	while (i--) fn2(&x,&y);
> > 	printf("%4lu ",elapsed(0));
> > }
>
> You are not initializing x and y and with -Os at least my gcc really
> uses floating point load/store operations to handle that code.

Thanks for pointing that out.

I was really waiting for someone to critique this, but keep in mind this code 
tries to surface a performance problem, and any modification changes the 
semantics of the compiled code, which then may yield different results.

> Maybe the coprocessor has a hard time normalizing certain garbage on the
> stack, but without/with randomization the data comes from other
> addresses and you're just lucky with the contents.

Good point, but this random garbage makes the test even more realistic, as 
this code would thus cover more variations without actually coding for it.

> Does this also happens if you add a "x=0, y=0;" line to that function?

with arch_stack_align using 0xf
gcc -Os tstExec.c
randomization on
causes 2x blips/hits
randomization off
causes no blips/hits
mv a.out tstExec
causes continuous 2x slowdown
sh -c ./tstExec
causes slowdown to disappear (can somebody explain this weirdness?)

with arch_stack_align using 0x7f
all weirdness is gone
gcc -O3 tstExec.c
randomization on
causes some minor blips/hits
randomization off
causes even less blips/hits

Going one step further,
with #define arch_stack_align(x) (x)
all blips/hits/weirdness are gone

Which means that either arch_stack_align isn't necessary at all, or 
randomization isn't working as intended.

Can somebody prove me wrong here?

Thanks!

--
Al


