Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbTIYTGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTIYTGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:06:09 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:44284 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261964AbTIYTFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:05:53 -0400
Message-ID: <3F733DF1.7010008@pacbell.net>
Date: Thu, 25 Sep 2003 12:11:45 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Milton Miller <miltonm@bga.com>, linux-kernel@vger.kernel.org
Subject: Re: USB problem. 'irq 9: nobody cared!'
References: <200309242257.h8OMvR5d090443@sullivan.realtime.net> <20030925042326.GA6751@washoe.rutgers.edu> <20030925180020.GB28876@kroah.com>
In-Reply-To: <20030925180020.GB28876@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------020307050304030901050106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020307050304030901050106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Thu, Sep 25, 2003 at 12:23:26AM -0400, Yaroslav Halchenko wrote:
> 
>>Nop - it didn't help  :-(
>>
>>http://onerussian.com/Linux/bug.USB2/dmesg
>>
>>which else usefull information I can provide?
> 
> 
> David, can you try to fix this up.  It all started with your uhci
> patch...

I have tried, two or three times now ...

The problem is that nobody has ever reported back with results from
testing any updated patch (see attachment, the guts of this being
from Alan Stern).  Sort of makes trying be a moot point ... :)

It's OK with me if you just revert the patch that adds a uhci_reset()
entry, but based on what I saw with EHCI and OHCI that'll just turn
up a different set of problems with certain BIOS configurations (none
of which I have) ... which will need to be fixed by having a UHCI
reset sequence that works correctly from _all_ initial states.

- Dave



--------------020307050304030901050106
Content-Type: text/plain;
 name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Diff"

--- 1.44/drivers/usb/host/uhci-hcd.c	Fri Jul 18 06:22:32 2003
+++ edited/drivers/usb/host/uhci-hcd.c	Fri Sep 19 12:23:54 2003
@@ -1960,8 +1960,9 @@
 {
 	unsigned int io_addr = uhci->io_addr;
 
-	/* Global reset for 50ms */
+	/* Global reset for 50ms, and don't interrupt me */
 	uhci->state = UHCI_RESET;
+	outw(0, io_addr + USBINTR);
 	outw(USBCMD_GRESET, io_addr + USBCMD);
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout((HZ*50+999) / 1000);
@@ -2187,6 +2188,7 @@
 	/* Maybe kick BIOS off this hardware.  Then reset, so we won't get
 	 * interrupts from any previous setup.
 	 */
+	outw(0, uhci->io_addr + USBINTR);
 	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
 	reset_hc(uhci);
 	return 0;

--------------020307050304030901050106--

