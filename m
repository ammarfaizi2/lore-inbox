Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265210AbRFVUbn>; Fri, 22 Jun 2001 16:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbRFVUbd>; Fri, 22 Jun 2001 16:31:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17917 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S265210AbRFVUb3>; Fri, 22 Jun 2001 16:31:29 -0400
Message-ID: <3B33AB06.A421381@mvista.com>
Date: Fri, 22 Jun 2001 13:31:02 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: signal dequeue ...
In-Reply-To: <XFMail.20010622115917.davidel@xmailserver.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On 22-Jun-2001 george anzinger wrote:
> > Davide Libenzi wrote:
> >>
> >> I'm just trying to figure out the reason why signal must be delivered one at
> >> a
> >> time instead of building a frame with multiple calls with only the last one
> >> chaining back to the kernel.
> >> All previous calls instead of calling the stub that jump back to the kernel
> >> will call a small stub like ( Ix86 ) :
> >>
> >> stkclean_stub:
> >>         add $frame_size, %esp
> >>         cmp %esp, $end_stubs
> >>         jae $sigreturn_stub
> >>         ret
> >> sigreturn_stub:
> >>         mov __NR_sigreturn, %eax
> >>         int $0x80
> >> end_stubs:
> >>
> >> ...
> >> | context1
> >> * $stkclean_stub
> >> * sigh1_eip
> >> | context0
> >> * $stkclean_stub
> >> * sigh0_eip
> >>
> >> When sigh0 return, it'll call stkclean_stub that will clean context0 and if
> >> we're at the end it'll call the jump-back-to-kernel stub, otherwise the
> >> it'll
> >> execute the  ret  the will call sigh1 handler ... and so on.
> >>
> > And if the user handler does a long_jmp?
> 
> But if the user handler does a long_jump even the old stub will be missed,
> isn't it ?

Right, but the remaining signals are still pending.  In your method, the
kernel doesn't know which were and which were not actually delivered.

George
