Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290514AbSAYUjE>; Fri, 25 Jan 2002 15:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290745AbSAYUiy>; Fri, 25 Jan 2002 15:38:54 -0500
Received: from [24.64.71.161] ([24.64.71.161]:41974 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S290514AbSAYUik>;
	Fri, 25 Jan 2002 15:38:40 -0500
Date: Fri, 25 Jan 2002 13:38:14 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        John Levon <movement@marcelothewonderpenguin.com>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
Message-ID: <20020125133814.U763@lynx.adilger.int>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	John Levon <movement@marcelothewonderpenguin.com>,
	linux-kernel@vger.kernel.org, davej@suse.de
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk> <Pine.LNX.4.33.0201251006220.1632-100000@penguin.transmeta.com> <20020125204911.A17190@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020125204911.A17190@wotan.suse.de>; from ak@suse.de on Fri, Jan 25, 2002 at 08:49:11PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 25, 2002  20:49 +0100, Andi Kleen wrote:
> @@ -810,11 +832,8 @@
>  		struct list_head *p;
>  
>  		list_for_each(p, &cache_chain) {
> -			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
> -
> -			/* The name field is constant - no lock needed. */
> -			if (!strcmp(pc->name, name))
> -				BUG();
> +			kmem_cache_t *pc;
> +			pc = list_entry(p, kmem_cache_t, next);
>  		}
>  	}
>  

So, what exactly does the above do now (hint: p and pc are both local
so they cannot be referenced anywhere else)?  It used to check that you
weren't trying to add two caches with the same name.  This isn't
possible with caches from broken modules anymore as they have no name.

In the end, it is mostly irrelevant if we have duplicate names in the
slab cache, because you can't "attach" to a cache by name (you can
only "create" a cache and access it via a pointer).  We may as well
just remove the whole loop above, since it doesn't do anything anymore.

> +		name = cachep->name; 
> +		{
> +		char tmp; 
> +		if (get_user(tmp, name)) 
> +			name = "broken"; 
> +		} 	

When calling kmem_cache_destroy() on a non-empty slab we should just
malloc some memory with the old cache name + "_leaked" for the name
pointer.  At least then we have a sane chance of figuring out what caused
the problem, instead of having a bunch of "broken" entries in the table,
and remove the above "broken" check entirely (we will always have a name).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

