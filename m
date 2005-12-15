Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbVLON2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbVLON2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbVLON2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:28:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56072 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965209AbVLON2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:28:53 -0500
Date: Thu, 15 Dec 2005 13:28:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <briglia.anderson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] [RFC] Add MMC password protection (lock/unlock) support
Message-ID: <20051215132847.GA6211@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <briglia.anderson@gmail.com>,
	linux-kernel@vger.kernel.org
References: <e55525570512140530u3601e325ha63b1db10209dbcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55525570512140530u3601e325ha63b1db10209dbcc@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 09:30:49AM -0400, Anderson Briglia wrote:
> @@ -69,12 +70,16 @@ struct mmc_card {
>  #define mmc_card_bad(c)		((c)->state & MMC_STATE_BAD)
>  #define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
>  #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
> +#define mmc_card_locked(c)	((c)->state & MMC_STATE_LOCKED)
> +
> +#define mmc_card_lockable(c)	((c)->csd.cmdclass & CCC_LOCK_CARD)

Looking at some of the MMC specs, this is not sufficient to tell whether
the card supports the lock/unlock commands - eg, the Sandisk cards have
a CCC value of 0x1ff but do not appear to support CMD42.

It would appear that there are different definitions for command
classes 6 to 8:

command group:		A				B
6			write write-protection		write protection
7			read write-protection		lock card
8			erase write-protection		app. specific

What the interpretation of whether A or B applies is unclear.
Type A cards have CSD structure 1 and MMC protocol version code 1.
Type B cards have CSD structure 2 and MMC protocol version code 3.

It would appear that the "CSD structure" field describes the version
of the CSD structure itself, and in part determines the validity
of the MMC protocol version field (maybe defining the mapping of
version codes to MMC spec versions).  Sandisk implies that CSD
structure 1 has version codes 0=v1.0-v1.2, 1=v1.4.

CSD structure 2 we have less idea about the interpretation of the
MMC protocol version codes, except that 3 may mean MMC spec v3.1.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
