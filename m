Return-Path: <linux-kernel-owner+w=401wt.eu-S964921AbWL1FUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWL1FUV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 00:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWL1FUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 00:20:21 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:63258 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964921AbWL1FUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 00:20:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q1hsabA5sF8F+QV0jyPo4pi/oSAmEQ3NmvtlvsRO7xXRtceiJK8rfhyozOD7Fl2EqaHQWNFJ4hneP7LYZp8S04+SnZcfwyQA05+U+4yloSeCwZjhhUHfvbpv/x8wY+FuiRGI6gZ4Ea/OL85d5R1VaQKQZAAocX4hd6kQ2wdgeBM=
Message-ID: <97a0a9ac0612272120g144d2364n932d6f66728f162e@mail.gmail.com>
Date: Wed, 27 Dec 2006 22:20:20 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Cc: "David Miller" <davem@davemloft.net>, ranma@tdiedrich.de, tbm@cyrius.com,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       "Andrew Morton" <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061226.205518.63739038.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
	 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org>
	 <20061227.165246.112622837.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
	 <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com>
	 <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Oops - forgot to hit "Reply to All" first time round.]

Hi Linus

On 12/27/06, Linus Torvalds <torvalds@osdl.org> wrote:

> For all I know, my test-program is buggy wrt the ordering printouts,
> though. Did you perhaps change the logic in any way?

I don't think so. I did reduce the target size

#define TARGETSIZE (100 << 12)

to make the program finish a little quicker, and for some reason I get

linus-test.c: In function 'remap':
linus-test.c:61: error: 'POSIX_FADV_DONTNEED' undeclared (first use in
this function)

when I compile the program, so I replaced POSIX_FADV_DONTNEED with 4
as defined in /usr/include/bits/fcntl.h.

Other than these two changes, the program is identical to the version
you posted.

I have run the program a few times, and the output is pretty
consistent. However, when I increase the target size, the difference
between the expected and actual values is larger.

Written as (749)935(738)
Chunk 1113 corrupted (1-1455)  (2965-323)
Expected 89, got 93
Written as (935)738(538)
Chunk 1114 corrupted (1-1455)  (329-1783)
Expected 90, got 94
Written as (738)538(678)
Chunk 1115 corrupted (1-1455)  (1789-3243)
Expected 91, got 95
Written as (538)678(989)
Chunk 1120 corrupted (1-1455)  (897-2351)
Expected 96, got 100
Written as (537)265(1005)
Chunk 1121 corrupted (1-1455)  (2357-3811)
Expected 97, got 101
Written as (265)1005(-1)

--- linus-test.c.orig   2006-12-28 06:17:24.000000000 +0100
+++ linus-test.c        2006-12-28 06:18:24.000000000 +0100
@@ -6,7 +6,7 @@
 #include <stdio.h>
 #include <time.h>

-#define TARGETSIZE (100 << 20)
+#define TARGETSIZE (100 << 14)
 #define CHUNKSIZE (1460)
 #define NRCHUNKS (TARGETSIZE / CHUNKSIZE)
 #define SIZE (NRCHUNKS * CHUNKSIZE)
@@ -61,7 +61,7 @@
 {
        if (mapping) {
                munmap(mapping, SIZE);
-                posix_fadvise(fd, 0, SIZE, POSIX_FADV_DONTNEED);
+                posix_fadvise(fd, 0, SIZE, 4);
        }
        return mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

Gordon

-- 
Gordon Farquharson
