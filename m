Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWGCXYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWGCXYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWGCXYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:24:32 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:65055 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932074AbWGCXYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:24:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=odQBTDVlyTv5pWcFf60yXiXSQoBztBZ8UDvuqUSSxBdpRXag18fAiPTQSJUfaprjPf4zet1sG/ct+A+MpO5JHyVWQLjePNRvjpj3T0epwG0jILPykkyx0abp4/tZZVvK51K9KAu+OPhe8nb3FpC+f6m/tvTAPYvUyqkCq1ZbXj0=
Message-ID: <e1e1d5f40607031624w245e5f70g2ae8f5d0e9d357c4@mail.gmail.com>
Date: Mon, 3 Jul 2006 19:24:30 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Cc: "Alon Bar-Lev" <alon.barlev@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060703222645.GA22855@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
	 <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>
	 <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>
	 <44A95F12.8080208@gmail.com>
	 <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>
	 <20060703214509.GA5629@kroah.com>
	 <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>
	 <20060703222645.GA22855@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that I didn't make myself clear on that... let me try to
explain on what I'm thinking to do. Let's take as example Dan's driver
at http://prdownload.berlios.de/dpfp/dpfp-driver-0.1.2.tar.bz2.

On our usb_device_id, we specify the vendor of the device, etc. We
could also (I don't know if this is the best place to do that) specify
which kind of device is it (printer, storage, fingerprint reader, HID,
etc). Let's suppose that we have some #define's or a enum that specify
the hundreds of different device types (is that possible ? :) Nothing
that a USB_GENERIC can't solve lol).

enum usb_device_type {
	USB_DEVICE_SCANNER,
	USB_DEVICE_KEYBOARD,
	USB_DEVICE_MOUSE,
	USB_DEVICE_FINGERPRINT_READER,
	USB_DEVICE_GENERIC,
	...
};

For each device, he have some kind of struct that is complex enough to
describe characteristics of each device, at least the most common
ones. So, for USB_DEVICE_FINGERPRINT_READER, we could have:

#define FINGEPRINT_IMAGE_JPG 0
#define FINGEPRINT_IMAGE_PNM 1
#define FINGEPRINT_IMAGE_BMP 2
#define FINGEPRINT_IMAGE_RAW 3

struct usb_devcap_fingerprint_reader {
	unsigned int width;
	unsigned int height;
	unsigned int colors;
	unsigned char cap_encrypted_output;
	unsigned char image_type; /* FINGEPRINT_IMAGE_PNM */
};

(I know, this sucks, but you got the idea).

So our usb_device_id array could also include the kind of device and a
pointer to our structure describing the device capabilities, something
like:

static struct usb_devcap_fingerprint_reader
usb_devcap_fingerprint_reader_mskeyboard = {
	.width = 100,
	.height = 100,
	.colors = 2,
	.cap_encrypted_output = 0,
	.image_type = FINGEPRINT_IMAGE_BMP,
}

static struct usb_device_id dpfp_table[] = {
	{
		/* Microsoft Keyboard with Fingerprint reader */
		USB_DEVICE(0x045e, 0x00bb),
		.driver_info = DPFP_TYPE_URU4000B,
		USB_DEVICE_FINGERPRINT_READER,
		(usb_devcap_fingerprint_reader *) usb_devcap_fingerprint_reader_mskeyboard,
	},
	{}	/* terminating null entry */
};

So, to know each fingerprint reader device (if any) and its
capabilities, we could have a directory like /dev/usb/fingerprint
where we could iterate and access the device thru
/dev/usb/fingerprint/fingerprint0. Opening a fd to this device and
issuing a ioctl(), we could have a usb_devcap_fingerprint_reader-like
structure on userspace filled in with the device's capabilities, so we
would know exactly what to expect when doing a cat
/dev/usb/fingerprint/fingerprint0 > /tmp/catchme.bmp.

I think that the most difficult part would be summarize the thousands
of different devices and their capabilities in a struct ()... but I
also think that this stuff is needed, and should be kept by the
kernel, and not some lib in userspace...

Daniel



-- 
What this world needs is a good five-dollar plasma weapon.
