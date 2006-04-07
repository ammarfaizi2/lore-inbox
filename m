Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWDGFSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWDGFSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWDGFSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:18:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60300
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932255AbWDGFSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:18:13 -0400
Date: Thu, 06 Apr 2006 22:18:07 -0700 (PDT)
Message-Id: <20060406.221807.114721185.davem@davemloft.net>
To: dan@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/binfmt_elf.c:maydump()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060406.153518.60508780.davem@davemloft.net>
References: <20060406.140357.14088592.davem@davemloft.net>
	<20060406221519.GA5453@nevyn.them.org>
	<20060406.153518.60508780.davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 06 Apr 2006 15:35:18 -0700 (PDT)

> With this patch applied, yes, it includes the complete text segments of
> every executable and shared library mapped into the program which is
> dumping core.

I did some more research and the 2.4.x kernel currently does
the test like this:

static inline int maydump(struct vm_area_struct *vma)
{
	/*
	 * If we may not read the contents, don't allow us to dump
	 * them either. "dump_write()" can't handle it anyway.
	 */
	if (!(vma->vm_flags & VM_READ))
		return 0;

	/* Do not dump I/O mapped devices! -DaveM */
	if (vma->vm_flags & VM_IO)
		return 0;
#if 1
	if (vma->vm_flags & (VM_WRITE|VM_GROWSUP|VM_GROWSDOWN))
		return 1;
	if (vma->vm_flags & (VM_READ|VM_EXEC|VM_EXECUTABLE|VM_SHARED))
		return 0;
#endif
	return 1;
}

Ok, if it's not readable don't put it into the core file, fine.
If it's an I/O mapping, skip it too, also makes sense.

The next check forces dumping of any wriable or stack segments.

The function always terminates at the next check, because VM_READ
is guarenteed to be set if we get here.  The first thing we
checked is if VM_READ was clear at the very top of the function.

Yikes...

Anyways, so what's exactly happening in 2.6.x right now?

static int maydump(struct vm_area_struct *vma)
{
	/* Do not dump I/O mapped devices or special mappings */
	if (vma->vm_flags & (VM_IO | VM_RESERVED))
		return 0;

	/* Dump shared memory only if mapped from an anonymous file.  */
	if (vma->vm_flags & VM_SHARED)
		return vma->vm_file->f_dentry->d_inode->i_nlink == 0;

	/* If it hasn't been written to, don't write it out */
	if (!vma->anon_vma)
		return 0;

	return 1;
}

Skip reserved or I/O mappings, ok.

Else skip shared mappings of non-anonymous files.  I'm not so sure
about this check.

Else skip any mapping not written to yet.  I still think at this
point the logic is wrong.

How about something like the following patch?  If it's executable
and not written to, skip it.  This would skip the main executable
image and all text segments of the shared libraries mapped in.

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 537893a..9ec5c2b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1167,8 +1167,10 @@ static int maydump(struct vm_area_struct
 	if (vma->vm_flags & VM_SHARED)
 		return vma->vm_file->f_dentry->d_inode->i_nlink == 0;
 
-	/* If it hasn't been written to, don't write it out */
-	if (!vma->anon_vma)
+	/* If it is executable and hasn't been written to,
+	 * don't write it out.
+	 */
+	if ((vma->vm_flags & VM_EXEC) && !vma->anon_vma)
 		return 0;
 
 	return 1;

