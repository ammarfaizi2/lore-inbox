Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWDXVud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWDXVud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWDXVud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:50:33 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:65376 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751330AbWDXVuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:50:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gij+dMvKfYDqYzqizvvgFSO+tJrrOe1yYNY8iW30QEAwfVdLLeH4EFHymoXn8Tptlom7Z5za8V8+jGkycidIIuai7nGHCS2N2AdKjknyGZNCSjQ7biLSEALIc08tMjk9v8HGMgjz120HaPF/HhNYg5a00r/XK0xKcuC2xtge8OU=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] binfmt_elf CodingStyle cleanup and remove some pointless casts
Date: Mon, 24 Apr 2006 23:51:14 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
References: <200604231858.15646.jesper.juhl@gmail.com> <200604241932.49912.jesper.juhl@gmail.com> <20060424133234.34a29533.akpm@osdl.org>
In-Reply-To: <20060424133234.34a29533.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604242351.14610.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 April 2006 22:32, Andrew Morton wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > We still need to cast u_platform from pointer to integer or gcc will yell 
> >  at us. But, I don't see why we should first cast it to `unsigned long' and 
> >  then to elf_addr_t, so I removed the `unsigned long' cast.
> 
> On 64 bit platforms, these:
> 
> 	some_pointer = (something *)some_u32;
> 	some_u32 = (u32)pointer;
> 
> will generate compile warnings concerning the differently-sized quantities
> on the lhs and rhs.
> 
> The usual way of suppressing this is
> 
> 	some_pointer = (something *)(unsigned long)some_u32;
> 	some_u32 = (unsigned long)pointer;
> 

I see. Thank you for the info, I had not considered that, but it makes sense.
The patch should look like below, then.


Remove redundant casts from NEW_AUX_ENT() arguments in fs/binfmt_elf.c

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/binfmt_elf.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

--- linux-2.6.17-rc2-git4/fs/binfmt_elf.c.old	2006-04-24 19:21:14.000000000 +0200
+++ linux-2.6.17-rc2-git4/fs/binfmt_elf.c	2006-04-24 23:47:23.000000000 +0200
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
@@ -199,17 +200,17 @@ create_elf_tables(struct linux_binprm *b
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
 		NEW_AUX_ENT(AT_PLATFORM,
-			(elf_addr_t)(unsigned long)u_platform);
+			    (elf_addr_t)(unsigned long)u_platform);
 	}
 	if (bprm->interp_flags & BINPRM_FLAGS_EXECFD) {
-		NEW_AUX_ENT(AT_EXECFD, (elf_addr_t)bprm->interp_data);
+		NEW_AUX_ENT(AT_EXECFD, bprm->interp_data);
 	}
 #undef NEW_AUX_ENT
 	/* AT_NULL is zero; clear the rest too */



