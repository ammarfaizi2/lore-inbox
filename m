Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWERRl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWERRl3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 13:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWERRl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 13:41:29 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:32940 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932102AbWERRl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 13:41:29 -0400
Date: Thu, 18 May 2006 19:41:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 01/16] ehca: module infrastructure
Message-ID: <20060518174112.GB26113@wohnheim.fh-wedel.de>
References: <4468BD39.3010008@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4468BD39.3010008@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006 19:41:13 +0200, Heiko J Schick wrote:
> + *  This source code is distributed under a dual license of GPL v2.0 and 
> OpenIB

Your mailer is still mangling long lines, it seems.  If you need a
quick solution, I could offer you a gmail invite.

> +
> +	EDEB_EX(7, "ret=%x", ret);
> +
> +	return ret;
> +
> +create_aqp1:
> +	ib_destroy_cq(sport->ibcq_aqp1);
> +
> +	EDEB_EX(7, "ret=%x", ret);
> +
> +	return ret;
> +}

Those two cases could be combined with a goto.  Saves a tiny amount of
rodata.

> +#define EHCA_RESOURCE_ATTR(name)                                           
> \
> +static ssize_t  ehca_show_##name(struct device *dev,                       
> \

You have spaces instead of tabs in the lines the mailer mangled.

> +                                                                           
> \
> +	data = rblock->name;                                               \
> +	kfree(rblock);                                                     \
> +									   \
> +	if ((strcmp(#name, "num_ports") == 0) && (ehca_nr_ports == 1))	   \
> +		return snprintf(buf, 256, "1\n");			   \
> +	else								   \
> +		return snprintf(buf, 256, "%d\n", data);		   \
> +									   \

Is rblock->num_ports uninitialized when (ehca_nr_ports == 1)?  Looks
rather odd.

> +	shca = (struct ehca_shca *)ib_alloc_device(sizeof(*shca));

A quick grep showed that every single return value of
ib_alloc_device() has a cast.
Roland, can't you just change ib_alloc_device() to return void*?

> +static struct of_device_id ehca_device_table[] =
> +{
> +	{
> +		.name       = "lhca",
> +		.compatible = "IBM,lhca",
> +	},
> +	{},
> +};

Is the extra element needed?

> +	if ((ret = ehca_create_slab_caches(&ehca_module))) {
> +		EDEB_ERR(4, "Cannot create SLAB caches");
> +		ret = -ENOMEM;
> +		goto module_init1;
> +	}

	ret = try_something()
	if (ret) {
		...
	}

> +	ehca_module.timer.data = (unsigned long)(void*)&ehca_module;

Why the double cast?

Jörn

-- 
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike
