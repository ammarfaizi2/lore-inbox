Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318122AbSHNNft>; Wed, 14 Aug 2002 09:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSHNNft>; Wed, 14 Aug 2002 09:35:49 -0400
Received: from ip131-20.dialup.edisontel.com ([62.94.65.132]:27777 "EHLO
	dreamland.darkstar.net") by vger.kernel.org with ESMTP
	id <S318122AbSHNNfs>; Wed, 14 Aug 2002 09:35:48 -0400
From: Kronos <kronos@kronoz.cjb.net>
To: Tom Miller <bsdwiz@optonline.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBMMCA 2.5.31
In-Reply-To: <fa.kans5jv.1ch8c18@ifi.uio.no>
X-Newsgroups: fa.linux.kernel
X-Newsreader: Micro$oft Outlook Espresso Corretto Grappa 5.4321.00
Message-Id: <20020814133941.6A6CA270E@dreamland.darkstar.net>
Date: Wed, 14 Aug 2002 15:39:41 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nell'articolo <fa.kans5jv.1ch8c18@ifi.uio.no> hai scritto:
> I don't use this driver, so despite this patch's simplicity, please
> provide test info, and if i did everything right.

Well, strsep has a different  prototype and different semantics, so your
patch won't even compile.

This one should work:

--- ibmmca.orig.c	Wed Aug 14 15:24:32 2002
+++ ibmmca.c	Wed Aug 14 15:29:11 2002
@@ -1406,9 +1406,10 @@
    io_base = 0;
    id_base = 0;
    if (str) {
-      token = strtok(str,",");
+      token = strsep(&str, ",");
       j = 0;
-      while (token) {
+      /* In case no delimiter was found str is made NULL. */
+      while (str) {
 	 if (!strcmp(token,"activity")) display_mode |= LED_ACTIVITY;
 	 if (!strcmp(token,"display")) display_mode |= LED_DISP;
 	 if (!strcmp(token,"adisplay")) display_mode |= LED_ADISP;
@@ -1424,7 +1425,7 @@
 	      scsi_id[id_base++] = simple_strtoul(token,NULL,0);
 	    j++;
 	 }
-	 token = strtok(NULL,",");
+	 token = strsep(&str, ",");
       }
    } else if (ints) {
       for (i = 0; i < IM_MAX_HOSTS && 2*i+2 < ints[0]; i++) {

It compiles, but I get other errors:

kronos@dreamland:/usr/src/linux-2.5# make drivers/scsi/ibmmca.o
make[1]: Entering directory `/usr/src/linux-2.5/drivers/scsi'
  gcc -Wp,-MD,./.ibmmca.o.d -D__KERNEL__ -I/usr/src/linux-2.5/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -nostdinc -iwithprefix include
-DKBUILD_BASENAME=ibmmca   -c -o ibmmca.o ibmmca.c
ibmmca.c: In function `interrupt_handler':
ibmmca.c:508: warning: dereferencing `void *' pointer
ibmmca.c:508: request for member `host_lock' in something not a
structure or union
ibmmca.c:515: warning: dereferencing `void *' pointer
ibmmca.c:515: request for member `host_lock' in something not a
structure or union
ibmmca.c:524: warning: dereferencing `void *' pointer
ibmmca.c:524: request for member `host_lock' in something not a
structure or union
ibmmca.c:531: warning: dereferencing `void *' pointer
ibmmca.c:531: request for member `host_lock' in something not a
structure or union
ibmmca.c:532: warning: dereferencing `void *' pointer
ibmmca.c:532: request for member `host_lock' in something not a
structure or union
ibmmca.c:542: warning: dereferencing `void *' pointer
ibmmca.c:542: request for member `host_lock' in something not a
structure or union
ibmmca.c: In function `ibmmca_getinfo':
ibmmca.c:1446: warning: dereferencing `void *' pointer
ibmmca.c:1446: request for member `host_lock' in something not a
structure or union
make[1]: *** [ibmmca.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5/drivers/scsi'
make: *** [drivers/scsi/ibmmca.o] Error 2

ciao,
Luca
-- 
Home: http://kronoz.cjb.net
La somma dell'intelligenza sulla terra e` una costante.
La popolazione e` in aumento.
