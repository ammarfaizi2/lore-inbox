Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQJ3QmD>; Mon, 30 Oct 2000 11:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129254AbQJ3Qlx>; Mon, 30 Oct 2000 11:41:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6404 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129092AbQJ3Qlc>; Mon, 30 Oct 2000 11:41:32 -0500
Date: Mon, 30 Oct 2000 11:27:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: John Levon <moz@compsoc.man.ac.uk>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.4.21.0010301605380.14174-100000@mrworry.compsoc.man.ac.uk>
Message-ID: <Pine.LNX.3.95.1001030111027.1186A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, John Levon wrote:

> On Mon, 30 Oct 2000, Richard B. Johnson wrote:
> 
> > 
> > Hello,
> > How much memory would it be reasonable for kmalloc() to be able
> > to allocate to a module?
> > 
> > Oct 30 10:48:31 chaos kernel: kmalloc: Size (524288) too large 
> > 
> > Using Version 2.2.17, I can't allocate more than 64k!  I need
> > to allocate at least 1/2 megabyte and preferably more (like 2 megabytes).
> > 
> > There are 256 megabytes of SDRAM available. I don't think it's
> > reasonable that a 1/2 megabyte allocation would fail, especially
> > since it's the first module being installed.
> > 
> > The attempt to allocate is memory of type GFP_KERNEL.
> 
> Why do you need physically-contiguous memory ? Can you not just use
> vmalloc()/vfree()
> 

Well, maybe there is a better way, but the following must happen:
I need a non-paged buffer that has already been allocated, so it is
available during an interrupt.

I get an interrupt, at which time I have to copy up to 4 megabytes
from a memory-mapped PCI window into this RAM. These data represent
a 'snap-shot' of the output of an ADC during the past ~20 us (yes
it's fast). Once I have copied the data, I can then re-enable
the ADC from within the ISR, i.e., allow the image data to change.

The ISR then executes wake_ip_interruptible() to notify a caller
sleeping in poll().

One the caller is awakened, he read()s the device and the data
are copied, using copy_to_user() into its buffers.

Now, I could set up a linked-list of buffers and use vmalloc()
if the buffers were allocated from non-paged RAM. I don't think
they are. These buffers must be present during an interrupt.

However, I could possibly use kmalloc() to initialize a linked-list
so they don't have to be contiguous.

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
