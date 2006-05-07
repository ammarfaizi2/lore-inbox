Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWEGRWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWEGRWW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 13:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWEGRWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 13:22:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:25524 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932200AbWEGRWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 13:22:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EZhYRtTq/RQQqiRgY5XinbgpdJGkzfaknkpagpIhrm+7qD6GgvB2wYjML8dgP4yHfAv4DpaIcBXnvR/7LFx7f80lIDlrsZ/CllaNKodAec3nqcyW8xJin95FtgLPhKqaeo4Mri5i1s7d09xk8iN/p0ENvBsPDJ1TmbkoCjTrhXM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ensure NULL deref can't possibly happen in is_exported()
Date: Sun, 7 May 2006 19:23:12 +0200
User-Agent: KMail/1.9.1
Cc: Richard Henderson <rth@twiddle.net>, Richard Henderson <rth@cygnus.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071923.12817.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If CONFIG_KALLSYMS is defined and if it should happen that is_exported() 
is given a NULL 'mod' and 
lookup_symbol(name, __start___ksymtab, __stop___ksymtab) returns 0, then 
we'll end up dereferencing a NULL pointer.

Patch below makes sure that'll never happen.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 kernel/module.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc3-git12-orig/kernel/module.c	2006-05-07 03:25:38.000000000 +0200
+++ linux-2.6.17-rc3-git12/kernel/module.c	2006-05-07 19:16:38.000000000 +0200
@@ -1326,7 +1326,7 @@ int is_exported(const char *name, const 
 	if (!mod && lookup_symbol(name, __start___ksymtab, __stop___ksymtab))
 		return 1;
 	else
-		if (lookup_symbol(name, mod->syms, mod->syms + mod->num_syms))
+		if (mod && lookup_symbol(name, mod->syms, mod->syms + mod->num_syms))
 			return 1;
 		else
 			return 0;


