Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262740AbTDAS4g>; Tue, 1 Apr 2003 13:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262741AbTDAS4g>; Tue, 1 Apr 2003 13:56:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:13781 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262740AbTDAS4b>; Tue, 1 Apr 2003 13:56:31 -0500
Date: Tue, 1 Apr 2003 11:08:48 -0800
From: Greg KH <greg@kroah.com>
To: Stephan Maciej <stephanm@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG, USB, visor] Reproduceable use-after-free with visor.c and pppd
Message-ID: <20030401190848.GB2627@kroah.com>
References: <200304012044.02940.stephanm@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304012044.02940.stephanm@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 08:44:02PM +0200, Stephan Maciej wrote:
> Hi all, Hi Greg,
> 
> I can reproduce errors of the "object was modified after freeing" kind when 
> connecting my Palm m505 to the internet as follows:
> 
> - Choose "Connect" in one of the Palm apps
> - Wait until I see "Meldet an" ("logs on") on the Palm
> - Run pppd as root:
> 	pppd /dev/usb/tts/1 debug local noauth ms-dns <blah> <foo>:<bar>
> - pppd initializes the connection -> connection is up and running (not too 
> long, see below)
> 
> My logs show (CONFIG_USB_DEBUG=y):
> 
> hub 4-0:0: port 2, status 101, change 1, 12 Mb/s
> hub 4-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
> hub 4-0:0: new USB device on port 2, assigned address 6
> usb 4-2: new device strings: Mfr=1, Product=2, SerialNumber=5
> usb 4-2: Product: Palm Handheld
> usb 4-2: Manufacturer: Palm, Inc.
> SerialNumber: <wannaknowthathuh?>
> usb_new_device - registering interface 4-2:0
> usb_device_probe
> usb_device_probe - got id
> Handspring Visor / Treo / Palm 4.0 / Clié 4.x converter detected
> usb 4-2: Handspring Visor / Treo / Palm 4.0 / Clié 4.x converter now attached
> 	to ttyUSB0 (or usb/tts/0 for devfs)
> Handspring Visor / Treo / Palm 4.0 / Clié 4.x converter now attached to 
> 	ttyUSB1 (or usb/tts/1 for devfs)
> 
> Then I start pppd:
> 
> pppd 2.4.1 started by root, uid 0
> Perms of /dev/usb/tts/1 are ok, no 'mesg n' neccesary.
> using channel 4
> Using interface ppp0
> Connect: ppp0 <--> /dev/usb/tts/1
> 
> <pppd blah follows>
> 
> Apr  1 20:11:25 sunrise pppd[1281]: local  IP address 192.168.100.1
> Apr  1 20:11:25 sunrise pppd[1281]: remote IP address 192.168.100.10
> status = 0x0
> 
> Connection is up. I wait a few seconds and kill pppd by typing ^C on the 
> terminal:
> 
> Apr  1 20:11:36 sunrise pppd[1281]: Terminating on signal 2.
> Apr  1 20:11:36 sunrise pppd[1281]: cbcp_lowerdown
> Apr  1 20:11:36 sunrise pppd[1281]: Script /etc/ppp/ip-down started (pid 1302)
> Apr  1 20:11:36 sunrise pppd[1281]: sent [LCP TermReq id=0x3 "User request"]
> Apr  1 20:11:36 sunrise pppd[1281]: Script /etc/ppp/ip-down finished (pid 
> 1302), status = 0x0
> Apr  1 20:11:36 sunrise pppd[1281]: rcvd [LCP TermAck id=0x3 "User request"]
> Apr  1 20:11:36 sunrise pppd[1281]: Connection terminated.
> Apr  1 20:11:37 sunrise pppd[1281]: Connect time 0.3 minutes.
> Apr  1 20:11:37 sunrise pppd[1281]: Sent 97 bytes, received 82 bytes.
> Apr  1 20:11:37 sunrise pppd[1281]: Exit.
> Apr  1 20:11:41 sunrise kernel: hub 4-0:0: port 2, status 100, change 3, 12 
> Mb/s
> Apr  1 20:11:41 sunrise kernel: usb 4-2: USB disconnect, address 6
> Apr  1 20:11:41 sunrise kernel: usb 4-2: unregistering interfaces
> Apr  1 20:11:41 sunrise kernel: visor ttyUSB0: Handspring Visor / Treo / Palm 
> 4.0 / Clié 4.x converter now disconnected from ttyUSB0
> Apr  1 20:11:41 sunrise kernel: visor ttyUSB1: Handspring Visor / Treo / Palm 
> 4.0 / Clié 4.x converter now disconnected from ttyUSB1
> Apr  1 20:11:41 sunrise kernel: visor 4-2:0: device disconnected
> Apr  1 20:11:41 sunrise kernel: usb 4-2: unregistering device
> Apr  1 20:11:41 sunrise kernel: hub 4-0:0: port 2 enable change, status 100

Looks like the USB device and visor driver is cleaned up nicely.  But
then...

> Apr  1 20:11:43 sunrise kernel: Slab corruption: start=ddd2b000, 
> expend=ddd2bfff, problemat=ddd2ba58

<snip>

I don't see any usb traces here in the backtrace.  Or ppp code.  I don't
know what could be causing this, sorry.

> Apr  1 19:52:44 sunrise kernel: drivers/usb/host/uhci-hcd.c: 9000: host controller process error. something bad happened
> Apr  1 19:52:44 sunrise kernel: drivers/usb/host/uhci-hcd.c: 9000: host controller halted. very bad
> 
> At this point my USB mouse didn't want to work anymore, and the Palm stopped 
> downloading stuff (how could it - the pppd process was stuck in D state). 
> Sadly I a) hadn't turned debugging on before and b) was stupid enough to see 
> where pppd got stuck (does that matter?).

No, this means your uhci controller had a serious fault.  We've been
seeing these much more often lately, I wonder what changed...

> <whining>
> And even *if* I find something and send out a patch to LKML it's going to be 
> ignored just as the past two patches I sent.
> </whining>

Did you send the patches to the maintainer of the code?

thanks,

greg k-h
