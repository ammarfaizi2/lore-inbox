Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315754AbSFJBA0>; Sun, 9 Jun 2002 21:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSFJBAZ>; Sun, 9 Jun 2002 21:00:25 -0400
Received: from mta02bw.bigpond.com ([139.134.6.34]:43464 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S315754AbSFJBAY>; Sun, 9 Jun 2002 21:00:24 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Chris Faherty <rallymonkey@bellsouth.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Logitech Mouseman Dual Optical defaults to 400cpi
Date: Mon, 10 Jun 2002 10:57:20 +1000
User-Agent: KMail/1.4.5
In-Reply-To: <20020608165243Z317422-22020+923@vger.kernel.org> <200206091807.11524.bhards@bigpond.net.au> <20020609151922Z317623-22020+1197@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206101057.20259.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002 01:19, Chris Faherty wrote:
> On Sunday 09 June 2002 04:07 am, Brad Hards wrote:
> > Was that using Snoopy?
>
> I believe that's what it was called.  The program was sniffusb 0.13.  I had
> problems get later versions to work.  Then I found a nice treatise on
> interpreting the log:
>
> http://www.toth.demon.co.uk/usb/reverse-0.2.txt
I'll have to check it out. There are a number of resources (including a nice 
Perl script that gets rid of much of the verbosity).
Later versions may be W2K, rather than for 98: 
http://sourceforge.net/projects/usbsnoop/

> > Any objections to me taking this to 2.4 and 2.5?
>
> Feel free.  I wonder if MS Intellimouse 3.0 has the same resolution
> problem. AFAIK they use the same sensor.
Probably not, because only low end manufacturers use reference designs 
directly. I have an intellimouse around here somewhere. Don't know anything 
about it, because it wouldn't have occurred to me to read the manual or 
install the windows drivers. Might have to check it out.

> > This could have been handled by a blacklist table quirk. Any reason why
> > you chose to do it this way?
>
> How does the blacklist work?  Originally I wanted to put the setting in
> mousedev but I wasn't sure how to access the usb_device from there.
Basically we declare a quirk (in drivers/usb/hid.h)
#define HID_QUIRK_LOGITECH_HIRES

and then associate the manufacturer and product IDs for the device with the 
quirk in hid-core.c (in hid_blacklist[])
{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DOPTICAL, 
HID_QUIRK_LOGITECH_HIRES },

And then use (hid->quirk & HID_QUIRK_LOGITECH_HIRES) as the test instead of 
((hid->dev->descriptor.idVendor == USB_VENDOR_ID_LOGITECH) &&
(hid->dev->descriptor.idProduct == USB_DEVICE_ID_LOGITECH_DOPTICAL)) in the 
routine you actually want to vary.

The advantage is really apparent when Logitech brings out another device with 
different product ID (eg a different colour plastic) that has the same 
firmware and needs the same change. Much easier to add to the (now badly 
misnamed) blacklist than to add more and more conditions to the if().

I'll try for a patch later, that might make this a bit clearer.

Brad


-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
