Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTI3HEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 03:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbTI3HEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 03:04:14 -0400
Received: from c-67-161-31-116.client.comcast.net ([67.161.31.116]:35337 "EHLO
	64m.dyndns.org") by vger.kernel.org with ESMTP id S263152AbTI3HEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 03:04:09 -0400
Date: Tue, 30 Sep 2003 00:05:56 -0700
From: Christopher Li <lkml@chrisli.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat sparse fixes
Message-ID: <20030930070556.GA2182@64m.dyndns.org>
References: <UTC200309282329.h8SNT5I29917.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0309290946070.23520-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309290946070.23520-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 09:50:54AM -0700, Linus Torvalds wrote:
> 
> On Mon, 29 Sep 2003 Andries.Brouwer@cwi.nl wrote:
> >
> > --- a/fs/fat/dir.c	Mon Sep 29 01:05:41 2003
> > +++ b/fs/fat/dir.c	Mon Sep 29 01:11:39 2003
> > @@ -630,7 +630,7 @@
> >  		    put_user(slen, &d1->d_reclen))
> >  			goto efault;
> >  	} else {
> > -		if (put_user(0, d2->d_name)			||
> > +		if (put_user(0, d2->d_name+0)			||
> >  		    put_user(0, &d2->d_reclen)			||
> >  		    copy_to_user(d1->d_name, name, len)		||
> >  		    put_user(0, d1->d_name+len)			||
> 
> The above seems to just work around a sparse bug. Please don't - I'd 
> rather have regular code and try to fix the sparse problem.
> 
> Hmm.. I wonder why sparse doesn't get the address space right on arrays. 
> It should see that "d2" is a user pointer , so d2->d_name is one too.

. The problem is in "*d2->d_name", the address space get
lost at evaluate_dereference of "*". It is a monster macro right
there. The simple version is:

struct dentry {
        char d_name[256];
};

int foo (void) {
        struct dentry __attribute__((noderef, address_space(1))) *d2;
        __typeof__(*d2->d_name) *__pu_addr = d2->d_name;
                   ^^^^^^^^^^^
}


 
> It gets it right if you add the "+0", or if you add a "&" in front. So 
> it looks like the sparse array->pointer degeneration misses something.

Besids address sapce, it seems that the source and target base type
is pointer of char_ctype instead of pointer of void_ctype. I get lost
there.

Regards.

Chris
