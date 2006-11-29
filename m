Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759006AbWK3EOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759006AbWK3EOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759004AbWK3EOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:14:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:36534 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1759003AbWK3EOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:14:17 -0500
X-Authenticated: #14349625
Subject: Re: [rfc patch] Re: [patch] PM: suspend/resume debugging should
	depend on SOFTWARE_SUSPEND
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@suse.cz>, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061129114934.eedb7405.akpm@osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	 <Pine.LNX.4.64.0611240959170.6991@woody.osdl.org>
	 <1164463898.6221.24.camel@Homer.simpson.net>
	 <200611251812.53246.rjw@sisk.pl>
	 <1164516833.6543.0.camel@Homer.simpson.net>
	 <1164708110.6021.12.camel@Homer.simpson.net>
	 <1164795696.6147.2.camel@Homer.simpson.net>
	 <1164796231.6147.12.camel@Homer.simpson.net>
	 <20061129114934.eedb7405.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 21:05:26 +0100
Message-Id: <1164830726.5913.3.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 11:49 -0800, Andrew Morton wrote:

> > +#ifdef CONFIG_PM
> > +static int serial_pnp_suspend(struct pnp_dev *dev, pm_message_t state)
> > +{
> > +	long line = (long)pnp_get_drvdata(dev);
> 
> Please avoid adding long lines.  (heh, I kill me)

Ok.  I also changed the place I got it from.

> We'd usually do
> 
> #else
> #define serial_pnp_suspend NULL
> #define serial_pnp_resume NULL
> 
> here
> 
> > +
> > +#endif /* CONFIG_PM */
> > +
> >  static struct pnp_driver serial_pnp_driver = {
> >  	.name		= "serial",
> > -	.id_table	= pnp_dev_table,
> >  	.probe		= serial_pnp_probe,
> >  	.remove		= __devexit_p(serial_pnp_remove),
> > +#ifdef CONFIG_PM
> > +	.suspend	= serial_pnp_suspend,
> > +	.resume		= serial_pnp_resume,
> > +#endif
> 
> and hence omit the ifdefs here.

New patch.

Add suspend/resume methods to drivers/serial/8250_pnp.c.  Tested on a
P4/HT 16550A box, ttyS0 login survives across suspend to ram.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.19-rc6-mm2/drivers/serial/8250_pnp.c.org	2006-11-29 07:14:15.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/serial/8250_pnp.c	2006-11-29 20:49:33.000000000 +0100
@@ -459,16 +459,43 @@ serial_pnp_probe(struct pnp_dev *dev, co
 
 static void __devexit serial_pnp_remove(struct pnp_dev *dev)
 {
-	long line = (long)pnp_get_drvdata(dev);
+	int line = (long)pnp_get_drvdata(dev);
 	if (line)
 		serial8250_unregister_port(line - 1);
 }
 
+#ifdef CONFIG_PM
+static int serial_pnp_suspend(struct pnp_dev *dev, pm_message_t state)
+{
+	int line = (int)pnp_get_drvdata(dev);
+
+	if (!line)
+		return -ENODEV;
+	serial8250_suspend_port(line - 1);
+	return 0;
+}
+
+static int serial_pnp_resume(struct pnp_dev *dev)
+{
+	int line = (int)pnp_get_drvdata(dev);
+
+	if (!line)
+		return -ENODEV;
+	serial8250_resume_port(line - 1);
+	return 0;
+}
+#else
+#define serial_pnp_suspend NULL
+#define serial_pnp_resume NULL
+#endif /* CONFIG_PM */
+
 static struct pnp_driver serial_pnp_driver = {
 	.name		= "serial",
-	.id_table	= pnp_dev_table,
 	.probe		= serial_pnp_probe,
 	.remove		= __devexit_p(serial_pnp_remove),
+	.suspend	= serial_pnp_suspend,
+	.resume		= serial_pnp_resume,
+	.id_table	= pnp_dev_table,
 };
 
 static int __init serial8250_pnp_init(void)


