Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVCIQOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVCIQOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVCIQOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:14:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8460 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261621AbVCIQLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:11:15 -0500
Date: Wed, 9 Mar 2005 16:11:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050309161108.F25398@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, Wen Xiong <wendyx@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com> <20050228063954.GB23595@kroah.com> <4228CE41.2000102@us.ltcfwd.linux.ibm.com> <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com> <20050308064424.GF17022@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050308064424.GF17022@kroah.com>; from greg@kroah.com on Mon, Mar 07, 2005 at 10:44:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 10:44:25PM -0800, Greg KH wrote:
> On Mon, Mar 07, 2005 at 05:46:51PM -0500, Wen Xiong wrote:
> > +static ssize_t jsm_tty_baud_show(struct class_device *class_dev, char *buf)
> > +{
> > +	struct jsm_channel *ch;
> > +
> > +	if (class_dev) {
> > +		ch = class_get_devdata(class_dev);
> > +		if ( ch && (ch->ch_bd->state == BOARD_READY))
> > +		return snprintf(buf, PAGE_SIZE, "%d\n", ch->ch_old_baud);
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +static CLASS_DEVICE_ATTR(baud, S_IRUGO, jsm_tty_baud_show, NULL);
> 
> No, please delete these, and the other sysfs files that duplicate the
> same info that you can get by using the standard Linux termios calls.
> There is no need for them here.

Greg, there's several other points about why the above is Bad(tm).

"class_dev" will always be non-null.

Note that this (and similar code) is racy.  Consider what happens when
the class device is removed (and the class devdata is NULL'd or kfree'd)
while another process on another CPU reads from one of these sysfs files.
*BANG*.

Also, if a class device attribute method is going to access data outside
the same allocation which the class device is a part of, you *absolutely*
*must* have some form of locking.

Also note that the formatting of these snippets of code is abismal.
There is a missing tab which makes it very non-readable.

With all of the above comments, it should be something like:

+static ssize_t jsm_tty_baud_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+	int ret = -EINVAL;
+
+	down(&some_lock);
+	ch = class_get_devdata(class_dev);
+	if (ch && (ch->ch_bd->state == BOARD_READY))
+		ret = snprintf(buf, PAGE_SIZE, "%d\n", ch->ch_old_baud);
+	up(&some_lock);
+
+	return ret;
+}
+static CLASS_DEVICE_ATTR(baud, S_IRUGO, jsm_tty_baud_show, NULL);

where "some_lock" is also taken in the device unregistration path, at
the point where the class devdata is NULL'd out.  (which the driver is
also missing.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
