Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVDFWHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVDFWHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 18:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVDFWHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 18:07:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:62130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262330AbVDFWHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 18:07:03 -0400
Date: Wed, 6 Apr 2005 15:07:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.12-rc2-mm1
Message-Id: <20050406150703.409dba1c.akpm@osdl.org>
In-Reply-To: <d2to03$t0t$1@sea.gmane.org>
References: <20050405000524.592fc125.akpm@osdl.org>
	<d2to03$t0t$1@sea.gmane.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> wrote:
>
> oes not compile on AthlonXP. For mmx_clear_page, only the prototype was
> changed, but the implementation is still the same. I guess that part of
> the patch slipped out somehow.
> 
> -extern void mmx_clear_page(void *page);
> 
> +extern void mmx_clear_page(void *page, int order);

I guess this will fix it...


diff -puN arch/i386/lib/mmx.c~add-a-clear_pages-function-to-clear-pages-of-higher-fix arch/i386/lib/mmx.c
--- 25/arch/i386/lib/mmx.c~add-a-clear_pages-function-to-clear-pages-of-higher-fix	Wed Apr  6 15:00:54 2005
+++ 25-akpm/arch/i386/lib/mmx.c	Wed Apr  6 15:06:09 2005
@@ -128,9 +128,10 @@ void *_mmx_memcpy(void *to, const void *
  *	other MMX using processors do not.
  */
 
-static void fast_clear_page(void *page)
+static void fast_clear_page(void *page, int order)
 {
 	int i;
+	int chunks = (4096 << order) / 64;
 
 	kernel_fpu_begin();
 	
@@ -138,8 +139,7 @@ static void fast_clear_page(void *page)
 		"  pxor %%mm0, %%mm0\n" : :
 	);
 
-	for(i=0;i<4096/64;i++)
-	{
+	for (i = 0; i < chunks; i++) {
 		__asm__ __volatile__ (
 		"  movntq %%mm0, (%0)\n"
 		"  movntq %%mm0, 8(%0)\n"
@@ -257,18 +257,18 @@ static void fast_copy_page(void *to, voi
  *	Generic MMX implementation without K7 specific streaming
  */
  
-static void fast_clear_page(void *page)
+static void fast_clear_page(void *page, int order)
 {
 	int i;
-	
+	int chunks = (4096 << order) / 128;
+
 	kernel_fpu_begin();
 	
 	__asm__ __volatile__ (
 		"  pxor %%mm0, %%mm0\n" : :
 	);
 
-	for(i=0;i<4096/128;i++)
-	{
+	for (i = 0; i < chunks; i++) {
 		__asm__ __volatile__ (
 		"  movq %%mm0, (%0)\n"
 		"  movq %%mm0, 8(%0)\n"
@@ -359,23 +359,23 @@ static void fast_copy_page(void *to, voi
  *	Favour MMX for page clear and copy. 
  */
 
-static void slow_zero_page(void * page)
+static void slow_zero_page(void *page, int order)
 {
 	int d0, d1;
 	__asm__ __volatile__( \
 		"cld\n\t" \
 		"rep ; stosl" \
 		: "=&c" (d0), "=&D" (d1)
-		:"a" (0),"1" (page),"0" (1024)
+		:"a" (0),"1" (page),"0" (1024 << order)
 		:"memory");
 }
  
-void mmx_clear_page(void * page)
+void mmx_clear_page(void *page, int order)
 {
 	if(unlikely(in_interrupt()))
-		slow_zero_page(page);
+		slow_zero_page(page, order);
 	else
-		fast_clear_page(page);
+		fast_clear_page(page, order);
 }
 
 static void slow_copy_page(void *to, void *from)
_

