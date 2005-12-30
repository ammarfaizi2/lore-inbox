Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVL3SP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVL3SP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 13:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVL3SP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 13:15:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14814 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750877AbVL3SP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 13:15:56 -0500
Subject: Re: [PATCH 12 of 20] ipath - misc driver support code
From: Arjan van de Ven <arjan@infradead.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <5e9b0b7876e2d570f25e.1135816291@eng-12.pathscale.com>
References: <5e9b0b7876e2d570f25e.1135816291@eng-12.pathscale.com>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 19:15:47 +0100
Message-Id: <1135966547.2941.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +int ipath_get_upages_nocopy(unsigned long start_page, struct page **p)
> +{
> +	int n;
> +	struct vm_area_struct *vm = NULL;
> +
> +	down_read(&current->mm->mmap_sem);
> +	n = get_user_pages(current, current->mm, start_page, 1, 1, 1, p, &vm);
> +	up_read(&current->mm->mmap_sem);
> +	if (n != 1) {
> +		_IPATH_INFO("get_user_pages for 0x%lx failed with %d\n",
> +			    start_page, n);
> +		if (n < 0)	/* it's an errno */
> +			return n;
> +		/*
> +		 * If we ever ask for more than a single page, we will have to
> +		 * free the pages (if any) that we did get, via ipath_get_upages()
> +		 * or put_page() directly.
> +		 */
> +		return -ENOMEM;	/* no way to know actual error */
> +	}
> +	vm->vm_flags |= VM_SHM | VM_LOCKED;
> +
> +	return 0;
> +}


I hope you're not depending on the VM_LOCKED thing.. since the user can
just undo that easily!

(this is also why all this "sys_mlock from the driver" is traditionally
buggy to the point of being a roothole, things like some of the binary
3D drivers have had this security hole for a long time, as did some of
the early infiniband drivers)

