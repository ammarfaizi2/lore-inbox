Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUDZJvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUDZJvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 05:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbUDZJvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 05:51:12 -0400
Received: from [203.14.152.115] ([203.14.152.115]:57093 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264461AbUDZJvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 05:51:01 -0400
Date: Mon, 26 Apr 2004 19:48:34 +1000
To: Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040426094834.GA4901@gondor.apana.org.au>
References: <E1B6on4-0005EW-00@gondolin.me.apana.org.au> <1080310299.2108.10.camel@atari.stigge.org> <20040326142617.GA291@elf.ucw.cz> <1080315725.2951.10.camel@atari.stigge.org> <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <1080325072.2112.89.camel@atari.stigge.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tags 234976 pending
quit

On Fri, Mar 26, 2004 at 07:17:52PM +0100, Roland Stigge wrote:
> 
> On Fri, 2004-03-26 at 17:17, Pavel Machek wrote:
> > > Please first read the full conversation I had with Herbert at
> > > http://bugs.debian.org/234976 . It contains documented debug sessions of
> > > this kind. Please tell me what to try.
> > 
> > Intel AGP, by chance?
> 
> Yes, but as I wrote, only on one of the machines in question.

OK, I've finally found out why agpgart locks up the machine upon
resuming from swsusp/pmdisk.

The reason is that the gatt table is remapped with ioremap_nocache,
which on i386 machines capable of PSE will result in 4M pages being
split.

When swsusp/pmdisk copies the pages back, the top page table is
written before the entries that it points to are filled in.
Depending on whether the second-level table lies before or after
the 4M-page in question, this will result in a page fault.

A simple solution is to copy the pages in reverse.  This way the
top page table is filled in last which should resolve this particular
issue.  The following patch does exactly that and fixes the problem
for me.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: arch/i386/power/swsusp.S
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/arch/i386/power/swsusp.S,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 swsusp.S
--- a/arch/i386/power/swsusp.S	28 Sep 2003 04:44:10 -0000	1.1.1.1
+++ b/arch/i386/power/swsusp.S	26 Apr 2004 09:31:46 -0000
@@ -33,8 +33,9 @@
 	movl %ecx,%cr3
 
 	call do_magic_resume_1
-	movl $0,loop
-	cmpl $0,nr_copy_pages
+	movl nr_copy_pages,%eax
+	movl %eax,loop
+	cmpl $0,%eax
 	je .L1453
 	.p2align 4,,7
 .L1455:
@@ -45,8 +46,8 @@
 	movl loop,%eax
 	movl loop2,%edx
 	sall $4,%eax
-	movl 4(%ecx,%eax),%ebx
-	movl (%ecx,%eax),%eax
+	movl -12(%ecx,%eax),%ebx
+	movl -16(%ecx,%eax),%eax
 	movb (%edx,%eax),%al
 	movb %al,(%edx,%ebx)
 	movl %cr3, %eax;              
@@ -59,11 +60,11 @@
 	cmpl $4095,%eax
 	jbe .L1459
 	movl loop,%eax
-	leal 1(%eax),%edx
+	leal -1(%eax),%edx
 	movl %edx,loop
 	movl %edx,%eax
-	cmpl nr_copy_pages,%eax
-	jb .L1455
+	cmpl $0,%eax
+	jne .L1455
 	.p2align 4,,7
 .L1453:
 	movl $__USER_DS,%eax

--MGYHOYXEY6WxJCY8--
