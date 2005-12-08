Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbVLHXXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbVLHXXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVLHXXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:23:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30223 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932714AbVLHXXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:23:01 -0500
Date: Thu, 8 Dec 2005 23:22:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Message-ID: <20051208232254.GC9357@flint.arm.linux.org.uk>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <20051205202707.GH15201@flint.arm.linux.org.uk> <200512070105.40169.dtor_core@ameritech.net> <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com> <20051207180842.GG6793@flint.arm.linux.org.uk> <d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com> <20051207190352.GI6793@flint.arm.linux.org.uk> <d120d5000512071418q521d2155r81759ef8993000d8@mail.gmail.com> <20051207225126.GA648@kroah.com> <d120d5000512071459s9b461d8ye7abc41d0e1950fd@mail.gmail.com> <20051208215257.78d7c67a.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208215257.78d7c67a.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 09:52:57PM +0100, Jean Delvare wrote:
> BTW, doesn't this suggest that the error path in
> platform_device_register_simple() is currently broken as well? If
> platform_device_add() fails therein, I take it that the resources
> previously allocated by platform_device_add_resources() will never be
> freed.

No.  If platform_device_add() fails then you platform_device_put()
it with no other action.  If it's been added, with the current
available interfaces, your only option is to
platform_device_unregister() it.

So:

- error during platform_device_alloc, no additional action necessary
- error returned by platform_device_add, you have a structure allocated
  and initialised, you platform_device_put it.
- subsequently you want to get rid of it, platform_device_unregister it,
  or alternatively platform_device_del + platform_device_put it (where
  provided.)

This is actually a generic driver model rule which can be applied to
all driver model interfaces which have the alloc/init, add, del, put,
register, unregister methods.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
