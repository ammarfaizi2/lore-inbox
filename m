Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318710AbSHEQyy>; Mon, 5 Aug 2002 12:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318714AbSHEQyy>; Mon, 5 Aug 2002 12:54:54 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:63502 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318710AbSHEQyx>;
	Mon, 5 Aug 2002 12:54:53 -0400
Date: Mon, 5 Aug 2002 09:56:02 -0700
From: Greg KH <greg@kroah.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Tyler Longren <tyler@captainjack.com>, kiza@gmx.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Message-ID: <20020805165601.GA27503@kroah.com>
References: <20020805003427.7e7fc9f4.tyler@captainjack.com> <200208052114.15020.bhards@bigpond.net.au> <200208060001.07546.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208060001.07546.bhards@bigpond.net.au>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 08 Jul 2002 15:10:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 12:00:55AM +1000, Brad Hards wrote:
> 
> Greg: I think this was one of your patches, associated with the 
> HIDINPUT patch. It looks like the return value is wrong. See 
> below.
> 
> --- include/linux/hiddev.h.orig Mon Aug  5 23:19:54 2002
> +++ include/linux/hiddev.h      Mon Aug  5 23:56:34 2002
> @@ -183,7 +183,7 @@
>  int __init hiddev_init(void);
>  void __exit hiddev_exit(void);
>  #else
> -static inline void *hiddev_connect(struct hid_device *hid) { return NULL; }
> +static inline void *hiddev_connect(struct hid_device *hid) { return -1; }
>  static inline void hiddev_disconnect(struct hid_device *hid) { }
>  static inline void hiddev_hid_event(struct hid_device *hid, unsigned int usage, int value) { }
>  static inline int hiddev_init(void) { return 0; }

??? Why return -1 as a void *?

The only caller of hiddev_connect is:
	if (!hiddev_connect(hid))
		hid->claimed |= HID_CLAIMED_HIDDEV;

Hm, seems like you don't want a void * there at all, but a int, right?
And as the "original" hiddev_connect returns an int, this does look like
a bug on my part, sorry.  I'll go fix it.

But that doesn't explain the error people are having with the code
compiled in.

thanks,

greg k-h
