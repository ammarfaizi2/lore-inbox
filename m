Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWHAXvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWHAXvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWHAXvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:51:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10920 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750749AbWHAXvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:51:21 -0400
Date: Tue, 1 Aug 2006 19:51:09 -0400
From: Dave Jones <davej@redhat.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
Message-ID: <20060801235109.GB12102@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andreas Schwab <schwab@suse.de>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060801184451.GP22240@redhat.com> <1154470467.15540.88.camel@localhost.localdomain> <20060801223011.GF22240@redhat.com> <20060801223622.GG22240@redhat.com> <20060801230003.GB14863@martell.zuzino.mipt.ru> <20060801231603.GA5738@redhat.com> <jebqr4f32m.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jebqr4f32m.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 01:28:49AM +0200, Andreas Schwab wrote:
 > Dave Jones <davej@redhat.com> writes:
 > 
 > > diff --git a/mm/slab.c b/mm/slab.c
 > > index 21ba060..39f1183 100644
 > > --- a/mm/slab.c
 > > +++ b/mm/slab.c
 > > @@ -1638,10 +1638,29 @@ static void poison_obj(struct kmem_cache
 > >  static void dump_line(char *data, int offset, int limit)
 > >  {
 > >  	int i;
 > > +	unsigned char total = 0, bad_count = 0, errors = 0;
 > 
 > No need to initialize errors here.

I'm going for the record of 'most times a patch gets submitted in one day'.
And to think we were complaining that patches don't get enough review ? :)
If every change had this much polish, we'd be awesome.

		Dave


In case where we detect a single bit has been flipped, we spew
the usual slab corruption message, which users instantly think
is a kernel bug.  In a lot of cases, single bit errors are
down to bad memory, or other hardware failure.

This patch adds an extra line to the slab debug messages
in those cases, in the hope that users will try memtest before
they report a bug.

000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Single bit error detected. Possibly bad RAM. Run memtest86.

Signed-off-by: Dave Jones <davej@redhat.com>

diff --git a/mm/slab.c b/mm/slab.c
index 21ba060..39f1183 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1638,10 +1638,28 @@ static void poison_obj(struct kmem_cache
 static void dump_line(char *data, int offset, int limit)
 {
 	int i;
+	unsigned char total = 0, bad_count = 0, errors;
 	printk(KERN_ERR "%03x:", offset);
-	for (i = 0; i < limit; i++)
+	for (i = 0; i < limit; i++) {
+		if (data[offset + i] != POISON_FREE) {
+			total += data[offset + i];
+			bad_count++;
+		}
 		printk(" %02x", (unsigned char)data[offset + i]);
+	}
 	printk("\n");
+
+	if (bad_count == 1) {
+		errors = total ^ POISON_FREE;
+		if (errors && !(errors & (errors-1))) {
+			printk (KERN_ERR "Single bit error detected. Probably bad RAM.\n");
+#ifdef CONFIG_X86
+			printk (KERN_ERR "Run memtest86+ or a similar memory test tool.\n");
+#else
+			printk (KERN_ERR "Run a memory test tool.\n");
+#endif
+		}
+	}
 }
 #endif
 

-- 
http://www.codemonkey.org.uk
