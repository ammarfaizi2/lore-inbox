Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTKHAGa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTKGWMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:12:08 -0500
Received: from ns.suse.de ([195.135.220.2]:17839 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264089AbTKGLdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 06:33:37 -0500
Date: Fri, 7 Nov 2003 12:32:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031107113235.GD591@suse.de>
References: <20031103122500.GA6963@suse.de> <20031103205234.GA17570@gondor.apana.org.au> <20031104084929.GH1477@suse.de> <20031104090325.GA21301@gondor.apana.org.au> <20031104090353.GM1477@suse.de> <20031105094855.GD1477@suse.de> <20031106210900.GA29000@gondor.apana.org.au> <20031107112346.GA5153@gondor.apana.org.au> <20031107112555.GC591@suse.de> <20031107112833.GA5239@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031107112833.GA5239@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07 2003, Herbert Xu wrote:
> On Fri, Nov 07, 2003 at 12:25:55PM +0100, Jens Axboe wrote:
> > 
> > Could be related, someone is doing an unlock on an already unlocked
> > page. Is this the same system that saw the bounce problem initially?
> 
> Yes, see http://bugs.debian.org/218566 for details.

Then there's likely just some other bug wrt bouncing. Hmm, does this
work?

===== mm/highmem.c 1.47 vs edited =====
--- 1.47/mm/highmem.c	Thu Oct  9 15:03:32 2003
+++ edited/mm/highmem.c	Fri Nov  7 12:32:03 2003
@@ -402,6 +402,8 @@
 		to->bv_len = from->bv_len;
 		to->bv_offset = from->bv_offset;
 
+		lock_page(to->bv_page);
+
 		if (rw == WRITE) {
 			char *vto, *vfrom;
 

-- 
Jens Axboe

