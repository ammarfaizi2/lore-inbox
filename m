Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbUJZBy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbUJZBy7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUJZBwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:52:07 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4051 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261923AbUJZBTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:19:08 -0400
Date: Mon, 25 Oct 2004 16:45:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: cmm@us.ibm.com, ray-lk@madrabbit.org, sct@redhat.com, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [PATCH 2/3] ext3 reservation allow turn off
 for specifed file
Message-Id: <20041025164516.1f02bb9f.akpm@osdl.org>
In-Reply-To: <1098745548.9754.7427.camel@w-ming2.beaverton.ibm.com>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	<1097856114.4591.28.camel@localhost.localdomain>
	<1097858401.1968.148.camel@sisko.scot.redhat.com>
	<1097872144.4591.54.camel@localhost.localdomain>
	<1097878826.1968.162.camel@sisko.scot.redhat.com>
	<109787 
	<1098147705.8803.1084.camel@w-ming2.beaverton.ibm.com>
	<1098294941.18850.4.camel@orca.madrabbit.org>
	<1098736389.9692.7243.camel@w-ming2.beaverton.ibm.com>
	<1098745548.9754.7427.camel@w-ming2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> 	/*
> +	 * if user passed a seeky-access hint to kernel,
> +	 * through POSIX_FADV_RANDOM,(file->r_ra.ra_pages is cleared)
> +	 * turn off reservation for block allocation correspondingly.
> +	 *
> +	 * Otherwise, if user switch back to POSIX_FADV_SEQUENTIAL or
> +	 * POSIX_FADV_NORMAL, re-open the reservation window.
> +	 */
> +	windowsz = atomic_read(&EXT3_I(inode)->i_rsv_window.rsv_goal_size);
> +	if ((windowsz > 0) && (!file->f_ra.ra_pages))
> +		atomic_set(&EXT3_I(inode)->i_rsv_window.rsv_goal_size, -1);
> +	if ((windowsz == -1) && file->f_ra.ra_pages)
> +		atomic_set(&EXT3_I(inode)->i_rsv_window.rsv_goal_size,
> +					EXT3_DEFAULT_RESERVE_BLOCKS);
> +

It's pretty sad that we add this extra code into ext3_prepare_write() -
it's almost never actually executed.

I wonder how important this optimisation really is?  I bet no applications
are using posix_fadvise(POSIX_FADV_RANDOM) anyway.

It we really see that benefits are available from this approach we probably
need to bite the bullet and add file_operations.fadvise()
