Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWBRKWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWBRKWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 05:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWBRKV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 05:21:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27540 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751149AbWBRKV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 05:21:58 -0500
Date: Sat, 18 Feb 2006 02:20:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Deal properly with strnlen_user()
Message-Id: <20060218022026.348e3b39.akpm@osdl.org>
In-Reply-To: <8396.1140188581@warthog.cambridge.redhat.com>
References: <8396.1140188581@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> +#define key_get_type_from_user(type, _type, error)		\
>  +do {								\
>  +	ret = strncpy_from_user(type, _type, sizeof(type));	\
>  +	if (ret < 0)						\
>  +		goto error;					\
>  +								\
>  +	if (ret == 0 || ret > sizeof(type) - 1) {		\
>  +		ret = -EINVAL;					\
>  +		goto error;					\
>  +	}							\
>  +								\
>  +	ret = -EPERM;						\
>  +	if (type[0] == '.')					\
>  +		goto error;					\
>  +								\
>  +	type[31] = '\0';					\
>  +} while(0)
>  +
>  +#define key_get_description_from_user(desc, _desc, dlen, error, error2)	\
>  +do {									\
>  +	ret = -EFAULT;							\
>  +	dlen = strnlen_user(_desc, PAGE_SIZE);				\
>  +	if (dlen <= 0)							\
>  +		goto error;						\
>  +									\
>  +	ret = -EINVAL;							\
>  +	if (dlen > PAGE_SIZE)						\
>  +		goto error;						\
>  +									\
>  +	ret = -ENOMEM;							\
>  +	desc = kmalloc(dlen, GFP_KERNEL);				\
>  +	if (!desc)							\
>  +		goto error;						\
>  +									\
>  +	ret = -EFAULT;							\
>  +	if (copy_from_user(desc, _desc, dlen - 1) != 0)			\
>  +		goto error2;						\
>  +									\
>  +	desc[dlen - 1] = '\0';						\
>  +} while(0)

ug.  Well it's your code ;)

It should really parameterise `ret' too.

Are you sure you want to do this?  From my reading, doing it with plain old
subroutines would work?
