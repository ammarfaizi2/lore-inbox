Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVFCHqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVFCHqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 03:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVFCHqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 03:46:00 -0400
Received: from mail.renesas.com ([202.234.163.13]:51878 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261170AbVFCHpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 03:45:46 -0400
Date: Fri, 03 Jun 2005 16:45:40 +0900 (JST)
Message-Id: <20050603.164540.1016292819.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sakugawa@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc5-mm2] m32r: Update m32r_sio.c to use cpu_relax()
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050531140151.791007b3.akpm@osdl.org>
References: <20050531.214805.783383719.takata.hirokazu@renesas.com>
	<20050531140151.791007b3.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed m32r_sio.c to use cpu_relax().

Thanks.

From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.12-rc5] m32r: Support M3A-2170(Mappi-III) platform
Date: Tue, 31 May 2005 14:01:51 -0700
> Hirokazu Takata <takata@linux-m32r.org> wrote:
> >
> > This patchset is for supporting a new m32r platform,
> > M3A-2170(Mappi-III) evaluation board.
> > An M32R chip multiprocessor is equipped on the board.
> > http://http://www.linux-m32r.org/eng/platform/platform.html
> > 
> > ...
> >  static void putc(char c)
> >  {
> > -
> >  	while ((*BOOT_SIO0STS & 0x3) != 0x3) ;
> 
> cpu_relax()?
> 
> >  static void putc(char c)
> >  {
> > -
> >  	while ((*SIO0STS & 0x1) == 0) ;
> 
> cpu_relax()?
> 

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/boot/compressed/m32r_sio.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)


diff -ruNp a/arch/m32r/boot/compressed/m32r_sio.c b/arch/m32r/boot/compressed/m32r_sio.c
--- a/arch/m32r/boot/compressed/m32r_sio.c	2005-06-02 12:09:19.000000000 +0900
+++ b/arch/m32r/boot/compressed/m32r_sio.c	2005-06-02 18:16:54.000000000 +0900
@@ -6,6 +6,7 @@
  */
 
 #include <linux/config.h>
+#include <asm/processor.h>
 
 static void putc(char c);
 
@@ -38,10 +39,12 @@ static int puts(const char *s)
 
 static void putc(char c)
 {
-	while ((*BOOT_SIO0STS & 0x3) != 0x3) ;
+	while ((*BOOT_SIO0STS & 0x3) != 0x3)
+		cpu_relax();
 	if (c == '\n') {
 		*BOOT_SIO0TXB = '\r';
-		while ((*BOOT_SIO0STS & 0x3) != 0x3) ;
+		while ((*BOOT_SIO0STS & 0x3) != 0x3)
+			cpu_relax();
 	}
 	*BOOT_SIO0TXB = c;
 }
@@ -56,10 +59,12 @@ static void putc(char c)
 
 static void putc(char c)
 {
-	while ((*SIO0STS & 0x1) == 0) ;
+	while ((*SIO0STS & 0x1) == 0)
+		cpu_relax();
 	if (c == '\n') {
 		*SIO0TXB = '\r';
-		while ((*SIO0STS & 0x1) == 0) ;
+		while ((*SIO0STS & 0x1) == 0)
+			cpu_relax();
 	}
 	*SIO0TXB = c;
 }

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
