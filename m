Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWH3Rwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWH3Rwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWH3Rwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:52:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:8034 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751263AbWH3Rwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:52:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YB7cKLIQgCYSN/rzkakuuEMX6oP/Yo1f147eEvnsBSSLFaXPJChfrCJlacVSgj+1zEIkCCtTT9mhSocvuGLeLUZtjGLJgKQAvrB/+Y0h0SZFJRp36s3vxApVA15hbRyTrMTTgbq4oMXQTA3eQcEhUohAgC8Ctie2F44ebuS3tUg=
Message-ID: <18d709710608301052u1307139dpf6e3b2da6e7bfcbe@mail.gmail.com>
Date: Wed, 30 Aug 2006 14:52:33 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: "David Wagner" <daw-usenet@taverner.cs.berkeley.edu>,
       schwidefsky@de.ibm.com
Subject: Re: [S390] cio: kernel stack overflow.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ed4gno$d29$1@taverner.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060830124047.GA22276@skybase>
	 <ed4gno$d29$1@taverner.cs.berkeley.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/06, David Wagner <daw@cs.berkeley.edu> wrote:
> Have you checked that in all cases all fields of the struct have
> been overwritten?  For instance, look at this:
>
> Martin Schwidefsky  wrote:
> >-      chp->dev = (struct device) {
> >-              .parent  = &css[0]->device,
> >-              .release = chp_release,
> >-      };
> >+      chp->dev.parent = &css[0]->device;
> >+      chp->dev.release = chp_release;
>
> Doesn't this leave chp->dev.bus still holding whatever old value it
> had laying around before?

You're correct. While this eliminates the possibility of getting
random values from the stack, it still leaves space for letting
previous unwanted values unchanged.
Unless, of course, the structure in question is kcalloc()'d (which is
not the case of gdev in the beginning of the patch - I haven't had the
time to check the other cases). But we surely can't rely on that.

>Unless I'm missing something, it looks to
> me like this diff causes a change in the semantics of the code.

I can't see the semantic change.

>
> Perhaps it would be better to memset() the entire struct (chp->dev, in
> this case) to zero, before assigning to individual fields, so there is
> no possibility of old remnant data still being left laying around?

Yes. Since the code can't be depend on the caller passing a zeroed
structure, it's definitely more safe to memset to 0 (or use kcalloc(),
instead of kmalloc(), when the allocation is the routine's own
responsability).

Changing subjects a little bit: where's the stack overflow in the
code? Either I'm too stupid to find it myself by looking at the patch
or the e-mail is mistitled.

Cheers,

    Julio Auto
