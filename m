Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVAQDwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVAQDwp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVAQDwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:52:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:43711 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262684AbVAQDsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:48:54 -0500
Date: Sun, 16 Jan 2005 19:48:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] i386/x86_64 fpu: fix x87 tag word simulation using fxsave
In-Reply-To: <200501170136.j0H1at6x026128@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0501161929400.8178@ppc970.osdl.org>
References: <200501170136.j0H1at6x026128@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Jan 2005, Roland McGrath wrote:
>
> Note, this code is identical in 2.4 so this fix applies there as well.

Uhh.. "(i + 8 - tos) & 7" makes no sense.

It's not only mathematically the same as "(i - tos) & 7", but I don't even 
see how you got to the "+ 8" in the first place..

Also, we're not using C++, so we don't do the "const" part of

	const unsigned int tos = ...

thing. So suggested version with trivial fixes appended (technically, you
don't need the "& 7" on the tos calculation either, but hey, at least that
one I see why it's there, and agree with - the compiler may well be able
to optimize both of these things away, so keeping the source in its
"logical" format makes sense). Does this still work for you?

> Fortunately, only the manuals differ and all the chips actually agree.

Hmm. 

What happens if it was in MMX mode? If I remember correctly, different 
CPU's do different things for MMX (some rotate them so that "mmx0" is 
always the same as "st(0)", some don't, and/or have separate hw registers 
altogether for it)? I realize we don't probably care, I'm just wondering 
if somebody knows...

			Linus

----
===== arch/i386/kernel/i387.c 1.22 vs edited =====
--- 1.22/arch/i386/kernel/i387.c	2004-10-28 00:39:55 -07:00
+++ edited/arch/i386/kernel/i387.c	2005-01-16 19:38:28 -08:00
@@ -111,16 +111,17 @@
 static inline unsigned long twd_fxsr_to_i387( struct i387_fxsave_struct *fxsave )
 {
 	struct _fpxreg *st = NULL;
+	unsigned int tos = (fxsave->swd >> 11) & 7;
 	unsigned long twd = (unsigned long) fxsave->twd;
 	unsigned long tag;
 	unsigned long ret = 0xffff0000u;
 	int i;
 
-#define FPREG_ADDR(f, n)	((char *)&(f)->st_space + (n) * 16);
+#define FPREG_ADDR(f, n)	((void *)&(f)->st_space + (n) * 16);
 
 	for ( i = 0 ; i < 8 ; i++ ) {
 		if ( twd & 0x1 ) {
-			st = (struct _fpxreg *) FPREG_ADDR( fxsave, i );
+			st = FPREG_ADDR( fxsave, (i - tos) & 7 );
 
 			switch ( st->exponent & 0x7fff ) {
 			case 0x7fff:
===== arch/x86_64/ia32/fpu32.c 1.8 vs edited =====
--- 1.8/arch/x86_64/ia32/fpu32.c	2004-05-30 12:49:35 -07:00
+++ edited/arch/x86_64/ia32/fpu32.c	2005-01-16 19:39:20 -08:00
@@ -28,16 +28,17 @@
 static inline unsigned long twd_fxsr_to_i387(struct i387_fxsave_struct *fxsave)
 {
 	struct _fpxreg *st = NULL;
+	unsigned long tos = (fxsave->swd >> 11) & 7;
 	unsigned long twd = (unsigned long) fxsave->twd;
 	unsigned long tag;
 	unsigned long ret = 0xffff0000;
 	int i;
 
-#define FPREG_ADDR(f, n)	((char *)&(f)->st_space + (n) * 16);
+#define FPREG_ADDR(f, n)	((void *)&(f)->st_space + (n) * 16);
 
 	for (i = 0 ; i < 8 ; i++) {
 		if (twd & 0x1) {
-			st = (struct _fpxreg *) FPREG_ADDR( fxsave, i );
+			st = FPREG_ADDR( fxsave, (i - tos) & 7 );
 
 			switch (st->exponent & 0x7fff) {
 			case 0x7fff:
