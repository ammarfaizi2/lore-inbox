Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVEKSMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVEKSMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVEKSMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:12:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:47324 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261226AbVEKSMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:12:07 -0400
Date: Wed, 11 May 2005 11:12:11 -0700
From: Greg KH <gregkh@suse.de>
To: security@isec.pl, linux-kernel@vger.kernel.org
Cc: full-disclosure@lists.netsys.com, bugtraq@securityfocus.com,
       vulnwatch@vulnwatch.org
Subject: Re: Linux kernel ELF core dump privilege elevation
Message-ID: <20050511181211.GA16652@kroah.com>
References: <Pine.LNX.4.44.0505101615410.1618-100000@isec.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0505101615410.1618-100000@isec.pl>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 01:08:56PM +0200, Paul Starzetz wrote:
> Hi,
> 
> since it became clear from the discussion in January about the uselib() 
> vulnerability, that the Linux community prefers full, non-embargoed 
> disclosure of kernel bugs, I release full details right now. However to 
> follows at least some of the responsable disclosure rules, no exploit code will be 
> released. Instead, only a proof-of-concept code is released to demonstrate 
> the vulnerability.

<snip>

And here's a patch for 2.6 that is completly untested.  I'll work on
testing it today and if it works, we will release a new 2.6.11.y release
with this fix in it.

thanks,

greg k-h


Subject: possibly fix Linux kernel ELF core dump privilege elevation

As noted by Paul Starzetz

references CAN-something-I-need-to-go-look-up...

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/binfmt_elf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/fs/binfmt_elf.c	2005-05-11 00:03:45.000000000 -0700
+++ gregkh-2.6/fs/binfmt_elf.c	2005-05-11 00:09:17.000000000 -0700
@@ -251,7 +251,7 @@
 	}
 
 	/* Populate argv and envp */
-	p = current->mm->arg_start;
+	p = current->mm->arg_end = current->mm->arg_start;
 	while (argc-- > 0) {
 		size_t len;
 		__put_user((elf_addr_t)p, argv++);
@@ -1301,7 +1301,7 @@
 static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 		       struct mm_struct *mm)
 {
-	int i, len;
+	unsigned int i, len;
 	
 	/* first copy the parameters from user space */
 	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
