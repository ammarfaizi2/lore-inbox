Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSLMQnE>; Fri, 13 Dec 2002 11:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSLMQnD>; Fri, 13 Dec 2002 11:43:03 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:43501 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S265134AbSLMQnC>; Fri, 13 Dec 2002 11:43:02 -0500
Message-ID: <3DFA0F2B.8080001@us.ibm.com>
Date: Fri, 13 Dec 2002 10:47:39 -0600
From: steven pratt <slpratt@us.ibm.com>
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alan@redhat.com, marcelo@hera.kernel.org
CC: slpratt@us.ibm.com
Subject: [PATCH] sscanf doesn't handle %x in 2.4.20
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In vsscanf in vsprintf.c incorectly uses isdigit to check for a leading 
numeric
after finding a %x and setting the base to 16.   This breaks device 
mapper under
certain conditions.   Following patch is backport from 2.5.50.

--- vsprintf.c    Thu Oct 11 13:17:22 2001
+++ /usr/src/linux-2.4.20/lib/vsprintf.c    Fri Dec 13 09:57:14 2002
@@ -637,7 +637,11 @@
         while (isspace(*str))
             str++;
 
-        if (!*str || !isdigit(*str))
+        if (!*str
+                    || (base == 16 && !isxdigit(*str))
+                    || (base == 10 && !isdigit(*str))
+                    || (base == 8 && (!isdigit(*str) || *str > '7'))
+                    || (base == 0 && !isdigit(*str)))
             break;
 
         switch(qualifier) {


