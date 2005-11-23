Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbVKWIBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbVKWIBN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbVKWIBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:01:12 -0500
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:26810 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030355AbVKWIBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:01:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ywWUMtlb1D22Lm7m82bMv+Iy/eRgJ/1TN7Nb1HqMxTLLMp5Anu5tiiv+eZTUW8H3KmuggVb2HU5Zjnb0wWQOfHtrt8kLb5BP33utud+3uYbGCYwjaSc8srqzppfXIHya9izkAQeNK/arrRMoN9zQNmpkv79ZTE9Q+C1lXqVA2lg=  ;
Message-ID: <438421C4.6020201@yahoo.com.au>
Date: Wed, 23 Nov 2005 19:01:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org
Subject: Re: vm-kswapd-incmin.patch problem
References: <20051122074818.GA3801@mail.ustc.edu.cn> <20051123040619.GA4386@mail.ustc.edu.cn>
In-Reply-To: <20051123040619.GA4386@mail.ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> Hi Nick,
> 

Hi Wu,

> Then I disabled the shrinker by:
>         echo 0 > /proc/sys/vm/vfs_cache_pressure
> 
> That increased the number from
>         3393    28      45      0       0       0
> to
>         6247    2672    45      0       0       0
> And there is no sudden huge increases of free pages any more.
> 

Yes, the inode shrinker can discard all pagecache from a file if
it is under a lot of pressure to free inodes. This is what you
are seeing I guess.

> Maybe your patch is shrinking the slabs much more, though I cannot confirm this
> from the source code. But one thing I'm sure is that there should be a lower
> bound for the unused dentries, either absolutely or relatively, something like
> this:
> 
> --- linux-2.6.15-rc1-mm2.orig/fs/dcache.c
> +++ linux-2.6.15-rc1-mm2/fs/dcache.c
> @@ -860,7 +860,7 @@ static int shrink_dcache_memory(int nr, 
>  			return -1;
>  		prune_dcache(nr);
>  	}
> -	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
> +	return (dentry_stat.nr_unused / 1000) * 10 * sysctl_vfs_cache_pressure;
>  }
>  

I don't think that kswapd-incmin puts much more pressure on the slab
(unless there is a bug), but I'll take a look. It could just be a
"weird" interaction in the reclaim code, or possibly a rounding issue.

Changing the pressure calculation here is probably not the right way
to do this, but rather in vmscan.c. I know Andrea has recently been
looking at a problem with slab shrinking too.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
