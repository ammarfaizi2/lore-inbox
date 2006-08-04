Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161458AbWHDXQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161458AbWHDXQY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161573AbWHDXQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:16:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57522 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161458AbWHDXQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:16:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<20060804225611.GG19244@in.ibm.com>
Date: Fri, 04 Aug 2006 17:14:37 -0600
In-Reply-To: <20060804225611.GG19244@in.ibm.com> (Vivek Goyal's message of
	"Fri, 4 Aug 2006 18:56:11 -0400")
Message-ID: <m1k65onleq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Tue, Aug 01, 2006 at 04:58:49AM -0600, Eric W. Biederman wrote:
>> 
>> The problem:
>> 
>> We can't always run the kernel at 1MB or 2MB, and so people who need
>> different addresses must build multiple kernels.  The bzImage format
>> can't even represent loading a kernel at other than it's default address.
>> With kexec on panic now starting to be used by distros having a kernel
>> not running at the default load address is starting to become common.
>> 
> Hi Eric,
>
> There seems to be a small anomaly in the current set of patches for i386.
>
> For example if one compiles the kernel with CONFIG_RELOCATABLE=y
> and CONFIG_PHYSICAL_START=0x400000 (4MB) and he uses grub to load
> the kernel then kernel would run from 1MB location. I think user would
> expect it to run from 4MB location.

Agreed.  That is a non-intuitive, and should probably be fixed.

> I think distro's might want to keep above config options enabled. 
> CONFIG_RELOCATABLE=y so that kexec can load kdump kernel at a 
> different address and CONFIG_PHYSICAL_START=non 1MB location, to
> extract better performance. (As we had discussions on mailing list
> some time back.)
>
> In principle this is a limitation on boot-loaders part but as we can
> not fix the boot-loaders out there, probably we can try fixing it
> at kernel level.
>
> What I have done here is that decompressor code will determine the
> final resting place of the kernel based on boot loader type. So 
> if I have been loaded by kexec, I am supposed to run from loaded address
> otherwise I am supposed to run from CONFIG_PHYSICAL_START as I have been
> loaded at 1MB address due to boot loader limitation and that's not the
> intention.
>
> A prototype patch is attached with the mail. I have assumed that I can
> assign a boot loader type id 9 to kexec (Documentation/i386/boot.txt).
> Also assuming that all other boot loaders apart from kexec have got 1MB
> limitation. If not, its trivial to include their boot loader ids also.
>
> I have tested this patch and it works fine. What do you think about
> this approach ?

I think there is some value in it. But I need to digest it.

I have a cold right now and am running pretty weak, so it is going to take me
a little bit to look at this.

I don't like taking action based upon bootloader type.  As that assumes
all kinds of things.  But having better rules for when we perform relocation
makes sense.  There might be a way to detect coming from setup.S

I gave it some care last time, I worked through this and it didn't quite work.

I guess the practical question is do people see a real performance benefit
when loading the kernel at 4MB?

Possibly the right solution is to do like I did on x86_64 and simply remove
CONFIG_PHYSICAL_START, and always place the kernel at 4MB, or something like
that.

The practical question is what to do to keep the complexity from spinning
out of control.  Removing CONFIG_PHYSICAL_START would seriously help with
that.

Eric
