Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVEQUkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVEQUkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVEQUkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:40:52 -0400
Received: from orb.pobox.com ([207.8.226.5]:55215 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261950AbVEQUki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:40:38 -0400
Date: Tue, 17 May 2005 15:40:29 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/8] ppc64: add a watchdog driver for rtas
Message-ID: <20050517204029.GA2748@otto>
References: <200505132117.37461.arnd@arndb.de> <200505132124.48963.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505132124.48963.arnd@arndb.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> +static volatile int wdrtas_miscdev_open = 0;
...
> +static int
> +wdrtas_open(struct inode *inode, struct file *file)
> +{
> +	/* only open once */
> +	if (xchg(&wdrtas_miscdev_open,1))
> +		return -EBUSY;

The volatile and xchg strike me as an obscure method for ensuring only
one process at a time can open this file.  Any reason a semaphore
couldn't be used?

> +static int
> +wdrtas_close(struct inode *inode, struct file *file)
> +{
> +	/* only stop watchdog, if this was announced using 'V' before */
> +	if (wdrtas_expect_close == WDRTAS_MAGIC_CHAR)
> +		wdrtas_timer_stop();
> +	else {
> +		printk("wdrtas: got unexpected close. Watchdog "
> +		       "not stopped.\n");

printk's need a valid log level specified.  There are several in this
file that lack them.


Nathan
