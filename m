Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSH0J0h>; Tue, 27 Aug 2002 05:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSH0J0h>; Tue, 27 Aug 2002 05:26:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48392 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315449AbSH0J0g>; Tue, 27 Aug 2002 05:26:36 -0400
Date: Tue, 27 Aug 2002 10:30:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Chua <jchua@fedex.com>
Cc: Erik Andersen <andersen@codepoet.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] initrd >24MB corruption (fwd)
Message-ID: <20020827103047.A13528@flint.arm.linux.org.uk>
References: <20020827025616.GA6998@codepoet.org> <Pine.LNX.4.44.0208271648040.26407-100000@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208271648040.26407-100000@boston.corp.fedex.com>; from jchua@fedex.com on Tue, Aug 27, 2002 at 04:55:00PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 04:55:00PM +0800, Jeff Chua wrote:
> On Mon, 26 Aug 2002, Erik Andersen wrote:
> > How much total ram does your system have?
> 
> 640MB.

Its not that problem then. 8)

I was suspecting that the write() to the ramdisk device was hanging
(which you could confirm by printk'ing an 'i' before and an 'o' after
the write call in flush_window() in init/do_mounts.c or
drivers/block/rd.c.  If you end up with 'i' as the last character, its
the write that hangs, if its an 'o' then its gunzip itself.)

The other possibility is this little critter:

static int __init fill_inbuf(void)
{
        if (exit_code) return -1;

        insize = read(crd_infd, inbuf, INBUFSIZ);
        if (insize == 0) return -1;

        inptr = 1;

        return inbuf[0];
}

You could put printks in the paths that return -1 and see if you're
hitting any of those.

However, returning '-1' is asking for trouble.  When I was looking at
how to handle the "out of space" in the ramdisk issue, I found that
there appears to be NO value that fill_inbuf() can return that will
guarantee to terminate inflate.c at an arbitary point in the
decompression.

In gzip, we abort the program on error.  In the kernel, we don't
have that luxury.  (Luckily initramfs uses a cut-down gzip to do
the decompression, which can exit on error.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

