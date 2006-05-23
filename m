Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWEWBDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWEWBDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWEWBDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:03:36 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:21968 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751222AbWEWBDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:03:35 -0400
Subject: Re: + input-new-force-feedback-interface.patch added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
In-Reply-To: <4471E2F6.1040709@gmail.com>
References: <200605180446.k4I4kFxs007658@shell0.pdx.osdl.net>
	 <1147963441.2866.5.camel@laptopd505.fenrus.org>
	 <4471E2F6.1040709@gmail.com>
Content-Type: text/plain
Date: Tue, 23 May 2006 03:03:24 +0200
Message-Id: <1148346205.3100.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-22 at 19:12 +0300, Anssi Hannula wrote:
> Arjan van de Ven wrote:
> > On Wed, 2006-05-17 at 21:46 -0700, akpm@osdl.org wrote:
> > 
> >>+
> >>+#ifdef DEBUG
> >>+#define debug(format, arg...) printk(KERN_DEBUG "ff-effects: " format "\n" , ## arg)
> >>+#else
> >>+#define debug(format, arg...) do {} while (0)
> >>+#endif
> > 
> > 
> > please just use the existing prdebug() thing for this, no need to invent
> > your own ;)
> 
> Couldn't find any info on that one, are you sure you spelled it correctly?


> 
> > 
#ifdef DEBUG
#define pr_debug(fmt,arg...) \
        printk(KERN_DEBUG fmt,##arg)
#else
#define pr_debug(fmt,arg...) \
        do { } while (0)
#endif


in linux/kernel.h


> Well, I don't know. When should EXPORT_SYMBOLs be EXPORT_SYMBOL_GPLs?
> 

if it's linux-only code or otherwise very internal, _GPL is usually the
right thing

> > hmmm stack space?
> > 
> 
> I count 76 bytes (x86), is that too much?

it's sort of ok, just make sure it doesn't grow more

> > 
> > that is almost always a wrong return value
> > 
> 
> It's returned when the device is mem-capable but driver doesn't
> implement set_gain() but sets FF_GAIN or when driver doesn't implement
> set_autocenter() but sets FF_AUTOCENTER. But yes, if that happens, it's
> a driver bug, so maybe this is not correct use for -ENOSYS. Probably
> there should be BUG() too here.

-EINVAL or so would be better; -ENOSYS basically is "not implemented
system call", which is totally off topic in this context

> 
> >>+	if (test_bit(FF_CONSTANT, dev->ff->flags))
> >>+		set_bit(FF_CONSTANT, dev->ffbit);
> >>+	if (test_bit(FF_SPRING, dev->ff->flags))
> >>+		set_bit(FF_SPRING, dev->ffbit);
> >>+	if (test_bit(FF_FRICTION, dev->ff->flags))
> >>+		set_bit(FF_FRICTION, dev->ffbit);
> >>+	if (test_bit(FF_DAMPER, dev->ff->flags))
> >>+		set_bit(FF_DAMPER, dev->ffbit);
> >>+	if (test_bit(FF_INERTIA, dev->ff->flags))
> > 
> > 
> > are you really sure you need atomic set_bit()'s here??
> > if so.. I think you have a race ;)
> 
> Well, I'm not. Is there an alternative?

__set_bit() is not atomic, and thus a lot faster if you don't need
atomic behavior..


