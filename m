Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbULOA2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbULOA2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbULOAVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:21:23 -0500
Received: from almesberger.net ([63.105.73.238]:33043 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261719AbULOAKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:10:02 -0500
Date: Tue, 14 Dec 2004 21:09:12 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041214210912.C1271@almesberger.net>
References: <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <20041214025110.A28617@almesberger.net> <Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org> <20041214135029.A1271@almesberger.net> <Pine.LNX.4.58.0412140950520.3279@ppc970.osdl.org> <20041214184605.B1271@almesberger.net> <m3fz28tp82.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3fz28tp82.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Wed, Dec 15, 2004 at 12:49:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Not sure about this. I think such types should be defined by the
> kernel, for it's use only. The libc (and any other userspace
> software) may probably use them (if they have to), but must not
> (re)define them.

That's not what should be happening there: if the kernel only uses
__u32 and friends but never uint32_t et al. at an interface,

typedef __u32 uint32_t;

should be a perfectly safe thing for glibc's stdint.h to do.

> The userspace should probably best use standard types.

Yes.

> This is
> userspace to know if their uint32_t has standard meaning equivalent
> to __u32 or if it's actually a function name.

Yes, but that's decided by whether you include stdint.h or
anything that has the effect of including stdint.h. What I'm
saying is that there should be a guarantee that __u32 and
uint32_t are always identical types. If they are merely
assignment-compatible, you run into problems like this

/* somewhere in a kernel-to-glibc interface (on 32 bit) */
typedef unsigned int __u32;
...
static __u32 foo;

/* elsewhere, in glibc (on 32 bit) */
typedef unsigned long uint32_t;
...
static uint32_t bar;

/* finally, in the application */
if (&foo == &bar)
	/* do something */;

warning: comparison of distinct pointer types lacks a cast

> and then userspace.c (libc et al) should:
> 
> #include linux/headers.h
> 
> str1 v;
> uint32_t variable = v.var;

Interfaces are normally specified with the explicit data type of
each item, in particular struct members. The masses will probably
look for solid branches instead of olive twigs for you if you try
to break this kind of assurance :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
