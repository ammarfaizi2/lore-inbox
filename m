Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272389AbTHFUaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272404AbTHFUaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:30:13 -0400
Received: from ida.rowland.org ([192.131.102.52]:26116 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S272389AbTHFUaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:30:04 -0400
Date: Wed, 6 Aug 2003 16:30:02 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Peter Denison <lkml@marshadder.uklinux.net>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.4.21 USB printer failure w/ HP PSC750
In-Reply-To: <Pine.LNX.4.44.0308061955440.1069-100000@marshall.localnet>
Message-ID: <Pine.LNX.4.44L0.0308061619120.1249-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, Peter Denison wrote:

> Having just upgraded to 2.4.21, the first time I tried to print, the
> following happened. The printer started to print, but gave up after a
> while and spat out just about 1" of image. Needless to say, it all worked
> fine under 2.4.20.
> 
> Intel 82801BA based MB, running stock 2.4.21 (compiled with gcc 3.3.1)
> with uhci driver (all on Debian testing)
> 
> This debugging code was introduced during 2.4.20->2.4.21, but I'm afraid I
> don't know what the significance of it is. (Happens when td->dma_handle !=
> (qh->element & ~UHCI_PTR_BITS) )
> 
> Can anyone tell me what's going on? I am happy to provide more information
> as necessary.

I can't tell you what's going on, but I can explain the debugging 
messages.

> kernel:  Element != First TD

That's not an error; it's just alerting you to the fact that the transfer 
being shown has already begun.

> kernel:   12: [d66d9240] link (166d9270) e3 SPD Length=3f MaxLen=3f DT0 EndPt=1
>  Dev=2, PID=e1(OUT) (buf=15f5c300)

Each of these guys is a packet (the data is split up into 64-byte packets) 
that has been transferred to the printer successfully.

> kernel:   13: [d66d9270] link (166d92a0) e0 SPD Stalled CRC/Timeo Length=3f
>  MaxLen=3f DT1 EndPt=1 Dev=2, PID=e1(OUT) (buf=15f5c340)

This is the trouble spot.  It's a packet that failed 3 times because the
printer did not respond within the timeout period or because noise in the
cable prevented the response from being received.

> kernel:   14: [d66d92a0] link (166d92d0) e3 SPD Active Length=0 MaxLen=3f DT0
>  EndPt=1 Dev=2, PID=e1(OUT) (buf=15f5c380)

These are additional packets that haven't been sent because the transfer 
was aborted when the trouble occurred above.

> kernel: printer.c: usblp0: nonzero read/write bulk status received: -110

-110 is the code for a timeout error.

> Aug  6 18:46:16 kernel: [d7b0b0c0] link (17b0b062) element (166d9030)
> kernel:  Element != First TD
> kernel:   0: [d66d9000] link (166d9030) e3 Length=7 MaxLen=7 DT0 EndPt=0 Dev=2,
>  PID=2d(SETUP) (buf=161364e0)
> kernel:   1: [d66d9030] link (166d9060) e0 SPD Stalled CRC/Timeo Length=7ff
>  MaxLen=0 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=167dbf67)
> kernel:   2: [d66d9060] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1
>  EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

This indicates more communications problems.  Have you checked that your
USB cable is okay?  Did you go back to 2.4.20 to see if that still works?

Alan Stern

