Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVLTVWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVLTVWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVLTVWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:22:45 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:24301 "EHLO
	mail.towertech.it") by vger.kernel.org with ESMTP id S932119AbVLTVWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:22:44 -0500
Date: Tue, 20 Dec 2005 22:23:43 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051220222343.71ee6bab@inspiron>
In-Reply-To: <20051220211344.GA14403@infradead.org>
References: <20051220214511.12bbb69c@inspiron>
	<20051220211344.GA14403@infradead.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005 21:13:45 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> >  drivers/rtc/class.c  |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/rtc/intf.c   |   67 +++++++++++++++++++++++++++++++
> >  drivers/rtc/utils.c  |   99 +++++++++++++++++++++++++++++++++++++++++++++
> 
> 
> Given that the files are really tiny I'd suggest to put everything into
> a single file (driver/char/rtc.c) instead of some arbitrary split.

 I can merge. It was easier to develop them this way.

> > + * rtc-class.c - rtc subsystem, base class
> 
> no need to put the file name into a comment.  it gets out of date far
> too easily (it already is in this case ;-))

 oooooops :)

> > +#define RTC_ID_PREFIX "rtc"
> > +#define RTC_ID_FORMAT RTC_ID_PREFIX "%d"
> 
> Having a format specifier hidden in a macro makes reading code very
> difficult, please just remove this.

 ack.

> > +	if (sscanf(cdev->class_id, RTC_ID_FORMAT, &id) == 1) {
> > +		class_device_unregister(cdev);
> > +		idr_remove(&rtc_idr, id);
> > +	} else
> > +		dev_dbg(cdev->dev,
> > +			"rtc_device_unregister() failed: bad class ID!\n");
> > +}
> 
> The scanf looks really fragile.  Can't you just have a rtc_device structure
> that the cdev and id are embedded into that can be passed to the
> unregistration function?

 I admit I copied from hwmon here :) I'll check into that.

> > +	if (ops->read_time) {
> > +		memset(tm, 0, sizeof(struct rtc_time));
> 
> do we really need the memset?

 It's a kind of protection in case something
 goes wrong in the driver. can be probably removed.

> > +obj-y				+= utils.o
> 
> why is this always built?

 because it exports utility functions used
 elsewhere in the kernel, some of them have been removed
 from the ARM part. Until everything gets cleaned up,
 it's better to always build those few funcs.

> > +obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
> > +rtc-core-y			:= class.o intf.o
> > +rtc-core-objs			:= $(rtc-core-y)
> 
> no need for this last line

 I remember I had compilation problems without it,
 I'll check again.

> > +struct rtc_class_ops {
> 
> What about just rtc_ops?

it's already used under ARM and i didn't wanted
to break it. 

 
> > +	int (*proc)(struct device *, char *buf);
> 
> this should be seq_file based.

 ack.

> > +static const unsigned char rtc_days_in_month[] = {
> > +	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
> > +};
> > +EXPORT_SYMBOL(rtc_days_in_month);
> 
> exporting static symbols is pretty wrong.  Exporting tables is pretty
> bad style aswell.

 Tables like this one are often used in rtc drivers. What
 can I use instead?

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

h
