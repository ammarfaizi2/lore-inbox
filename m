Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUJTGxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUJTGxy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270084AbUJTGs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 02:48:26 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:55220 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268425AbUJTGpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 02:45:32 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Fw: X is killed when trying to suspend with USB Mouse plugged in
Date: Wed, 20 Oct 2004 01:45:27 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Nils Rennebarth <Nils.Rennebarth@web.de>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0410191134090.1023-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0410191134090.1023-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410200145.27952.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 October 2004 10:35 am, Alan Stern wrote:
> On Mon, 18 Oct 2004, Dmitry Torokhov wrote:
> 
> > > I don't know about /dev/input/mouse1.  But the oops isn't a bug... it's a 
> > > weakness in the way Linux implements loadable kernel modules.
> > > 
> > 
> > Ugh, it is not module implementation weakness, it looks like refcounting
> > problem in USB.
> 
> Could you explain that more fully?  Are you talking about a particular 
> refcounting problem in the usbhid subsystem or do you mean a more 
> pervasive problem in the whole USB system?  And why do you say it's a 
> refcounting problem in the first place?
> 

I am not sure it it is HID-specific problem or a wider one but it looks
like usbhid can be unloaded while there are references to objects produced
by this module - hence refcounting problem. You either have to disallow
unloading while there are references (but this path leads to potential
deadlocks) or have a generic release function registered with the core that
pretty much always stays there. Then you can free all device-specific data
at unload time and mark the object as a zombie so anything that tries to
touch it releases it quickly and then the core routine will free skeleton
data at last.

The patch that I sent should hide the problem somewhat as at disconnect
time it will unregister corresponsing class devices thus dropping the
reference that was pinning usbhid structures.

-- 
Dmitry
