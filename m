Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRCTKwU>; Tue, 20 Mar 2001 05:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129529AbRCTKwB>; Tue, 20 Mar 2001 05:52:01 -0500
Received: from mx5.port.ru ([194.67.23.40]:61200 "EHLO mx5.port.ru")
	by vger.kernel.org with ESMTP id <S129511AbRCTKvs>;
	Tue, 20 Mar 2001 05:51:48 -0500
From: "Parity Error" <bootup@mail.ru>
To: "Jamie Lokier" <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: switch_to()/doesnt %esp get replaced with %ebp on ret
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 144.16.67.146 via proxy [202.141.1.20]
In-Reply-To: <20010319150425.D19104@pcep-jamie.cern.ch>
Reply-To: "Parity Error" <bootup@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E14fJjA-000Pf0-00@f6.mail.ru>
Date: Tue, 20 Mar 2001 13:51:00 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I dont know if you understood my doubt, but your pointer
to bp accidentally or otherwise solved the mystery. 

The problem was although switch_to changes esp to the
next processes stack, code emitted by the compiler, has
"cached" the 'prev' processes's esp via ebp, and uses this
at return to restore... So in effect, esp would again
get changed to prev's esp.

switch_to is a MACRO and saves ebp on stack and restores
it. The above ensures that the cached ebp is also changed
to the next's cached ebp, in some sense. I removed the
push %ebp , and pop %ebp from switch_to and ran and it
promptly crashed. But with -fomit-frame-pointer, all this
does not take place.

Still, could some one enlighten me on why esi and edi are
also similarly saved and restored ?

-----Original Message-----
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Parity Error <bootup@mail.ru>
Date: Mon, 19 Mar 2001 15:04:25 +0100
Subject: Re: switch_to()/doesnt %esp get replaced with %ebp on ret

=
=That's not nice code from the compiler (suboptimal), but it'll work.
=leal -24(%ebp),%esp is perfectly ok in the epilogue of a function.
=You're right that %esp is lost -- in this case, %ebp has effectively the
=same information.
=
=Think like this: a perfectly normal function (without switch_to) can
=have this:
=
=f: pushl %ebp
=   movl %esp,%ebp
=   pushl %ebx
=   ... do stuff, decrement %esp a lot to call functions etc. etc. ...
=   movl -4(%ebp),%esp
=   popl %ebx
=   popl %ebp
=   ret
=
=Parity Error wrote:
=> in schedule(), switch_to() macro changes esp to
=> the new process's stack. But, on exit frm schedule,
=> how come it does not get overwritten with  ebp-24,
=> as the dissasembled code shows. The code was compiled
=> without the -fomit-frame-pointer.
=> 
=>         pushl 508(%ecx)
=>         jmp __switch_to
=> 1:      popl %ebp
=>         popl %edi
=>         popl %esi
=> 
=>         jmp .L1180
=> 
=> .L1180: 
=> 	leal -24(%ebp),%esp
=>         popl %ebx
=>         popl %esi
=>         popl %edi
=>         movl %ebp,%esp
=>         popl %ebp
=>         ret
=
