Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTDCSvK 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263417AbTDCSsQ 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:48:16 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:28370 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263425AbTDCSrp 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 13:47:45 -0500
Date: Thu, 3 Apr 2003 20:01:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Pete Zaitcev <zaitcev@redhat.com>
cc: riel@redhat.com, <linux-kernel@vger.kernel.org>, <linux390@de.ibm.com>
Subject: Re: gcc-3.2 breaks rmap on s390x
In-Reply-To: <20030403131054.B25676@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0304031954480.2237-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Pete Zaitcev wrote:
> 
> the following patch seems to fix my rmap problems on s390x.
> 
> --- linux-2.4.20-2.1.24.z1/include/linux/mm.h	2003-03-27 21:30:09.000000000 -0500
> +++ linux-2.4.20-2.1.24.z2/include/linux/mm.h	2003-04-02 20:26:11.000000000 -0500
> @@ -376,8 +376,10 @@
>  	 */
>  #ifdef CONFIG_SMP
>  	while (test_and_set_bit(PG_chainlock, &page->flags)) {
> -		while (test_bit(PG_chainlock, &page->flags))
> +		while (test_bit(PG_chainlock, &page->flags)) {
>  			cpu_relax();
> +			barrier();
> +		}
>  	}
>  #endif
>  }

Isn't it rather odd that it should fix the problem you describe?
because the barrier you're adding comes only in the exceptional path,
when the lock was found already held.  I suppose the compiler is free
to make the barrier more general than you've asked for, but it seems
unsafe to rely on that.

Hugh

