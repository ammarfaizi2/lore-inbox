Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318237AbSG3L5x>; Tue, 30 Jul 2002 07:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318238AbSG3L5x>; Tue, 30 Jul 2002 07:57:53 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:9486 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318237AbSG3L5x>;
	Tue, 30 Jul 2002 07:57:53 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200207301201.g6UC18n10068@oboe.it.uc3m.es>
Subject: [PATCH] another fix for vsprintf.c in 2.4.18
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Tue, 30 Jul 2002 14:01:08 +0200 (MET DST)
Cc: marcelo@conectiva.com.br
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh - there's yet another bug in the lib/vsprintf.c implementation
of scanf. This time it's in the handling of %x. The symptom is
that "9bc" will be recongnized as hex OK, but "abc" won't be.

The problem is that the vscanf routine attemps to gobble space before
beginning to parse the number and stops at a digit.  But it should, in
the case that base=16, stop at a hexadecimal digit, not only at a
decimal digit.


--- vsprintf.c.orig	Tue Jul 30 09:45:29 2002
+++ vsprintf.c	Tue Jul 30 13:34:04 2002
@@ -640,7 +645,7 @@
 		while (isspace(*str))
 			str++;
 
-		if (!*str || !isdigit(*str))
+		if (!*str || !((base==16)?isxdigit(*str):isdigit(*str)))
 			break;
 
 		switch(qualifier) {


The case when base=8 (%o) and base=0 (%i) are OK, as in the former the
number will begin with a 0, and the latter means that we expect a
leading 0x or 0 if it's a funny number, or else it's decimal (%d).
Either way, searching for a decimal digit was always OK there.  It's
only the base=16 (%x) case for which the code was broken, for the
cases when the number starts with [a-f].

Peter
