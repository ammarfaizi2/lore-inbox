Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUAEQqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 11:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUAEQqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 11:46:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:38322 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263173AbUAEQqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 11:46:19 -0500
Date: Mon, 5 Jan 2004 08:46:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: 2.6.1-rc1 affected?
In-Reply-To: <1073320318.21198.2.camel@midux>
Message-ID: <Pine.LNX.4.58.0401050840290.21265@home.osdl.org>
References: <1073320318.21198.2.camel@midux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, Markus Hästbacka wrote:
> 
> I heard the news about the new exploit, and I'm wondering if 2.6.0 or
> 2.6.1-rc1 is affected with this mremap bug?

Yup.

I'd actually personally prefer a stronger test than the one in 2.4.24, and 
my personal preference would be for just disallowing the degenerate cases
entirely.  I don't see a "mremap away" as being a valid thing to do, since 
if that is what you want, why not just do a "munmap()"?

Uli cc'd, to check whether libc could ever use a zero-sized mremap()..

		Linus

----
===== mm/mremap.c 1.33 vs edited =====
--- 1.33/mm/mremap.c	Sat Aug 23 23:50:10 2003
+++ edited/mm/mremap.c	Mon Jan  5 08:34:21 2004
@@ -315,6 +315,10 @@
 	old_len = PAGE_ALIGN(old_len);
 	new_len = PAGE_ALIGN(new_len);
 
+	/* Don't allow the degenerate cases */
+	if (!(old_len | new_len))
+		goto out;
+
 	/* new_addr is only valid if MREMAP_FIXED is specified */
 	if (flags & MREMAP_FIXED) {
 		if (new_addr & ~PAGE_MASK)
