Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbULNFwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbULNFwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 00:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbULNFwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 00:52:06 -0500
Received: from almesberger.net ([63.105.73.238]:33036 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261426AbULNFv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 00:51:59 -0500
Date: Tue, 14 Dec 2004 02:51:10 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041214025110.A28617@almesberger.net>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>; from torvalds@osdl.org on Sun, Nov 28, 2004 at 05:28:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, this discussion has gone on for too long anyway, but let's make it
> easier for everybody. The kernel uses u8/u16/u32 because:
> 
> 	- the kernel should not depend on, or pollute user-space naming.
> 	  YOU MUST NOT USE "uint32_t" when that may not be defined, and
> 	  user-space rules for when it is defined are arcane and totally
> 	  arbitrary.

Hmm, so you're predicting problems if user space includes something
that uses uint32_t ? Wouldn't either of these work (descriptive file
names for clarity):

 1) include/linux-user/foo.h:
    #include <stdint.h>
    #include <linux-kernel-and-user-common/foo.h>

    include/linux/foo.h:
    #include <linux/stdint.h>
    #include <linux-kernel-and-user-common/foo.h>

    (And document that anything under linux-user may pull in a
    certain set of standard headers, such as stdint.h, maybe
    sys/types.h, etc.)

 2) include/linux-user/foo.h:
    #ifndef __KERNEL__
    #include <stdint.h>
    #else
    #include <linux/stdint.h>  /* if we want this */
    #endif
    ...
    foo stuff (or some include)
    ...

    Idem. (Sort of the opposite of what we have today.)

 3) just require that some stdint.h has been included before
    including linux-user/foo.h

For user space that absolutely insists on doing its own uint32_t,
a refined variant of case 3 (i.e. detailing of what exactly is
expected to be defined) or, in case 1, direct use of
linux-kernel-and-user-common/foo.h along with the definition from
case 3 should work.

There are other cases where a header file may pull in other
definitions, e.g. for fcntl.h, POSIX decrees

| Inclusion of the <fcntl.h> header may also make visible all
| symbols from <sys/stat.h> and <unistd.h>.

So the semantics of for cases 1 and 2 would be consistent with
current POSIX practice.

What am I missing ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
