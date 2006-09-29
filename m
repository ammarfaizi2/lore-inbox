Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWI2B4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWI2B4Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 21:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWI2B4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 21:56:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:5840 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751266AbWI2B4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 21:56:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t3IXAyrv6iOVwxjR535oGqiY7o5bIjx7XqGE3vUWZ6kOkZExWpNmftfFbvCm+1juFQR+8IrVpegIjG5+RsD5p61mtfjKsLDazMfhp4Jgb/3qYyx3LC9p73wE2id7YWeXlkytF3ZzzQVwitLmGxPUBlTSRI/MY7NV07GvZPsqBrk=
Message-ID: <76505a370609281856p67d9d9a9tce0b8bdadebb25de@mail.gmail.com>
Date: Fri, 29 Sep 2006 09:56:22 +0800
From: keios <keios.cn@gmail.com>
To: "Matt Mackall" <mpm@selenic.com>
Subject: Re: [PATCH] low performance of lib/sort.c , kernel 2.6.18
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060928223341.GI6412@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <76505a370609280818r3ffc9a4akf4cec6ed366d32e3@mail.gmail.com>
	 <20060928223341.GI6412@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it is almost same as the first version, except a little
difference : descendants of node [r] is [r * 2 + 1] and [r * 2 + 2]
(comment:the size of element is ignored), but yours is [r * 2] and [r
* 2 + 1] .

The tree you build is :
       [0]
        |
       [1]
      /   \
    [2]   [3]
   /  \    /  \
 [4]  [5][6]  [7]

Not same as standard tree :
       [0]
      /   \
    [1]   [2]
   /  \    /  \
 [3]  [4][5]  [6]

We can find the standard algorithm here:
http://en.wikipedia.org/wiki/Heapsort .

So , in every shift-down operation (comment: In sort.c, it is after
heapify , second loop in /* sort */ section ), [0] will compare with
[0] and [1], and always swap with [1] . Performance lost here .

Acked-by: keios <keios.cn@gmail.com>

On 9/29/06, Matt Mackall <mpm@selenic.com> wrote:
> On Thu, Sep 28, 2006 at 11:18:45PM +0800, keios wrote:
> > It is a non-standard heap-sort algorithm implementation because the
> > index of child node is wrong . The sort function still outputs right
> > result, but the performance is O( n * ( log(n) + 1 ) ) , about 10% ~
> > 20% worse than standard algorithm .
> >
> > Signed-off-by: keios <keios.cn@gmail.com>
>
> Was a bit mystified by this as your patch matches what I've got
> in my userspace test harness from 2003.
>
> Here's what I submitted, which is almost the same as yours:
>
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/broken-out/lib-sort-heapsort-implementation-of-sort.patch
>
> Then Zou Nan hai sent Andrew a fix for an off-by-one bug here (merged
> with my patch):
>
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/broken-out/lib-sort-heapsort-implementation-of-sort.patch
>
> ..which introduced the performance regression.
>
> And then I subsequently tweaked my local copy for use in another
> project, coming up with your version.
>
> So this passes my test harness just fine (for both even and odd array
> sizes).
>
> Acked-by: Matt Mackall <mpm@selenic.com>
>
> --
> Mathematics is the supreme nostalgia of our time.
>
