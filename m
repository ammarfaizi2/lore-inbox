Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVA3QtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVA3QtT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 11:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVA3QtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 11:49:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16146 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261727AbVA3Qsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 11:48:54 -0500
Date: Sun, 30 Jan 2005 16:48:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       =?iso-8859-1?Q?Martin_K=F6gler?= <e9925248@student.tuwien.ac.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Deadlock in serial driver 2.6.x
Message-ID: <20050130164840.D25000@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@osdl.org>,
	=?iso-8859-1?Q?Martin_K=F6gler?= <e9925248@student.tuwien.ac.at>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050126132047.GA2713@stud4.tuwien.ac.at> <20050126231329.440fbcd8.akpm@osdl.org> <1106844084.14782.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1106844084.14782.45.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Sun, Jan 30, 2005 at 03:39:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 03:39:32PM +0000, Alan Cox wrote:
> On Iau, 2005-01-27 at 07:13, Andrew Morton wrote:
> > Martin Kögler <e9925248@student.tuwien.ac.at> wrote:
> > (For some reason the NMI watchdog isn't triggering here, and it's still
> > taking interrupts).
> 
> > Looks like low-latency mode is busted.
> 
> low latency mode is fine, the drivers/serial layer is busted. It workd
> fine with non drivers/serial using hardware still, and it worked fine in
> 2.4

Unfortunately it creates a major locking problem.  We need to hold the
spinlock because we're using the port structures and relying on things
like the tty structure staying around during the interrupt processing.

We call into the tty layer, and the tty layer calls us back via the
write method, (for echo purposes) and that's indistinguishable from
user-level or other kernel-level writes.

Unsolvable as the tty layer currently stands.  tty needs to not call back
into serial drivers when they supply read characters from their interrupt
functions.

tty layer's busted. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
