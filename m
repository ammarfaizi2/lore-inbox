Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965797AbWKJDwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965797AbWKJDwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 22:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966079AbWKJDwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 22:52:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:35629 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965797AbWKJDwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 22:52:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PdSk3eo6hQ+wDqVSPnozrA7rjPWupPxmKXHgXAebLWMRIvRrb2i4YJsIfEmFkaq8bz5huNlvod0DYpJuCQfy5ov0WhpzQMnuQEUlxnYelNkAdPrivg4uvRfkLJUHE15LRxW7PmL2m9mduEhxjNhiN+Aisq/IEWCAG5mBhNdGeg4=
Message-ID: <aec7e5c30611091952j6cd7988akc1671d269925bba9@mail.gmail.com>
Date: Fri, 10 Nov 2006 12:52:40 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
Cc: "Magnus Damm" <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       "Vivek Goyal" <vgoyal@in.ibm.com>, "Andi Kleen" <ak@muc.de>,
       fastboot@lists.osdl.org, Horms <horms@verge.net.au>,
       "Dave Anderson" <anderson@redhat.com>
In-Reply-To: <m1psbwzpmx.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061102101942.452.73192.sendpatchset@localhost>
	 <20061102101949.452.23441.sendpatchset@localhost>
	 <m1psbwzpmx.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Thanks for your answer.

On 11/9/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Magnus Damm <magnus@valinux.co.jp> writes:
>
> > elf: Align elf notes properly
> >
> > The kernel currently contains several elf note aligment implementations. Most
> > implementations follow the spec on 32-bit platforms, but none current aligns
> > the notes correctly on 64-bit platforms. This patch tries to fix this by
> > interpreting the 64-bit and 32-bit elf specs as the following:
> >
> > offset bytes name
> > 0      4     n_namesz -+                  -+
> > 4      4     n_descsz  | elf note header   |
> > 8      4     n_type   -+                   | elf note entry size - N4
> > 12     N1    name                          |
> > N2     N3    desc                         -+
> >
> > WS = word size in bytes (4 for 32 bit, 8 for 64 bit)
> > N1 = roundup(n_namesz + sizeof(elf note header), WS) - sizeof(elf note header)
> > N2 = sizeof(elf note header) + N1
> > N3 = roundup(n_descsz, WS)
> > N4 = sizeof(elf note header) + N1 + N2
> >
> > The elf note header contains three 32-bit values on 32-bit and 64-bit systems.
> > The header is followed by name and desc data together with padding. The
> > alignment and padding varies depending on the word size.
>
> I see your point and I disagree.  The notes in a kernel generated
> core dump do not vary in size.  Find me some implementation evidence that
> anyone ever added the extra 4 bytes of alignment to the description and the
> padding fields and I will be ready to consider this.  Currently this
> just appears to be reading a draft spec that doesn't match reality.

I'm not sure you see all my points. The important parts are the
offsets - offset 0 and offset N2 in the description above. The should
be aligned somehow. Exactly how to align them depends on if the 64-bit
spec is valid or not.

My points are:

- Some kdump code rounds up the size of "elf note header" today. This
is unneccessary for 32 bit alignment and plain wrong for 64 bit
alignment. So I think that the code is strange and should be changed
regardless if the 64-bit spec is valid or not.

- Many implementations incorrectly calculate N2 as: roundup(sizeof(elf
note header)) + roundup(n_namesz).

- You say that the size of the notes do not vary and therefore this is
a non-issue. I agree that the size does not vary, but I believe that
the aligment _is_ an issue. One example is the N2 calculation above,
but more importantly the vmcore code that merges the elf note sections
into one. You know, if you have more than one cpu you will end up with
more than one crash note. And if you run Xen you will have even more
crash notes.

- On top of this I think it would be nice if all this code could be
unified to avoid code duplication. But we need to straighten out this
and agree on how the aligment should work before the code can be
merged into one implementation.

Thanks,

/ magnus
