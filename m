Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVBLSS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVBLSS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 13:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVBLSS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 13:18:58 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:39271 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261176AbVBLSRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 13:17:42 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kenan Esau <kenan.esau@conan.de>
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Date: Sat, 12 Feb 2005 13:17:39 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, harald.hoyer@redhat.de,
       lifebook@conan.de, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
References: <20050211201013.GA6937@ucw.cz> <1108227679.12327.24.camel@localhost>
In-Reply-To: <1108227679.12327.24.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502121317.40090.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 February 2005 12:01, Kenan Esau wrote:

> Second thing is that I am not shure that it is a good idea to integrate
> the lbtouch-support into the psmouse-driver since there is no real way
> of deciding if the device you are talking to is REALLY a
> lifebook-touchsreen or not. 
> 

I think Arjan's idea about using DMI could be very effective for this
particular touchscreen.

> I also don't think that it is useful to have two devices for the
> touchscreen. I assume you want to have one device for relative movements
> and one for the absolute ones!? But for the implementor in userspace (X,
> SDL,...) it will be easier if ALL events from this HW-device come via
> one device-node. 
> 

Why? These are separate, one might want to disable touchscreen and keep
quick-point or other way around.

> I think my driver works and is clean enough for integration into the
> kernel. We can talk about integrating calls to libps2 instead of doing
> the stuff myself (I am a big fan of preventing code-duplication) but
> don't you think it would be more wise to use a driver which works (since
> the very early 2.6-days) and build upon that instead of trying to
> implement your own one from the scratch and using snippets from very old
> and obsolete code?
> 

We need to get it integrated right away I think. There just too much stuff
in psmouse that shoudl be used (rate and resolution exported through sysfs,
timeout and resend handling, etc.)

Plus, in your current driver:

- MODULE_PARM is obsolete

- data_lock spinlock is either unneeded or may cause deadlocks since it is
  used in interrupt handler and the other places that are using it do not
  disable interrupts

- it is not necessary to suppress duplicate button events in the driver
  as the driver core will do that for you and it will make interrupt
  handler almost the same as Vojtech's. Btw, I don't think his handler
  has a problem - I would expect touchscreen to send anoter packet when
  finger leaves its surface so untouch will not be lost.

- using interruptible_sleep_on for delays is somewhat inelegant I think. 

- it needs some changes to compile with the latest version of serio.

-- 
Dmitry
