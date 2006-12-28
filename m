Return-Path: <linux-kernel-owner+w=401wt.eu-S1754923AbWL1TTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbWL1TTN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 14:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbWL1TTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 14:19:13 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:46055 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677AbWL1TTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 14:19:12 -0500
X-Greylist: delayed 15010 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 14:19:12 EST
Message-ID: <459418D2.2000702@yahoo.fr>
Date: Thu, 28 Dec 2006 20:19:46 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chen Kenneth W <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one
References: <20061226.205518.63739038.davem@davemloft.net> <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net> <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org> <4593DE31.4070401@yahoo.fr>
In-Reply-To: <4593DE31.4070401@yahoo.fr>
Content-Type: multipart/mixed;
 boundary="------------060409070603090200050703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060409070603090200050703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Guillaume Chazarain a écrit :
> I get this kind of corruption: 
> http://guichaz.free.fr/linux-bug/corruption.png

Actually in qemu, I get three different behaviours:
- no corruption at all : with linux-2.4
- corruption only on the first chunks: before  [PATCH] mm: balance dirty 
pages as identified by Kenneth
- corruption of all chunks: after the balance dirty pages patch

Bisecting in linux-2.5 land I found 
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm3/broken-out/fadvise-flush-data.patch 
to cause the corruption for me.

The attached patch fixes the corruption for me.

-- 
Guillaume


--------------060409070603090200050703
Content-Type: text/x-patch;
 name="fadvise-dontneed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fadvise-dontneed.patch"

diff -r 3859b1144d3a mm/fadvise.c
--- a/mm/fadvise.c	Sun Dec 24 05:00:03 2006 +0000
+++ b/mm/fadvise.c	Thu Dec 28 19:53:40 2006 +0100
@@ -96,9 +96,6 @@ asmlinkage long sys_fadvise64_64(int fd,
 	case POSIX_FADV_NOREUSE:
 		break;
 	case POSIX_FADV_DONTNEED:
-		if (!bdi_write_congested(mapping->backing_dev_info))
-			filemap_flush(mapping);
-
 		/* First and last FULL page! */
 		start_index = (offset+(PAGE_CACHE_SIZE-1)) >> PAGE_CACHE_SHIFT;
 		end_index = (endbyte >> PAGE_CACHE_SHIFT);

--------------060409070603090200050703--
