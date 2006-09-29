Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWI2Gpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWI2Gpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWI2Gpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:45:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030193AbWI2Gpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:45:46 -0400
Date: Thu, 28 Sep 2006 23:45:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 006 of 8] knfsd: nfsd4: fslocations data structures
Message-Id: <20060928234540.fd74f1e1.akpm@osdl.org>
In-Reply-To: <1060929030913.24108@suse.de>
References: <20060929130518.23919.patches@notabene>
	<1060929030913.24108@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 13:09:13 +1000
NeilBrown <neilb@suse.de> wrote:

> 
> From: Manoj Naik <manoj@almaden.ibm.com>
> 
> Define FS locations structures, some functions to manipulate them, and add
> code to parse FS locations in downcall and add to the exports structure.
> 
> ...
>  
> +#ifdef CONFIG_NFSD_V4
> +
> +static int
> +fsloc_parse(char **mesg, char *buf, struct nfsd4_fs_locations *fsloc)
> +{
> +	int len;
> +	int migrated, i, err;
> +
> +	len = qword_get(mesg, buf, PAGE_SIZE);
> +	if (len != 5 || memcmp(buf, "fsloc", 5))
> +		return 0;
> +
> +	/* listsize */
> +	err = get_int(mesg, &fsloc->locations_count);
> +	if (err)
> +		return err;
> +	if (fsloc->locations_count < 0)

this is unsigned.

> +		return -EINVAL;
> +	if (fsloc->locations_count == 0)
> +		return 0;
> +
> +	fsloc->locations = kzalloc(fsloc->locations_count
> +			* sizeof(struct nfsd4_fs_location), GFP_KERNEL);

This is subject to multiplication overflow.  If it's a privileged operation
and isn't dependent on stuff coming in over the wire then ok..


> +	if (!fsloc->locations)
> +		return -ENOMEM;
> +	for (i=0; i < fsloc->locations_count; i++) {
> +		/* colon separated host list */
> +		err = -EINVAL;
> +		len = qword_get(mesg, buf, PAGE_SIZE);
> +		if (len <= 0)
> +			goto out_free_all;
> +		err = -ENOMEM;
> +		fsloc->locations[i].hosts = kstrdup(buf, GFP_KERNEL);
> +		if (!fsloc->locations[i].hosts)
> +			goto out_free_all;
> +		err = -EINVAL;
> +		/* slash separated path component list */
> +		len = qword_get(mesg, buf, PAGE_SIZE);
> +		if (len <= 0)
> +			goto out_free_all;
> +		err = -ENOMEM;
> +		fsloc->locations[i].path = kstrdup(buf, GFP_KERNEL);
> +		if (!fsloc->locations[i].path)
> +			goto out_free_all;
> +	}
> +	/* migrated */
> +	err = get_int(mesg, &migrated);
> +	if (err)
> +		goto out_free_all;
> +	err = -EINVAL;
> +	if (migrated < 0 || migrated > 1)
> +		goto out_free_all;
> +	fsloc->migrated = migrated;
> +	return 0;
> +out_free_all:
> +	nfsd4_fslocs_free(fsloc);

This call to nfsd4_fslocs_free() can end up kfreeing members of
fsloc->locations[] which haven't been initialised here.  Are we sure the
caller set them all to zero?

> +	return err;
> +}
> +
> +#else /* CONFIG_NFSD_V4 */
> +static int fsloc_parse(char **, char *, struct svc_export *) { return 0; }

static inline

This has a different prototype from the other version of fsloc_parse()

This ain't C++ - function arguments need identifiers as well as types.

Someone needs to read Documentation/SubmitChecklist..


