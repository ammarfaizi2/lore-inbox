Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVLTVaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVLTVaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVLTVaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:30:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15373 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932130AbVLTVaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:30:22 -0500
Date: Tue, 20 Dec 2005 21:30:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051220213013.GB31364@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	linux-kernel@vger.kernel.org
References: <20051220214511.12bbb69c@inspiron> <20051220211344.GA14403@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220211344.GA14403@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 09:13:45PM +0000, Christoph Hellwig wrote:
> > +int rtc_read_time(struct class_device *class_dev, struct rtc_time *tm)
> > +{
> > +	int err = -EINVAL;
> > +	struct rtc_class_ops *ops = class_get_devdata(class_dev);
> > +
> > +	if (ops->read_time) {
> > +		memset(tm, 0, sizeof(struct rtc_time));
> 
> do we really need the memset?

Absolutely yes, otherwise if 'tm' is on the stack and it ultimately
gets copied to userspace, it will leak kernel memory.  Why?
Unfortunately, not all elements of 'tm' are written to by RTC
drivers.

You can argue that the RTC drivers need fixing, but since this bug
has gone completely unnoticed in _all_ kernels which have an RTC
driver up until I discovered it and reported it to vendor-sec
during the 2.5 cycle, I think a little bit of cheap protection
against buggy drivers when security leaks are concerned is not
unreasonable.  Especially when they don't get found in the normal
run of things.

(you could make a case for eliminating it _if_ there was a RTC
subsystem maintainer who knew the code and therefore knew what
to look out for.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
