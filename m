Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTIXAw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTIXAw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:52:29 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:60109 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261152AbTIXAwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:52:25 -0400
Date: Tue, 23 Sep 2003 18:02:58 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Deepak Saxena <dsaxena@mvista.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com.br
Subject: Re: [PATCH] Fix %x parsing in vsscanf()
Message-ID: <20030924010258.GA24014@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
References: <20030923212207.GA25234@xanadu.az.mvista.com> <Pine.LNX.4.44.0309231421450.24527-100000@home.osdl.org> <20030923213533.GN7665@parcelfarce.linux.theplanet.co.uk> <20030923221611.GA25464@xanadu.az.mvista.com> <20030923222632.GO7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923222632.GO7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 23 2003, at 23:26, viro@parcelfarce.linux.theplanet.co.uk was caught saying:
> The following, AFAICS, would be correct:
> 
>         if (*cp == '0') {
>                 cp++;
>                 if (unlikely((*cp == 'x' || *cp == 'X') && isxdigit(cp[1]))) {
>                         if (!base || base == 16) {
>                                 cp++;
>                                 base = 16;
>                         }
>                 } else if (!base)
>                         base = 8;
>         } else if (!base)
>                 base = 10;

We can remove everything but "base = 10;" from the second "else if"
clause b/c by this point we're guaranteed that it's not a hex or
octal value.

===== lib/vsprintf.c 1.16 vs edited =====
--- 1.16/lib/vsprintf.c	Sat Jul 12 12:49:57 2003
+++ edited/lib/vsprintf.c	Tue Sep 23 17:56:50 2003
@@ -32,16 +32,17 @@
 {
 	unsigned long result = 0,value;
 
-	if (!base) {
+	if (*cp == '0') {
+	       	cp++;
+	       	if (unlikely((*cp == 'x' || *cp == 'X') && isxdigit(cp[1]))) {
+		       	if (!base || base == 16) {
+			       	cp++;
+			       	base = 16;
+		       	}
+	       	} else if (!base)
+		       	base = 8;
+	} else if (!base) {
 		base = 10;
-		if (*cp == '0') {
-			base = 8;
-			cp++;
-			if ((*cp == 'x') && isxdigit(cp[1])) {
-				cp++;
-				base = 16;
-			}
-		}
 	}
 	while (isxdigit(*cp) &&
 	       (value = isdigit(*cp) ? *cp-'0' : toupper(*cp)-'A'+10) < base) {
@@ -76,16 +77,17 @@
 {
 	unsigned long long result = 0,value;
 
-	if (!base) {
+	if (*cp == '0') {
+	       	cp++;
+	       	if (unlikely((*cp == 'x' || *cp == 'X') && isxdigit(cp[1]))) {
+		       	if (!base || base == 16) {
+			       	cp++;
+			       	base = 16;
+		       	}
+	       	} else if (!base)
+		       	base = 8;
+	} else if (!base) {
 		base = 10;
-		if (*cp == '0') {
-			base = 8;
-			cp++;
-			if ((*cp == 'x') && isxdigit(cp[1])) {
-				cp++;
-				base = 16;
-			}
-		}
 	}
 	while (isxdigit(*cp) && (value = isdigit(*cp) ? *cp-'0' : (islower(*cp)
 	    ? toupper(*cp) : *cp)-'A'+10) < base) {



-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com
