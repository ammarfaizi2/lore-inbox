Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUCaHZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 02:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUCaHZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 02:25:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29962 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261780AbUCaHZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 02:25:20 -0500
Date: Wed, 31 Mar 2004 08:25:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm1
Message-ID: <20040331082514.A27804@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20040330023437.72bb5192.akpm@osdl.org> <20040331000301.GB9269@kroah.com> <20040330162850.50a0fad4.akpm@osdl.org> <20040330182627.0e43f1ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040330182627.0e43f1ae.akpm@osdl.org>; from akpm@osdl.org on Tue, Mar 30, 2004 at 06:26:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 06:26:27PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > I'm thinking that this can be fixed from the other direction: just before
> >  release_dev() calls close (dropping BKL), if tty->count==1, make the
> >  going-away tty ineligible for concurrent lookups.  Do that by setting
> >  tty->driver->ttys[idx] to NULL.  Maybe.
> 
> Famous last word: Volia!

I suspect you may just be able to get away with this for serial drivers
using serial_core.  However, I suspect it'll break non-serial_core using
serial drivers.

The serial drivers track the tty count themselves, so that they know
when to do the final close processing (why you may ask - because of
the blocking for DCD in the open code.)  I wouldn't like to say what
would happen if ->open were called for a different tty structure for
the same port while ->close was in progress.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
