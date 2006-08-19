Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422770AbWHSUQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbWHSUQo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 16:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422774AbWHSUQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 16:16:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60069 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422770AbWHSUQn (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 16:16:43 -0400
Date: Sat, 19 Aug 2006 21:16:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] Reiser4 bug fixes
Message-ID: <20060819201612.GB12853@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
References: <44BE947F.30507@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BE947F.30507@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 01:22:23PM -0700, Hans Reiser wrote:
> Hopefully this will make reiser4 stable code again.  Or at least, a lot more stable than v3 (or other FSes) was when it went in....
> 
> 
> Signed-off-by: Hans Reiser
> 
> From: Vladimir Saveliev <vs@namesys.com>
> 
> This patch contains 4 reiser4 bug fixes:
> - missing long term lock unlock on read' error handling code path is added
> - truncate_inode_pages is now called with embedded mapping. 
>   It is needed to deal properly with block device special files.
> - copy_to_user might be called for more bytes than was prefaulted with fault_in_pages_writeable.
>   That caused undesirable major page faults.
> - readdir bug similar to the previous one:
>   call to filldir might lead to deadlock due to major page fault.
> 
> Signed-off-by: Vladimir Saveliev <vs@namesys.com>
> 
> 
> 
> diff -puN fs/reiser4/super_ops.c~reiser4-one-line-fixes fs/reiser4/super_ops.c
> --- linux-2.6.18-rc-mm2/fs/reiser4/super_ops.c~reiser4-one-line-fixes	2006-07-19 16:25:49.000000000 +0400
> +++ linux-2.6.18-rc-mm2-vs/fs/reiser4/super_ops.c	2006-07-19 16:25:49.000000000 +0400
> @@ -202,7 +202,7 @@ static void reiser4_delete_inode(struct 
>  			fplug->delete_object(inode);
>  	}
>  
> -	truncate_inode_pages(inode->i_mapping, 0);
> +	truncate_inode_pages(&inode->i_data, 0);

Where do you reset i_mapping to be different from i_data?  It is a valid
thing to do in theory (that's why we have those different fields), but in
practice most usages I've seen are bogus.

(And yes, this is not a personal attack again you, just a normal review)

