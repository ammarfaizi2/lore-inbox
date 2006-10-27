Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423722AbWJ0F4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423722AbWJ0F4E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 01:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423716AbWJ0F4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 01:56:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:15822 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423722AbWJ0F4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 01:56:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jVyB0xfumfgTAT0/cwqxIu2SwoaRK+1XxO7t37NPxMjzGLcOyUj6suhwkBf6qoEdNHL0c2a/5ifsRKTBQGOzRQkhogKXPL2ITMSoUVk2wMPqKD/eebCkPB5/o/pTx3NvvBizWggSVUMpEH/HfPDWidXq6xvYXyKVH6Ju7jEGBdA=
Message-ID: <aec7e5c30610262256v5090bb6at2c62fb113a71828c@mail.gmail.com>
Date: Fri, 27 Oct 2006 14:56:01 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: vgoyal@in.ibm.com
Subject: Re: [PATCH] Kdump: Align 64-bit ELF crash notes correctly (x86_64, powerpc)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       "Andi Kleen" <ak@muc.de>, fastboot@lists.osdl.org,
       Horms <horms@verge.net.au>, "Dave Anderson" <anderson@redhat.com>,
       ebiederm@xmission.com
In-Reply-To: <20061026144018.GB11284@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061026094957.3410.45001.sendpatchset@localhost>
	 <20061026144018.GB11284@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

Thanks for the quick reply!

On 10/26/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> On Thu, Oct 26, 2006 at 06:49:57PM +0900, Magnus Damm wrote:
> > Kdump: Align 64-bit ELF crash notes correctly (x86_64, powerpc)
> >
> > The current ELF code aligns data to 32-bit addresses, regardless if ELFCLASS32
> > or ELFCLASS64 is used. This works well for the 32-bit case, but for 64-bit
> > notes we should (of course) align to 64-bit addresses. At least if we intend
> > to follow the "ELF-64 Object File Format, Version 1.5 Draft 2, May 27, 1998".
> >
> > Unfortunately this change affects 3 pieces of code:
> > - The regular Linux kernel: See x86_64 and powerpc changes below.
> > - The "crash" kernel: Needs to align properly when merging notes, see below.
> > - The utilities that read the vmcore files: Crash, GDB and so on.
> >
> Hi Magnus,
>
> Interesting observation. Going through the ELF-64 Object File format,
> version 1.5, it does look like that note data should be aligned to
> 8byte boundary for 64bit and not 4 byte boundary.
>
> But given the fact that as of today, gdb, readelf parse the notes correctly,
> then they are broken too and needs to be changed?

Well, yes, other tools needs to be updated as well.

I just quickly went through the code for readelf from binutils-2.16.1
and in readelf.c, process_corefile_note_segment() always treats
alignment as 4. Broken. The bfd code in the same package seems to be
correct in most 64-bit cases though, struct elf_size_info ->
log_file_align seems to be the value we are looking for. It is set to
3 for at least elf64-{alpha, hppa, mips, s390, sparc}. I've not been
able to figure out the status for ppc and x86_64.

I do however believe that no-one has been troubled by this so far
because we happen to have well formed data. It seems like the only
string that is passed to append_elf_note() in the kdump case is "CORE"
and it is 5 bytes including terminating zero.

The old code adds 3 bytes and divides by 4 to get 2 32-bit values.
With my fix we would add 7 bytes and divide by 8 to get 1 64-bit value.

In both cases we pad to a total of 8 bytes. So we seem to be lucky with "CORE".
This also means that my fix doesn't affect the format of the data in
the current case.

> I just looked at process core dumper (binfmt_elf.c) and that too also
> seems to be creating notes aligned at 4byte boundary (alignfile()).
>
> Same seems to be the case of /proc/kcore ((storenote()). Notes seem to
> be 4byte aligned.
>
> So looks like, everywhere in kernel and tool chain we are still following
> the assumption of notes being 4byte aligned even for 64bit.
>
> I think if you are fixing it, then please fix it for /proc/kcore and
> process core dumps too so that kernel exports a consistent image and then
> tool chain folks can do the modifications.

Yes, that makes sense. I will have a look at it. I assume that
following the spec is what we want to do, but if someone disagrees
please shout _now_!

Thanks,

/ magnus
