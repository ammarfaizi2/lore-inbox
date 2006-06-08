Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWFHJNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWFHJNr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 05:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWFHJNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 05:13:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:14285 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751308AbWFHJNq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 05:13:46 -0400
Message-ID: <4487EA41.3030400@fr.ibm.com>
Date: Thu, 08 Jun 2006 11:13:37 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: schwidefsky@de.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       arjan@infradead.org
Subject: Re: 2.6.17-rc5-mm2 link issues on s390
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EE5A4.7050201@fr.ibm.com> <1149168482.5279.34.camel@localhost> <447EF175.4040608@fr.ibm.com> <20060608072802.GB9416@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060608072802.GB9416@osiris.boeblingen.de.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------090604090005060404010608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604090005060404010608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Heiko Carstens wrote:

> This looks wrong: "b" is a u64 and you write it to something that is an
> unsigned long. We're going to miss a few bits on 31 bit platforms...

Indeed. Here's another version protecting the quad macros with __s390x__.
to be applied on rc6-mm1.

For the moment, __raw_writeq() is needed by __iowrite64_copy() which is
protected by CONFIG_64BIT. Some drivers also use it.

Thanks for reviewing,

C.

--------------090604090005060404010608
Content-Type: text/x-patch;
 name="s390-add-raw_writeq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="s390-add-raw_writeq.patch"

From: Cedric Le Goater <clg@fr.ibm.com>
Replace-Subject: s390 adds __raw_writeq required by __iowrite64_copy.

It also adds all the related quad routines. 

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

---
 include/asm-s390/io.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: 2.6.17-rc6-mm1/include/asm-s390/io.h
===================================================================
--- 2.6.17-rc6-mm1.orig/include/asm-s390/io.h
+++ 2.6.17-rc6-mm1/include/asm-s390/io.h
@@ -86,20 +86,35 @@ extern void iounmap(void *addr);
 #define readb(addr) (*(volatile unsigned char *) __io_virt(addr))
 #define readw(addr) (*(volatile unsigned short *) __io_virt(addr))
 #define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
+#ifdef __s390x__
+#define readq(addr) (*(volatile unsigned long *) __io_virt(addr))
+#endif
 
 #define readb_relaxed(addr) readb(addr)
 #define readw_relaxed(addr) readw(addr)
 #define readl_relaxed(addr) readl(addr)
+#ifdef __s390x__
+#define readq_relaxed(addr) readq(addr)
+#endif
 #define __raw_readb readb
 #define __raw_readw readw
 #define __raw_readl readl
+#ifdef __s390x__
+#define __raw_readq readq
+#endif
 
 #define writeb(b,addr) (*(volatile unsigned char *) __io_virt(addr) = (b))
 #define writew(b,addr) (*(volatile unsigned short *) __io_virt(addr) = (b))
 #define writel(b,addr) (*(volatile unsigned int *) __io_virt(addr) = (b))
+#ifdef __s390x__
+#define writeq(b,addr) (*(volatile unsigned long *) __io_virt(addr) = (b))
+#endif
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel
+#ifdef __s390x__
+#define __raw_writeq writeq
+#endif
 
 #define memset_io(a,b,c)        memset(__io_virt(a),(b),(c))
 #define memcpy_fromio(a,b,c)    memcpy((a),__io_virt(b),(c))

--------------090604090005060404010608--
