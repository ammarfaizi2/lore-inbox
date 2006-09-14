Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWINXwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWINXwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWINXwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:52:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932146AbWINXwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:52:09 -0400
Date: Thu, 14 Sep 2006 16:52:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [PATCH 3/7] SLIM main patch
Message-Id: <20060914165205.c56365e7.akpm@osdl.org>
In-Reply-To: <1158083865.18137.13.camel@localhost.localdomain>
References: <1158083865.18137.13.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006 10:57:45 -0700
Kylene Jo Hall <kjhall@us.ibm.com> wrote:

> SLIM is an LSM module which provides an enhanced low water-mark
> integrity and high water-mark secrecy mandatory access control
> model.
> 

trivial things:


> --- linux-2.6.18/security/slim/slm_main.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17-working/security/slim/slm_main.c	2006-09-06 11:49:09.000000000 -0700
> @@ -0,0 +1,1378 @@
> +/*
> + * SLIM - Simple Linux Integrity Module
> + *
> + * Copyright (C) 2005,2006 IBM Corporation
> + * Author: Mimi Zohar <zohar@us.ibm.com>
> + * 	   Kylene Hall <kjhall@us.ibm.com>
> + *
> + *      This program is free software; you can redistribute it and/or modify
> + *      it under the terms of the GNU General Public License as published by
> + *      the Free Software Foundation, version 2 of the License.
> + */
> +
> +#include <linux/mman.h>
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/security.h>
> +#include <linux/integrity.h>
> +#include <linux/proc_fs.h>
> +#include <linux/socket.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include <linux/namei.h>
> +#include <linux/mm.h>
> +#include <linux/shm.h>
> +#include <linux/ipc.h>
> +#include <linux/errno.h>
> +#include <linux/xattr.h>
> +#include <net/sock.h>
> +
> +#include "slim.h"
> +
> +#define XATTR_NAME "security.slim.level"
> +
> +#define ZERO_STR "0"
> +#define UNTRUSTED_STR "UNTRUSTED"
> +#define USER_STR "USER"
> +#define SYSTEM_STR "SYSTEM"
> +
> +char *slm_iac_str[] = {
> +	ZERO_STR,
> +	UNTRUSTED_STR,
> +	USER_STR,
> +	SYSTEM_STR
> +};

Could this be made static?

> +static char *get_token(char *buf_start, char *buf_end, char delimiter,
> +		       int *token_len)
> +{
> +	char *bufp = buf_start;
> +	char *token = NULL;
> +
> +	while (!token && (bufp < buf_end)) {	/* Get start of token */
> +		switch (*bufp) {
> +		case ' ':
> +		case '\n':
> +		case '\t':
> +			bufp++;
> +			break;
> +		case '#':
> +			while ((*bufp != '\n') && (bufp++ < buf_end)) ;

newline needed here.

> +
> +/*
> + * Determine if a file is opened with write permissions.
> + */
> +static int has_file_wperm(struct slm_file_xattr *cur_level)
> +{
> +	int i, j = 0;
> +	struct files_struct *files = current->files;
> +	unsigned long fd = 0;
> +	struct fdtable *fdt;
> +	struct file *file;
> +	int rc = 0;
> +
> +	if (is_kernel_thread(current))
> +		return 0;
> +
> +	if (!files || !cur_level)
> +		return 0;
> +
> +	spin_lock(&files->file_lock);
> +	fdt = files_fdtable(files);
> +
> +	for (;;) {
> +		i = j * __NFDBITS;
> +		if (i >= fdt->max_fdset || i >= fdt->max_fds)
> +			break;
> +		fd = fdt->open_fds->fds_bits[j++];
> +		while (fd) {
> +			if (fd & 1) {
> +				file = fdt->fd[i++];
> +				if (file)
> +					rc = mark_has_file_wperm(file,
> +						cur_level);
> +			}
> +			fd >>= 1;
> +		}
> +	}
> +	spin_unlock(&files->file_lock);
> +	return rc;
> +}

Could we use a more meaningful identifier than `j' here?  Perhaps `i' too?


> +#define EXEMPT_STR "EXEMPT"
> +static enum slm_iac_level parse_iac(char *token)
> +{
> +	int iac;
> +
> +	if (strncmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
> +		return SLM_IAC_EXEMPT;
> +	for (iac = 0; iac < sizeof(slm_iac_str) / sizeof(char *); iac++) {

ARRAY_SIZE()

> +		if (strncmp(token, slm_iac_str[iac], strlen(slm_iac_str[iac]))
> +		    == 0)
> +			return iac;
> +	}
> +	return SLM_IAC_ERROR;
> +}
> +
>
> ...
>
> +
> +static inline int slm_getprocattr(struct task_struct *tsk,
> +				  char *name, void *value, size_t size)

It's rather pointless to declare a function inline and to then only refer to
it via a pointer-to-function.  Please review all inlinings.


