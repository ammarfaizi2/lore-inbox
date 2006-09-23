Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWIWJxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWIWJxI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 05:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWIWJxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 05:53:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18350 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751144AbWIWJxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 05:53:07 -0400
Subject: Re: 2.6.19 -mm merge plans
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Claudio Lanconelli <lanconelli.claudio@eptar.com>
In-Reply-To: <20060923010610.d048629e.akpm@osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	 <45121382.1090403@garzik.org>  <20060923010610.d048629e.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 10:52:08 +0100
Message-Id: <1159005128.24527.894.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-23 at 01:06 -0700, Andrew Morton wrote:
> WARNING: "register_mtd_blktrans" [drivers/mtd/rfd_ftl.ko] undefined!
> WARNING: "deregister_mtd_blktrans" [drivers/mtd/rfd_ftl.ko] undefined!
> WARNING: "add_mtd_blktrans_dev" [drivers/mtd/rfd_ftl.ko] undefined!
> WARNING: "del_mtd_blktrans_dev" [drivers/mtd/rfd_ftl.ko] undefined!

Ah, I hadn't realised that 'bool FOO depends on tristate BAR' would
allow FOO=y, BAR=m. And since we don't recurse into drivers/mtd at all
when building vmlinux and CONFIG_MTD=m, setting CONFIG_SSFDC=y would
mean that it _thought_ it was building mtd_blkdevs.c into the kernel but
in fact it wasn't. I hadn't tested that combination, since it makes no
sense -- yet it's what allmodconfig does. Sorry 'bout that.

I've fixed this by making SSFDC a tristate, and I've fixed it
differently for CMDLINEPARTS which has had the same problem for ages.

> Quick review:
> 
> - search for "( " and " )", fix.

Not sure which you're referring to -- there's a NULL-terminated array of
strings which seems just fine as it is, and there's a size vs. C-H-S
table. The latter could _possibly_ use C99 initialisers, but for
something so simple I think it would just get in the way. It's an
entirely local structure anyway -- it's defined just above the table.
We don't have to worry about the initialiser getting out of sync with
the structure definition, so I didn't see the point in mandating C99
initialisers for it, since Claudio chose to do otherwise. It's his
choice, as far as I'm concerned.

I did notice that he misspelled 'MiB' and fix that though :)

> - Might want to do something about the 512-byte automatic variable in
>   get_valid_cis_sector()

Done. Thanks for spotting that.

-- 
dwmw2

