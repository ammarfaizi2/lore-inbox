Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWELHjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWELHjB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 03:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWELHjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 03:39:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34497 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751047AbWELHjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 03:39:00 -0400
Date: Fri, 12 May 2006 08:38:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: cel@citi.umich.edu, lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
Message-ID: <20060512073856.GA9471@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Badari Pulavarty <pbadari@us.ibm.com>, cel@citi.umich.edu,
	lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com> <1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com> <20060511114743.53120432.akpm@osdl.org> <1147374464.12421.24.camel@dyn9047017100.beaverton.ibm.com> <20060511132136.569d59c1.akpm@osdl.org> <4463A269.2080601@us.ibm.com> <4463AB55.2010105@citi.umich.edu> <4463B368.9050602@us.ibm.com> <4463B7B0.4000102@citi.umich.edu> <1147387803.12421.34.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147387803.12421.34.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 03:50:03PM -0700, Badari Pulavarty wrote:
> diff -Naurp -X /usr/src/dontdiff linux-2.6.17-rc3/fs/smbfs/file.c linux-2.6.17-rc3.save/fs/smbfs/file.c
> --- linux-2.6.17-rc3/fs/smbfs/file.c	2006-04-26 19:19:25.000000000 -0700
> +++ linux-2.6.17-rc3.save/fs/smbfs/file.c	2006-05-09 15:30:32.000000000 -0700
> @@ -233,7 +233,7 @@ smb_file_read(struct file * file, char _
>  		(long)dentry->d_inode->i_size,
>  		dentry->d_inode->i_flags, dentry->d_inode->i_atime);
>  
> -	status = generic_file_read(file, buf, count, ppos);
> +	status = do_sync_read(file, buf, count, ppos);
>  out:
>  	return status;
>  }

this look wrong.  The additional work in smb_file_read/smb_file_write
needs to be done in smb_file_aio_read/smb_file_aio_write, and .read/.write
can be set to do_sync_read/do_sync_write directly.

> diff -Naurp -X /usr/src/dontdiff linux-2.6.17-rc3/fs/udf/file.c linux-2.6.17-rc3.save/fs/udf/file.c
> --- linux-2.6.17-rc3/fs/udf/file.c	2006-04-26 19:19:25.000000000 -0700
> +++ linux-2.6.17-rc3.save/fs/udf/file.c	2006-05-09 15:27:28.000000000 -0700
> @@ -136,7 +136,7 @@ static ssize_t udf_file_write(struct fil
>  		}
>  	}
>  
> -	retval = generic_file_write(file, buf, count, ppos);
> +	retval = do_sync_write(file, buf, count, ppos);

ditto.  also IIRC this only happens for the udf write path.

