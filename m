Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267568AbUIOVgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267568AbUIOVgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUIOVd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:33:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:43437 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267523AbUIOV12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:27:28 -0400
Date: Wed, 15 Sep 2004 14:31:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: hari@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, suparna@in.ibm.com,
       mbligh@aracnet.com, ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [PATCH][5/6]ELF format dump file access
Message-Id: <20040915143111.23dac3d7.akpm@osdl.org>
In-Reply-To: <20040915125631.GF15450@in.ibm.com>
References: <20040915125041.GA15450@in.ibm.com>
	<20040915125145.GB15450@in.ibm.com>
	<20040915125322.GC15450@in.ibm.com>
	<20040915125422.GD15450@in.ibm.com>
	<20040915125525.GE15450@in.ibm.com>
	<20040915125631.GF15450@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> wrote:
>
> +/*
> + * Reads from the oldmem device from given offset till
> + * given count
> + */
> +static ssize_t read_from_oldmem(char *buf, size_t count,
> +			     loff_t *ppos, int userbuf)
> +{
> +	unsigned long pfn, p = *ppos;
> +	size_t read = 0;
> +
> +	pfn = p / PAGE_SIZE;
> +	p = p % PAGE_SIZE;
> +
> +	if (pfn > saved_max_pfn) {
> +		read = -EINVAL;
> +		goto done;
> +	}
> +
> +	if (count > PAGE_SIZE - p)
> +		count = PAGE_SIZE - p;
> +
> +	if (copy_oldmem_page(pfn, buf, count, userbuf)) {
> +		read = -EFAULT;
> +		goto done;
> +	}
> +
> +	*ppos += count;

hm, what's going on here?  *ppos is a loff_t but you've copied it
into a 32-bit local prior to calculating the pfn.
