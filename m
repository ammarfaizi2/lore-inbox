Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTLIWad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 17:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTLIWad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 17:30:33 -0500
Received: from ns.int.pl ([212.106.140.230]:28943 "EHLO novacom.pl")
	by vger.kernel.org with ESMTP id S263434AbTLIWaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 17:30:30 -0500
Date: Tue, 9 Dec 2003 23:31:22 +0100
From: Rafal Skoczylas <nils@secprog.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.test11 bug
Message-ID: <20031209223122.GA16808@secprog.org>
Reply-To: Rafal Skoczylas <nils@secprog.org>
References: <20031208034631.GA14081@secprog.org> <Pine.LNX.4.58.0312072100250.13236@home.osdl.org> <20031208161742.GB9087@secprog.org> <Pine.LNX.4.58.0312080848560.13236@home.osdl.org> <Pine.LNX.4.58.0312080911470.13236@home.osdl.org> <20031209194827.GA22265@secprog.org> <Pine.LNX.4.58.0312091221440.21456@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312091221440.21456@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I am leaving most Linus' quotations so everyone could see what we were
talking about as I haven't CC'ed previous email to lkml nor have Linus ]

On Tue, Dec 09, 2003 at 12:31:15PM -0800, Linus Torvalds wrote:
> > First I had an impression like my ram has to be broken as the address is
> > the same in all but one, but how would it pass all those memtests
> > I performed 2 nights ago? And why is it allways the same call trace?
> 
> It's interesting - it looks like it's the
> 
> 	dentry = file->f_dentry;
> 
> thing, with "file" being NULL.
> 
> Can you do a "gdb vmlinux" and then do "x/20i __fput" for me, to show what
> your compiler is doing?
> 
> Oh, and do a "disassemble fput" too.
> 
> Because "file" really shouldn't be NULL there - and even if it was, we
> should have gotten an oops _earlier_, when we did the
> "atomic_dec_and_test()" on "file->f_count".

2.6.0-test11 -- no frame pointers
gcc (GCC) 3.3.2 (Shameless Linux)

GNU gdb 6.0
[...]
(gdb) x/20i __fput
0xc0155850 <__fput>:    push   %ebp
0xc0155851 <__fput+1>:  push   %edi
0xc0155852 <__fput+2>:  push   %esi
0xc0155853 <__fput+3>:  push   %ebx
0xc0155854 <__fput+4>:  mov    %eax,%ebx
0xc0155856 <__fput+6>:  sub    $0xc,%esp
0xc0155859 <__fput+9>:  mov    0xc(%ebx),%edi
0xc015585c <__fput+12>: mov    0x8(%eax),%eax
0xc015585f <__fput+15>: mov    %eax,0x8(%esp,1)
0xc0155863 <__fput+19>: mov    0x8(%eax),%ebp
0xc0155866 <__fput+22>: lea    0x78(%ebx),%eax
0xc0155869 <__fput+25>: cmp    %eax,0x78(%ebx)
0xc015586c <__fput+28>: jne    0xc0155963 <__fput+275>
0xc0155872 <__fput+34>: mov    %ebx,(%esp,1)
0xc0155875 <__fput+37>: call   0xc016ae50 <locks_remove_flock>
0xc015587a <__fput+42>: mov    0x10(%ebx),%eax
0xc015587d <__fput+45>: test   %eax,%eax
0xc015587f <__fput+47>: je     0xc015588c <__fput+60>
0xc0155881 <__fput+49>: mov    0x30(%eax),%esi
0xc0155884 <__fput+52>: test   %esi,%esi
(gdb) disassemble fput
Dump of assembler code for function fput:
0xc0155830 <fput+0>:    mov    %eax,%edx
0xc0155832 <fput+2>:    decl   0x14(%eax)
0xc0155835 <fput+5>:    sete   %al
0xc0155838 <fput+8>:    test   %al,%al
0xc015583a <fput+10>:   jne    0xc0155840 <fput+16>
0xc015583c <fput+12>:   nop
0xc015583d <fput+13>:   ret
0xc015583e <fput+14>:   mov    %esi,%esi
0xc0155840 <fput+16>:   mov    %edx,%eax
0xc0155842 <fput+18>:   jmp    0xc0155850 <__fput>
0xc0155847 <fput+23>:   mov    %esi,%esi
0xc0155849 <fput+25>:   lea    0x0(%edi,1),%edi
End of assembler dump.
(gdb)


> Hmm.. Maybe that is actually the "dentry->d_inode" access instead -
> although for me the inode field is at offset 12. But if you have an UP
> kernel, offset 8 might be the right one.. Anyway, a NULL inode is _also_ a
> bug at that point, so it's not as if that solves anything.
> 
> I wonder if there is a problem with gcc-3.3.2. Have you tried other
> compilers?

Not yet. Now I'm downloading 2.9x and will try with that one.

> Also, it might be interesting to hear if there is a difference if you
> compile with frame pointers off (or on, if they are now off).

Now they are off. I'll try turning on and if it won't get any better I'll
try with another compiler.
Anyway, while compiling with frame pointers I got another oops ;/
This one is different those we have seen so far:
http://secprog.org/who/rs/linux/2003-12-09b-linux-2.6.0-test11.txt

For those who haven't seen previous ones from today:
http://secprog.org/who/rs/linux/2003-12-09-linux-2.6.0-test11.txt

nils.
-- 
"Blessed is the man, who having nothing to say, abstains from giving wordy
evidence of the fact."  -- http://secprog.org/who/rs/quote.php?id=1
