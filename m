Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSJYIio>; Fri, 25 Oct 2002 04:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbSJYIi3>; Fri, 25 Oct 2002 04:38:29 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:44046 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261313AbSJYIiB>; Fri, 25 Oct 2002 04:38:01 -0400
Message-Id: <200210250838.g9P8cop14595@Port.imtp.ilyichevsk.odessa.ua>
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Date: Fri, 25 Oct 2002 11:31:21 -0200
X-Mailer: KMail [version 1.3.2]
Cc: arjanv@redhat.com
References: <3DB82ABF.8030706@colorfullife.com>
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9KHJT6C61YQ5FO7ROGDJ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_9KHJT6C61YQ5FO7ROGDJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

On 24 October 2002 15:15, Manfred Spraul wrote:
> AMD recommends to perform memory copies with backward read operations
> instead of prefetch.
>
> http://208.15.46.63/events/gdc2002.htm
>
> Attached is a test app that compares several memory copy
> implementations. Could you run it and report the results to me,
> together with cpu, chipset and memory type?
>
> Please run 2 or 3 times.

There are the couple of wrinkles:

        __asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );
Wrong. Parameter is output. Remove one ':', replace "m" -> "=m".

        __asm__ __volatile__ (
                " femms\n" : :
        );
What for? frstor will nuke out MMX state anyway.

static void fast_copy_page(void *to, void *from)
has two fsaves and no frstor ;)

"run three times" - can program do that on its own and find minimum?

I modified your test to be able to run it on Celeron.
(#defined out femms, replaced prefetch -> prefetchnta). Results are below.

I think it is impossible to make Best for all CPUs (tm) copy
function, we will newer know... maybe Hammer will do fastest copies
by rep movsb?

Btw, I used Arjan's program too, attaching my version...
Your method is indeed faster (see npf_copy.c).

We should avoid doing the same thing again and again...
There are several block ops in the kernel (memcpys, 
csum_copy routines (see my other post)), can we
coordinate efforts to speed them up too?

FWIW, here's my results (Celeron 1200):
# ./a.out
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
copy_page() tests
copy_page function 'warm up run'         took 42394 cycles per page
copy_page function '2.4 non MMX'         took 41923 cycles per page
copy_page function '2.4 MMX fallback'    took 41903 cycles per page
copy_page function '2.4 MMX version'     took 43036 cycles per page
copy_page function 'faster_copy'         took 28337 cycles per page
copy_page function 'even_faster'         took 24632 cycles per page
copy_page function 'no_prefetch'         took 23087 cycles per page
# ./a.out
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
copy_page() tests
copy_page function 'warm up run'         took 45152 cycles per page
copy_page function '2.4 non MMX'         took 44443 cycles per page
copy_page function '2.4 MMX fallback'    took 45530 cycles per page
copy_page function '2.4 MMX version'     took 45441 cycles per page
copy_page function 'faster_copy'         took 29266 cycles per page
copy_page function 'even_faster'         took 25849 cycles per page
copy_page function 'no_prefetch'         took 24014 cycles per page
# ./a.out
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
copy_page() tests
copy_page function 'warm up run'         took 45850 cycles per page
copy_page function '2.4 non MMX'         took 44603 cycles per page
copy_page function '2.4 MMX fallback'    took 45631 cycles per page
copy_page function '2.4 MMX version'     took 57267 cycles per page
copy_page function 'faster_copy'         took 29628 cycles per page
copy_page function 'even_faster'         took 25989 cycles per page
copy_page function 'no_prefetch'         took 23987 cycles per page

--------------Boundary-00=_9KHJT6C61YQ5FO7ROGDJ
Content-Type: application/x-bzip2;
  name="timing_clear_copy.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="timing_clear_copy.tar.bz2"

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
UJDbbHAb

--------------Boundary-00=_9KHJT6C61YQ5FO7ROGDJ--
