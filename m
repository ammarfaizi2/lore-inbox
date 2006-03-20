Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWCTIzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWCTIzf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWCTIzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:55:35 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:11636 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932250AbWCTIze convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:55:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IUowV1XFK2Ick7JSvaNcfD5tlOmggJQNuK1bsvkU14PJmCY270jYPLYjwfHSCUQ6EmnIHN2u1nSZLZqETUKRanbNK4QsF+bajZQbrl1Jv4Wf10WZ1z6DAf2Igqb2Gz9dTbSsYUHNU9lnKD80707gRb949CSng9VYDCgFU95SNuc=
Message-ID: <9a8748490603200055p7be38dc8lac2e78f4798e6def@mail.gmail.com>
Date: Mon, 20 Mar 2006 09:55:33 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist() (try #2)
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Christoph Lameter" <clameter@sgi.com>
In-Reply-To: <84144f020603191040h9b07b10w418b6cdd73f8b114@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603182137.08521.jesper.juhl@gmail.com>
	 <84144f020603191040h9b07b10w418b6cdd73f8b114@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On 3/19/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 3/18/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > Currently the only caller of alloc_kmemlist() will BUG() if alloc_kmemlist()
> > fails, but that doesn't mean we shouldn't clean up properly IMHO. Also, the
> > caller (do_tune_cpucache()) could maybe be changed in the future to do
> > something more clever than just BUG() and in that case we really shouldn't
> > be leaking memory when we return -ENOMEM.
>
> Yeah, and BUG() can be no-op for embedded.
>
> On 3/18/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > The patch has been compile and boot tested on x86, but since I'm not very
> > intimate with the slab code I'd appreciate it if someone would take a close
> > look on the changes before merging them.
>
> You probably didn't hit the error path on your x86 box. The patch
> looks good to me for -mm although there's few comments below.
>
> > +/*
> > +   If one or more allocations fail we need to undo all allocations done up to
> > +   this point.
> > +   Unfortunately this means yet another loop, but since this only happens on
> > +   failure and frees up memory in a memory-tight situation, it's not too bad.
> > + */
>
> The formatting of this comment looks strange.
>
> > +       for_each_online_node(node) {
> > +               if (count <= 0)
> > +                       break;
> > +               if (cachep->nodelists[node]) {
>
> Would probably make sense to extract the above expression into local
> variable to reduce kernel text size.
>
> > +                       kfree(cachep->nodelists[node]->shared);
> > +                       free_alien_cache(cachep->nodelists[node]->alien);
> > +                       kfree(cachep->nodelists[node]);
> > +                       cachep->nodelists[node] = NULL;
> > +               }
> > +               count--;
> > +       }
> > +       return -ENOMEM;
>

Thank you very much for your feedback.

I'll create an updated patch with the changes you suggest. They make
perfect sense.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
