Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752454AbWCFWwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbWCFWwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbWCFWwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:52:05 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:61760 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752458AbWCFWwC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:52:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bLRYKL0/Ai+LrhdVVuQ+ExtefrrpH2Y2I8P6A+hfy/IhvlcbK1/krqlgnz+uU54KJFxdufwE8LBc+H5tS5w4zfpj+DAQQCu6ielTFdcmZRDbLSMDEPKymzNoQ9ewSB7vL7qrEGTOszWPR43CaMp/sKX32HNjlVFZsQPhnzDcURY=
Message-ID: <9a8748490603061452k794fc6cdk54b4ba7a27151bb1@mail.gmail.com>
Date: Mon, 6 Mar 2006 23:52:01 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "Jens Axboe" <axboe@suse.de>, "Pekka Enberg" <penberg@cs.helsinki.fi>
In-Reply-To: <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	 <200603062136.17098.jesper.juhl@gmail.com>
	 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
	 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
	 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
	 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
	 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> Ok,
>  I have a new favorite suspect.
>
Heh, you are coming up with stuff to test faster than I can build &
boot kernels ;-)
Which is good, we'll get to the bottom of this all the faster :)


> It is this one: commit 4d268eba1187ef66844a6a33b9431e5d0dadd4ad:
>
[--snip--]
>
> Now, maybe I'm just off my rocker again (I've certainly been batting 0.000
> so far, even if I think I've been finding real bugs). So who knows. But I
> get the feeling that that patch is broken.
>
> Either revert it, or try this (TOTALLY UNTESTED!!!) patch..
>
Hmm, that patch doesn't apply at all to 2.6.16-rc5-mm2 :/

patching file mm/slab.c
Hunk #1 FAILED at 1628.
1 out of 1 hunk FAILED -- saving rejects to file mm/slab.c.rej


$ cat mm/slab.c.rej
***************
*** 1628,1649 ****
  			size_t size, size_t align, unsigned long flags)
  {
  	size_t left_over = 0;
- 	int gfporder;

- 	for (gfporder = 0 ; gfporder < MAX_GFP_ORDER; gfporder++) {
  		unsigned int num;
  		size_t remainder;

- 		cache_estimate(gfporder, size, align, flags, &remainder, &num);
  		if (!num)
  			continue;
-
  		/* More than offslab_limit objects will cause problems */
- 		if ((flags & CFLGS_OFF_SLAB) && num > offslab_limit)
  			break;

  		cachep->num = num;
- 		cachep->gfporder = gfporder;
  		left_over = remainder;

  		/*
--- 1628,1652 ----
  			size_t size, size_t align, unsigned long flags)
  {
  	size_t left_over = 0;

+ 	for (;; cachep->gfporder++) {
  		unsigned int num;
  		size_t remainder;

+ 		if (cachep->gfporder > MAX_GFP_ORDER) {
+ 			cachep->num = 0;
+ 			break;
+ 		}
+
+ 		cache_estimate(cachep->gfporder, size, align, flags,
+ 			       &remainder, &num);
  		if (!num)
  			continue;
  		/* More than offslab_limit objects will cause problems */
+ 		if (flags & CFLGS_OFF_SLAB && cachep->num > offslab_limit)
  			break;

  		cachep->num = num;
  		left_over = remainder;

  		/*



> And hey, maybe I'm just crazy.
>
Somehow I don't think that's the core problem here ;)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
