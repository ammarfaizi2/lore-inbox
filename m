Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWBFU4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWBFU4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWBFU4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:56:55 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:41551 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S964824AbWBFU4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:56:54 -0500
In-Reply-To: <1139254711.10437.42.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0602061116190.11785-100000@gate.crashing.org> <1139250251.10437.39.camel@localhost.localdomain> <DC17879A-2B03-4D20-865F-C89386A393EF@kernel.crashing.org> <1139254711.10437.42.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <812D6543-5268-4D3E-93B0-12161D148120@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Revert serial 8250 console fixes
Date: Mon, 6 Feb 2006 14:56:46 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 6, 2006, at 1:38 PM, Alan Cox wrote:

> On Llu, 2006-02-06 at 13:14 -0600, Kumar Gala wrote:
>> Can you explain further why you had to change wait_for_xmitr() from
>> testing BOTH_EMPTY to UART_LSR_THRE.
>
> Because you want to wait for the uart to show that it is ready to  
> accept
> a character, not that the byte has been clocked out entirely. Thats
> essential for working with virtual serial ports on servers as they use
> the fact there is no pending character to work out how to packetize it
> as a TCP stream.
>
>
>> Also, what exactly would you be looking for in a register dump?
>
> When it gets stuck what state are the serial chip registers in and  
> where
> is the OS hanging ?

The following seems to make things better for me.  Can you take a  
look and let me know what you thing.  If it looks good, I'll send  
Russell a clean patch:

- kumar

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 179c1f0..b1fc97d 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2229,6 +2229,7 @@ serial8250_console_write(struct console
          *      and restore the IER
          */
         wait_for_xmitr(up, BOTH_EMPTY);
+       up->ier |= UART_IER_THRI;
         serial_out(up, UART_IER, ier | UART_IER_THRI);
}


