Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTEGGbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTEGGbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:31:47 -0400
Received: from [217.157.19.70] ([217.157.19.70]:50443 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S262912AbTEGGbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:31:45 -0400
From: Thomas Horsten <thomas@horsten.com>
To: "ismail (cartman) donmez" <voidcartman@yahoo.com>,
       "David S. Miller" <davem@redhat.com>, marcelo@conectiva.com.br
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Date: Wed, 7 May 2003 07:44:27 +0100
User-Agent: KMail/1.5.1
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
References: <20030506104956.A29357@infradead.org> <200305061640.13360.thomas@horsten.com> <200305070850.59912.voidcartman@yahoo.com>
In-Reply-To: <200305070850.59912.voidcartman@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305070744.27207.thomas@horsten.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 6:50 am, ismail (cartman) donmez wrote:
> On Tuesday 06 May 2003 18:40, Thomas Horsten wrote:
> > --- linux-2.4.21-rc1-orig/include/asm-i386/types.h	2002-08-03
> > 01:39:45.000000000 +0100
> > +++ linux-2.4.21-rc1-ac4/include/asm-i386/types.h	2003-05-06
> > 15:07:06.000000000 +0100
> > @@ -17,10 +17,8 @@
> >  typedef __signed__ int __s32;
> >  typedef unsigned int __u32;
> >
> > -#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
> >  typedef __signed__ long long __s64;
> >  typedef unsigned long long __u64;
> > -#endif
>
> Imho this is bad here you define a long long variable even if userspace
> apps use -ansi flag where Ansi standart has no support for long long
> variables. I think this should be fixed in userspace.

Well if you look at my earlier patch (where I changed byteorder.h instead), 
you'll see that the two places conflict for sure, and is objectively an error 
- hence the need for a fix, whatever you think about userland including these 
headers in general:

1. In types.h we define __u64 only if __STRICT_ANSI__ is *not* defined.
2. In byteorder.h we declare an inline function that uses __u64, regardless of 
whether __STRICT_ANSI__ is defined (new in 2.4.21).

It causes a compile error in the most trivial circumstance: Create a .c file 
with just one line, e.g. "include <asm/types.h>" and compile it with -ansi.

My reasoning for the original patch was: The new code added in 2.4.21 causes 
the break, __u64 is not going to be defined if -ansi is (and this has been 
the case all along, so that means with 99.9% certainty that nobody are 
actually using even the old macro version of swab64, or it would have broken 
then). So, take the inline swab64 out if __STRICT_ANSI__ is defined and don't 
use "long long".

Then David said he didn't like the approach since another header might use 
swab64 (I don't think its highly likely but it's certainly a possibility). So 
then I suggested this fix instead which he liked more. This fix is also not 
100% correct in that it breaks ANSI C, (but I'm sure other kernel headers 
might do that just as well), but at least swab64 will always be available, 
and it will work when compiling with GCC on x86 platform even with -ansi on 
(remember that the file being patched is in asm-x86 so this won't affect 
other platforms).

Another argument for the second solution is that if the userland apps are not 
supposed to include the headers in the first place then why would we ever 
check for __STRICT_ANSI__ in kernel headers.

However I do not agree with that - I think it makes total sense for userland 
to include kernel headers when we are talking e.g. specific device driver 
interface. Imagine Joe Admin has firewall which is a pretty old Slackware 
with 2.2 kernel and wants to upgrade to 2.4 to get from ipchains to iptables 
(all just an example). He just downloads the 2.4 kernel and builds it, 
symlinks to /usr/src/linux so his /usr/include/linux and ../asm will point to 
the new kernel then he goes on to build the iptables userland binary - oops, 
this didn't work if he'd relied on a separate set of kernel headers and a 
package didn't happen to be available, also what's the use of maintaining two 
sets of essentially the same header when we could just sanitize the Linux 
ones a bit (read: just enough that they don't break userland).

In summary I'm not too concerned which of the two solutions are included but I 
think one should be for sure. It's just plain wrong to have the #ifdef 
__STRICT_ANSI__ in one place and not the other.

// Thomas

