Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262559AbSJGRGx>; Mon, 7 Oct 2002 13:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262556AbSJGRGx>; Mon, 7 Oct 2002 13:06:53 -0400
Received: from fusion.wineasy.se ([195.42.198.105]:34826 "HELO
	fusion.wineasy.se") by vger.kernel.org with SMTP id <S262559AbSJGRGO>;
	Mon, 7 Oct 2002 13:06:14 -0400
Date: Mon, 7 Oct 2002 19:11:41 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: Keith Owens <kaos@sgi.com>
Cc: Andreas Schuldei <andreas@schuldei.org>, linux-kernel@vger.kernel.org
Subject: Re: kdb against memory corruption?
Message-ID: <20021007171140.GD1102@lukas>
References: <20021006200801.GD1316@lukas> <10888.1033981406@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10888.1033981406@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Keith Owens (kaos@sgi.com) [021007 11:03]:

[... lots of good doc ...]

> I just ran some tests to make sure and kdb bph works as described
> above.  Things to watch out for :-
> 
>   bph is current cpu only, use bpha for all cpus.  Is your box SMP?

No, UP.

>   Address must be a multiple of the length.
> 
> It is easier to pick a single byte that you know is being changed and
> just watch that byte, with bpha <address> dataw 1.

yes, those criteria match.

Does it work for the memset way of setting stuff? does the
debuginterface catch this, too, for you?
<memset+14>: repz stos %al,%es:(%edi)

an other idea (by erikm) was that virutal and physical address
mode is mixed up. how do i find out which one is used by kdb and the
debug interface of the cpu? do i need to convert, somehow?

Or is something else wrong with what i do?


During bootup i am dumped into the debugger because my breakpoint funktion was reached:


TTY 7: ef8f8000
&FLIP.char_buf_ptr: ef8f8168
Instruction(i) breakpoint #0 at 0xc016d428 (adjusted)
0xc016d428 tty_kdb_bp:         int3

Entering kdb (current=0xef90c000, pid 28) due to Breakpoint @ 0xc016d428
kdb> md 0xef8f8168 1
0xef8f8168 ef8f8574 00000000 00000000 00000000   t..ï............
kdb> bpha 0xef8f8168 dataw 1
Forced Data Write BP #1 at 0xef8f8168
    is enabled in dr0 for 1 bytes globally
kdb> md 0xef8f8168 1
0xef8f8168 ef8f8574 00000000 00000000 00000000   t..ï............
kdb> go


And after bootup is complete, i press Ctrl-A and am dumped into the debugger:


Entering kdb (current=0xc02f6000, pid 0) due to Keyboard Entry
kdb> md 0xef8f8168 1
0xef8f8168 00000000 00000000 00000000 00000000   ................
kdb> bl
Instruction(i) BP #0 at 0xc016d428 (tty_kdb_bp)
    is enabled globally adjust 1
Forced Data Write BP #1 at 0xef8f8168
    is enabled in dr0 for 1 bytes globally
kdb>


so something overwrote the address, but i got no feedback on it.
