Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTDUTXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTDUTXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:23:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53206 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261863AbTDUTXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:23:07 -0400
Date: Mon, 21 Apr 2003 20:35:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       "David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030421193510.GQ10374@parcelfarce.linux.theplanet.co.uk>
References: <20030421185806.GP10374@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0304211204440.9109-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304211204440.9109-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 12:05:32PM -0700, Linus Torvalds wrote:
> 
> On Mon, 21 Apr 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > Let's go for 32:32 internal and simply map upon mknod(2) and friends.
                                                             ^^^^^^^^^^^ ;-)
> stat() too.

stat() family, ustat(2), quota syscall, ioctls that pass device numbers,
/dev/raw, RAID, probably process accounting.

FWIW, I believe that you are overestimating the amount of internal code
that cares about device numbers.  Recent example: tty drivers.  99% of
references to tty->device were of form
	minor(tty->device)-tty->driver.start_minor.
Adding tty->index initialized to the above
	a) cleans the code up and kills a bunch of typos
	b) is obvious (albeit minor) optimization
	c) makes much more sense from the driver POV - "that's 5th of my
ttys" vs. "when somebody opens a device with dev_t equal to 5:69, they'll
get this tty".  The latter makes sense when we are opening that sucker -
at the same time when we decide which driver will handle it in the first
place.

If anything, I'd rather see code in char_dev.c give us a triple -
file_operations, pointer to whatever object driver wanted to associate
with this device number (tty_driver, in case of tty layer) and index.

We can do that easily (drivers/block/genhd.c has almost exactly what
we need), old drivers can still use minor() to their hearts' contest
and we can start killing a *lot* of ugly warts.  Old register_chrdev()
will work as usual - just tell the char_dev.c that everything with
that major should get a triple (file_operations, NULL, minor).  No
changes required....
