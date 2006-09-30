Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWI3Ptz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWI3Ptz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 11:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWI3Ptz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 11:49:55 -0400
Received: from mx2.rowland.org ([192.131.102.7]:35089 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1751197AbWI3Pty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 11:49:54 -0400
Date: Sat, 30 Sep 2006 11:49:52 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Paolo Ornati <ornati@fastwebnet.it>
cc: Arkadiusz =?UTF-8?B?SmHFgm93aWVj?= <ajalowiec@interia.pl>,
       <linux-kernel@vger.kernel.org>, <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] PROBLEM: Kernel 2.6.x freeze
In-Reply-To: <20060930141455.29fdadef@localhost>
Message-ID: <Pine.LNX.4.44L0.0609301131190.7052-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006, Paolo Ornati wrote:

> This one should be correct:
> 
> 00000000 <str>:
>    0:   5c                      pop    %esp
>    1:   89 57 2c                mov    %edx,0x2c(%edi)
>    4:   8b 40 44                mov    0x44(%eax),%eax
>    7:   c7 47 40 00 00 00 00    movl   $0x0,0x40(%edi)
>    e:   89 47 3c                mov    %eax,0x3c(%edi)
>   11:   8b 45 00                mov    0x0(%ebp),%eax
>   14:   8b 55 04                mov    0x4(%ebp),%edx
>   17:   89 02                   mov    %eax,(%edx)
>   19:   89 50 04                mov    %edx,0x4(%eax)
>   1c:   89 6d 00                mov    %ebp,0x0(%ebp)
>   1f:   8d 47 18                lea    0x18(%edi),%eax
>   22:   89 6d 04                mov    %ebp,0x4(%ebp)
>   25:   39 47 18                cmp    %eax,0x18(%edi)
>   28:   75 4b                   jne    75 <main+0x75>
>   2a:   0f b6 47 50             movzbl 0x50(%edi),%eax
             ||
             ---> _This_ is where the crash occurred.

>   2e:   a8 02                   test   $0x2,%al
>   30:   88 44 24 08             mov    %al,0x8(%esp)
>   34:   74 3f                   je     75 <main+0x75>
>   36:   0f b6 46 20             movzbl 0x20(%esi),%eax   <----- crash!
             ||
             ---> Not here.

>   3a:   8b 4e 20                mov    0x20(%esi),%ecx
>   3d:   ba                      .byte 0xba
>   3e:   fe                      (bad)
>   3f:   ff                      .byte 0xff

The actual last instruction looks like this:

>   3d:   ba fe ff ff ff          mov    $0xfffffffe,%edx

> So now the problem is, as you pointed out, to discover why EIP is
> pointing to "b6" intead of "0f".

Another problem: The oops message shows that edi = 0.  So there should
have been an addressing exception in the line at offset 25, assuming the
CPU ran straight through this code.

Comparing the disassembly to the source code shows the instruction that
crashed was in this part of drivers/usb/host/uhci-q.c:uhci_giveback_urb()

	/* Take the URB off the QH's queue.  If the queue is now empty,
	 * this is a perfect time for a toggle fixup. */
	list_del_init(&urbp->node);
	if (list_empty(&qh->queue) && qh->needs_fixup) {

It was the fetch of qh->needs_fixup, which is a bitfield.

The alternative is that something caused a jump directly to the byte at 
2b.  Maybe a return address got corrupted on the stack; obviously there 
aren't any direct jumps to that location.  I don't have a clue how to 
track this any further.

We can rule out the possibility that the kernel's object code was
corrupted.  The dump in the oops message agrees exactly with the objdump
output.

The simplest answer is that Arkadiusz's CPU is a little flakey.  But 
that would be too easy.

Alan Stern

