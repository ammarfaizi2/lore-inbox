Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293060AbSBWAhp>; Fri, 22 Feb 2002 19:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293062AbSBWAhg>; Fri, 22 Feb 2002 19:37:36 -0500
Received: from f266.law11.hotmail.com ([64.4.16.141]:24838 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S293060AbSBWAhU>;
	Fri, 22 Feb 2002 19:37:20 -0500
X-Originating-IP: [156.153.254.2]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: bcrl@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial patch against mempool
Date: Fri, 22 Feb 2002 16:37:13 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F266IJI90Ss8uaP6wb800006420@hotmail.com>
X-OriginalArrivalTime: 23 Feb 2002 00:37:14.0051 (UTC) FILETIME=[3CE26130:01C1BC02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is a good suggestion too, I have redone the patch so
that the alloc_fn and free_fn are checked before calling
kmalloc(). I think the BUG_ON is also a good solution

I have the following now

1.
--- mempool.c.org       Fri Feb 22 12:00:58 2002
+++ mempool.c   Fri Feb 22 17:26:02 2002
@@ -34,6 +34,9 @@
        mempool_t *pool;
        int i;

+       BUG_ON(!alloc_fn);
+       BUG_ON(!free_fn);
+
        pool = kmalloc(sizeof(*pool), GFP_KERNEL);
        if (!pool)
                return NULL;

2.
--- mempool.c.org       Fri Feb 22 12:00:58 2002
+++ mempool.c   Fri Feb 22 17:38:52 2002
@@ -34,6 +34,8 @@
        mempool_t *pool;
        int i;

+       BUG_ON(!(alloc_fn && free_fn));
+
        pool = kmalloc(sizeof(*pool), GFP_KERNEL);
        if (!pool)
                return NULL;



I think (1) is more readable, what do you say?
Balbir

>From: Benjamin LaHaise <bcrl@redhat.com>
>To: Balbir Singh <balbir_soni@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] Trivial patch against mempool
>Date: Fri, 22 Feb 2002 19:02:56 -0500
>
>On Fri, Feb 22, 2002 at 12:28:14PM -0800, Balbir Singh wrote:
> > Check if the alloc_fn and free_fn are not NULL. The caller generally
> > ensures that alloc_fn and free_fn are valid. It would not harm
> > to check. This makes the checking in mempool_create() more complete.
>
>Rather than leak memory in that case, why not just BUG_ON null
>function pointers so that people know what code is at fault?
>
>		-ben




_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

