Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269367AbUIIIMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269367AbUIIIMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 04:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269373AbUIIIMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 04:12:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:5299 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269367AbUIIIMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 04:12:09 -0400
Date: Thu, 9 Sep 2004 01:10:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Chinner <dgc@sgi.com>
Cc: lord@xfs.org, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Major XFS problems...
Message-Id: <20040909011007.42f98641.akpm@osdl.org>
In-Reply-To: <20040909165255.C2738@melbourne.sgi.com>
References: <20040908133954.GB390@unthought.net>
	<20040909074533.B3958243@wobbly.melbourne.sgi.com>
	<413F823F.3020507@xfs.org>
	<20040909165255.C2738@melbourne.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Chinner <dgc@sgi.com> wrote:
>
> If the dentry_stat.nr_unused is less than 100, then we'll return 0
>  due to integer division (99/100 = 0), and the shrinker calculations
>  will see this as a slab that does not need shrinking because:
> 
>  185         list_for_each_entry(shrinker, &shrinker_list, list) {
>  186                 unsigned long long delta;
>  187 
>  188                 delta = (4 * scanned) / shrinker->seeks;
>  189                 delta *= (*shrinker->shrinker)(0, gfp_mask);
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  190                 do_div(delta, lru_pages + 1);
>  191                 shrinker->nr += delta;
>  192                 if (shrinker->nr < 0)
>  193                         shrinker->nr = LONG_MAX;        /* It wrapped! */
>  194 
>  195                 if (shrinker->nr <= SHRINK_BATCH)
>  196                         continue;
> 
>  because we returned zero and therefore delta becomes zero and
>  shrinker->nr never gets larger than SHRINK_BATCH.
> 
>  Hence in low memory conditions when you've already reaped most of
>  the unused dentries, you can't free up the last 99 unused dentries.
>  Maybe this is intentional (anyone?) because there isn't very much to
>  free up in this case, but some memory freed is better than none when
>  you have nothing at all left.

Yes, it's intentional.  Or at least, it's known-and-not-cared about ;)

The last 99 unused dentries will not be reaped.
