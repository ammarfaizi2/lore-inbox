Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSHTHci>; Tue, 20 Aug 2002 03:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSHTHci>; Tue, 20 Aug 2002 03:32:38 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:10278 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S316113AbSHTHch>; Tue, 20 Aug 2002 03:32:37 -0400
Date: Tue, 20 Aug 2002 09:35:39 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: kuebelr@email.uc.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cdrom per drive sysctl's
Message-Id: <20020820093539.5b8fef35.kristian.peters@korseby.net>
In-Reply-To: <20020819200927.GA8771@cartman>
References: <20020819200927.GA8771@cartman>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686-debian-linux-gnu 2.4.19
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuebelr@email.uc.edu schrieb:
> currently, users cannot change cdrom sysctls (debug, autoclose, lock,
> etc.) on a per drive basis.  this patch implements a per-drive
> sysctl/proc interface based on Jens Axboe's TODO list in cdrom.c.

Seems fine to me. And it reduces size of the module.
What about user-space apps ? Wouldn't the patch break those apps that try to read stats the old way ? Then It's probably better for linux 2.5.

> [...]
> +static void cdrom_register_sysctl(struct cdrom_device_info *cdi) {
> +	struct cdrom_sysctl_table *cst;
> +
> +	cdi->sysctl_table = kmalloc(sizeof(struct cdrom_sysctl_table), GFP_KERNEL);
> +	if (!cdi->sysctl_table)
> +		goto err;
> +

I personally would use:

	if ( (cdi->sysctl_table = kmalloc(sizeof(struct cdrom_sysctl_table), GFP_KERNEL)) == NULL)
		goto err;

But that doesn't make any difference for gcc I think.

> +	cst = cdi->sysctl_table;
> +
> +	/* copy the default settings for the new drive */
> +	memcpy(cst, &cdrom_table, sizeof(struct cdrom_sysctl_table));

Hm. I don't understand this. Why are you applying the default settings to a new entry hence they're overwritten later ?

> +	cst->options_table[0].data = &cst->options.autoclose;
> +	cst->options_table[1].data = &cst->options.autoeject;
> +	cst->options_table[2].data = &cst->options.debug;
> +	cst->options_table[3].data = &cst->options.lock;
> +	cst->options_table[4].data = &cst->options.check_media;
> +	cst->options_table[5].procname = "info";
> +	cst->options_table[5].extra1 = cdi;
> +	cst->drive_table[0].child = cst->options_table;
> +	cst->drive_table[0].procname = cdi->name;
> +	cst->drive_table[0].ctl_name = kdev_t_to_nr(cdi->dev);
> +	cst->cdrom_table[0].child = cst->drive_table;
> +	cst->dev_table[0].child = cst->cdrom_table;
> +
> +	cst->sysctl_header = register_sysctl_table(cst->dev_table, 0);
> +	if (cst->sysctl_header)
> +		return;
> +
> +	kfree(cdi->sysctl_table);
> +err:
> +	cdinfo(CD_WARNING, "failed to register sysctl table for %s\n", cdi->name);
> +	return;
> +}
> [...]

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
