Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424635AbWKQAMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424635AbWKQAMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424795AbWKQAMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:12:35 -0500
Received: from gw.goop.org ([64.81.55.164]:45743 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1424635AbWKQAMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:12:35 -0500
Message-ID: <455D0155.9000305@goop.org>
Date: Thu, 16 Nov 2006 16:24:53 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Eric Dumazet <dada1@cosmosbay.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <1158047806.2992.7.camel@laptopd505.fenrus.org> <200611151227.04777.dada1@cosmosbay.com> <200611151232.31937.ak@suse.de> <20061115172003.GA20403@elte.hu> <455B4E2F.7040408@goop.org> <1163613702.31358.145.camel@laptopd505.fenrus.org> <455B5B55.20803@goop.org> <20061115190606.GB9303@elte.hu>
In-Reply-To: <20061115190606.GB9303@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------080303010202030309000704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080303010202030309000704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> what point would there be in using it? It's not like the kernel could 
> make use of the thread keyword anytime soon (it would need /all/ 
> architectures to support it) ...

The plan was to implement the x86 arch-specific percpu stuff to use it,
since it allows gcc better optimisation opportunities.

>  and the kernel doesnt mind how the 
> current per_cpu() primitives are implemented, via assembly or via C. In 
> any case, it very much matters to see the precise cost of having the pda 
> selector value in %gs versus %fs.
>   

Hm, well, unfortunately for me, there is a small but distinct advantage
to using %fs rather than %gs (around 0-5ns per iteration).  The notable
exception being the "AMD-K6(tm) 3D+ Processor", where %gs is about 25%
(15ns) faster.

I'll revise the patches to use %fs and resubmit.

    J

--------------080303010202030309000704
Content-Type: text/plain;
 name="results-mixed.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="results-mixed.txt"

"Genuine Intel(R) CPU           T2400  @ 1.83GHz" @1000Mhz (6,14,8):
ds=7b fs=0 gs=33 ldt=f gdt=3b CPUTIME 
   <none> with data selector: 0ns/iteration
   fs with data selector: 26ns/iteration
   gs with data selector: 30ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 26ns/iteration
   gs with LDT selector: 26ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 26ns/iteration
   gs with GDT selector: 30ns/iteration

"Intel(R) Pentium(R) 4 CPU 1.80GHz" @1817.9Mhz (15,2,4):
ds=7b fs=0 gs=33 ldt=f gdt=3b CPUTIME 
   <none> with data selector: 0ns/iteration
   fs with data selector: 33ns/iteration
   gs with data selector: 34ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 43ns/iteration
   gs with LDT selector: 52ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 33ns/iteration
   gs with GDT selector: 34ns/iteration

"Intel(R) Celeron(R) CPU 2.40GHz" @2394.47Mhz (15,2,9):
ds=7b fs=0 gs=33 ldt=f gdt=3b CPUTIME 
   <none> with data selector: 0ns/iteration
   fs with data selector: 20ns/iteration
   gs with data selector: 24ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 21ns/iteration
   gs with LDT selector: 26ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 21ns/iteration
   gs with GDT selector: 26ns/iteration

"Pentium 75 - 200" @166.206Mhz (5,2,12):
ds=7b fs=0 gs=33 ldt=f gdt=3b GTOD
   <none> with data selector: 1ns/iteration
   fs with data selector: 74ns/iteration
   gs with data selector: 75ns/iteration

   <none> with LDT selector: 1ns/iteration
   fs with LDT selector: 74ns/iteration
   gs with LDT selector: 75ns/iteration

   <none> with GDT selector: 1ns/iteration
   fs with GDT selector: 74ns/iteration
   gs with GDT selector: 74ns/iteration

"AMD-K6(tm) 3D+ Processor" @451.105Mhz (5,9,1):
ds=7b fs=0 gs=33 ldt=f gdt=3b GTOD
   <none> with data selector: 0ns/iteration
   fs with data selector: 59ns/iteration
   gs with data selector: 44ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 59ns/iteration
   gs with LDT selector: 44ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 59ns/iteration
   gs with GDT selector: 44ns/iteration

"AMD Athlon(tm) XP 3000+" @2162.74Mhz (6,10,0):
ds=7b fs=0 gs=33 ldt=f gdt=3b CPUTIME
   <none> with data selector: 0ns/iteration
   fs with data selector: 10ns/iteration
   gs with data selector: 11ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 11ns/iteration
   gs with LDT selector: 11ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 11ns/iteration
   gs with GDT selector: 11ns/iteration


"AMD Athlon(tm) 64 Processor 3500+" @2210.23Mhz (15,31,0):
ds=2b fs=0 gs=63 ldt=f gdt=6b GTOD
   <none> with data selector: 0ns/iteration
   fs with data selector: 11ns/iteration
   gs with data selector: 11ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 10ns/iteration
   gs with LDT selector: 11ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 10ns/iteration
   gs with GDT selector: 11ns/iteration

"Pentium III (Coppermine)" @700Mhz (6,8,6):
ds=7b fs=0 gs=33 ldt=f gdt=3b CPUTIME
   <none> with data selector: 0ns/iteration
   fs with data selector: 38ns/iteration
   gs with data selector: 45ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 39ns/iteration
   gs with LDT selector: 41ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 39ns/iteration
   gs with GDT selector: 44ns/iteration

--------------080303010202030309000704--
