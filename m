Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWBWBKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWBWBKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 20:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWBWBKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 20:10:51 -0500
Received: from mx0.towertech.it ([213.215.222.73]:16067 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1030358AbWBWBKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 20:10:50 -0500
Date: Thu, 23 Feb 2006 02:09:52 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Andrew Morton <akpm@osdl.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] RTC subsystem, class
Message-ID: <20060223020952.42124378@inspiron>
In-Reply-To: <20060222141554.0f5e2aa3.akpm@osdl.org>
References: <20060219232211.368740000@towertech.it>
	<20060219232211.628944000@towertech.it>
	<20060222141554.0f5e2aa3.akpm@osdl.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006 14:15:54 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Couple of questions.
> 
> a) Is all this code 100% compatible with existing kernel interfaces?  No
>    userspace-visible breakage?  Right down the all the same -EFOO return
>    codes for all the same errors?

 this new class works only in places of the kernel were there were no
 RTCs before.. basically, I haven't touched the x86 or any other platform clock
 and focused only on i2c clocks which were actually not used.

 From the userspace point of view, the interface is the same. I noticed
 that hwclock does not like things like time that is not changing or
 an -EINVAL on a read, which can instead happen when you use
 i2c clocks. However, that is not an issue yet because hwclock has
 not been used on those i2c clocks until now. 

> 
> b) Will the kernel compile and run at each stage of your patch series? 
>    I hit a nasty no-compile half an hour through a git-bisect session
>    yesterday and it's still smarting.

 I' haven't tested it.. I think there may be problems because at some
 points some functions in the kernel needs to be renamed and/or
 changed.. i would say the first two patches should be applied
 together. 

> Code looks nice and clean.

 thanks.

> > +	if ((rtc = kzalloc(sizeof(struct rtc_device), GFP_KERNEL)) == NULL) {
> 
> You do a lot of
> 
> 	if ((lhs = rhs) == something)
> 
> But preferred kernel style is
> 
> 	lhs = rhs;
> 	if (lhs == something)

 good to know, that is also my preferred style. I will happily change
 this, I just thought the kernel style was the other one :)


> Generally, kernel style is to keep things as utterly simple as they can be.

[..]

> > +config RTC_HCTOSYS_DEVICE
> > +	string "The RTC to read the time from"
> > +	depends on RTC_HCTOSYS = y
> > +	default "rtc0"
> > +	help
> > +	  The RTC device that will be used as the source for
> > +	  the system time, usually rtc0.
> 
> hm.  Doesn't the above disable RTC_HCTOSYS and RTC_HCTOSYS_DEVICE if
> RTC_CLASS=m?

 yes. I can't remember if it is intended, but the point of having
 hctosys was to copy the time early in the bootup process.

> > +
> > +extern struct class *rtc_class;
> 
> Please always put extern declarations in a header file.

 ack.

> > +EXPORT_SYMBOL(rtc_update_irq);
> 
> I don't know what this does.
> 
> Please document all non-static functions.  Preferably with kernel-doc
> format.  Feel free to document static functions too..

 will do.

> > +int rtc_irq_set_freq(struct class_device *class_dev, struct rtc_task *task, int freq)
> > +{
> > +	int err = 0, tmp = 0;
> > +	unsigned long flags;
> > +	struct rtc_device *rtc = to_rtc_device(class_dev);
> > +
> > +	/* allowed range is 2-8192 */
> > +	if (freq < 2 || freq > 8192)
> > +		return -EINVAL;
> > +
> > +/*	if ((freq > rtc_max_user_freq) && (!capable(CAP_SYS_RESOURCE)))
> > +		return -EACCES;
> > +*/
> 
> What happened to rtc_max_user_freq?

 not implemented yet, I need to handle it in a different way. rtc_irq_set_freq
 is the kernel interface, I must move this check in the /dev/rtc code.

 How can I handle further updates, just repost the whole patchset
 to lkml ?

 thanks for you review!

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

