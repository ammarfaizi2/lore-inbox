Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWIWR0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWIWR0g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 13:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWIWR0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 13:26:36 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:62194 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751338AbWIWR0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 13:26:36 -0400
Date: Sat, 23 Sep 2006 18:26:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Anatoli Antonovitch <antonovi@ati.com>
cc: Willy Tarreau <w@1wt.eu>, Tigran Aivazian <tigran@veritas.com>,
       Michael Chen <micche@ati.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]i386: fix overflow in vmap on an x86 system which has
 more than 4GB memory.
In-Reply-To: <1158334477.5219.1.camel@antonovi-desktop>
Message-ID: <Pine.LNX.4.64.0609231759590.30885@blonde.wat.veritas.com>
References: <1158334477.5219.1.camel@antonovi-desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Sep 2006 17:26:22.0009 (UTC) FILETIME=[635F5290:01C6DF35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a 2.4 fix (not needed in 2.6): let's CC maintainer Willy Tarreau.

On Fri, 15 Sep 2006, Anatoli Antonovitch wrote:

> Description
> (max_mapnr << PAGE_SHIFT) would overflow on an x86 system which has more
> than 4GB memory, and hence cause vmap to fail every time.

Good point, thanks for the patch.  Sorry I'm so slow to get to it.

> 
> Signed-off-by: Michael Chen <micche@ati.com>
> 
> Patch
> diff -Nur linux-2.4.21-40.EL/mm/vmalloc.c
> linux-2.4.21-40.EL.diff/mm/vmalloc.c
> --- linux-2.4.21-40.EL/mm/vmalloc.c     2006-02-02 21:13:20.000000000
> -0600
> +++ linux-2.4.21-40.EL.diff/mm/vmalloc.c        2006-09-04

And still needs fixing in latest mainline 2.4.

> 11:29:33.000000000 -0500
> @@ -298,8 +298,8 @@
>         struct vm_struct *area;
>         unsigned long size = count << PAGE_SHIFT;
>  
> -       if (!size || size > (max_mapnr << PAGE_SHIFT))
> -               return NULL;
> +    if (!count || count > max_mapnr)
> +        return NULL;

I'm afraid the tabs got messed up in both the old and new lines.
Also, count is a signed int (whereas size and max_mapnr are both
unsigned longs), so best reject "count <= 0" rather than just "!count".

>         area = get_vm_area(size, flags);
>         if (!area) {
>                 return NULL;

Here's a replacement patch for Willy.  Anatoli, you didn't sign
off the patch yourself: so I'm assuming Michael is the originator.


From: Michael Chen <micche@ati.com>

(max_mapnr << PAGE_SHIFT) would overflow on a system which has
4GB memory or more, and so could cause vmap to fail every time.

Signed-off-by: Michael Chen <micche@ati.com>
Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/vmalloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.4.34-pre3/mm/vmalloc.c	2004-04-14 14:05:41.000000000 +0100
+++ linux/mm/vmalloc.c	2006-09-23 17:52:59.000000000 +0100
@@ -293,7 +293,7 @@ void * vmap(struct page **pages, int cou
 	struct vm_struct *area;
 	unsigned long size = count << PAGE_SHIFT;
 
-	if (!size || size > (max_mapnr << PAGE_SHIFT))
+	if (count <= 0 || count > max_mapnr)
 		return NULL;
 	area = get_vm_area(size, flags);
 	if (!area) {
