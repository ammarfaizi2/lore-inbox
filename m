Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129892AbQJaOBC>; Tue, 31 Oct 2000 09:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130019AbQJaOAw>; Tue, 31 Oct 2000 09:00:52 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64004 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129892AbQJaOAk>; Tue, 31 Oct 2000 09:00:40 -0500
Date: Tue, 31 Oct 2000 08:59:53 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linux kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.4.21.0010311134590.23139-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.3.95.1001031084051.13415A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Rik van Riel wrote:

> On Tue, 31 Oct 2000, Ingo Oeser wrote:
> > On Mon, Oct 30, 2000 at 02:40:16PM -0200, Rik van Riel wrote:
> 
> > > If you write the defragmentation code for the VM, I'll
> > > be happy to bump up the limit a bit ...
> > 
> > Should become easier once we start doing physical page scannings.
> > 
> > We could record physical continous freeable areas on the fly
> > then. If someone asks for them later, we recheck whether they
> > still exists and free (inactive_clean) or remap (active or
> > inactive_dirty) the whole area, whether they are used or not. 
> > 
> > This could still be improved by using up smallest fit areas
> > first for kmalloc() based on these areas.
> 
> > Rik: What do you think about this (physical cont. area cache) for 2.5?
> 
> http://www.surriel.com/zone-alloc.html
> 
> cheers,
> 
> Rik
> --

Since Linux is starting to be used in many 'strange' non-desktop
environments, maybe it's time to provide a hook to reserve the
top N kilobytes of RAM for strange buffers. Like:

	append="..,reserve=2M".

Upon startup, a pointer, valid when using the kernel DS, could be
initialized to point to the beginning of this area. This is essentially
zero overhead for the kernel because it just points to one longword
greater than the RAM the kernel will use.

In the event that this is too much work, then an additional entry could
be made in the GDT to address this area, and the resulting segment
number could be included in a kernel header file. To access it, code
would do:

	push	ds
	movl	$RESERVE_MEM, %eax
	movl	%eax,ds
	.....
	DS:[0] now points to its beginning.
	pop	ds

This 'free' area could be used for all kinds of stuff including helping
to relocate/debug come complex things.

The cost to performance is zero. A GDT entry on Intel is 8 bytes.


Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
