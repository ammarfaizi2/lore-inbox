Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWHBHLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWHBHLp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWHBHLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:11:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12499 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751299AbWHBHLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:11:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, "Jan Kratochvil" <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, "Vivek Goyal" <vgoyal@in.ibm.com>,
       "Linda Wang" <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<aec7e5c30608012334y42e947e6ge935e5d866f78c84@mail.gmail.com>
Date: Wed, 02 Aug 2006 01:09:55 -0600
In-Reply-To: <aec7e5c30608012334y42e947e6ge935e5d866f78c84@mail.gmail.com>
	(Magnus Damm's message of "Wed, 2 Aug 2006 15:34:39 +0900")
Message-ID: <m1lkq7txz0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> On 8/1/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> The problem:
>>
>> We can't always run the kernel at 1MB or 2MB, and so people who need
>> different addresses must build multiple kernels.  The bzImage format
>> can't even represent loading a kernel at other than it's default address.
>> With kexec on panic now starting to be used by distros having a kernel
>> not running at the default load address is starting to become common.
>>
>> The goal of this patch series is to build kernels that are relocatable
>> at run time, and to extend the bzImage format to make it capable of
>> expressing a relocatable kernel.
>
> Nice work. I'd really like to see support for relocatable kernels in
> mainline (and kexec-tools!).

kexec-tools already have initial support for ELF ET_DYN executables.
Vivek posted a fix a day two ago so I expect that the support
should be working.

> Eric, could you please list the advantages of your run-time relocation
> code over my incomplete relocate-in-userspace prototype posted to
> fastboot a few weeks ago?

If you watch an architecture evolve one thing you will notice is that
the kinds of relocations keep growing.  An ever growing list of things
to for the bootloader to do is a pain.  Especially when bootloaders
generally need to be as simple and as fixed as possible because bootloaders
are not something you generally want to update.

Beyond that if you look at head.S the code to process the relocations 
(after I have finished post processing them at build time) is 9 instructions.
Which is absolutely trivial, at least for now.

By keeping the bzImage processing the relocations we have kept the
bootloader/kernel interface simple.

> One thing I know for sure is that your implementation supports bzImage
> while my only supports relocation of vmlinux files. Are there any
> other uses for relocatable bzImage except kdump?

I can't think of any volume users.  A hypervisor that would actually report
the real physical addresses would be a candidate.  It's a general purpose
facility so if it is interesting users will show up.  Static
relocation has already found another use on x86_64.

There are definitely users of an ELF bzImage beyond the kdump case.
Anything that doesn't have a traditional 16bit BIOS on it.  LinuxBIOS,
and Xen, and some others.

Not having to keep track of anything but your bzImage to boot is also
a serious advantage.  It's the one binary to rule them all. :)

Eric
