Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292553AbSBTWve>; Wed, 20 Feb 2002 17:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292559AbSBTWvY>; Wed, 20 Feb 2002 17:51:24 -0500
Received: from jalon.able.es ([212.97.163.2]:40925 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S292553AbSBTWvN>;
	Wed, 20 Feb 2002 17:51:13 -0500
Date: Wed, 20 Feb 2002 23:50:56 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Nicholas Petreley <nicholas@petreley.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch to NVIDIA_kernel & kernel 2.5.5
Message-ID: <20020220235056.A4607@werewolf.able.es>
In-Reply-To: <20020220200135.GA706@petreley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?iso-8859-1?Q?=3C20020220200135=2EGA706?=
	=?iso-8859-1?Q?=40petreley=2Ecom=3E=3B_from_nicholas=40petreley=2Ecom_on_?=
	=?iso-8859-1?Q?mi=E9=2C?= feb 20, 2002 at 21:01:35 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020220 Nicholas Petreley wrote:
>I think you may not have meant to do this part of the patch in nv.c:
>
>+/*         
>             if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
>+*/
>+           if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
>                return -EAGAIN;
>
>
>How about this instead:
>
>+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
>             if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
>                  return -EAGAIN;
>+#else
>+            if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
>+                 return -EAGAIN;
>+#endif
>

and why not:

#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
#define NV_IS_CTRL_DEV(inode) NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev)
#define REMAP_PR(vma, start, page, size, flags) \
		remap_page_range(start, page, size, flags)
#else
#define NV_IS_CTRL_DEV(inode) NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)
#define REMAP_PR(vma, start, page, size, flags) \
		remap_page_range(vma,start, page, size, flags)
#endif

so you just leave the code readable:

-    if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
+    if (NV_IS_CTRL_DEV(inode))

and

-            if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
+            if (REMAP_PR(vma,start, page, PAGE_SIZE, PAGE_SHARED))

instead of polluted by tons of #ifdefs....

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-rc2-jam1 #1 SMP Tue Feb 19 00:35:21 CET 2002 i686
