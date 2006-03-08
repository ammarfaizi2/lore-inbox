Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWCHS3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWCHS3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 13:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWCHS3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 13:29:52 -0500
Received: from fmr23.intel.com ([143.183.121.15]:21394 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932088AbWCHS3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 13:29:51 -0500
Message-Id: <200603081828.k28ISgg10244@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zhang, Yanmin'" <yanmin_zhang@linux.intel.com>,
       <linux-kernel@vger.kernel.org>
Cc: "David Gibson" <david@gibson.dropbear.id.au>
Subject: RE: [PATCH] ftruncate on huge page couldn't extend hugetlb file
Date: Wed, 8 Mar 2006 10:28:41 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZCYDLuW1VM4urZT2amDQ9wuPaiVQAfW87w
In-Reply-To: <1141788278.29825.89.camel@ymzhang-perf.sh.intel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang, Yanmin wrote on Tuesday, March 07, 2006 7:25 PM
> Currently, ftruncate on hugetlb files couldn't extend them. My patch enables it.
> 
> This patch is against 2.6.16-rc5-mm3 and on the top of the patch which
> implements mmap on zero-length hugetlb files with PROT_NONE.

> -
> -	inode->i_size = offset;
> -	spin_lock(&mapping->i_mmap_lock);
> -	if (!prio_tree_empty(&mapping->i_mmap))
> -		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
> -	spin_unlock(&mapping->i_mmap_lock);
> -	truncate_hugepages(inode, offset);
> +        if (offset > inode->i_size) {
> +        	if (hugetlb_extend_reservation(HUGETLBFS_I(inode), pgoff) != 0)
> +			return -ENOMEM;
> +		inode->i_size = offset;
> +	}
> +	else {
> +
> +		inode->i_size = offset;
> +		spin_lock(&mapping->i_mmap_lock);
> +		if (!prio_tree_empty(&mapping->i_mmap))
> +			hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
> +		spin_unlock(&mapping->i_mmap_lock);
> +		truncate_hugepages(inode, offset);
> +	}
>  	return 0;
>  }
 
Hmm??  I don't think you need to extend the reservation when extending
hugetlb file via ftruncate.  You don't have any vma that pass beyond
current size.  So making a reservation is a wrong thing to do here.

- Ken

