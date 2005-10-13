Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVJMWIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVJMWIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 18:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVJMWIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 18:08:31 -0400
Received: from qproxy.gmail.com ([72.14.204.207]:28885 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751112AbVJMWIa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 18:08:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J8qmFa0QRyNzhj7c8EIJQrzWZCTqdna5u/MDOL9+DOUdZPP6DRrTJ8nSXmAy4FxYh475jRlGf3ynvDL4v4QGaKNOzyMY7Jm1mrlPWqf8bI9SFGzbsCoCIvlX9dYOSRHhxwKZk0lo54WCHlQrcmFzcEY6COk8VfnVOivX0TJ9lnY=
Message-ID: <9a8748490510131508r49a048cau7e08d77ef1d614ad@mail.gmail.com>
Date: Fri, 14 Oct 2005 00:08:28 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Mark Gross <mgross@linux.intel.com>
Subject: Re: Fwd: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Sebastien.Bouchard@ca.kontron.com, mark.gross@intel.com
In-Reply-To: <200510131436.06718.mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510060803.21470.mgross@linux.intel.com>
	 <200510121636.29821.mgross@linux.intel.com>
	 <20051013011451.GA28844@kroah.com>
	 <200510131436.06718.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/05, Mark Gross <mgross@linux.intel.com> wrote:
> On Wednesday 12 October 2005 18:14, Greg KH wrote:
> > On Wed, Oct 12, 2005 at 04:36:29PM -0700, Mark Gross wrote:
> > > No, but I'm glad I tested that otherwise the my problem with using dev_dbg
> > > with the kobj->dev devices I got from the misc_device class could have
> gotten
> > > by me.
> >
> > Yeah, it's always good to test the code to make sure it compiles :)
> >
> > This patch looks good, I have no objections to it.
> >
> > thanks,
> >
>
> One minor update, after testing with misc_class device for udev I found that
> it would be nice to have the sysfs file inodes all use the same base name
> "teleco_clock".
>
> Please consider including this driver in the MM tree.
>
> See attached.
>

Hi Mark,

I just took a new look at your patch and I have (again) a few small comments...


+static int tlclk_open(struct inode *inode, struct file *filp)
+{
+	int result;
+
+	/* Make sure there is no interrupt pending while
+	 * initialising interrupt handler */
+	inb(TLCLK_REG6);
+
+	/* This device is wired through the FPGA IO space of the ATCA blade
+	 * we can't share this IRQ */
+	result = request_irq(telclk_interrupt, &tlclk_interrupt,
+			     SA_INTERRUPT, "telco_clock", tlclk_interrupt);
+	if (result == -EBUSY) {
+		printk(KERN_ERR "telco_clock: Interrupt can't be reserved!\n");
+		return -EBUSY;
+	}
+	inb(TLCLK_REG6);	/* Clear interrupt events */
+
+	return 0;
+}

It seems to me that you can get rid of the "result" variable here by
rewriting the funcion like this :

static int tlclk_open(struct inode *inode, struct file *filp)
{
	/* Make sure there is no interrupt pending while
	 * initialising interrupt handler */
	inb(TLCLK_REG6);

	/* This device is wired through the FPGA IO space of the ATCA blade
	 * we can't share this IRQ */
	if (-EBUSY == request_irq(telclk_interrupt, &tlclk_interrupt,
			     SA_INTERRUPT, "telco_clock", tlclk_interrupt)) {
		printk(KERN_ERR "telco_clock: Interrupt can't be reserved!\n");
		return -EBUSY;
	}
	inb(TLCLK_REG6);	/* Clear interrupt events */

	return 0;
}

And btw, what about the other error return values that request_irq can return?
You might get back -ENOMEM or -EINVAL...  So shouldn't you rather be
doing something like

result = request_irq(...);
if (result < 0)
   /* handle error */

?????

(which then of course would bring the "result" variable back into play ;)


+ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
...
+	return  sizeof(struct tlclk_alarms);

Why do you have 2 spaces here between "return" and "sizeof..." ?


+static DEVICE_ATTR(current_ref, S_IRUGO, show_current_ref, NULL);
+
+
+static ssize_t show_interrupt_switch(struct device *d,

Surely a single space between these two lines should be enough ;) (ok,
I'm nitpicking, I admit it).


+	unsigned long tmp;
+	unsigned char val;
+	unsigned long flags;
+
+	sscanf(buf, "%lX", &tmp);
+	dev_dbg(d, "tmp = 0x%lX\n", tmp);
+
+	val = (unsigned char)tmp;

You do this a lot, I'm wondering why you don't read directly into
"val" and then get rid of the "tmp" variable?


Maybe I'm missing something, but in tlclk_init() you are calling
request_region() and in case of failure you can end up exiting via the
out3: label which will result in release_region() being called... What
now prevents the release region() in tlclk_cleanup() from being called
on an already released region?




--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
