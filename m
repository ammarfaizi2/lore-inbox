Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVBCXXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVBCXXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 18:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbVBCXWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 18:22:52 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:41894 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261897AbVBCXTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 18:19:34 -0500
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, mpm@selenic.com,
       Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
References: <E1CwI5w-0000mJ-00@gondolin.me.apana.org.au>
	<1107342847.21040.18.camel@winden.suse.de>
From: Junio C Hamano <junkio@cox.net>
Date: Thu, 03 Feb 2005 15:19:31 -0800
In-Reply-To: <1107342847.21040.18.camel@winden.suse.de> (Andreas
 Gruenbacher's message of "Wed, 02 Feb 2005 12:14:07 +0100")
Message-ID: <7v1xbxkz98.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AG" == Andreas Gruenbacher <agruen@suse.de> writes:

AG> On Wed, 2005-02-02 at 11:50, Herbert Xu wrote:
>> What if a/b aren't aligned?

AG> If people sort arrays that are unaligned even though the
AG> element size is a multiple of sizeof(long) (or sizeof(u32)
AG> as Matt proposes), they are just begging for bad
AG> performance.

If the user of your sort routine is dealing with an array of
this shape:

    struct { char e[8]; } a[]

the alignment for the normal access (e.g. a[ix].e[iy]) would not
matter and they are not begging for bad performance, are they?
It is only this swap routine, which is internal to the
implementation of sort, that is begging for it, methinks.  

Is unaligned access inside of the kernel get fixed up on all
architectures?  If not, this would not just be a performance
issue but becomes a correctness issue.

How about something like this to be a bit more defensive:

static inline void swap(void *a, void *b, int size)
{
       if (((unsigned long)a | (unsigned long)b | size) % sizeof(long)) {
	       char t;
	       do {
		       t = *(char *)a;
		       *(char *)a++ = *(char *)b;
		       *(char *)b++ = t;
	       } while (--size > 0);
       } else {
	       long t;
	       do {
		       t = *(long *)a;
		       *(long *)a = *(long *)b;
		       *(long *)b = t;
		       size -= sizeof(long);
	       } while (size > sizeof(long));
       }
}

