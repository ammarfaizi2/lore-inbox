Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSD3TmC>; Tue, 30 Apr 2002 15:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315185AbSD3TmB>; Tue, 30 Apr 2002 15:42:01 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:44739 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315182AbSD3Tl6>; Tue, 30 Apr 2002 15:41:58 -0400
Date: Tue, 30 Apr 2002 14:41:56 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: =?ISO-8859-1?Q?Jos=E9?= Fonseca <j_r_fonseca@yahoo.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to write portable MMIO code?
In-Reply-To: <20020430190110.GA20294@localhost>
Message-ID: <Pine.LNX.4.44.0204301428480.32217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2002, José Fonseca wrote:

> Unfortunately one of the problems occurs in a idle wait loop, when a 
> register is being sucessively read.

Hmmh, suppose you have different problem (most likely elsewhere) then.

> And if so, how the wmb() example in "Linux Device Drivers" 
> (http://www.xml.com/ldd/chapter/book/ch08.html#t1) can be explained? The 
> "Bus-Independent Device Accesses" 
> (http://www.kernelnewbies.org/documents/kdoc/deviceiobook/x44.html) also 
> refers what you suggested, but it also mentions the use of memory 
> barriers. So how and when should they be used?

Well, my understanding is the following: (if I get something wrong, 
hopefully somebody who's reading this will correct me)

the barrier(), {,r,w}mb() stuff is for actually for normal memory 
accesses.

About barrier():

If you have

	*p1 = 1; *p2 = 2;

the compiler may decide to reorder this to (if it knows that p1 != p2)

	*p2 = 2; *p1 = 1;

A barrier() in between will inhibit this reordering.

For some archs, even the barrier() is not sufficient to serialize the
accesses to RAM. The compiler may generate something like

	mov [p1], 1
	mov [p2], 2

but on e.g. alpha (where the asm would look differently ;-), the processor
may decide to put the second instruction on the memory bus before the 
first one. Only an mb in between will guarantee the ordering on the
memory bus.

Now, for IO, basically the same holds, though I wouldn't want to guarantee 
that the macros designed for the memory bus would work on the PCI bus as 
expected.

However, I do *believe*, that the readl/writel functions implicitly do the
right thing and introduce barriers where needed. On x86 e.g., the macros
do a cast to (volatile *), which will ensure that these functions are
compiled without reordering. As x86 is strongly ordered, no additional
mb() or whatever is necessary (nor does it exist) to make sure that this
ordering will propagate to the PCI bus.

There's definitely people here who know that stuff better than I do, 
though.

--Kai


