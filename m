Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWJFI03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWJFI03 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 04:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWJFI03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 04:26:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58049 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751204AbWJFI02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 04:26:28 -0400
Subject: Re: __STRICT_ANSI__ checks in headers
From: David Woodhouse <dwmw2@infradead.org>
To: Ismail Donmez <ismail@pardus.org.tr>
Cc: Sam Ravnborg <sam@ravnborg.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       mchehab@infradead.org
In-Reply-To: <200610051116.12726.ismail@pardus.org.tr>
References: <200609150901.33644.ismail@pardus.org.tr>
	 <200610011034.57158.ismail@pardus.org.tr>
	 <20061001091411.GA9647@uranus.ravnborg.org>
	 <200610051116.12726.ismail@pardus.org.tr>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 09:26:22 +0100
Message-Id: <1160123182.26064.140.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 11:16 +0300, Ismail Donmez wrote:
> The problem shows itself in the modpost, somehow __extension__ clause seems to 
> foobar module CRC. I am not yet successfull on making modpost ignore 
> __extension__ .
> 
> Any ideas appreciated. 

Something like this (and build with GENERATE_PARSER=1) _ought_ to do it,
but doesn't work:

diff --git a/scripts/genksyms/keywords.gperf b/scripts/genksyms/keywords.gperf
index c75e0c8..1c31f38 100644
--- a/scripts/genksyms/keywords.gperf
+++ b/scripts/genksyms/keywords.gperf
@@ -11,6 +11,7 @@ __attribute, ATTRIBUTE_KEYW
 __attribute__, ATTRIBUTE_KEYW
 __const, CONST_KEYW
 __const__, CONST_KEYW
+__extension__,EXTENSION_KEYW
 __inline, INLINE_KEYW
 __inline__, INLINE_KEYW
 __signed, SIGNED_KEYW
diff --git a/scripts/genksyms/parse.y b/scripts/genksyms/parse.y
index ca04c94..66ae413 100644
--- a/scripts/genksyms/parse.y
+++ b/scripts/genksyms/parse.y
@@ -60,6 +60,7 @@ remove_list(struct string_list **pb, str
 %token CONST_KEYW
 %token DOUBLE_KEYW
 %token ENUM_KEYW
+%token EXTENSION_KEYW
 %token EXTERN_KEYW
 %token FLOAT_KEYW
 %token INLINE_KEYW
@@ -269,7 +270,7 @@ cvar_qualifier_seq:
 
 cvar_qualifier:
 	CONST_KEYW | VOLATILE_KEYW | ATTRIBUTE_PHRASE
-	| RESTRICT_KEYW
+	| RESTRICT_KEYW | EXTENSION_KEYW
 		{ /* restrict has no effect in prototypes so ignore it */
 		  remove_node($1);
 		  $$ = $1;

-- 
dwmw2

