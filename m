Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268916AbUIQSNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268916AbUIQSNk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 14:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268944AbUIQSNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 14:13:39 -0400
Received: from mail.aknet.ru ([217.67.122.194]:40722 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S268916AbUIQSNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 14:13:02 -0400
Message-ID: <414B2949.700@aknet.ru>
Date: Fri, 17 Sep 2004 22:13:29 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <4149D243.5050501@aknet.ru> <200409162203.17988.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409162203.17988.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Denis Vlasenko wrote:
>> Which means that the higher word of ESP gets
>> trashed. This bug beats dosemu rather badly,
>> but there seem to be not much info about that
>> bug available on the net.
> Well. Strictly speaking it's not a bug.
> Code executes as it should. IRET returns to the correct
> location. Upper 16 bits of ESP do not affect execution
> in this case.
Unfortunately this is not true. Mainly because
the code is still 32bit, so when is operates with
the stack pointer directly, it gets ESP, not SP.
Here are a few examples from the real DOS progs:
---
frstor  [esp]  <--crash
---
push    ebp
mov     ebp,esp
mov     edx,[ebp+0x8]  <--crash
---
and there are much more. "mov ebp,esp" is just a
standard thing, and then the ebp is being used to
access the locals and function arguments. Why do
they use the 16bit stack in that case, is another
question. Unfortunately some of them do.

> You want CPU to preserve upper bits,
> but this will waste a handful of transistors
> practically for no gain.
I don't think so. After all, if only the B bit is
set, this is being done. So I guess all the transistors
are in place (well, of course this is just a wild
guess).

> I think dosemu should just work around this.
I see no way to work around this in user-space.
Esp. since dosemu doesn't control the execution
completely, it acts as a monitor, only getting a
control when exceptions occur. For dosemu code
there are no problems, but the DOS program that
is running, crashes.

> Is there some subtle problem with that in dosemu?
Nothing subtle I think. The problem is real and
quite hurts. Fortunately it happened that using
the dos32a extender instead of dos4gw "fixes" it
for the dos4gw-based apps. But users wants
everything out of the box, and never read docs or
even the error messages in a log, so this doesn't
really help:) And there are some not dos4gw-based
progs that are affected either.

>> Why it was not fixed for so many years, looks
>> also like an interesting question, as for me.
> Because it does not matter for 99.9999% of users...
Aparently you are underestimating the amount of
the dosemu users out there:) AFAIK it is also a
problem for Win95 DOS box sometimes.

> # gcc -O2 stk.c
> # ./a.out
> sp=0xbffffb30, ss=0x7b
> In sighandler: esp=bffffb10
> Now sp=0xccf1fb10, ss=0x7f
> Esp changed, strange...
That's strange indeed! Apparently your ESP value,
0xccf1fb10, is greater than 0xc0000000, in which
case my program should just write "BUG!", but for
you it doesn't. Haven't you altered the code
somehow? Why I compare it with 0xc0000000, is
because ESP has the higher word of a kernel's stack
address, so it should be above the TASK_SIZE when
corrupted.

