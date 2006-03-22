Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751889AbWCVAxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbWCVAxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbWCVAxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:53:46 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:31960 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751889AbWCVAxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:53:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z5Hx6O0n9l6bfVRKuEEkslf5KZm41UtBz34rdoojSPzVPtcG6DcK2i2QYeEywhE1HW0YbGO4SEeQD6otA5isD1B6P5i4xbdnrPtHQDG6dLhj4o9sQuvZTGJgnzonuDljYAFuwMbM0Qmlxqdwz/AzWY4uOgDAFAUDSn4wJhARGY8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>, "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()  (try #3)
Date: Wed, 22 Mar 2006 01:54:16 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, "Christoph Lameter" <clameter@sgi.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
References: <200603182137.08521.jesper.juhl@gmail.com> <84144f020603191040h9b07b10w418b6cdd73f8b114@mail.gmail.com> <9a8748490603200055p7be38dc8lac2e78f4798e6def@mail.gmail.com>
In-Reply-To: <9a8748490603200055p7be38dc8lac2e78f4798e6def@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220154.16266.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pekka, Andrew, Christoph & everyone else,


On Monday 20 March 2006 09:55, Jesper Juhl wrote:
> Hi Pekka,
> 
> On 3/19/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > On 3/18/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > > Currently the only caller of alloc_kmemlist() will BUG() if alloc_kmemlist()
> > > fails, but that doesn't mean we shouldn't clean up properly IMHO. Also, the
> > > caller (do_tune_cpucache()) could maybe be changed in the future to do
> > > something more clever than just BUG() and in that case we really shouldn't
> > > be leaking memory when we return -ENOMEM.
> >
> > Yeah, and BUG() can be no-op for embedded.
> >
> > On 3/18/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > > The patch has been compile and boot tested on x86, but since I'm not very
> > > intimate with the slab code I'd appreciate it if someone would take a close
> > > look on the changes before merging them.
> >
> > You probably didn't hit the error path on your x86 box. The patch
> > looks good to me for -mm although there's few comments below.
> >
> > > +/*
> > > +   If one or more allocations fail we need to undo all allocations done up to
> > > +   this point.
> > > +   Unfortunately this means yet another loop, but since this only happens on
> > > +   failure and frees up memory in a memory-tight situation, it's not too bad.
> > > + */
> >
> > The formatting of this comment looks strange.
> >
> > > +       for_each_online_node(node) {
> > > +               if (count <= 0)
> > > +                       break;
> > > +               if (cachep->nodelists[node]) {
> >
> > Would probably make sense to extract the above expression into local
> > variable to reduce kernel text size.
> >
> > > +                       kfree(cachep->nodelists[node]->shared);
> > > +                       free_alien_cache(cachep->nodelists[node]->alien);
> > > +                       kfree(cachep->nodelists[node]);
> > > +                       cachep->nodelists[node] = NULL;
> > > +               }
> > > +               count--;
> > > +       }
> > > +       return -ENOMEM;
> >
> 
> Thank you very much for your feedback.
> 
> I'll create an updated patch with the changes you suggest. They make
> perfect sense.
> 

Here's the latest version of my patch to fix the mem leak in alloc_kmemlist().
It should address Pekkas's comments.

Andrew: Do you think this could go into -mm and get some field testing, so 
perhaps it has a chance of making 2.6.17?


Fix memory leak in mm/slab.c::alloc_kmemlist().
If one allocation fails we have to roll-back all allocations made up to the 
point of failure.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 mm/slab.c |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)

--- linux-2.6.16-rc6-mm2-orig/mm/slab.c	2006-03-18 16:55:55.000000000 +0100
+++ linux-2.6.16-rc6-mm2/mm/slab.c	2006-03-21 22:33:45.000000000 +0100
@@ -3399,12 +3399,17 @@ EXPORT_SYMBOL_GPL(kmem_cache_name);
 static int alloc_kmemlist(struct kmem_cache *cachep)
 {
 	int node;
+	int count = -1;
 	struct kmem_list3 *l3;
-	int err = 0;
+	struct array_cache *new;
+	struct array_cache **new_alien;
 
 	for_each_online_node(node) {
-		struct array_cache *nc = NULL, *new;
-		struct array_cache **new_alien = NULL;
+		struct array_cache *nc = NULL;
+
+		new = NULL;
+		new_alien = NULL;
+		count++;
 #ifdef CONFIG_NUMA
 		new_alien = alloc_alien_cache(node, cachep->limit);
 		if (!new_alien)
@@ -3447,10 +3452,29 @@ static int alloc_kmemlist(struct kmem_ca
 					cachep->batchcount + cachep->num;
 		cachep->nodelists[node] = l3;
 	}
-	return err;
+	return 0;
+/**
+ * If one or more allocations fail we need to undo all allocations done up to
+ * this point. Unfortunately this means yet another loop, but since this only
+ * happens on failure and frees up memory in a memory-tight situation, it's
+ * not too bad.
+ */
 fail:
-	err = -ENOMEM;
-	return err;
+	kfree(new);
+	free_alien_cache(new_alien);
+	for_each_online_node(node) {
+		if (count <= 0)
+			break;
+		l3 = cachep->nodelists[node];
+		if (l3) {
+			kfree(l3->shared);
+			free_alien_cache(l3->alien);
+			kfree(l3);
+			cachep->nodelists[node] = NULL;
+		}
+		count--;
+	}
+	return -ENOMEM;
 }
 
 struct ccupdate_struct {




