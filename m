Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbTCJLzB>; Mon, 10 Mar 2003 06:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbTCJLzB>; Mon, 10 Mar 2003 06:55:01 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:41739 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261301AbTCJLzA>;
	Mon, 10 Mar 2003 06:55:00 -0500
Date: Mon, 10 Mar 2003 13:05:34 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
Message-ID: <20030310120534.GA4125@win.tue.nl>
References: <20030309135402.GB32107@suse.de> <20030309171314.GA3783@win.tue.nl> <20030309203359.GA7276@suse.de> <20030309195555.A22226@infradead.org> <20030309203144.GA3814@win.tue.nl> <Pine.LNX.4.44.0303092310470.32518-100000@serv> <20030309230824.GA3842@win.tue.nl> <Pine.LNX.4.44.0303101100250.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303101100250.5042-100000@serv>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 11:58:17AM +0100, Roman Zippel wrote:

> > -       error = register_chrdev(driver->major, driver->name, &tty_fops);
> > +       error = register_chrdev_region(driver->major, driver->minor_start,
> > +                                      driver->num, driver->name, &tty_fops);
> 
> Are that much parameters really needed?

Yes.

If you want to follow Al you would write
	MKDEV(driver->major, driver->minor_start)
instead of this
	driver->major, driver->minor_start
and you would have one parameter less.

Andries


[I wrote Al and wanted to cc l-k but typoed. Let me copy this letter
for information purposes and to show that we do not want to write MKDEV.]

-------------------------------------------------------------------------
Some more comments on types and their structure.

As you know very well, I had a setup in the ancient times
with a kdev_t that was a pointer, and

#define MINOR(dev)      (dev)->minor

That was nice and well - you thought that a refcount
was needed, I thought that with the given rules for use
it was possible to prove that no refcount was needed,
and the discussion was never settled.
If we ever meet FTF we can fight that fight.

In the below I will use kdev_t again, but now with an
entirely different meaning, not a pointer but an
arithmetic type.

User space (programs, file systems) has many dev_t
instances that must remain valid. So, when dev_t
changes size the 16-bit values must keep their old
major and minor. This means that for a dev_t the
operations MINOR, MAJOR, MKDEV are not completely trivial.
They involve tests on whether the value fits into 16 bits.
E.g.

#define MKDEV(ma,mi)   ((dev_t)(((((ma) & ~0xff) == 0) && (((mi) & ~0xff) == 0
)) ? (((ma) << 8) | (mi)) : (((ma) << DEV_MINOR_BITS) | (mi))))

This is fine for communication with user space, but inside
the kernel itself we like something that is smaller and faster,
like

#define __mkdev(major, minor)  (((major) << KDEV_MINOR_BITS) + (minor))

So inside the kernel we must use kdev_t where user space
uses dev_t. Now both are arithmetic, but the bits are packed
differently.

Now you understand why I would like to remove the MKDEV
that you have in every call of blk_register_region.

Andries

