Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVHBKQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVHBKQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVHBKQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 06:16:57 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:17186 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261465AbVHBKQ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 06:16:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iCT5SzVaTZxS7Fjqa+SxFdfx165/wLewepmZwU01CZe8uf+wq1mZ8DqaDUOAMWtJFy2GuM2MM1pK3cgGzMpKeWKvNPS48dbIoJk7ALQ1xfebHwT8PPgPiLYV8IUhrrrfbLfaRB3xBirbpIlGQBrG1LsM3Dltz6DwA8ChuUbX9Jc=
Message-ID: <84144f0205080203163cab015c@mail.gmail.com>
Date: Tue, 2 Aug 2005 13:16:53 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: [PATCH 00/14] GFS
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <20050802071828.GA11217@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050802071828.GA11217@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 8/2/05, David Teigland <teigland@redhat.com> wrote:
> Hi, GFS (Global File System) is a cluster file system that we'd like to
> see added to the kernel.  The 14 patches total about 900K so I won't send
> them to the list unless that's requested.  Comments and suggestions are
> welcome.  Thanks

> +#define kmalloc_nofail(size, flags) \
> +	gmalloc_nofail((size), (flags), __FILE__, __LINE__)

[snip]

> +void *gmalloc_nofail_real(unsigned int size, int flags, char *file,
> +			  unsigned int line)
> +{
> +	void *x;
> +	for (;;) {
> +		x = kmalloc(size, flags);
> +		if (x)
> +			return x;
> +		if (time_after_eq(jiffies, gfs2_malloc_warning + 5 * HZ)) {
> +			printk("GFS2: out of memory: %s, %u\n",
> +			       __FILE__, __LINE__);
> +			gfs2_malloc_warning = jiffies;
> +		}
> +		yield();

This does not belong in a filesystem. It also seems like a very bad
idea. What are you trying to do here? If you absolutely must not fail,
use __GFP_NOFAIL instead.

> +	}
> +}
> +
> +#if defined(GFS2_MEMORY_SIMPLE)
> +
> +atomic_t gfs2_memory_count;
> +
> +void gfs2_memory_add_i(void *data, char *file, unsigned int line)
> +{
> +	atomic_inc(&gfs2_memory_count);
> +}
> +
> +void gfs2_memory_rm_i(void *data, char *file, unsigned int line)
> +{
> +	if (data)
> +		atomic_dec(&gfs2_memory_count);
> +}
> +
> +void *gmalloc(unsigned int size, int flags, char *file, unsigned int line)
> +{
> +	void *data = kmalloc(size, flags);
> +	if (data)
> +		atomic_inc(&gfs2_memory_count);
> +	return data;
> +}
> +
> +void *gmalloc_nofail(unsigned int size, int flags, char *file,
> +		     unsigned int line)
> +{
> +	atomic_inc(&gfs2_memory_count);
> +	return gmalloc_nofail_real(size, flags, file, line);
> +}
> +
> +void gfree(void *data, char *file, unsigned int line)
> +{
> +	if (data) {
> +		atomic_dec(&gfs2_memory_count);
> +		kfree(data);
> +	}
> +}

-mm has memory leak detection patches and there are others floating
around. Please do not introduce yet another subsystem-specific debug allocator.

                                    Pekka
