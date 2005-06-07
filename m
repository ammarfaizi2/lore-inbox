Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVFGJIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVFGJIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 05:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVFGJIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 05:08:05 -0400
Received: from mail.mev.co.uk ([62.49.15.74]:28620 "EHLO mail.mev.co.uk")
	by vger.kernel.org with ESMTP id S261814AbVFGJHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 05:07:41 -0400
Message-ID: <42A563C2.5020500@mev.co.uk>
Date: Tue, 07 Jun 2005 10:07:14 +0100
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Leonard <ian@smallworld.cx>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: 2.4.30 - USB serial problem
References: <mailman.1117130162.21749.linux-kernel2news@redhat.com> <20050531184048.5ef9fd44.zaitcev@redhat.com> <429EC63F.5070804@smallworld.cx> <42A55AB6.2060001@smallworld.cx>
In-Reply-To: <42A55AB6.2060001@smallworld.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2005 09:07:17.0201 (UTC) FILETIME=[4D7C7C10:01C56B40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2005 09:28, Ian Leonard wrote:
> I finally got to the bottom of this problem (with Ian Abbotts help). I 
> had the wrong usb host module loaded, ubci not usb_uhci (in fact it was 
> compiled in to the kernel). The write call to the usbserial device was 
> blocking. This seemed to happen when a data packet of more than 8 bytes 
> was written.

It's actually a problem with queuing more than one bulk URB in the uhci 
driver.  (The TTY line discipline is probably splitting your single 
write into two or more writes, and the ftdi_sio driver queues an URB for 
each of these individual writes.)

> Having two drivers, one which works sometimes seems to be a bit of an 
> elephant trap.

The recommended advice (from David Brownell) seems to be to avoid 
queueing more than one bulk URB, though the "alternate" UHCI driver 
(uhci.o) seems to be the only one with this problem as far as I can tell.

I'll probably implement a different write implementation for the 
ftdi_sio driver to avoid the problem when I get a bit of free time.

> This was an error that occurred when I was preparing the new config 
> file. I would guess I left the usb as the default. It might me better to 
> have no defaults in the config, that way you are forced to make the 
> correct selection.
> 
> What is the recommended way of transferring .config files between kernel 
> versions? I see there are always a lot of changes. Can you safely just 
> copy the existing file and then run xconfig to include any new options?

Copy the previous .config across and run 'make oldconfig'.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-
