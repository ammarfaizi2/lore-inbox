Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWECHNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWECHNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 03:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWECHNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 03:13:09 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:31107 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S964825AbWECHNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 03:13:08 -0400
Message-ID: <346640383.02545@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Wed, 3 May 2006 15:13:25 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060503071325.GC4781@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>
References: <346556235.24875@ustc.edu.cn> <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 08:55:06AM -0700, Linus Torvalds wrote:
> So I would _seriously_ claim that the place to do all the statistics 
> allocation is in anything that ends up having to call "->readpage()", and 
> do it all on a virtual mapping level.
> 
> Yes, it isn't perfect either (I'll mention some problems), but it's a 
> _lot_ better. It means that when you gather the statistics, you can see 
> the actual _files_ and offsets being touched. You can even get the 
> filenames by following the address space -> inode -> i_dentry list.
> 
>    This is important for several reasons:
>     (a) it makes it a hell of a lot more readable, and the user gets a 
> 	lot more information that may make him see the higher-level issues 
> 	involved.
>     (b) it's in the form that we cache things, so if you read-ahead in 
> 	that form, you'll actually get real information.
>     (c) it's in a form where you can actually _do_ something about things 
> 	like fragmentation etc ("Oh, I could move these files all to a 
> 	separate area")

There have been two alternatives for me:
        1) static/passive interface i.e. the /proc/filecache querier
           - user-land tools request to dump the cache contents on demand
        2) dynamic/active interface i.e. the readpage() logger
           - user-land daemon accepts live page access/io activities

> Now, admittedly it has a few downsides:
> 
>  - right now "readpage()" is called in several places, and you'd have to 
>    create some kind of nice wrapper for the most common 
>    "mapping->a_ops->readpage()" thing and hook into there to avoid 
>    duplicating the effort.
> 
>    Alternatively, you could decide that you only want to do this at the 
>    filesystem level, which actually simplifies some things. If you 
>    instrument "mpage_readpage[2]()", you'll already get several of the 
>    ones you care about, and you could do the others individually.
> 
>    [ As a third alternative, you might decide that the only thing you
>    actually care about is when you have to wait on a locked page, and 
>    instrument the page wait-queues instead. ]
> 
>  - it will miss any situation where a filesystem does a read some other 
>    way. Notably, in many loads, the _directory_ accesses are the important 
>    ones, and if you want statistics for those you'd often have to do that 
>    separately (not always - some of the filesystems just use the same 
>    page reading stuff).
> 
> The downsides basically boil down to the fact that it's not as clearly 
> just one single point. You can't just look at the request queue and see 
> what physical requests go out.

Good insights.
The readpage() activities logging idea has been appealing for me.
We might even go further to log mark_page_accessed() calls for more
information.

This approach is more precise, and provides process/page
correlations and time info that the /proc/filecache interface cannot
provide. Though it involves more complexity and overhead(for me they
mean the possibility of being rejected:).

Wu
