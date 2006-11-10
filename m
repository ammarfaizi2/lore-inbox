Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424353AbWKJFLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424353AbWKJFLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 00:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424309AbWKJFLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 00:11:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18134 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1424353AbWKJFLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 00:11:31 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: "Magnus Damm" <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       "Vivek Goyal" <vgoyal@in.ibm.com>, "Andi Kleen" <ak@muc.de>,
       fastboot@lists.osdl.org, Horms <horms@verge.net.au>,
       "Dave Anderson" <anderson@redhat.com>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
References: <20061102101942.452.73192.sendpatchset@localhost>
	<20061102101949.452.23441.sendpatchset@localhost>
	<m1psbwzpmx.fsf@ebiederm.dsl.xmission.com>
	<aec7e5c30611091952j6cd7988akc1671d269925bba9@mail.gmail.com>
Date: Thu, 09 Nov 2006 22:09:26 -0700
In-Reply-To: <aec7e5c30611091952j6cd7988akc1671d269925bba9@mail.gmail.com>
	(Magnus Damm's message of "Fri, 10 Nov 2006 12:52:40 +0900")
Message-ID: <m1irhnnb09.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> I'm not sure you see all my points. The important parts are the
> offsets - offset 0 and offset N2 in the description above. The should
> be aligned somehow. Exactly how to align them depends on if the 64-bit
> spec is valid or not.
>
> My points are:
>
> - Some kdump code rounds up the size of "elf note header" today. This
> is unneccessary for 32 bit alignment and plain wrong for 64 bit
> alignment. So I think that the code is strange and should be changed
> regardless if the 64-bit spec is valid or not.

Sure that is reasonable, if correct.

> - Many implementations incorrectly calculate N2 as: roundup(sizeof(elf
> note header)) + roundup(n_namesz).

I am not certain that is incorrect.  roundup(sizeof(elf note header), 4) +
roundup(n_namesize, 4) will yield something that is properly 4 byte aligned.
I do agree that implementation is not correct for 8 byte alignment.  8 byte
alignment does not appear to be in widespread use in the wild.

> - You say that the size of the notes do not vary and therefore this is
> a non-issue. I agree that the size does not vary, but I believe that
> the aligment _is_ an issue. One example is the N2 calculation above,
> but more importantly the vmcore code that merges the elf note sections
> into one. You know, if you have more than one cpu you will end up with
> more than one crash note. And if you run Xen you will have even more
> crash notes.

Sure that is clearly an issue.

> - On top of this I think it would be nice if all this code could be
> unified to avoid code duplication. But we need to straighten out this
> and agree on how the aligment should work before the code can be
> merged into one implementation.

Sure.

To verify your claim that 8 byte alignment is correct I checked the
core dump code in fs/binfmt_elf.c in the linux kernel.  That always
uses 4 byte alignment.  Therefore it appears clear that only doing
4 byte alignment is not a local misreading of the spec, and is used in
other implementations.  If you can find an implementation that uses
8 byte alignment I am willing to consider it.

The current situation is that the linux kernel generated application
core dumps use 4 byte alignment so I expect that is what existing
applications such as gdb expect.

Therefore we use 4 byte alignment unless it can be shown that the
linux core dumps are a fluke and should be fixed.


Eric
