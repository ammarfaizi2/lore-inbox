Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131131AbRADWog>; Thu, 4 Jan 2001 17:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131552AbRADWo0>; Thu, 4 Jan 2001 17:44:26 -0500
Received: from zeus.kernel.org ([209.10.41.242]:8723 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131131AbRADWoO>;
	Thu, 4 Jan 2001 17:44:14 -0500
Date: Thu, 4 Jan 2001 22:42:34 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Asang K Dani <asang@yahoo.com>, linux-kernel@vger.kernel.org,
        sct@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: generic_file_write code segment in 2.2.18
Message-ID: <20010104224234.B1290@redhat.com>
In-Reply-To: <20010104052948.12042.qmail@web2303.mail.yahoo.com> <20010104085137.A18532@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010104085137.A18532@gruyere.muc.suse.de>; from ak@suse.de on Thu, Jan 04, 2001 at 08:51:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 04, 2001 at 08:51:37AM +0100, Andi Kleen wrote:
> On Wed, Jan 03, 2001 at 09:29:48PM -0800, Asang K Dani wrote:
> 
> The code is buggy as far as I can see. copy_from_user doesn't return the 
> number of bytes copied, but the number of bytes not copied when an error
> occurs (or 0 on success).  

But in this case, _any_ non-zero number of bytes copied is a success,
because it indicates that we have dirtied a portion of the page cache.

> Correct would be:
> 
> 	
> --- linux-work/mm/filemap.c-o	Wed Jan  3 17:37:27 2001
>  		dest = (char *) page_address(page) + offset;
>  		if (dest != buf) { /* See comment in update_vm_cache_cond. */
> -			bytes -= copy_from_user(dest, buf, bytes);
> +			if (copy_from_user(dest, buf, bytes))
> +				status = -EFAULT; 
>  			flush_dcache_page(page_address(page));
>  		}
> -		status = -EFAULT;
> -		if (bytes)
> +		if (!status)
>  			status = inode->i_op->updatepage(file, page, offset, bytes, sync);

No, because then you'd be skipping the updatepage() call if we took a
fault mid-copy after copying some data.  That would imply you had
dirtied the page cache without an updatepage().

The current behaviour should just result in a short IO, which should
be fine.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
