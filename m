Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbTDTHzK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 03:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTDTHzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 03:55:10 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:7143 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP id S263538AbTDTHzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 03:55:09 -0400
Message-ID: <3EA25595.9000001@csse.uwa.edu.au>
Date: Sun, 20 Apr 2003 16:08:53 +0800
From: David Glance <david@csse.uwa.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: fisaksen@bewan.com, Greg KH <greg@kroah.com>
Subject: Re: PATCH: usb-uhci: interrupt out with urb->interval 0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not subscribed to this list - please include me on the 
'cc' line.

Version: 2.4.21-pre6
Subsystem: USB
Driver: Lego USB Tower

Writing one-short interrupt out transfers without this patch 
cause the system to hang. Applying this patch fixes that 
(thankfully after fsck'ing my disk a dozen times!) - however 
the driver (which works still using usb-ohci on an ohci 
card) - doesn't work because the reads are  failing - 
returning a ETIMEDOUT.

I am assuming that the changes made (see below) - somehow 
have affected other aspects of one-shot interrupt in transfers?

Thanks

David


Frode wrote:

A recent change (2.4.21) in the usb-uhci driver calls
"uhci_clean_iso_step2" after the completion of one-shot 
(urb->interval
0) interrupt out transfers. This call clears the list of 
descriptors.
However, it crashes when trying to get the next desciptor in 
the "for"
loop in the "process_interrupt" function, since the list of 
descriptors
are already cleared. A simple change I did was to do a 
"break" to quit
the "for" loop for interrupt out transfers with urb->interval 0.

Thanks,
Frode

--- drivers/usb/usb-uhci.c.orig 2003-04-16 
15:39:04.000000000 +0200
+++ drivers/usb/usb-uhci.c 2003-04-16 15:39:56.000000000 +0200
@@ -2628,6 +2628,7 @@
                                   // correct toggle after 
unlink
                                   usb_dotoggle (urb->dev, 
usb_pipeendpoint (urb->pipe), usb_pipeout
(urb->pipe));
                                   clr_td_ioc(desc); // 
inactivate TD
+ break;
                           }
                   }
           }

