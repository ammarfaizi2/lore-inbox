Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWHJGlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWHJGlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbWHJGlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:41:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49817 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161091AbWHJGlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:41:08 -0400
Date: Wed, 9 Aug 2006 23:40:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
Message-Id: <20060809234019.c8a730e3.akpm@osdl.org>
In-Reply-To: <1155172843.3161.81.camel@localhost.localdomain>
References: <1155172843.3161.81.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2006 18:20:43 -0700
Mingming Cao <cmm@us.ibm.com> wrote:

> 
> Define SECTOR_FMT to print sector_t in proper format
> 
> ...
>
>  #define HAVE_SECTOR_T
>  typedef u64 sector_t;
> +#define SECTOR_FMT "%llu"

We've thus-far avoided doing this.  In fact a similar construct in
device-mapper was recently removed.

Unlike many other attempts, this one appears to be correct (people usually
get powerpc wrong, due to its u64=unsigned long).

That being said, I'm not really sure we want to add this.  It produces
rather nasty-looking source code and thus far we've just used %llu and we've
typecasted the sector_t to `unsigned long long'.  That happens in a lot of
places in the kernel and perhaps we don't want to start innovating in ext4
;)

That also being said...  does a 32-bit sector_t make any sense on a
48-bit-blocknumber filesystem?  I'd have thought that we'd just make ext4
depend on 64-bit sector_t and be done with it.

Consequently, sector_t should largely vanish from ext4 and JBD2, except for
those places where it interfaces with the VFS and the block layer. 
Internally it should just use 64-bit quantities.  That could be u64, but
I'd suggest that the fs simply open-code `unsigned long long' so that we
don't need to play any gams at all when passing these things into printk.

Finally, perhaps the code is printing block numbers too much ;)


<Notices E3FSBLK, wonders how that snuck through>

I'd suggest that "[patch] ext3: remove E3FSBLK" be written and merged
before we clone ext4, too...

