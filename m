Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVKUKkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVKUKkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 05:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVKUKkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 05:40:39 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:27758 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932265AbVKUKki convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 05:40:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EQE7peRTGr+lw0qGr+kqNiTS9U0AA++br0HmFb+hXNeIy6t07l7Uc3n/Bh+l3UsFhX5GT3TgyGxJapFo56v44EtWwPa6E/ywcOdVG5mk1+O9f0W61lXeOGsPO8w+o6XuYn7mVZ3FnW6ANWIshBNVmfpmvwDqlicH+eZeCvd8jO0=
Message-ID: <9a8748490511210240n97ab19ev8c27dc7b6f0e3d51@mail.gmail.com>
Date: Mon, 21 Nov 2005 11:40:38 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386, nmi: signed vs unsigned mixup
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490511191745h6aebd102r91007bc2b84382ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511200010.33658.jesper.juhl@gmail.com>
	 <20051119162805.47796de9.akpm@osdl.org>
	 <9a8748490511191630r3ad3e24w4e6d21b3f3b0c3a7@mail.gmail.com>
	 <20051119170818.5e16afae.akpm@osdl.org>
	 <9a8748490511191715x61057bc8i1431ca3a24cfb2e6@mail.gmail.com>
	 <20051119173358.2bf1dbb5.akpm@osdl.org>
	 <9a8748490511191745h6aebd102r91007bc2b84382ff@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 11/20/05, Andrew Morton <akpm@osdl.org> wrote:
[snip]
> >
> > Sure, go for it - let's see what the patches end up looking like.  We might
> > find real bugs in there - I found a bunch of howlers back in 2.3.late.
> > That was with `gcc -W' which turns on more than -Wsigned-compare.
> >
> > Maybe you could prepare a quick overall summary first, see if you can work
> > out the overall scope of the problem and then we can take a look at that,
> > decide what bits to attack?
> >
> Sure, I'll do that tomorrow.
> All these sign issues all over annoy me :)
> I'll try to get a handle on the scope of the thing tomorrow, then send
> a mail with what I find, then we can talk about what would be useful
> to do.
>

Ok, I did an allyesconfig build (x86 build) of 2.6.15-rc2 with
-Wsign-compare and I have some numbers.

The total number of warnings for the build ended up at 14681
Of course some of the warnings are not related to sign issues, so
let's look at just

comparison between signed and unsigned   (12378 instances of this one)
signed and unsigned type in conditional expression   (2109 instances
of this one)
comparison of promoted ~unsigned with constant   (4 instances of this one)

So for the signedness related warnings we have a total of 14491 warnings.
The 14491 warnings come from a total of 1701 files.

This looks like a lot, but it's really not as bad as it looks since a
lot of the warnings are duplicates.

Let's take a look at the top 10 offenders :

1)
4078 counts of
warning: comparison between signed and unsigned
from include/asm/bitops.h:339

2)
1125 counts of
warning: comparison between signed and unsigned
from include/linux/netdevice.h:796

3)
256 counts of
warning: signed and unsigned type in conditional expression
from drivers/scsi/aic7xxx/aic79xx_osm_pci.c:79

4)
256 counts of
warning: signed and unsigned type in conditional expression
from drivers/scsi/aic7xxx/aic79xx_osm_pci.c:77

5)
120 counts of
warning: signed and unsigned type in conditional expression
from fs/xfs/xfs_mount.h:458

6)
90 counts of
warning: comparison between signed and unsigned
from include/net/tcp_ecn.h:53

7)
90 counts of
warning: comparison between signed and unsigned
from include/net/tcp.h:866

8)
90 counts of
warning: signed and unsigned type in conditional expression
from include/net/tcp.h:1148

9)
90 counts of
warning: signed and unsigned type in conditional expression
from include/net/tcp.h:1143

10)
86 counts of
warning: comparison between signed and unsigned
from include/linux/fb.h:859


So, if we just cleaned up the top 10 offenders we'd get rid of 6281
out of the total 14491 warnings.

I've not yet looked at what would be involved in fixing these top 10,
I'll look at that later, for now I just wanted to post the numbers I
had.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
