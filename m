Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945989AbWKJGyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945989AbWKJGyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945991AbWKJGyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:54:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:46087 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1945989AbWKJGx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:53:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jxu2FpJyGWrlpln39zNZttR0/hC3065XmpllpaxJpSYa8P/C54n3riWbR/4e0SGc1WS/q3wfBMJmf8kToPDLYjZivp7X9asYoMDndgEAnOAVPlZyMXjr8FNOFIgMpJRC5v3AJ7mdnDxa/fMq1ugVxKYUHl8kIW5wdQldSbvNNXo=
Message-ID: <aec7e5c30611092253q6bd15701x1f5da122de5c7075@mail.gmail.com>
Date: Fri, 10 Nov 2006 15:53:57 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
Cc: "Magnus Damm" <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       "Vivek Goyal" <vgoyal@in.ibm.com>, "Andi Kleen" <ak@muc.de>,
       fastboot@lists.osdl.org, Horms <horms@verge.net.au>,
       "Dave Anderson" <anderson@redhat.com>
In-Reply-To: <m1irhnnb09.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061102101942.452.73192.sendpatchset@localhost>
	 <20061102101949.452.23441.sendpatchset@localhost>
	 <m1psbwzpmx.fsf@ebiederm.dsl.xmission.com>
	 <aec7e5c30611091952j6cd7988akc1671d269925bba9@mail.gmail.com>
	 <m1irhnnb09.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Magnus Damm" <magnus.damm@gmail.com> writes:
>
> > I'm not sure you see all my points. The important parts are the
> > offsets - offset 0 and offset N2 in the description above. The should
> > be aligned somehow. Exactly how to align them depends on if the 64-bit
> > spec is valid or not.
> >
> > My points are:
> >
> > - Some kdump code rounds up the size of "elf note header" today. This
> > is unneccessary for 32 bit alignment and plain wrong for 64 bit
> > alignment. So I think that the code is strange and should be changed
> > regardless if the 64-bit spec is valid or not.
>
> Sure that is reasonable, if correct.
>
> > - Many implementations incorrectly calculate N2 as: roundup(sizeof(elf
> > note header)) + roundup(n_namesz).
>
> I am not certain that is incorrect.  roundup(sizeof(elf note header), 4) +
> roundup(n_namesize, 4) will yield something that is properly 4 byte aligned.
> I do agree that implementation is not correct for 8 byte alignment.  8 byte
> alignment does not appear to be in widespread use in the wild.

You are correct that it only matters if we are interested in 8 byte
alignment. So it should be a non-issue for the 4-byte aligment case.

> > - You say that the size of the notes do not vary and therefore this is
> > a non-issue. I agree that the size does not vary, but I believe that
> > the aligment _is_ an issue. One example is the N2 calculation above,
> > but more importantly the vmcore code that merges the elf note sections
> > into one. You know, if you have more than one cpu you will end up with
> > more than one crash note. And if you run Xen you will have even more
> > crash notes.
>
> Sure that is clearly an issue.
>
> > - On top of this I think it would be nice if all this code could be
> > unified to avoid code duplication. But we need to straighten out this
> > and agree on how the aligment should work before the code can be
> > merged into one implementation.
>
> Sure.
>
> To verify your claim that 8 byte alignment is correct I checked the
> core dump code in fs/binfmt_elf.c in the linux kernel.  That always
> uses 4 byte alignment.  Therefore it appears clear that only doing
> 4 byte alignment is not a local misreading of the spec, and is used in
> other implementations.  If you can find an implementation that uses
> 8 byte alignment I am willing to consider it.

Yes, fs/binfmt_elf.c is one of the files that my patch modifies. There
are several elf note implementations in the kernel, all seem to use
4-byte aligment.

Implementations that use 8-byte alignment:

binutils-2.16.1/bfd/elf.c: elf_core_write_note() is using
log_file_align which is set to 3 on some 64-bit platforms.  8-byte
alignment in some cases.

binutils-2.16.1/binutils/readelf.c: process_corefile_note_segment() is
always using 4-byte alignment though.

> The current situation is that the linux kernel generated application
> core dumps use 4 byte alignment so I expect that is what existing
> applications such as gdb expect.

Most applications probably expect 4-byte aligned data. OTOH, I just
came across HP's ELF-64 Object File Format document. It says that
8-byte alignment should be used:

http://devresource.hp.com/drc/STK/docs/refs/elf-64-hp.pdf

So now we have two documents that say 8-byte alignment should be used.

> Therefore we use 4 byte alignment unless it can be shown that the
> linux core dumps are a fluke and should be fixed.

Ok. Vivek, Dave, anyone? Comments?

/ magnus
