Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVBGQ0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVBGQ0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVBGQ0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:26:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6077 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261181AbVBGQZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:25:30 -0500
Date: Mon, 7 Feb 2005 16:25:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       matthew@wil.cx, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] Altix : ioc4 serial driver support
Message-ID: <20050207162525.GA15926@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	matthew@wil.cx, B.Zolnierkiewicz@elka.pw.edu.pl
References: <20050103140938.GA20070@infradead.org> <Pine.SGI.3.96.1050131164059.62785B-100000@fsgi900.americas.sgi.com> <20050201092335.GB28575@infradead.org> <420139BF.4000100@sgi.com> <20050202215716.GA23253@infradead.org> <42079029.5040401@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42079029.5040401@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 09:58:33AM -0600, Patrick Gefre wrote:
> Latest version with review mods:
> ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support


 - still not __iomem annotations.
 - still a ->remove method

more comments (mostly nipicks I missed last time, nothing too exciting):


+#define DEVICE_NAME_DYNAMIC "ttyIOC0"	/* need full name for misc_register */

this one is completely unused.

+#define PENDING(_p)	readl(&(_p)->ip_mem->sio_ir) & _p->ip_ienb

probably wants some braces around the macro body

+static struct ioc4_port *get_ioc4_port(struct uart_port *the_port)
+{
+	struct ioc4_control *control = dev_get_drvdata(the_port->dev);
+	int ii;
+
+	if (control) {
+		for ( ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++ ) {
+			if (!control->ic_port[ii].icp_port)
+				continue;
+			if (the_port == control->ic_port[ii].icp_port->ip_port)
+				return control->ic_port[ii].icp_port;
+		}
+	}
+	return (struct ioc4_port *)0;

just return NULL here.

+static irqreturn_t ioc4_intr(int irq, void *arg, struct pt_regs *regs)
+{
+	struct ioc4_soft *soft;
+	uint32_t this_ir, this_mir;
+	int xx, num_intrs = 0;
+	int intr_type;
+	int handled = 0;
+	struct ioc4_intr_info *ii;
+
+	soft = (struct ioc4_soft *)arg;
+	if (!soft)
+		return IRQ_NONE;	/* Polled but no ioc4 registered */

no need to cast.  and it can't be NULL either.

+	spin_lock_irqsave(&port->ip_lock, port_flags);
+	wake_up_interruptible(&info->delta_msr_wait);
+	spin_unlock_irqrestore(&port->ip_lock, port_flags);

no need to lock around a wake_up()

+	/* Start up the serial port */
+	spin_lock_irqsave(&port->ip_lock, port_flags);
+	retval = ic4_startup_local(the_port);
+	if (retval) {
+		spin_unlock_irqrestore(&port->ip_lock, port_flags);
+		return retval;
+	}
+	spin_unlock_irqrestore(&port->ip_lock, port_flags);
+	return 0;

what about just

	spin_lock_irqsave(&port->ip_lock, port_flags);
	retval = ic4_startup_local(the_port);
	spin_unlock_irqrestore(&port->ip_lock, port_flags);
	return reval;

?
	
+	struct ioc4_port *port = get_ioc4_port(the_port);
+	unsigned long port_flags;
+
+	spin_lock_irqsave(&port->ip_lock, port_flags);
+	ioc4_change_speed(the_port, termios, old_termios);
+	spin_unlock_irqrestore(&port->ip_lock, port_flags);
+	return;

no need for empty returns at the end of void functions

+static struct uart_driver ioc4_uart = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "ioc4_serial",
+	.dev_name	= DEVICE_NAME,
+	.major		= DEVICE_MAJOR,
+	.minor		= DEVICE_MINOR,
+	.nr		= IOC4_NUM_CARDS * IOC4_NUM_SERIAL_PORTS,
+	.cons		= NULL,
+};

no need to initialize .cons to zero, the compiler does that for you.

+	if ( !request_region(tmp_addr, sizeof(struct ioc4_mem), "sioc4_mem")) {

superflous space before the !

+	if (!request_irq(pdev->irq, ioc4_intr, SA_SHIRQ,
+				"sgi-ioc4serial", (void *)soft)) {
+		control->ic_irq = pdev->irq;
+	} else {
+		printk(KERN_WARNING
+		    "%s : request_irq fails for IRQ 0x%x\n ",
+			__FUNCTION__, pdev->irq);
+	}

Can the driver work without an irq?

