Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbUKNC7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUKNC7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 21:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUKNC7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 21:59:53 -0500
Received: from lists.us.dell.com ([143.166.224.162]:37849 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261238AbUKNC7u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 21:59:50 -0500
Date: Sat, 13 Nov 2004 20:58:14 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Christian Kujau <evil@g-house.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
Message-ID: <20041114025814.GA20342@lists.us.dell.com>
References: <200411122248_MC3-1-8E97-BFE5@compuserve.com> <20041113142835.GA9109@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113142835.GA9109@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 08:28:35AM -0600, Matt Domsch wrote:
> It still doesn't explain why Christian's BIOS reports more devices
> than he has, that's still UI, so don't re-apply the edd.S patch just reverted.

Alexander van Heukelum noted to me that addw here modifies CF, so I
think something like should fix that.  Christian, if you're in a
position to test this, I'd really appreciate it.  You've been a
fantastic bug reporter / tester!

Not ready for Linus yet, and you'll need to re-apply the previous
edd.S patch which is now reverted in Linus's tree.  As your BIOS
reports via CHECK EXTENSIONS PRESENT that you've got more devices than
you actually have, hopefully the int13 EXTENDED READ won't succeed for
non-existant devices anymore, and then neither will the READ SECTORS
call.

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== arch/i386/boot/edd.S 1.3 vs edited =====
--- 1.3/arch/i386/boot/edd.S	2004-10-20 03:37:11 -05:00
+++ edited/arch/i386/boot/edd.S	2004-11-13 20:31:58 -06:00
@@ -58,8 +58,12 @@
 	sti					# work around buggy BIOSes
 	popw	%dx
 	popw	%si
-	addw	$EDD_DEV_ADDR_PACKET_LEN, %sp	# remove packet from stack
-	jnc   edd_mbr_store_sig
+	pushfl					# save EFLAGS into ebx	
+	popl	%ebx				# because addw modifies CF
+    	addw	$EDD_DEV_ADDR_PACKET_LEN, %sp	# remove packet from stack
+	pushl	%ebx				# get back right CF
+	popfl
+    	jnc	edd_mbr_store_sig
 	# otherwise, fall through to the legacy read function
 
 edd_mbr_read_sectors:
