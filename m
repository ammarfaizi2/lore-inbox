Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312497AbSDDABl>; Wed, 3 Apr 2002 19:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312499AbSDDABb>; Wed, 3 Apr 2002 19:01:31 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:36877 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312497AbSDDABR>; Wed, 3 Apr 2002 19:01:17 -0500
Message-ID: <3CAB9756.C5F89C13@zip.com.au>
Date: Wed, 03 Apr 2002 15:59:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Denny Gudea <ekay@ecs.fullerton.edu>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 3c59x.c - kernel message explosion (fwd)
In-Reply-To: <Pine.GSO.4.33.0204031538340.19587-100000@titan.ecs.fullerton.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denny Gudea wrote:
> 
> Hi,
> 
> id like to thank you for maintaining this driver..
> 
> i have a 3com 3c905 and im using 3c59x.c driver to run it in my linux
> machine. it is connected to a hub on a network with 7 nodes. it seems like
> one of the hosts on my network has a duplex problem (as is described in
> vortex.txt). the problem i'm having is that the driver does a lot of
> kernel messages for this error even though my debug is set to the default.
> 
> i've looked at the code and the problem seems to be due to a small typo:
> this code segment begins at line 1826:
> ------------------------------------------------
>        if (status & TxComplete) {                      /* Really "TxError" for us. */
>                 tx_status = inb(ioaddr + TxStatus);
>                 /* Presumably a tx-timeout. We must merely re-enable. */
>                 if (vortex_debug > 2
>                         || (tx_status != 0x88 && vortex_debug > 0)) {
>                         printk(KERN_ERR "%s: Transmit error, Tx status register %2.2x.\n",
>                                    dev->name, tx_status);
>                         if (tx_status == 0x82) {
>                                 printk(KERN_ERR "Probably a duplex mismatch.  See "
>                                                 "Documentation/networking/vortex.txt\n");
>                         }
>                         dump_tx_ring(dev);
> -------------------------------------------------
> i believe the problem resides when it tests for the debug level:
> 
>                   if (vortex_debug > 2
>                         || (tx_status != 0x88 && vortex_debug > 0)) {

The code is OK, I think.  It says, in a rather tortured manner,
"if debug > 0 then print stuff, unless it is a max-collisions-exceeded
event" and "if debug > 2 then print all events".

Probably many of these driver messages should be throttled
by net_ratelimit() but in practice, things work out OK.

Your machine is a special case, because your network is
bust.  The default value of `debug' is 1.  If you set
it to zero, those messages should go away?

-
