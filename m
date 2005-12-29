Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVL2TYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVL2TYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbVL2TYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:24:40 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:44764 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750882AbVL2TYk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:24:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GSG4xkVqOdZiBho6J2E9Tz0Zw+iu4wFFCJ1Oh8Arnherkajg0lQTY0oh15HIxOXu3AMSqdH2DlyyuLk9tjilxsC7m30sJZ8g2s7GWF/d3s+CCVfuDds8mK6oG3MoJFg/UGiDhXsWgQ8jxCEuIlTxkM4M/2DhpzwRkVbQnovY0BE=
Message-ID: <84144f020512291124sd895dfbp87ca9fd75552d671@mail.gmail.com>
Date: Thu, 29 Dec 2005 21:24:38 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH 17 of 20] ipath - infiniband verbs support, part 3 of 3
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <584777b6f4dc5269fa89.1135816296@eng-12.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <584777b6f4dc5269fa89.1135816296@eng-12.pathscale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Copy-paste reuse alert!]

On 12/29/05, Bryan O'Sullivan <bos@pathscale.com> wrote:
> +static struct ib_mr *ipath_reg_phys_mr(struct ib_pd *pd,
> +                                      struct ib_phys_buf *buffer_list,
> +                                      int num_phys_buf,
> +                                      int acc, u64 *iova_start)
> +{
> +       struct ipath_mr *mr;
> +       int n, m, i;
> +
> +       /* Allocate struct plus pointers to first level page tables. */
> +       m = (num_phys_buf + IPATH_SEGSZ - 1) / IPATH_SEGSZ;
> +       mr = kmalloc(sizeof *mr + m * sizeof mr->mr.map[0], GFP_KERNEL);
> +       if (!mr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /* Allocate first level page tables. */
> +       for (i = 0; i < m; i++) {
> +               mr->mr.map[i] = kmalloc(sizeof *mr->mr.map[0], GFP_KERNEL);
> +               if (!mr->mr.map[i]) {
> +                       while (i)
> +                               kfree(mr->mr.map[--i]);
> +                       kfree(mr);
> +                       return ERR_PTR(-ENOMEM);
> +               }
> +       }
> +       mr->mr.mapsz = m;

[snip, snip]

> +static struct ib_mr *ipath_reg_user_mr(struct ib_pd *pd,
> +                                      struct ib_umem *region,
> +                                      int mr_access_flags,
> +                                      struct ib_udata *udata)
> +{
> +       struct ipath_mr *mr;
> +       struct ib_umem_chunk *chunk;
> +       int n, m, i;
> +
> +       n = 0;
> +       list_for_each_entry(chunk, &region->chunk_list, list)
> +           n += chunk->nents;
> +
> +       /* Allocate struct plus pointers to first level page tables. */
> +       m = (n + IPATH_SEGSZ - 1) / IPATH_SEGSZ;
> +       mr = kmalloc(sizeof *mr + m * sizeof mr->mr.map[0], GFP_KERNEL);
> +       if (!mr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /* Allocate first level page tables. */
> +       for (i = 0; i < m; i++) {
> +               mr->mr.map[i] = kmalloc(sizeof *mr->mr.map[0], GFP_KERNEL);
> +               if (!mr->mr.map[i]) {
> +                       while (i)
> +                               kfree(mr->mr.map[--i]);
> +                       kfree(mr);
> +                       return ERR_PTR(-ENOMEM);
> +               }
> +       }
> +       mr->mr.mapsz = m;

[snip, more duplicate code]

The above fragment is repeated at least three times. Please factor out
the common code into separate functions.

                              Pekka
