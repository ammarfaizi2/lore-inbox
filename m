Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWJDEGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWJDEGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWJDEGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:06:36 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:20120 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932339AbWJDEGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:06:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=MbRgpyIsBtXxmPQTp6LbpIKC4GzXzbodIjOcFEEBgG9kqUIWon5tgoC2fLHG0ZorjY7H7IhxMfLq+Q5W15k9ysM3CzBFyXe8xWx07VUjNJII6ZuCkQtZOyUtaqQwty0ODvJDDD97kqDyaD9xzFoN/zpNTLn+7g49ZELDScmGatE=
Reply-To: andrew.j.wade@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Date: Tue, 3 Oct 2006 23:24:27 -0400
User-Agent: KMail/1.9.1
Cc: tim.c.chen@linux.intel.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, leonid.i.ananiev@intel.com
References: <1159916644.8035.35.camel@localhost.localdomain> <1159920569.8035.71.camel@localhost.localdomain> <20061003181452.778291fb.akpm@osdl.org>
In-Reply-To: <20061003181452.778291fb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610032324.29454.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 21:14, Andrew Morton wrote:
> There are changes here: in the old code we'll avoid reading the static
> variable.  In the new code we'll read the static variable, but we'll avoid
> evaluating the condition.

Tim Chen's patch goes back to the old behaviour. I suspect the cache
misses on __warn_once is what he is measuring. If so, the (untested)
patch below should reduce the cache misses back to those of the old
code.

signed-off-by: Andrew Wade <andrew.j.wade@gmail.com>
diff -rupN a/include/asm-generic/bug.h b/include/asm-generic/bug.h
--- a/include/asm-generic/bug.h	2006-10-03 13:58:40.000000000 -0400
+++ b/include/asm-generic/bug.h	2006-10-03 23:17:37.000000000 -0400
@@ -45,9 +45,10 @@
 	static int __warn_once = 1;			\
 	typeof(condition) __ret_warn_once = (condition);\
 							\
-	if (likely(__warn_once))			\
-		if (WARN_ON(__ret_warn_once)) 		\
+	if (unlikely(__ret_warn_once) && __warn_once) {	\
 			__warn_once = 0;		\
+			WARN_ON(1);			\
+	};						\
 	unlikely(__ret_warn_once);			\
 })
