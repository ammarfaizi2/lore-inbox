Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUEJEO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUEJEO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 00:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUEJEO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 00:14:56 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:37569 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264502AbUEJEOx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 00:14:53 -0400
Subject: Re: [PATCH*] show last kernel-image symbol in /proc/kallsyms
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <20040509171452.09ee1ca0.rddunlap@osdl.org>
References: <20040509171452.09ee1ca0.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1084162450.8121.6.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 14:14:10 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-10 at 10:14, Randy.Dunlap wrote:
> 'cat' or 'tail' of /proc/kallsyms (2.6.6-rc2 or -rc3, & probably much
> earlier) does not include the last kernel-image symbol (_einittext).
> 
> _einittext is the last symbol generated in .tmp_kallsyms2.S
> and the symbol count in that file also appears to be correct,
> but the iterator code for /proc/kallsyms comes up 1 short somehow.
> 
> Here are 2 patches.  Either one of them "fixes" the problem.
> Neither of them is the correct fix AFAIK.

Ah, I see you are a student of the Morton school of patch extraction. 
Well, it worked.

Name: Show Last Symbol in /proc/kallsyms
Status: Tested on 2.6.6-rc3.bk11

The current code doesn't show the last symbol (usually _einittext) in
/proc/kallsyms.  The reason for this is subtle: s_start() returns an
empty string for position 0 (ignored by s_show()), and s_next()
returns the first symbol for position 1.

What should happen is that update_iter() for position 0 should fill in
the first symbol.  Unfortunately, the get_ksymbol_core() fills in the
symbol information, *and* updates the iterator: we have to split these
functions, which we do by making it return the length of the name
offset.

Then we can call get_ksymbol_core() without moving the iterator,
meaning that we can call it at position 0 (ie. s_start()).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.6-rc3-bk11/kernel/kallsyms.c working-2.6.6-rc3-bk11/kernel/kallsyms.c
--- linux-2.6.6-rc3-bk11/kernel/kallsyms.c	2004-03-12 07:57:28.000000000 +1100
+++ working-2.6.6-rc3-bk11/kernel/kallsyms.c	2004-05-10 13:11:06.000000000 +1000
@@ -171,21 +171,23 @@ static int get_ksymbol_mod(struct kallsy
 	return 1;
 }
 
-static void get_ksymbol_core(struct kallsym_iter *iter)
+/* Returns space to next name. */
+static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
 {
-	unsigned stemlen;
+	unsigned stemlen, off = iter->nameoff;
 
 	/* First char of each symbol name indicates prefix length
 	   shared with previous name (stem compression). */
-	stemlen = kallsyms_names[iter->nameoff++];
+	stemlen = kallsyms_names[off++];
 
-	strlcpy(iter->name+stemlen, kallsyms_names+iter->nameoff, 128-stemlen);
-	iter->nameoff += strlen(kallsyms_names + iter->nameoff) + 1;
+	strlcpy(iter->name+stemlen, kallsyms_names + off, 128-stemlen);
+	off += strlen(kallsyms_names + off) + 1;
 	iter->owner = NULL;
 	iter->value = kallsyms_addresses[iter->pos];
 	iter->type = 't';
 
 	upcase_if_global(iter);
+	return off - iter->nameoff;
 }
 
 static void reset_iter(struct kallsym_iter *iter)
@@ -210,16 +212,16 @@ static int update_iter(struct kallsym_it
 
 	/* We need to iterate through the previous symbols: can be slow */
 	for (; iter->pos != pos; iter->pos++) {
-		get_ksymbol_core(iter);
+		iter->nameoff += get_ksymbol_core(iter);
 		cond_resched();
 	}
+	get_ksymbol_core(iter);
 	return 1;
 }
 

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

