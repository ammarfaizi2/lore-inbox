Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVGKNvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVGKNvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVGKNvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:51:15 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:57815 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261674AbVGKNvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:51:11 -0400
To: Stelian Pop <stelian@popies.net>
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
References: <20050708101731.GM18608@sd291.sivit.org>
	<1120821481.5065.2.camel@localhost>
	<20050708121005.GN18608@sd291.sivit.org>
	<20050709191357.GA2244@ucw.cz> <m33bqnr3y9.fsf@telia.com>
	<20050710120425.GC3018@ucw.cz> <m3y88e9ozu.fsf@telia.com>
	<1121078371.12621.36.camel@localhost.localdomain>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Jul 2005 15:48:57 +0200
In-Reply-To: <1121078371.12621.36.camel@localhost.localdomain>
Message-ID: <m3eka5h2ra.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian@popies.net> writes:

> Le lundi 11 juillet 2005 à 02:15 +0200, Peter Osterlund a écrit :
> > Vojtech Pavlik <vojtech@suse.cz> writes:
> > 
> > > Using a function like
> > > 
> > > 	return (x_old * 3 + x) / 4;
> > > 
> > > eliminates the need for a FIFO, and has similar (if not better)
> > > properties to floating average, because its coefficients are
> > > [ .25 .18 .14 .10 ... ].
> > 
> > Agreed.
> 
> Except that this does not work well enough.
> 
> There are two problems I encountered in this driver:
> * fuzz problems (keeping the finger at the same place makes the pointer
> dance around its position). This is solved by the input core's fuzz
> treatment, as I already set the fuzz to 16 in the code.
> 
> * hickup problems (moving the finger generates non linear points,
> something like 1 1 1 3 3 3 4 4 4 instead of 1 1 1 2 2 3 3 4 4). And here
> the floating average approach works better than the input core's method.
> (this could probably be solved also by changing the way the absolute
> coordinate is calculated from the sensor array in atp_calculate_abs, but
> I haven't been able to find a better linear function).

It would be interesting if you could generate some debug dumps using
the "sample" line:

+	dbg_dump("sample", xy_cur);

The "accumulator" dumps are not needed, the raw data should be
enough. Including timing information would be helpful though, like
this:

--- a/drivers/usb/input/appletouch.c
+++ b/drivers/usb/input/appletouch.c
@@ -121,7 +121,7 @@ struct atp {
 #define dbg_dump(msg, tab) \
 	if (debug > 1) {						\
 		int i;							\
-		printk("appletouch: %s ", msg);				\
+		printk("appletouch: %s %lld ", msg, (long long)jiffies);\
 		for (i = 0; i < ATP_XSENSORS + ATP_YSENSORS; i++)	\
 			printk("%02x ", tab[i]); 			\
 		printk("\n"); 						\

Debug dumps for the following actions would be interesting.

1. When not touching the touchpad.
2. When trying to hold a finger on the touchpad without moving it.
3. A single finger movement. (Touch, move finger, release.)
4. A single finger touch. First a light touch, then pressing harder
   and harder, to see if a reliable pressure value can be computed
   from the data.
5. A two-finger touch.

> I would prefer to submit the patch myself, because as you say you cannot
> test the code and those changes are rather sensitive.

No problem, I just needed a patch when I was playing around with StGIT
and thought I might as well use a real patch.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
