Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUHYO1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUHYO1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUHYO1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:27:17 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:45065 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264997AbUHYO1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:27:02 -0400
Date: Wed, 25 Aug 2004 15:26:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michal Ludvig <mludvig@suse.cz>
Cc: CryptoAPI List <cryptoapi@lists.logix.cz>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] /dev/crypto for Linux
Message-ID: <20040825152651.A8381@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michal Ludvig <mludvig@suse.cz>,
	CryptoAPI List <cryptoapi@lists.logix.cz>,
	linux-kernel@vger.kernel.org, James Morris <jmorris@redhat.com>
References: <412BB517.4040204@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412BB517.4040204@suse.cz>; from mludvig@suse.cz on Tue, Aug 24, 2004 at 11:37:27PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int verbosity = 0;

no need to initialize to 0

> +module_param(verbosity, int, 0644);
> +MODULE_PARM_DESC(verbosity, "0: normal, 1: verbose, 2: debug");
> +
> +#ifdef CRYPTODEV_STATS

whi is this not a config option?

> +static int enable_stats = 0;

as above

> +	copy_from_user(alg_name, sop->alg_name, sop->alg_namelen);

this needs error checking.

> +	keyp = kmalloc(sop->keylen, GFP_KERNEL);

retval checking

> +	copy_from_user(keyp, sop->key, sop->keylen);

error checking

> +	if(down_trylock(&ses_ptr->sem)) {
> +		dprintk(2, KERN_DEBUG, "Waiting for semaphore of sid=0x%08X\n",
> +			ses_ptr->sid);
> +		down(&ses_ptr->sem);
> +	}

just use down please

> +static int
> +clonefd(struct file *filp)
> +{
> +	struct files_struct * files = current->files;
> +	int fd;
> +
> +	fd = get_unused_fd();
> +	if (fd >= 0) {
> +		get_file(filp);
> +		FD_SET(fd, files->open_fds);
> +		fd_install(fd, filp);
> +	}
> +
> +	return fd;
> +}

Yikes.

> +static int
> +cryptodev_ioctl(struct inode *inode, struct file *filp,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	struct session_op sop;
> +	struct crypt_op cop;
> +	struct fcrypt *fcr = filp->private_data;
> +	uint32_t ses;
> +	int ret, fd;
> +
> +	if (!fcr)
> +		BUG();
> +
> +	switch (cmd) {
> +		case CRIOGET:
> +			fd = clonefd(filp);
> +			put_user(fd, (int*)arg);
> +			return 0;

Extremly bad API.  Just allow opening the device multiple times,
and get a new context each time (can be stored in file->private_data

> +		case CIOCGSESSION:
> +			copy_from_user(&sop, (void*)arg, sizeof(sop));
> +			ret = crypto_create_session(fcr, &sop);
> +			if (ret)
> +				return ret;
> +			copy_to_user((void*)arg, &sop, sizeof(sop));

missing error check.

> +			return 0;
> +
> +		case CIOCFSESSION:
> +			get_user(ses, (uint32_t*)arg);

dito

> +			ret = crypto_finish_session(fcr, ses);
> +			return ret;
> +
> +		case CIOCCRYPT:
> +			copy_from_user(&cop, (void*)arg, sizeof(cop));
> +			ret = crypto_run(fcr, &cop);
> +			copy_to_user((void*)arg, &cop, sizeof(cop));

dito


besides the rather crappy implementation I'm not sure a crypto device
makes any sense until we have hardware accelerators, and for these this
is most likely not he right API
