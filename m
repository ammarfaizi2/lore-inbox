Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVLMHPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVLMHPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 02:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVLMHPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 02:15:43 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:12553 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932487AbVLMHPm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 02:15:42 -0500
Date: Tue, 13 Dec 2005 08:17:52 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: More platform driver questions
Message-Id: <20051213081752.5de5eef4.khali@linux-fr.org>
In-Reply-To: <20051211221034.GE22537@flint.arm.linux.org.uk>
References: <20051211220023.19820e47.khali@linux-fr.org>
	<20051211221034.GE22537@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> On Sun, Dec 11, 2005 at 10:00:23PM +0100, Jean Delvare wrote:
> > The base I/O address seemed to belong to .platform_data, as this is the
> > only way I have to pass the information through the .probe mechanism
> > (or should I use platform_get_resource instead?) All the rest I have
> > put in .driver_data. Actually, I even duplicated the base I/O address
> > there, as it made the rest of the code much more simple.
> 
> You should generally use the resources to pass address information.

OK, I've changed my code that way. Thanks for the hint.

> > It seems that in most .remove functions, we explicitely set the driver
> > data pointer to NULL before freeing the associated memory. I am
> > wondering why. Can someone explain? Given that the device is just being
> > deleted anyway, I don't quite see the benefit in doing so. But I guess
> > I am once again missing something obvious.
> 
> This depends on your point of view - whether you think there's a
> possibility that the driver_data might be accessed somehow after
> you've freed the pointer.  Having a NULL pointer will give you a
> very deterministic failure.
> 
> Of course, it can also be viewed as needless code and therefore not
> required.  Again, it's an opinion thing.

I don't mind the extra expense if it helps spotting race conditions. I
just wanted to make sure we agreed that doing so would simply change
the nature of the error we'll get if such a condition happens, but
won't actually prevent this error from happening. Unless each user of
the driver data has an explicit NULL check, which isn't the case for my
driver (and I *would* mind that extra expense.)

Now the question is, is there actually any race condition there? In my
case, the only users of the driver data are the sysfs callback
functions, so I guess that this is all down to whether the driver core
will unregister them before platform_driver.remove is called, or after
it is called. If .remove is called first, then yes my code is racy and
I'll have to fix it.

Thanks,
-- 
Jean Delvare
