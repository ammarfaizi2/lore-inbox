Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSKBUlm>; Sat, 2 Nov 2002 15:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbSKBUlm>; Sat, 2 Nov 2002 15:41:42 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:57649 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261409AbSKBUlj>; Sat, 2 Nov 2002 15:41:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Stas Sergeev <stssppnn@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Larger IO bitmap?
Date: Sat, 2 Nov 2002 22:48:11 +0100
User-Agent: KMail/1.4.3
References: <3DC417A4.2000903@yahoo.com>
In-Reply-To: <3DC417A4.2000903@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211022248.11869.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Increasing the IO bitmap size has huge effects on your Task State Segment 
size. It sure is possible to increase that size, but be aware that this means 
you are using megabytes for your TSS's only !

Of course, with current memory sizes, some might say "why bother", but IMHO it 
is still a very good reason not to do it. The Embedded guys will sure agree 
with me. 

Running iopl(3) isn't that bad, as long as your code knows what it is doing... 
Ioperm is only needed for virtual 8086 mode (aka DOS emulation mode) and is 
nice for buggy code. (If you don't trust your own programming skills and 
think you might pass wrong parameters to outb() ) 

You need root privileges for both iopl and ioperm requests, so that is no 
argument eighter. The fact your software runs setuid root automatically means 
you trust the software.

With this in mind, dosemu is the only reason why the bitmap should be 
extended. (virtual 86 mode uses the bitmap to emulate io access when needed). 
In my humble opinion, dosemu is not important enough to make TSS's huge 
bloated things by default.

The advantage for XFree would be that it needs to call ioperm() a thousand 
times instead of calling iopl() once. That sure is an advantage in my eyes... 

Well... it might be an option in the kernel on x86 systems: [ ] bloat kernel 
memory usage with huge TSS's, but I really thing this should not be the 
default way to go.

Jos

On Saturday 02 November 2002 19:21, Stas Sergeev wrote:
> Hello.
>
> I was trying to add some VESA support to
> dosemu and found that on my Radeon7500
> card it requires an access to the ports
> from range 0x9800-0x98ff. As ioperm()
> doesn't allow to open such a ports, I've
> got a very slow graphics.
> What happens is this:
> IO attempt->GPF->return_to_dosemu->
> decode insn->change uid->change IOPL->
> do IO->change IOPL->change uid->
> back_to_DOS_execution.
> You may guess how slow it is, but if I
> say that it is as slow as the simple
> screen redraw takes up to a minute, that
> may still be a surprise:)
>
> My question is: why do we still have a
> 128-bit IO bitmap? Is it possible to have
> the full 8K IO bitmap per process under
> Linux? And if yes, then why not yet?
> (Note: I am using the latest 2.4 kernels
> and I don't know if there is something
> changed in 2.5 about that problem. If
> something is changed, then sorry for wasting
> your time).
>
> I think that could be an advantage also for
> X. I think currently X works around the
> problem by keeping IOPL==3 all the run,
> but that can't work for dosemu.
>
> I've found several discussions on that
> topic, but they all ended unconclusively
> (too difficult, too expensive, useless etc).
> But as the last discussion I've found was
> dated 1998, I think it is time to reiterate:)
>
> Can anyone please suggest what must be done
> in order to enlarge the thing? The obvious
> way of increasing IO_BITMAP_SIZE constant
> doesn't do the trick.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


