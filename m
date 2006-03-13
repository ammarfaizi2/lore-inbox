Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWCMPYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWCMPYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 10:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWCMPYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 10:24:49 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:22406 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932139AbWCMPYs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 10:24:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lOoBpmJI776aftLGYOCp1rjiuR3Vraaazv/o3RdKb7iGyXe9s/z573j6sfN4RXNO/qpyMsu0lJwQblrXhFIfzAQRUs0uCY14MgwkhHdzhOt0WBmZxEW+x/Jiu5L9oeln4mQuR2Lbw34zm5rBAREXae4KvxNIOg/nV+RH71U8cS4=
Message-ID: <661de9470603130724mc95405dr6ee32d00d800d37@mail.gmail.com>
Date: Mon, 13 Mar 2006 20:54:47 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [patch 1/3] radix tree: RCU lockless read-side
Cc: "Nick Piggin" <npiggin@suse.de>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
In-Reply-To: <4414E2CB.7060604@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060207021822.10002.30448.sendpatchset@linux.site>
	 <20060207021831.10002.84268.sendpatchset@linux.site>
	 <661de9470603110022i25baba63w4a79eb543c5db626@mail.gmail.com>
	 <44128EDA.6010105@yahoo.com.au>
	 <661de9470603121904h7e83579boe3b26013f771c0f2@mail.gmail.com>
	 <4414E2CB.7060604@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

>
> But we should have already rcu_dereference()ed "slot", right
> (in the loop above this one)? That means we are now able to
> dereference it, and the data at the other end will be valid.
>

Yes, but my confusion is about the following piece of code

<begin code>

       for ( ; height > 1; height--) {

               for (i = (index >> shift) & RADIX_TREE_MAP_MASK ;
                               i < RADIX_TREE_MAP_SIZE; i++) {
-                       if (slot->slots[i] != NULL)
+                       __s = rcu_dereference(slot->slots[i]);
+                       if (__s != NULL)
                               break;
                       index &= ~((1UL << shift) - 1);
                       index += 1UL << shift;
@@ -531,14 +550,14 @@ __lookup(struct radix_tree_root *root, v
                       goto out;

               shift -= RADIX_TREE_MAP_SHIFT;
-               slot = slot->slots[i];
+               slot = __s;
       }

       /* Bottom level: grab some items */
       for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
               index++;
               if (slot->slots[i]) {
-                       results[nr_found++] = slot->slots[i];
+                       results[nr_found++] = &slot->slots[i];
                       if (nr_found == max_items)
                               goto out;
               }
<end code>

In the for loop, lets say __s is *not* NULL, we break from the loop.
In the loop below
slot->slots[i] is derefenced without rcu, __s is not used. Is that not
inconsistent?
