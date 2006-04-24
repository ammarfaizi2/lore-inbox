Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWDXRcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWDXRcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWDXRcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:32:09 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:34784 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751033AbWDXRcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:32:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tv0pyBGFSjaELXglBInv6YcTLRPdJ9AuLR6rwHcO7aPf0HVqZ34JAkphhVmxhQo3LLcbcRPzz/W9UbTXJDxAfHePrtzpUvaVDAVBSBUEanaQ9qJ524Qyas1n/idX+EYD5mi8lsRiP0/qsFaCbOuSkYCv4ZLkxAoC6lWHCm+4lcM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] binfmt_elf CodingStyle cleanup and remove some pointless casts
Date: Mon, 24 Apr 2006 19:32:49 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, ericy@cais.com
References: <200604231858.15646.jesper.juhl@gmail.com> <20060423142648.6ef34b9f.akpm@osdl.org> <9a8748490604240015s61b8b897r34a8be65dc9bac22@mail.gmail.com>
In-Reply-To: <9a8748490604240015s61b8b897r34a8be65dc9bac22@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604241932.49912.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 April 2006 09:15, Jesper Juhl wrote:
> On 4/23/06, Andrew Morton <akpm@osdl.org> wrote:
> > The typecasting for NEW_AUX_ENT is random, ugly, irrational and
> > undesirable.  It's always u32 or unsigned long.  Perhaps as a followup
> > patch you could look at removing the unneeded casts? (hopefully that'll
> > be all of them)
> >
> Sure, I'll take a look at that this evening, hopefully that'll mean a
> follow-up patch in aproximately 12-16hrs.
> 
I got rid of all but one cast. 

We still need to cast u_platform from pointer to integer or gcc will yell 
at us. But, I don't see why we should first cast it to `unsigned long' and 
then to elf_addr_t, so I removed the `unsigned long' cast.

Patch applies on top of the previous one.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/binfmt_elf.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.17-rc2-git4/fs/binfmt_elf.c.old	2006-04-24 19:21:14.000000000 +0200
+++ linux-2.6.17-rc2-git4/fs/binfmt_elf.c	2006-04-24 19:20:49.000000000 +0200
@@ -177,10 +177,11 @@ create_elf_tables(struct linux_binprm *b
 	}
 
 	/* Create the ELF interpreter info */
-	elf_info = (elf_addr_t *) current->mm->saved_auxv;
+	elf_info = (elf_addr_t *)current->mm->saved_auxv;
 #define NEW_AUX_ENT(id, val) \
 	do { \
-		elf_info[ei_index++] = id; elf_info[ei_index++] = val; \
+		elf_info[ei_index++] = id; \
+		elf_info[ei_index++] = val; \
 	} while (0)
 
 #ifdef ARCH_DLINFO
@@ -199,17 +200,16 @@ create_elf_tables(struct linux_binprm *b
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
 	NEW_AUX_ENT(AT_FLAGS, 0);
 	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
-	NEW_AUX_ENT(AT_UID, (elf_addr_t)tsk->uid);
-	NEW_AUX_ENT(AT_EUID, (elf_addr_t)tsk->euid);
-	NEW_AUX_ENT(AT_GID, (elf_addr_t)tsk->gid);
-	NEW_AUX_ENT(AT_EGID, (elf_addr_t)tsk->egid);
- 	NEW_AUX_ENT(AT_SECURE, (elf_addr_t)security_bprm_secureexec(bprm));
+	NEW_AUX_ENT(AT_UID, tsk->uid);
+	NEW_AUX_ENT(AT_EUID, tsk->euid);
+	NEW_AUX_ENT(AT_GID, tsk->gid);
+	NEW_AUX_ENT(AT_EGID, tsk->egid);
+ 	NEW_AUX_ENT(AT_SECURE, security_bprm_secureexec(bprm));
 	if (k_platform) {
-		NEW_AUX_ENT(AT_PLATFORM,
-			(elf_addr_t)(unsigned long)u_platform);
+		NEW_AUX_ENT(AT_PLATFORM, (elf_addr_t)u_platform);
 	}
 	if (bprm->interp_flags & BINPRM_FLAGS_EXECFD) {
-		NEW_AUX_ENT(AT_EXECFD, (elf_addr_t)bprm->interp_data);
+		NEW_AUX_ENT(AT_EXECFD, bprm->interp_data);
 	}
 #undef NEW_AUX_ENT
 	/* AT_NULL is zero; clear the rest too */


