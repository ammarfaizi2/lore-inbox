Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSLaSEK>; Tue, 31 Dec 2002 13:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbSLaSEK>; Tue, 31 Dec 2002 13:04:10 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:17883 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264620AbSLaSEJ>; Tue, 31 Dec 2002 13:04:09 -0500
Date: Tue, 31 Dec 2002 10:18:47 -0800
From: David Brownell <david-b@pacbell.net>
Subject: patch -- mempool buglet (?)
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Message-id: <3E11DF87.4090901@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_3x0onUuOOPQHtsSSMqFJXg)"
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_3x0onUuOOPQHtsSSMqFJXg)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

I noticed this when reading the mempool code ... looked
wrong to me, it was using kfree() not the de-allocator
matching the allocation it just made.  This is on a fault
path that likely doesn't get much use.

Compiles, untested, "looks right".

- Dave

--Boundary_(ID_3x0onUuOOPQHtsSSMqFJXg)
Content-type: text/plain; name=mempool.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=mempool.patch

--- mm/mempool.c-dist	Tue Dec 31 10:03:51 2002
+++ mm/mempool.c	Tue Dec 31 10:04:24 2002
@@ -142,14 +142,14 @@
 		element = pool->alloc(gfp_mask, pool->pool_data);
 		if (!element)
 			goto out;
 		spin_lock_irqsave(&pool->lock, flags);
 		if (pool->curr_nr < pool->min_nr)
 			add_element(pool, element);
-		else
-			kfree(element);		/* Raced */
+		else 	/* Raced */
+			pool->free(element, pool->pool_data);
 	}
 out_unlock:
 	spin_unlock_irqrestore(&pool->lock, flags);
 out:
 	return 0;
 }

--Boundary_(ID_3x0onUuOOPQHtsSSMqFJXg)--
