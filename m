Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbTCEP0K>; Wed, 5 Mar 2003 10:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbTCEP0K>; Wed, 5 Mar 2003 10:26:10 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:12759 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267190AbTCEP0H>; Wed, 5 Mar 2003 10:26:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.20: lib/vsprintf.c: Fix vsscanf of hex digits
Date: Wed, 5 Mar 2003 09:31:23 -0600
X-Mailer: KMail [version 1.2]
Cc: "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0303050931230P.05199@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The current vsscanf() in 2.4 does not correctly scan hex digits that begin 
with a-f. (It does work correctly for hex digits that begin with 0-9). This 
patch fixes that bug, and is based on the fix that was added to 2.5.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/


--- linux-2.4.20a/lib/vsprintf.c	Tue Jan 21 11:12:02 2003
+++ linux-2.4.20b/lib/vsprintf.c	Tue Jan 21 11:11:49 2003
@@ -637,7 +637,11 @@
 		while (isspace(*str))
 			str++;
 
-		if (!*str || !isdigit(*str))
+		if (!*str
+		    || (base == 16 && !isxdigit(*str))
+		    || (base == 10 && !isdigit(*str))
+		    || (base == 8 && (!isdigit(*str) || *str > '7'))
+		    || (base == 0 && !isdigit(*str)))
 			break;
 
 		switch(qualifier) {
