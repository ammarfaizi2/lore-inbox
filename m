Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965357AbWKTKCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965357AbWKTKCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 05:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbWKTKCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 05:02:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:44021 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965357AbWKTKCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 05:02:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OAhpKZdYw1Dp1P/cmBC0hCHnMZDcrfv4k0AZbGsgvrYC0okjCN0Mi3tLmM2DQnpcOJ2yHkMF5Py+nIlz2xG+bXjxpABDrp9pu8v5usiP2VRhmF1mcA4bC63jW70q+b+S20+RBwGkdpNJl4ku8K8/HjuNw5EIOQHoxtmYvOMUqVQ=
Message-ID: <aec7e5c30611200202j77c9e20cgd89ca782ac73e58b@mail.gmail.com>
Date: Mon, 20 Nov 2006 19:02:42 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: vgoyal@in.ibm.com
Subject: Re: [PATCH 17/20] x86_64: Remove CONFIG_PHYSICAL_START
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Reloc Kernel List" <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
In-Reply-To: <20061118024529.GC25205@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061117223432.GA15449@in.ibm.com>
	 <20061117225628.GR15449@in.ibm.com>
	 <aec7e5c30611171714p23c00fdbgea4a1097cfdf4ec0@mail.gmail.com>
	 <20061118024529.GC25205@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> On Sat, Nov 18, 2006 at 10:14:31AM +0900, Magnus Damm wrote:
> > On 11/18/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > >I am about to add relocatable kernel support which has essentially
> > >no cost so there is no point in retaining CONFIG_PHYSICAL_START
> > >and retaining CONFIG_PHYSICAL_START makes implementation of and
> > >testing of a relocatable kernel more difficult.
> > >
> > >Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> > >Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> > >---

[snip]
 >linux-2.6.19-rc6-reloc/arch/x86_64/mm/fault.c~x86_64-Remove-CONFIG_PHYSICAL_START
  2006-11-17 00:12:50.000000000 -0500
> > >+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/mm/fault.c  2006-11-17
> > >00:12:50.000000000 -0500
> > >@@ -644,9 +644,9 @@ void vmalloc_sync_all(void)
> > >                        start = address + PGDIR_SIZE;
> > >        }
> > >        /* Check that there is no need to do the same for the modules
> > >        area. */
> > >-       BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL));
> > >+       BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL_map));
> > >        BUILD_BUG_ON(!(((MODULES_END - 1) & PGDIR_MASK) ==
> > >-                               (__START_KERNEL & PGDIR_MASK)));
> > >+                               (__START_KERNEL_map & PGDIR_MASK)));
> > > }
> >
> > This code looks either like a bugfix or a bug. If it's a fix then
> > maybe it should be broken out and submitted separately for the
> > rc-kernels?
> >
>
> Magnus, Eric got rid of __START_KERNEL because he was compiling kernel
> for physical addr zero which made __START_KERNEL and __START_KERNEL_map
> same, hence he got rid of __START_KERNEL. That's why above change.
>
> But compiling for physical address zero has got drawback that one can
> not directly load a vmlinux as it shall have to be loaded at physical
> addr zero. Hence I changed the behavior back to compile the kernel for
> physical addr 2MB. So now __START_KERNEL = __START_KERNEL_map + 2MB.
>
> Now it makes sense to retain __START_KERNEL. I have done the changes.

I misunderstood and thought __START_KERNEL was a physical address and
__START_KERNEL_map was a virtual one. But now I understand. Thank you.

>
> > >diff -puN include/asm-x86_64/page.h~x86_64-Remove-CONFIG_PHYSICAL_START
> > >include/asm-x86_64/page.h
> > >---
> > >linux-2.6.19-rc6-reloc/include/asm-x86_64/page.h~x86_64-Remove-CONFIG_PHYSICAL_START        2006-11-17 00:12:50.000000000 -0500
> > >+++ linux-2.6.19-rc6-reloc-root/include/asm-x86_64/page.h       2006-11-17
> > >00:12:50.000000000 -0500
> > >@@ -75,8 +75,6 @@ typedef struct { unsigned long pgprot; }
> > >
> > > #endif /* !__ASSEMBLY__ */
> > >
> > >-#define __PHYSICAL_START       _AC(CONFIG_PHYSICAL_START,UL)
> > >-#define __START_KERNEL         (__START_KERNEL_map + __PHYSICAL_START)
> > > #define __START_KERNEL_map     _AC(0xffffffff80000000,UL)
> > > #define __PAGE_OFFSET           _AC(0xffff810000000000,UL)
> >
> > I understand that you want to remove the Kconfig option
> > CONFIG_PHYSICAL_START and that is fine with me. I don't however like
> > the idea of replacing __PHYSICAL_START and __START_KERNEL with
> > hardcoded values. Is there any special reason behind this?
> >
>
> All the hardcodings for 2MB have disappeared in final version. See next
> patch in the series which actually implements relocatable kernel. Actually
> the whole logic itself has changed hence we did not require these
> hardcodings. This patch retains these hardcodings so that even if somebody
> removes the top patch, kernel can be compiled and booted.
>
> So bottom line, all the hardcodings are not present once all the patches
> have been applied.

My gut feeling said a big no when I saw that you replaced constants
with hardcoded values. But if the hardcoded values disappear when all
patches are applied then I'm happy!

> > The code in page.h already has constants for __START_KERNEL_map and
> > __PAGE_OFFSET (thank god) and none of them are adjustable via Kconfig.
> > Why not change as little as possible and keep __PHYSICAL_START and
> > __START_KERNEL in page.h and the places that use them but remove
> > references to CONFIG_PHYSICAL_START in Kconfig, defconfig, and page.h?
>
> Good suggestion. Now I have retained __START_KERNEL. But did not feel
> the need to retain __PHYSICAL_START. It will be used only at one place
> in page.h

Just to nitpick, isn't the 2M value used both in page.h and head.S? I
don't fully understand the reason why you are hardcoding, but it is
not that important. I think this version of the patch is much better.
Thank you!

/ magnus
