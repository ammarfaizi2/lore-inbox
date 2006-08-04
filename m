Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161469AbWHDVUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161469AbWHDVUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbWHDVUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:20:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22995 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161469AbWHDVUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:20:13 -0400
Date: Fri, 4 Aug 2006 14:19:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Andreas Schwab <schwab@suse.de>, Alexey Dobriyan <adobriyan@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
Message-Id: <20060804141955.3139b20b.akpm@osdl.org>
In-Reply-To: <20060802001626.GA14689@redhat.com>
References: <20060801184451.GP22240@redhat.com>
	<1154470467.15540.88.camel@localhost.localdomain>
	<20060801223011.GF22240@redhat.com>
	<20060801223622.GG22240@redhat.com>
	<20060801230003.GB14863@martell.zuzino.mipt.ru>
	<20060801231603.GA5738@redhat.com>
	<jebqr4f32m.fsf@sykes.suse.de>
	<20060801235109.GB12102@redhat.com>
	<20060802001626.GA14689@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 20:16:26 -0400
Dave Jones <davej@redhat.com> wrote:

> In case where we detect a single bit has been flipped, we spew
> the usual slab corruption message, which users instantly think
> is a kernel bug.  In a lot of cases, single bit errors are
> down to bad memory, or other hardware failure.
> 
> This patch adds an extra line to the slab debug messages
> in those cases, in the hope that users will try memtest before
> they report a bug.

Well boy, this has to be the most-reviewed patch ever.  You'd think that
I'd apply it with great confidence and warm fuzzies.

However...


From: Andrew Morton <akpm@osdl.org>

- one decl per line is more patching-friendly and a bit more idiomatic.

- make `bad_count' an int: a uchar might overflow

- Put a blank line between decls and code

- rename `total' to `error', remove `errors'.

- there's no need to sum up the errors.

- don't need to check for non-zero `errors': we know it is != POISON_FREE.

- make it look non-crapful in an 80-col window.

- add missing spaces in arithmetic

Cc: Dave Jones <davej@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---


diff -puN mm/slab.c~single-bit-flip-detector-tidy mm/slab.c
--- a/mm/slab.c~single-bit-flip-detector-tidy
+++ a/mm/slab.c
@@ -1637,11 +1637,13 @@ static void poison_obj(struct kmem_cache
 static void dump_line(char *data, int offset, int limit)
 {
 	int i;
-	unsigned char total = 0, bad_count = 0, errors;
+	unsigned char error = 0;
+	int bad_count = 0;
+
 	printk(KERN_ERR "%03x:", offset);
 	for (i = 0; i < limit; i++) {
 		if (data[offset + i] != POISON_FREE) {
-			total += data[offset + i];
+			error = data[offset + i];
 			bad_count++;
 		}
 		printk(" %02x", (unsigned char)data[offset + i]);
@@ -1649,11 +1651,13 @@ static void dump_line(char *data, int of
 	printk("\n");
 
 	if (bad_count == 1) {
-		errors = total ^ POISON_FREE;
-		if (errors && !(errors & (errors-1))) {
-			printk(KERN_ERR "Single bit error detected. Probably bad RAM.\n");
+		error ^= POISON_FREE;
+		if (!(error & (error - 1))) {
+			printk(KERN_ERR "Single bit error detected. Probably "
+					"bad RAM.\n");
 #ifdef CONFIG_X86
-			printk(KERN_ERR "Run memtest86+ or a similar memory test tool.\n");
+			printk(KERN_ERR "Run memtest86+ or a similar memory "
+					"test tool.\n");
 #else
 			printk(KERN_ERR "Run a memory test tool.\n");
 #endif
_

