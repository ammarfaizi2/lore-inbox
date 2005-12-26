Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVLZTNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVLZTNP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVLZTNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:13:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3600 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932109AbVLZTNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:13:13 -0500
Date: Mon, 26 Dec 2005 19:13:07 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][MMC] Buggy cards need to leave programming state
Message-ID: <20051226191307.GA17191@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <43AFEDF8.2060404@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43AFEDF8.2060404@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2005 at 02:19:52PM +0100, Pierre Ossman wrote:
> I've gotten two reports for cards that just crap out during write
> transfers. The solution I've given them is to make the mmc block layer
> wait for the card to leave programming state.

This is interesting.  In the specs I have, they indicate that the
correct behaviour of a MMC card for CMD24 (write block) is that
when its write buffer is full, it will hold the DAT signal low to
indicate "busy" to the host controller.

Now, the ARM MMCI holds the data path in the "BUSY" state while
the MMC card asserts this indication, so we don't complete the
data transfer until the card says it's not busy.

For PXAMCI, it looks like we aren't waiting for the indication
from the host which tells us that the "BUSY" has cleared.

Does wbsd wait for the DAT busy signal to de-assert?

However, I do note that from the October dump, the card is
reporting that it is ready for more data (bit 8):

MMC: req done (0d): 0: 00000f00 4b000000 00000000 00000000

whereas it's impossible to tell with the November dump because
the useful information has been edited out.  Hence the November
dump is rather useless.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
