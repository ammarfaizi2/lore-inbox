Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbTLIHlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 02:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265651AbTLIHlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 02:41:05 -0500
Received: from terminus.zytor.com ([63.209.29.3]:42718 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265649AbTLIHk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 02:40:58 -0500
Message-ID: <3FD57C77.4000403@zytor.com>
Date: Mon, 08 Dec 2003 23:40:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jamie Lokier <jamie@shareable.org>, Nikita Danilov <Nikita@Namesys.COM>,
       Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
References: <200312081646.42191.arnd@arndb.de> <3FD4B9E6.9090902@zytor.com> <16340.49791.585097.389128@laputa.namesys.com> <3FD4C375.2060803@zytor.com> <20031209025952.GA26439@mail.shareable.org> <3FD53FC6.5080103@zytor.com> <20031209034935.GA26987@mail.shareable.org> <3FD55F9D.9070203@zytor.com> <Pine.LNX.4.58.0312082321470.18255@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312082321470.18255@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> And as far as I know, it won't. Newer gcc's will _require_ memory
> arguments to be lvalues (well, it will warn if they aren't), and will
> always turn them into addressables of that particular lvalue.
> 

Well, I get no warning from the following code, with gcc 3.2.2 and -W -Wall:

int foo(int x)
{
   int y, z, w;

   asm("movl %1,%0" : "=r" (y) : "r" (x));
   asm("movl %1,%0" : "=r" (z) : "m" (y+1));
   asm("movl %1,%0" : "=r" (w) : "m" (33));

   return z+w;
}

The memory operand is definitely not an lvalue.  gcc allocates a stack slot
for the y+1 value as a temporary automatic and passes it in.  The value 33
is put in the .rodata segment:

00000000 <foo>:
    0:   55                      push   %ebp
    1:   89 e5                   mov    %esp,%ebp
    3:   50                      push   %eax
    4:   8b 45 08                mov    0x8(%ebp),%eax
    7:   89 c0                   mov    %eax,%eax
    9:   40                      inc    %eax
    a:   89 45 fc                mov    %eax,0xfffffffc(%ebp)
    d:   8b 15 00 00 00 00       mov    0x0,%edx
                         f: R_386_32     .rodata.cst4
   13:   8b 45 fc                mov    0xfffffffc(%ebp),%eax
   16:   01 d0                   add    %edx,%eax
   18:   c9                      leave
   19:   c3                      ret

> This is actually an issue, because some asm code depends on getting the
> proper address - not just the proper value. Things like locks etc care
> _deeply_ about more than just the value.

That would be a very bad thing indeed.  Fortunately I think it would take
some rather odd contortions on the part of the compiler for that situation
to occur at all, I would think, and if the gcc people have since been
made aware of it it should be pretty easy for them to make sure it will not
happen.

	-hpa

