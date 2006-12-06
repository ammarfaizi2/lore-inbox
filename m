Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760648AbWLFOYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760648AbWLFOYG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760647AbWLFOYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:24:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:63425 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760639AbWLFOYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:24:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gKuOkliXr97Tecr24EFme9cL5neL7m4PSobZhrS93DXKbnLwW0oWsJsYHYqsBkR/j6gyXUzEQDmqbtQIV17Em8lPx6Nno0Y0064xbBKbySrzTXbUW3y/KMFORIXJD6mEgqoElpXeQOMeBNhZBKvTrJ46uCDIDPgOXOKlmBd4AvE=
Message-ID: <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com>
Date: Wed, 6 Dec 2006 09:24:02 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Kosina" <jkosina@suse.cz>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
Cc: "Li Yu" <raise.sail@gmail.com>, "Greg Kroah Hartman" <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       "Vincent Legoll" <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>,
       "Marcel Holtmann" <marcel@holtmann.org>
In-Reply-To: <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612061803324532133@gmail.com>
	 <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/6/06, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 6 Dec 2006, Li Yu wrote:
>
> >       1. Make hidinput_disconnect_core() be more robust, it can not
> >          break anything even failed to allocate device struct.
> >       2. Thanks new input device driver API, we need not the extra code
> >          for support force-feed device yet, so say bye to
> >          CONFIG_HID_SIMPLE_FF.
> > Is this ready to merge? or What still is problem in them? Thanks.
>
> Hi,
>
> actually, I have prepared patches to split the USBHID code in two parts -
> generic HID, which could be hooked by transport-specific HID layers (USB,
> Bluetooth).
>
> I did not send them to lkml/linux-usb, as they are quite big (mainly
> because a lot of code is being moved around). I am currently trying to
> setup a git repository on kernel.org, hopefully kernel.org people will
> react, so that the patches could be easily put into git repository and be
> available for rewiew and easy merge. After that, they are planned to be
> merged either into Greg's or Andrew's tree. I can send them to you if you
> want.
>
> Do you think that you could wait a little bit more, after the split has
> been done? (it's currently planned approximately after 2.6.20-rc1). It
> seems to me that your patches will apply almost cleanly on top of the
> split patches (you will have to change the pathnames, of course).
>

I still have the same objection - the "simple'" code will have to be
compiled into the driver instead of being a separate module and
eventyally will lead to a monster-size HID module. We have this issue
with psmouse to a degree but with HID the growth potential is much
bigger IMO.

Jiri, I have not looked at your patches yet (I need to do that) but
what I was hoping to do (or have someone to do ;) ) is to provide
ability to define HID transport drivers (we would have USB transport
and bluetooth transport) and then say:

  device = hid_create_device(&my_transport);
  device->event = my_event_handler;
  ....
  hid_start_device(device);

hid-create_device would parse all reports and create "standard" hid
device. Then you have a chance to override and tweak it as you see
fit.

This way we could have several small drivers implementing quirks to
the generic HID driver. Most of the code is still in hid core module
but every individual driver is complete USB (or bluetooth) driver, has
its own device table and is loaded via standard driver code bust
matching/hotplug modalias mechanism.

Btw, I saw you moving it into drivers/hid, would not
drivers/input/hid/ suit better?

-- 
Dmitry
