Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268524AbUJDVEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268524AbUJDVEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUJDVEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:04:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23562 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268524AbUJDVEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:04:23 -0400
Date: Mon, 4 Oct 2004 22:04:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] set membase in serial8250_request_port
Message-ID: <20041004220419.C21216@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Williamson <alex.williamson@hp.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1096916062.4510.20.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096916062.4510.20.camel@tdi>; from alex.williamson@hp.com on Mon, Oct 04, 2004 at 12:54:22PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 12:54:22PM -0600, Alex Williamson wrote:
> 
>    I'm running into a problem that seems to be caused by this really old
> changeset:
> 
> http://linux.bkbits.net:8080/linux-2.5/cset@3d9f67f2BWvXiLsZCFwD-8s_E9AN6A
> 
> When I run 'setserial /dev/ttyS1 uart 16450' on an ia64 system w/ MMIO
> UARTs, I get a NAT consumption oops from the kernel.  The problem is
> that this code path calls serial8250_release_port() where the membase
> gets cleared.  However, the subsequent call to serial8250_request_port()
> doesn't restore membase, causing a read from a bad address.  I don't see
> many users of the UPF_IOREMAP flag, so I think the solution is to simply
> make the remap case symmetric to the unmap case.  Patch below.  Thanks,

Mostly correct reasoning, but the solution is wrong.  Consider what
happens if we call request_port where we have set mapbase and pre-
initialised membase for a memory mapped port (eg, PCI card.)

This would cause us to re-ioremap the mapbase, which is wrong.  We
must obey the UPF_IOREMAP flag here.  Note also that this fix you're
reverting will break 8250 for PPC people...

Could you give further information about the problem you're seeing?
Bear in mind that I know precisely zero about ia64 oopsen so you'll
probably have to explain it to me in detail.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
