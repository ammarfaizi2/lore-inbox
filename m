Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281245AbRKLFEB>; Mon, 12 Nov 2001 00:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281253AbRKLFDx>; Mon, 12 Nov 2001 00:03:53 -0500
Received: from rj.sgi.com ([204.94.215.100]:5067 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281245AbRKLFDq>;
	Mon, 12 Nov 2001 00:03:46 -0500
Date: Mon, 12 Nov 2001 16:01:59 +1100
From: Nathan Scott <nathans@sgi.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] extended attributes
Message-ID: <20011112160159.F583135@wobbly.melbourne.sgi.com>
In-Reply-To: <20011107111224.C591676@wobbly.melbourne.sgi.com> <20011107023218.A4754@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107023218.A4754@wotan.suse.de>; from ak@suse.de on Wed, Nov 07, 2001 at 02:32:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 02:32:18AM +0100, Andi Kleen wrote:
> On Wed, Nov 07, 2001 at 11:12:24AM +1100, Nathan Scott wrote:
> > A manual page describing the system call interface can be found here[4].
> > We're very interested in feedback on this.  In particular, Linus - would
> 
> The cursor support looks quite complicated.  ...
> Stateless cursors are just nasty!
> ...

hi folks,

We've removed the cursor operations, and gone back to Andreas'
original, simpler list approach.  Revised versions of the two
extattr man pages are in the XFS CVS repository, or use:
	http://acl.bestbits.at/man/extattr.2.html
	http://acl.bestbits.at/man/extattr.5.html

I notice that 2.4.15-pre3 doesn't have the patch below - Linus,
Alan, could you please apply it? - it will help us a great deal.
This would be useful to the ext2/ext3, InterMezzo/SnapFS, NTFS,
XFS, JFS and BeFS filesystem implementations for Linux, and to
any other filesystems planning to support extended attributes
in the future as well.

many thanks.

-- 
Nathan


diff -Naur 2.4.14-pristine/arch/i386/kernel/entry.S 2.4.14-reserved/arch/i386/kernel/entry.S
--- 2.4.14-pristine/arch/i386/kernel/entry.S	Sat Nov  3 12:18:49 2001
+++ 2.4.14-reserved/arch/i386/kernel/entry.S	Wed Nov  7 10:02:59 2001
@@ -622,6 +622,9 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
 	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_readahead)	/* 225 */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for extattr  */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for lextattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fextattr */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -Naur 2.4.14-pristine/include/asm-i386/unistd.h 2.4.14-reserved/include/asm-i386/unistd.h
--- 2.4.14-pristine/include/asm-i386/unistd.h	Thu Oct 18 03:03:03 2001
+++ 2.4.14-reserved/include/asm-i386/unistd.h	Wed Nov  7 10:02:59 2001
@@ -230,6 +230,9 @@
 #define __NR_security		223	/* syscall for security modules */
 #define __NR_gettid		224
 #define __NR_readahead		225
+#define __NR_extattr		226	/* syscall for extended attributes */
+#define __NR_lextattr		227	/* syscall for extended attributes */
+#define __NR_fextattr		228	/* syscall for extended attributes */
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
