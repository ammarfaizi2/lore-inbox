Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753834AbWKMDFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbWKMDFU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 22:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753837AbWKMDFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 22:05:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42123 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1753834AbWKMDFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 22:05:18 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: "Jeremy Fitzhardinge" <jeremy@goop.org>,
       "David Miller" <davem@davemloft.net>, horms@verge.net.au,
       magnus@valinux.co.jp, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com,
       ak@muc.de, fastboot@lists.osdl.org, anderson@redhat.com
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
References: <45550D2F.2070004@goop.org>
	<20061110.153930.23011358.davem@davemloft.net>
	<455518C6.8000905@goop.org>
	<20061110.164349.35665774.davem@davemloft.net>
	<4555256F.2050006@goop.org>
	<aec7e5c30611121816s2087c455o6dea419d13de5615@mail.gmail.com>
Date: Sun, 12 Nov 2006 20:03:30 -0700
In-Reply-To: <aec7e5c30611121816s2087c455o6dea419d13de5615@mail.gmail.com>
	(Magnus Damm's message of "Mon, 13 Nov 2006 11:16:19 +0900")
Message-ID: <m1irhkt5dp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> On 11/11/06, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>> David Miller wrote:
>> > We should be OK with the elf note header since n_namesz, n_descsz, and
>> > n_type are 32-bit types even on Elf64.  But for the contents embedded
>> > in the note, I am not convinced that there are no potential issues
>>
>> PT_NOTE segments are not generally mmaped directly, nor are they
>> generally very large.  There should be no problem for a note-using
>> program to load/copy the notes into memory with appropriate alignment.
>> I guess a lot of the contents of core elf notes are register dumps and
>> so on, so debuggers must be already dealing with this.
>
> Someone apparently thought that 32-bit alignment was a good thing and
> put it in the spec for the 32-bit format. You argue that most programs
> copy instead of mmap() which sounds correct, but if someone wants to
> mmap() then our current 32-bit aligned 64-bit elf note implementation
> is broken. Which may or may not be ok.
>
> So why was 32-bit alignment put in the 32-bit spec? I suspect the
> reason was to support direct access of note contents. Either using
> mmap() or read() and direct access. Remeber that the notes could
> contain anything which may require properly aligned data for direct
> access. I think this was the reason the word size alignment was put in
> the spec for in the first place.

This conversation appears to be about 10 years to late.  We have been
providing 32bit alignment on 64bit platforms in the ELF notes since
they were introduced.  x86 is the last architecture to go 64bit.

Even readelf.c assumes notes are always 32bit aligned in their data segment.

If we were doing it from scratch there are clearly some decent reasons for
providing 64bit alignment of the descr field.  Those reasons may be
offset by the needless incompatibility between 32bit and 64bit notes
but that doesn't matter at this point.

The reality on the ground is 32bit alignment.  Doing anything else would
be ABI breakage.  Breaking the ABI of our core files and thus gdb and the
rest of the tools just to conform to some draft spec is daft.

The advantage is not worth it.  None of this stuff is on a fast path
anyway.

At this point the right solution is to amend the lsb so it clearly
specifies what the existing practice is.  So people don't read the
inconsistent specification and get confused. 

Eric
