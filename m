Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752183AbWCJI6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbWCJI6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbWCJI6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:58:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7611 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752183AbWCJI6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:58:53 -0500
Date: Fri, 10 Mar 2006 00:56:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: dev@openvz.org, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk,
       devel@openvz.org, saw@saw.sw.com.sg
Subject: Re: [PATCH] ext3: ext3_symlink should use GFP_NOFS allocations
 inside (ver. 3)
Message-Id: <20060310005634.292a26f5.akpm@osdl.org>
In-Reply-To: <1141980385.2876.30.camel@laptopd505.fenrus.org>
References: <44113CCC.5080602@openvz.org>
	<1141980385.2876.30.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Fri, 2006-03-10 at 11:46 +0300, Kirill Korotaev wrote:
> > Andrew,
> > 
> > Fixed both comments from Al Viro (thanks, Al):
> > - should have a separate helper
> > - should pass 0 instead of GFP_KERNEL in page_symlink()
> 
> >  
> > +	page = find_or_create_page(mapping, 0,
> > +			mapping_gfp_mask(mapping) | gfp_mask);
> 
> 
> 
> this does not work; GFP_NOFS has a bit *LESS* than GFP_KERNEL, not a bit
> more. As such a | operation isn't going to be useful....
> 
> (So I think that while Al's intention was good, the implication of it
> isn't ;)

Yup.  page_symlink() needs to pass in mapping_gfp_mask(inode->i_mapping)
and ext3 needs to pass in, umm,

	mapping_gfp_mask(inode->i_mapping) & ~__GFP_FS

or

	GFP_NOFS|__GFP_HIGHMEM.

preferably the former I guess.
