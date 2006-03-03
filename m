Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWCCRJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWCCRJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWCCRJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:09:26 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:10124 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1030249AbWCCRJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:09:25 -0500
Date: Fri, 3 Mar 2006 18:08:53 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm2
Message-ID: <20060303170852.GA17018@ens-lyon.fr>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
X-Sieve: CMU Sieve 2.2
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/
>
>
> - Should be a bit better than 2.6.16-rc5-mm1, but I still had to fix a ton
>   of things to get this to compile and boot.  We're not being careful enough.
>
> - The procfs rework is getting there, but some problems probably still remain.
>
> - There will be a number of new warnings at boot time when initcalls fail.
>   Generally that's OK: it usually indicates that you linked something into
>   vmlinux which you're not actually using.  But sometimes it can indicate
>   kernel bugs.
>
> - The (much-shrunk) audit git tree is back.
>

I have the following warning:

drivers/rtc/interface.c: In function 'rtc_set_mmss':
drivers/rtc/interface.c:91: warning: 'old.tm_hour' is used uninitialized in this function
drivers/rtc/interface.c:91: warning: 'old.tm_min' is used uninitialized in this function

The following patch fixes it (maybe using goto would be better and avoid
having lines > 80 chars).

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.fr>

Index: linux/drivers/rtc/interface.c
===================================================================
--- linux.orig/drivers/rtc/interface.c
+++ linux/drivers/rtc/interface.c
@@ -76,21 +76,25 @@ int rtc_set_mmss(struct class_device *cl
 		if (rtc->ops->read_time && rtc->ops->set_time) {
 		        struct rtc_time new, old;
 
-		        new.tm_sec  = secs % 60;
-		        secs /= 60;
-		        new.tm_min  = secs % 60;
-		        secs /= 60;
-		        new.tm_hour = secs % 24;
-
-		       /*
-		        * avoid writing when we're going to change the day
-		        * of the month.  We will retry in the next minute.
-		        * This basically means that if the RTC must not drift
-		        * by more than 1 minute in 11 minutes.
-		        */
-			if (!((old.tm_hour == 23 && old.tm_min == 59) ||
-		            (new.tm_hour == 23 && new.tm_min == 59)))
-				err = rtc->ops->set_time(class_dev->dev, &new);
+			err = rtc->ops->read_time(class_dev->dev, &old);
+			if (!err) {
+
+				new.tm_sec  = secs % 60;
+				secs /= 60;
+				new.tm_min  = secs % 60;
+				secs /= 60;
+				new.tm_hour = secs % 24;
+
+			       /*
+				* avoid writing when we're going to change the day
+				* of the month.  We will retry in the next minute.
+				* This basically means that if the RTC must not drift
+				* by more than 1 minute in 11 minutes.
+				*/
+				if (!((old.tm_hour == 23 && old.tm_min == 59) ||
+				    (new.tm_hour == 23 && new.tm_min == 59)))
+					err = rtc->ops->set_time(class_dev->dev, &new);
+			}
 		}
 		else
 			err = -EINVAL;
