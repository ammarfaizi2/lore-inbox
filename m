Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbUKPVwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbUKPVwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUKPVuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:50:08 -0500
Received: from alog0146.analogic.com ([208.224.220.161]:18560 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261841AbUKPVtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:49:13 -0500
Date: Tue, 16 Nov 2004 16:49:05 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: A M <alim1993@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing program counter registers from within C or Aseembler.
In-Reply-To: <20041116212015.32217.qmail@web51901.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0411161625540.2050@chaos.analogic.com>
References: <20041116212015.32217.qmail@web51901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, A M wrote:

> Hello,
>
> Does anybody know how to access the address of the
> current executing instruction in C while the program
> is executing?
>

Sure. Any interrupt saves the return address. It can
be thus inspected. The debugger uses a software interrupt
to do the same thing. The offset of the current instruction
is in EIP for ix86 machines. The problem is that if you
execute code to get that EIP, you end up getting the EIP
of the code that reads the EIP (not too useful). Therefore,
you need to use an interrupt.

> Also, is there a method to load a program image from
> memory not a file (an exec that works with a memory
> address)? Mainly I am looking for a method that brings
> a program image into memory modify parts of it and
> start the in-memory modified version.
>

extern char buffer[];

Make some code to load code into that buffer.

int (*funct)(void) = buffer;

Initialize a pointer to that buffer, then call it.

Note, code needs to be relocatable. If you don't know
what that means, don't do this at home.

In principle, the code is supposed to be loaded into the
.text segment. You can make a text-segment buffer using
assembly

.section	.text
buffer:		.long	0
.global	buffer
.type	buffer,@function
.org	. + 0x1000
end:
.size	buffer,.-buffer
.end


> Can anybody think of a method to replace a thread
> image without replacing the whole process image?
>
> Thanks,
>
> Ali
>

Just overwrite the code...

funct()
{


}
next()
{

}


main()
{
     len = (funct - next);
     memcpy(funct, new_code, len);
     funct();
}


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
