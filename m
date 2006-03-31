Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWCaSLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWCaSLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWCaSLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:11:06 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:37307 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932185AbWCaSLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:11:05 -0500
From: David Brownell <david-b@pacbell.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: question on spi_bitbang
Date: Fri, 31 Mar 2006 10:11:00 -0800
User-Agent: KMail/1.7.1
Cc: spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org>
In-Reply-To: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311011.00981.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 9:31 am, Kumar Gala wrote:
> I'm looking at using spi_bitbang for a SPI driver and was trying to  
> understand were the right point is to handle MODE switches.
> 
> There are 4 function pointers provided for each mode.

That's if you are indeed "bit banging", or your controller is the
type that's basically a wrapper around a shift register:  each
txrx_word() function transfers (or bitbangs) a 1-32 bit word in
the relevant SPI mode (0-3).

There's also a higher level txrx_bufs() routine for buffer-at-a-time
access, better suited to DMA, FIFOs, and half-duplex hardware.


> My controller   
> HW has a mode register which allows setting clock polarity and clock  
> phase.  I assume what I want is in my chipselect() function is to set  
> my mode register and have the four function pointers set to the same  
> function.

I don't know how your particular hardware works, but if you have a
real SPI controller it would probably be more natural to have your
setup() function handle that mode register earlier, out of the main
transfer loop ... unless that mode register is shared among all
chipselects, in which case you'd use the setup_transfer() call for
that, inside the transfer loop.  (That call hasn't yet been merged
into the mainline kernel yet; it's in the MM tree.)

The chipselect() call should only affect the chipselect signal and,
when you're activating a chip, its initial clock polarity.  Though
if you're not using the latest from the MM tree, that's also your
hook for ensuring that the SPI mode is set up right.

- Dave

