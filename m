Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271069AbTGPUsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271079AbTGPUrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:47:51 -0400
Received: from AMarseille-107-1-3-129.w80-11.abo.wanadoo.fr ([80.11.1.129]:16512
	"EHLO diablo") by vger.kernel.org with ESMTP id S271069AbTGPUqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:46:53 -0400
Message-ID: <3F15BE12.3000704@free.fr>
Date: Wed, 16 Jul 2003 23:05:22 +0200
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030704 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Oops report] (ppp/pppoatm)... explanation found !
References: <3F157830.8030402@free.fr> <3F15AF87.3000500@free.fr>
In-Reply-To: <3F15AF87.3000500@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally found an explanation for my problem : the debian hotplug 
script it not yet 2.6-aware and module-autoloading did't work any more 
on 2.6* kernels...
Launching pppd/pppoatm without the speedtouch kernel module causes the 
same oops also on 2.5.75-bk3.

My problem is now solved, but it remains that I really don't think that 
I should have gotten a kernel oops !

Steps to reproduce:

1) Put something like this in /etc/ppp/peers/bug (probably only the last 
two lines are necessary):

--------------------------
lock
persist
defaultroute
noipdefault
noauth
holdoff 4
maxfail 0
asyncmap 0
lcp-echo-interval  2
lcp-echo-failure   7
user "anonymous"

plugin /usr/lib/pppd/2.4.1/pppoatm.so
8.35
-------------------------

2) Do not load and/or remove any DSL+pppoatm kernel driver
3) pppd call bug

I really believe this is a kernel bug that should be fixed (and most 
probably a pppoatm one : I don't remember ever getting such an error 
when launching pppd with my pcmcia V90 modem disconnected), but from [1] 
it's not clear to me who is the pppoatm kernel maintainer these days : 
anybody knows to whom I should forward this bugreport ?

Best regards,

Vincent

[1] 
http://linux.bkbits.net:8080/linux-2.5/hist/net/atm/pppoatm.c?nav=index.html|src/|src/net|src/net/atm

Vince wrote:
> More information.
> Replying to myself... this oops :
> 
> - doesn't occur up to 2.5.75-bk3 / 2.5.75-mm1
> - also happens on 2.6.0-test1 :
> 
> -------------------------------------------------------------------
> Unable to handle kernel NULL pointer dereference at virtual address 
> 00000026
>  printing eip:
> c027014b
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c027014b>]    Not tainted
> EFLAGS: 00210206
> EIP is at __vcc_connect+0x2b/0x230
> eax: 0000000a   ebx: 00000000   ecx: 00000023   edx: c02e81bc
> esi: ce30d200   edi: 00000000   ebp: 00000023   esp: c8297e60
> ds: 007b   es: 007b   ss: 0068
> Process pppd (pid: 1097, threadinfo=c8296000 task=c8883880)
> Stack: 00000000 c0306a00 c8296000 00000000 cffcf1c0 ce30d200 c9106080
> c0270407
>        ce30d200 00000000 00000008 00000023 00200246 0008d200 c8296000
> cffcf1c0
>        c8297ee8 c9106080 c026d602 c9106080 00000000 00000008 00000023
> ffffffb3
> Call Trace:
>  [<c0270407>] vcc_connect+0xb7/0x1f0
>  [<c026d602>] pvc_bind+0xb2/0x150
>  [<c0212a75>] sys_connect+0x85/0xc0
>  [<c026d74f>] pvc_setsockopt+0x9f/0xf0
>  [<c0212f28>] sys_setsockopt+0x78/0xc0
>  [<c021360d>] sys_socketcall+0xcd/0x2a0
>  [<c0109087>] syscall_call+0x7/0xb
> -----------------------------------------------------------------------
> 

