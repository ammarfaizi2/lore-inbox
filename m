Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWJDNTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWJDNTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWJDNTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:19:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:54418 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S932406AbWJDNTu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:19:50 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,255,1157353200"; 
   d="scan'208"; a="1353757:sNHT19845036"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] Cache miss eliminating in WARN_ON_ONCE
Date: Wed, 4 Oct 2006 17:19:42 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC3F3F28@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Cache miss eliminating in WARN_ON_ONCE
Thread-Index: AcbnZcdscLygcBP3ReW7v5cZrINmwwAO5BAg
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <andrew.j.wade@gmail.com>
Cc: <tim.c.chen@linux.intel.com>, <herbert@gondor.apana.org.au>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Oct 2006 13:19:47.0599 (UTC) FILETIME=[C3C2C1F0:01C6E7B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The static variable __warn_once was "never" read (until there is no bug)
before patch "Let WARN_ON/WARN_ON_ONCE return the condition"
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;h=684f978347deb42d180373ac4c427f82ef963171
 in WARN_ON_ONCE's line 
- if (unlikely((condition) && __warn_once)) { \
because 'condition' is false. There was no cache miss as a result.

Cache miss for __warn_once is happened in new lines
+ if (likely(__warn_once)) \
+ if (WARN_ON(__ret_warn_once)) \

Proposed patch is tested by tbench.

>From Leonid Ananiev

Cache miss eliminating in WARN_ON_ONCE  by testing expression value
before static variable value.

Signed-off-by: Leonid Ananiev <leonid.i.ananiev@intel.com>
--- linux-2.6.18-git14/include/asm-generic/bug.h
+++ linux-2.6.18-git14b/include/asm-generic/bug.h
@@ -45,9 +45,12 @@
        static int __warn_once = 1;                     \
        typeof(condition) __ret_warn_once = (condition);\
                                                        \
-       if (likely(__warn_once))                        \
-               if (WARN_ON(__ret_warn_once))           \
+       /* check 'condition' first to avoid cache miss with __warn_once
*/\
+       if (unlikely(__ret_warn_once))                  \
+               if (__warn_once) {                      \
                        __warn_once = 0;                \
+                       WARN_ON(1);                     \
+               }                                       \
        unlikely(__ret_warn_once);                      \
 })
