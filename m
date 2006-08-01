Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWHAWgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWHAWgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWHAWgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:36:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10119 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750706AbWHAWga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:36:30 -0400
Date: Tue, 1 Aug 2006 18:36:22 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
Message-ID: <20060801223622.GG22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060801184451.GP22240@redhat.com> <1154470467.15540.88.camel@localhost.localdomain> <20060801223011.GF22240@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801223011.GF22240@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 06:30:11PM -0400, Dave Jones wrote:
 > On Tue, Aug 01, 2006 at 11:14:27PM +0100, Alan Cox wrote:
 >  > Ar Maw, 2006-08-01 am 14:44 -0400, ysgrifennodd Dave Jones:
 >  > > +		case POISON_FREE ^ 0x01:
 >  > > +		case POISON_FREE ^ 0x02:
 >  > > +		case POISON_FREE ^ 0x04:
 >  > > +		case POISON_FREE ^ 0x08:
 >  > > +		case POISON_FREE ^ 0x10:
 >  > > +		case POISON_FREE ^ 0x20:
 >  > > +		case POISON_FREE ^ 0x40:
 >  > > +		case POISON_FREE ^ 0x80:
 >  > > +			printk (KERN_ERR "Single bit error detected. Possibly bad RAM.\n");
 >  > > +#ifdef CONFIG_X86
 >  > > +			printk (KERN_ERR "Run memtest86 or other memory test tool.\n");
 >  > > +#endif
 >  > > +			return;
 >  > 
 >  > Gack .. NAK
 >  > 
 >  > #1: Do we want memtest86 or memtest86+ ?
 > 
 > I doubt it really matters.
 > 
 >  > #2: The check is horrible and there is an elegant implementation for
 >  > single bit.
 >  > 
 >  > 	errors = value ^ expected;
 >  > 	if (errors && !(errors & (errors - 1)))
 >  > 		printk(KERN_ERR "Single bit error detected....");
 >  
 > Good call, I'll hack that up.

Take #2.

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
@@ -1638,10 +1638,29 @@ static void poison_obj(struct kmem_cache
 static void dump_line(char *data, int offset, int limit)
 {
 	int i;
+	unsigned char total=0, bad_count=0;
 	printk(KERN_ERR "%03x:", offset);
-	for (i = 0; i < limit; i++)
+	for (i = 0; i < limit; i++) {
+		if (data[offset+i] != POISON_FREE) {
+			total += data[offset+i];
+			++bad_count;
+		}
 		printk(" %02x", (unsigned char)data[offset + i]);
+	}
 	printk("\n");
+
+	if (bad_count == 1) {
+		errors = total ^ POISON_FREE;
+		if ((errors && !(errors & (errors-1))) {
+			printk (KERN_ERR "Single bit error detected. Probably bad RAM.\n");
+#ifdef CONFIG_X86
+			printk (KERN_ERR "Run memtest86+ or similar memory test tool.\n");
+#else
+			printk (KERN_ERR "Run a memory test tool.\n");
+#endif
+			return;
+		}
+	}
 }
 #endif
 
-- 
http://www.codemonkey.org.uk
