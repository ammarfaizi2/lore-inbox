Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWHYGjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWHYGjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWHYGjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:39:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:46213 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932333AbWHYGje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:39:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f6pjkuS98VMaZZfptvsQ5OzruVVRcNMPNZ1fPPhSPgcCfjMtsIchHWncwQ+6Zq5sUZwCET7ivPXNcpK+7Ycauq1r4vam8YrB6ztcEBdjOb+sMWZTilZz+t78vCQsJX1UrlhthwPh7mSlRcYO/7SPIZJqG14bHvsQIg3r7fLRIdY=
Message-ID: <a2ebde260608242339h3ad6718fg26a00ef56c86a1dc@mail.gmail.com>
Date: Fri, 25 Aug 2006 14:39:33 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Fwd: Unnecessary Relocation Hiding?
Cc: ak@suse.de, "Christoph Lameter" <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <a2ebde260608242329r12259e0k7e798ee1d8737d68@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com>
	 <Pine.LNX.4.64.0608241125140.4394@schroedinger.engr.sgi.com>
	 <17646.14056.102017.127644@cargo.ozlabs.ibm.com>
	 <a2ebde260608241830p2d26b20bp6bfb9b1b5a267ec6@mail.gmail.com>
	 <17646.29510.296315.569294@cargo.ozlabs.ibm.com>
	 <a2ebde260608242329r12259e0k7e798ee1d8737d68@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mail was rejected by the list because I sent it in HTML format, my
fault. Resend it in plain-text and you can delete the version you do
not like.

I put my understanding below for your confirm or correcting, ...

Once I get a C pointer, say "some_type_t * ptr;" ...

1. If I want to treat it as an ordinary C array and retrieve elements
from it, then plain pointer addition is OK. Like this:

some_type_t * ptr1 = ptr + 2;

2. If I want to add some offset to it (that is, the ptr need to be
converted to _void *_ or _unsigned long_ before manipulated), and the
offset does not exceed sizeof(some_type_t), then plain C addtion is
OK. Like this:

unsigned long raw_addr = (unsigned long)ptr;
int *second_mem = raw_addr + sizeof(int);  // as long as the
sizeof(int) less than
                                                               // the
sizeof(some_type_t), for example,
                                                               //
some_type_t really has two members and the
                                                               // the
first is really an integer.

3. If I want to add some offset to it (after converted to _void *_ or
_unsigned long_). However, the offset exceed sizeof(some_type_t). In
this case, gcc still (mis-)assume that I would want to do the same
thing as case 2 (but I am not actually). In this case, I have to use
RELOC_HIDE. And this is exactly what per_cpu() going to do.

== the end of the description of my understanding ==

Thanks.
Feng,Dong





2006/8/25, Paul Mackerras <paulus@samba.org>:
> Dong Feng writes:
>
> > Sorry for perhaps extending the specific question to a more generic
> > one. In which cases shall we, in current or future development,
> > prevent gcc from knowing a pointer-addition in the way RELOC_HIDE? And
> > in what cases shall we just write pure C point addition?
>
> Where you are saying to gcc "you think this variable is at this
> address, but I know it's actually at this other address over here" you
> should use RELOC_HIDE.  Where the addition is being used to get the
> address of some part of the object (so the resulting address is still
> within the object) you can just use plain addition.
>
> Paul.
>
