Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290766AbSAYScC>; Fri, 25 Jan 2002 13:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290770AbSAYSbx>; Fri, 25 Jan 2002 13:31:53 -0500
Received: from [24.64.71.161] ([24.64.71.161]:28406 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S290766AbSAYSbm>;
	Fri, 25 Jan 2002 13:31:42 -0500
Date: Fri, 25 Jan 2002 11:31:18 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Levon <movement@marcelothewonderpenguin.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
Message-ID: <20020125113118.S763@lynx.adilger.int>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	John Levon <movement@marcelothewonderpenguin.com>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	davej@suse.de
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk> <Pine.LNX.4.33.0201251006220.1632-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201251006220.1632-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 25, 2002 at 10:08:56AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 25, 2002  10:08 -0800, Linus Torvalds wrote:
> I would prefer instead just avoiding the copy altogether, and just save
> the name pointer - with no length restrictions.
> 
> Right now the code has the comment
> 
>    /* Copy name over so we don't have problems with unloaded modules */

Yes, I put that in.

> but that was written before "kmem_cache_destroy()" existed, and we should
> long ago have fixed any modules that don't properly destroy their caches
> when they exit (and yes, I know the difference between "should" and "did",
> but that's not an excuse for a bad interface).

The problem is that if, for some reason, the cache is NOT empty when you
call kmem_cache_destroy(), it will not be freed, but the module exits
anyways.  Then, any access to /proc/slabinfo will OOPS.

Yes, code should be written correctly so that its slab is empty when it
exits, but I'd rather have a _bit_ of safety here so that you can at
least check slabinfo when you get a kernel message "slab is not empty"
(or whatever it is) so you can at least try and investigate the problem.

The other alternative is to BUG with enough information to figure out
the status of this cache if you try to free a non-empty cache.  At
least then you would get some data at the time the real problem happens
as opposed to killing some random process later that tries to read
slabinfo.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

