Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262841AbSJ1KOI>; Mon, 28 Oct 2002 05:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262865AbSJ1KOI>; Mon, 28 Oct 2002 05:14:08 -0500
Received: from mail.cscoms.net ([202.183.255.13]:23055 "EHLO csmail.cscoms.com")
	by vger.kernel.org with ESMTP id <S262841AbSJ1KOH>;
	Mon, 28 Oct 2002 05:14:07 -0500
Date: Mon, 28 Oct 2002 17:19:56 +0700
From: Alain Fauconnet <alain@cscoms.net>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, lve@ns.aanet.ru
Subject: Re: UPD: Frequent/consistent panics in 2.4.19 at ip_route_input_slow, in_dev_get(dev)
Message-ID: <20021028171956.A14460@cscoms.net>
References: <20021021100207.E302@cscoms.net> <200210211640.UAA07235@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210211640.UAA07235@sex.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Mon, Oct 21, 2002 at 08:40:16PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 21, 2002 at 08:40:16PM +0400, kuznet@ms2.inr.ac.ru wrote:
> 
> Try better to enable slab poisoning in slab.h. If it that thing
> which I think of, it would provoke crash.
> 
> Alexey
> 

I have got a new crash on the same box with CONFIG_DEBUG_SLAB=y
(reminder: Kernel 2.4.19)

Unable to handle kernel paging request at  virtual address 5a5a5a5e

EIP : 0010:[<c02318a9>] <ip_route_input_slow+33>
EAX : 00000000   EBX : 5a5a5a5a   ECX : 9c515bec
EDX : 5a5a5a5a   ESI : ccb5b542   EDI : d71a10ac
EBP : c1aae690   ESP : c02f3e44

Process Swapper (pid: 0, stackpage = c02f3000)

Stack: 5a5a5a   ccb5b542   d71a10ac   c1aae690
(sorry, first stack word was written down incorrectly by operator, one
byte lost)

Call Trace:
[<c010980d>] <get_irq_list+137>
[<c0109a71>] <do_IRQ+133>
[<c02321ca>] <ip_route_input+338>
[<c02342e4>] <ip_rcv_finish+40>

(I find this stack trace strange. Once again I  haven't  written  this
down myself so I can't be sure it's 100% accurate)


Code : ff 42 04 b8 54 24 24 89 54 24 28 c7 44 24 20 00 00 00 00 c7

Still the same exact place in ip_route_input_slow:

(gdb) x/i 0xc02318a9
0xc02318a9 <ip_route_input_slow+33>:    incl   0x4(%edx)
0xc02318ac <ip_route_input_slow+36>:    mov    0x24(%esp,1),%edx
0xc02318b0 <ip_route_input_slow+40>:    mov    %edx,0x28(%esp,1)
0xc02318b4 <ip_route_input_slow+44>:    movl   $0x0,0x20(%esp,1)
0xc02318bc <ip_route_input_slow+52>:    movl   $0x0,0x38(%esp,1)
0xc02318c4 <ip_route_input_slow+60>:    movl   $0x0,0x34(%esp,1)

It looks to me that the value in DX is "poisoned" data isn't it?
I assume that the kernel is trying to use dynamic memory that has been
released already, right?

What's next in tracing this one down?

Thanks for any hint,
_Alain_

