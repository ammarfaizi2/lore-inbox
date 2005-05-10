Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVEJOHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVEJOHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 10:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVEJOHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 10:07:33 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:36034 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261656AbVEJOHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 10:07:22 -0400
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: Colin Leroy <colin@colino.net>
Subject: Re: [linux-usb-devel] [2.6.12-rc4] network wlan connection goes down
Date: Tue, 10 May 2005 07:07:13 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050509162454.1c1c09a9@colin.toulouse> <200505090812.49090.david-b@pacbell.net> <20050510104349.7aca4227@colin.toulouse>
In-Reply-To: <20050510104349.7aca4227@colin.toulouse>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505100707.13356.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 May 2005 1:43 am, Colin Leroy wrote:
> On Mon, 9 May 2005 08:12:48 -0700
> David Brownell <david-b@pacbell.net> wrote:
> 
> > However, if you enable CONFIG_USB_DEBUG and send the "async" and
> > "registers" files from the relevant /sys/class/usb_host/usbN
> > directory, it should be easy to tell whether there's an issue at that
> > particular level.
> 
> ok, I reproduced it. I've put in place a crontab that checks if my
> router is pingable, and if not, dumps async and registers, resets the
> zd1201 (the iwconfig command is the one that puts it back into a
> functioning state), and dumps async and registers.

Hmm, well nothing looks wrong at the OHCI level.  It's possible that
the data toggle got screwed up somehow; there are devices where the
hardware doesn't reset it when it should.  If that's the case, there'd
likely be some rx or tx error (does "ifconfig" show any?  dmesg?) and
the wlan driver's recovery would need updating to ensure that the
various endpoints get properly reset given those quirks.

If you can report what the "iwconfig essid ..." command does down
at the USB level, that should help sort things out.  It's possible
that the network TX timeout mechanism might be a good place to kick
in some driver recovery scheme.  And it's not unknown that device
firmware cause problems!

It might also be good to check whether this is a case where packets
go out, but don't come back in; or vice versa.


> Here's the result:
> ... <snip> ...
> 
> The registers file changes while everything works, too. For example
> "BLF" isn't always present on the cmdstatus line.

BLF == "Bulk List Filled", basically it means the wlan
driver submitted a bulk URB and your printed the schedule
out before the hardware restarted its scan of that part
of the async schedule and cleared the bit.

What those dumps showed is just that there's an IN transfer
pending, with that WLAN driver polling the device to see
if there's a packet for your Linux host.  USB network links
do that more or less all the time the link is up.


> Also, I saw these lines in dmesg. Sadly enough they don't appear in
> syslog so I can't tell whether it happened at the same time the network
> went down.
> ohci_hcd 0001:10:1b.0: fminterval a7782edf
> ohci_hcd 0001:10:1b.0: fminterval a7782edf
> ohci_hcd 0001:10:1b.0: fminterval a7782edf
> ohci_hcd 0001:10:1b.0: fminterval a7782edf

Safe to ignore; there's some debug stuff that shouldn't
kick in when you "cat registers", but it does.

- Dave


> 
> Hope this helps,
> -- 
> Colin
> 
