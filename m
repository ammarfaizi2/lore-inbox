Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVA3SCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVA3SCL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVA3SCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:02:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50447 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261752AbVA3SCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:02:01 -0500
Date: Sun, 30 Jan 2005 18:01:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@davemloft.net>, Robert.Olsson@data.slu.se,
       akpm@osdl.org, torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050130180146.E25000@flint.arm.linux.org.uk>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	"David S. Miller" <davem@davemloft.net>, Robert.Olsson@data.slu.se,
	akpm@osdl.org, torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20050127004732.5d8e3f62.akpm@osdl.org> <16888.58622.376497.380197@robur.slu.se> <20050127164918.C3036@flint.arm.linux.org.uk> <20050127123326.2eafab35.davem@davemloft.net> <20050128001701.D22695@flint.arm.linux.org.uk> <20050127163444.1bfb673b.davem@davemloft.net> <20050128085858.B9486@flint.arm.linux.org.uk> <20050130132343.A25000@flint.arm.linux.org.uk> <41FD17FE.6050007@trash.net> <41FD18C5.6090108@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41FD18C5.6090108@trash.net>; from kaber@trash.net on Sun, Jan 30, 2005 at 06:26:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 06:26:29PM +0100, Patrick McHardy wrote:
> Patrick McHardy wrote:
> 
> > Russell King wrote:
> >
> >> I don't know if the code is using fragment lists in ip_fragment(), but
> >> on reading the code a question comes to mind: if we have a list of
> >> fragments, does each fragment skb have a valid (and refcounted) dst
> >> pointer before ip_fragment() does it's job?  If yes, then isn't the
> >> first ip_copy_metadata() in ip_fragment() going to overwrite this
> >> pointer without dropping the refcount?
> >>
> > Nice spotting. If conntrack isn't loaded defragmentation happens after
> > routing, so this is likely the cause.
> 
> OTOH, if conntrack isn't loaded forwarded packet are never defragmented,
> so frag_list should be empty. So probably false alarm, sorry.

I've just checked Phil's mails - both Phil and myself are using
netfilter on the troublesome boxen.

Also, since FragCreates is zero, and this does mean that the frag_list
is not empty in all cases so far where ip_fragment() has been called.
(Reading the code, if frag_list was empty, we'd have to create some
fragments, which increments the FragCreates statistic.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
