Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270749AbUJUOxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270749AbUJUOxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269198AbUJUOse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:48:34 -0400
Received: from speedy.tutby.com ([195.209.41.194]:20617 "EHLO tut.by")
	by vger.kernel.org with ESMTP id S270728AbUJUOor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:44:47 -0400
Message-ID: <4177CB5E.7000503@tut.by>
Date: Thu, 21 Oct 2004 17:44:46 +0300
From: Yura Pakhuchiy <Cha0sMaster@tut.by>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: be, ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: ntfs.ko needs unknown symbol end_iomem (under uml)
References: <4177BF68.7080707@tut.by> <1098367622.10371.13.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1098367622.10371.13.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Anton Altaparmakov wrote:
> On Thu, 2004-10-21 at 14:53, Yura Pakhuchiy wrote:
> 
>>Hi Anton,
>>
>>When I compile ntfs as module for UML I receive during build:
>>*** Warning: "end_iomem" [fs/ntfs/ntfs.ko] undefined!
>>
>>It's ntfs bug or uml bug? Or am I doing something wrong?
> 
> 
> UML is broken.  It defines VMALLOC_START to ((end_iomem +
> VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)) but it clearly does not export
> end_iomem to modules which means modules cannot use VMALLOC_START.
> 
> But ntfs uses VMALLOC_START to determine if a pointer is in kmalloc()-ed
> memory or vmalloc()-ed memory so if you want to build it as a module you
> need to fix uml to export end_iomem, i.e. by for example adding:
> 
> EXPORT_SYMBOL(end_iomem);
> 
> after the end_iomem definition in arch/um/kernel/um_arch.c and the
> reconfiguring, recbuilding the kernel.
> 
> You may wish to report this to LKML / the UML maintainer (after you have
> made sure that this does actually fix it).
> 
> Best regards,
> 
> 	Anton

I didn't find UML maintainer in MAINTAINERS, so I send this to
linux-kernel@vger.kernel.org.

I added line that Anton suggested and it's fixed above bug. Patch below.

Best regards,
	Yura


--- ntfs-2.6-devel/arch/um/kernel/um_arch.c     2004-10-19 20:50:05.000000000 +0300
+++ ntfs-2.6-yura/arch/um/kernel/um_arch.c      2004-10-21 17:14:18.000000000 +0300
@@ -300,6 +300,7 @@ static void __init uml_postsetup(void)
  /* Set during early boot */
  unsigned long brk_start;
  unsigned long end_iomem;
+EXPORT_SYMBOL(end_iomem);

  #define MIN_VMALLOC (32 * 1024 * 1024)


