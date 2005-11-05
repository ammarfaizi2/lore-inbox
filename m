Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVKEAyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVKEAyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVKEAyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:54:49 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:14417 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751367AbVKEAyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:54:49 -0500
From: David Brownell <david-b@pacbell.net>
To: stephen@streetfiresound.com
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
Date: Fri, 4 Nov 2005 16:54:46 -0800
User-Agent: KMail/1.7.1
Cc: eemike@gmail.com, Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200511031615.22630.david-b@pacbell.net> <200511041216.20301.david-b@pacbell.net> <1131147483.426.78.camel@localhost.localdomain>
In-Reply-To: <1131147483.426.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041654.47109.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 November 2005 3:38 pm, Stephen Street wrote:
> On Fri, 2005-11-04 at 12:16 -0800, David Brownell wrote:
> > I'd be confused.  They're both slave-specific ... and owned by
> > the master/controller driver.
> 
> I'm using the spi_board_info.platform_data to pass configuration
> information to the spi_device (slave) driver and
> spi_board_info.controller_data to pass SPI bus configuration for the
> specific slave device.  This allows different bus configurations for
> each attached SPI device.  

That's not what I thought we were talking about. Stepping back, what's
confusing is that there are three different kinds of per-device data,
and the names are used inconsistently:

  spi_device.dev.platform_data ... from board_info.platform_data
	This is for the driver of the spi_device ... board-specific
	data that'd be the same for PXA or OMAP or PPC805 or whatever

  spi_device.platform_data ... from board_info.controller_data
	This is static controller-specific information, which you were
	using for things like chipselect functions and fifo tuning.
	(I had proposed to name this as "controller_data" in the
	spi_device too.)
 
  spi_device.controller_data ... runtime state for the controller
	This is dynamic controller-specific information, which you
	were using for things like copies of register settings that
	set up clock speed and SPI mode for the device.
	(I had proposed to rename this as "controller_state".)

I don't know how much board_info.controller_data would be used by other
kinds of SPI controller (that is, not PXA), but it seems to me that could
also be stored in platform_data for the controller itself (if we wanted
to simplify things).



> IMHO the confusion is coming from the fact that struct spi_board_info is
> being used to pass related, but implementation dependent, configuration
> information to both the master and the slave simultaneously.  Maybe we
> are asking spi_board_info to carry to much information?

It'd probably be a lot simpler to get rid of board_info.controller_data
since that could just as easily be passed through the controller's own
platform_data ...


> > Instead, how about "controller_data" changing to match its role
> > in board_info (static info, not dynamic), and "platform_data"
> > becoming something like "controller_state"?  
> 
> If you mean spi_device.controller_data becomes
> spi_device.controller_state, yes!

Good.  We agree on one half of my proposal.  :)

Now as for board_info.controller_data and its clone in spi_device,
how about if I just delete that ... so that it'd be provided in the
platform_device.dev.platform_data for the controller?  That'd also
let you substitute a typed pointer for a void* one, usually a sign
of goodness.

- Dave

