Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTKHCsW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 21:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTKHCsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 21:48:21 -0500
Received: from web21010.mail.yahoo.com ([216.136.227.64]:52905 "HELO
	web21010.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261546AbTKHCsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 21:48:20 -0500
Message-ID: <20031108024819.25606.qmail@web21010.mail.yahoo.com>
Date: Fri, 7 Nov 2003 18:48:19 -0800 (PST)
From: Itay Ben-Yaacov <nib_maps@yahoo.com>
Subject: Re: 2.6.0_test6: CONFIG_I8K produces wrong/no keycodes for specialbuttons
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a Dell I8200 as well.  I tried to dig into this a bit, and came up with the following.  
The basic problem is the new (wrt 2.4) mandatory passage through the input layer.
In 2.4, under X, the keyboard was in RAW mode, and the server got the scancodes and did whatever
it did with them.  In a vt, the keyboard is in XLATE mode, and complains it cannot process these
keys, but who cares.

Now, in 2.6, the keyboard ALWAYS translates keys, passes them translated through the input layer,
and on the other side, if we are under X, it un-translates them to emulate the good old RAW mode. 
So thhere are two issues:  first, atkbd.c must be taught how to translate these keys to something
meaningful.  Since in 2.4 they are not translated at all, I just had to come up with SOMETHING.  I
am not sure these are the best keycodes to translate to, but they will do for the time being. 
Then, keyboard.c must be taught how to un-translate these back to the good old e0 01 -- e0 04.

So check tou the patch below and tell me what you think.

Thanks,
Itay


diff -u -r linux-2.6.0-test9/drivers/char/keyboard.c linux-2.6.0-test9.new/drivers/char/keyboard.c
--- linux-2.6.0-test9/drivers/char/keyboard.c	2003-10-25 14:43:27.000000000 -0400
+++ linux-2.6.0-test9.new/drivers/char/keyboard.c	2003-11-06 21:33:00.000000000 -0500
@@ -944,7 +944,7 @@
 	 80, 81, 82, 83, 43, 85, 86, 87, 88,115,119,120,121,375,123, 90,
 	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
 	367,288,302,304,350, 92,334,512,116,377,109,111,373,347,348,349,
-	360, 93, 94, 95, 98,376,100,101,321,316,354,286,289,102,351,355,
+	360,257,258,259,260,376,100,101,321,316,354,286,289,102,351,355,
 	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,
 	291,108,381,281,290,272,292,305,280, 99,112,257,258,359,270,114,
 	118,117,125,374,379,115,112,125,121,123,264,265,266,267,268,269,
diff -u -r linux-2.6.0-test9/drivers/input/keyboard/atkbd.c
linux-2.6.0-test9.new/drivers/input/keyboard/atkbd.c
--- linux-2.6.0-test9/drivers/input/keyboard/atkbd.c	2003-10-25 14:44:30.000000000 -0400
+++ linux-2.6.0-test9.new/drivers/input/keyboard/atkbd.c	2003-11-06 21:04:46.000000000 -0500
@@ -65,13 +65,13 @@
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,
 	  0,  0, 92, 90, 85,  0,137,  0,  0,  0,  0, 91, 89,144,115,  0,
-	217,100,255,  0, 97,165,164,  0,156,  0,  0,140,115,  0,  0,125,
-	173,114,  0,113,152,163,151,126,128,166,  0,140,  0,147,  0,127,
+	217,100,255,  0, 97,165,130,  0,156,  0,  0,140,115,  0,131,125,
+	173,114,  0,113,152,163,132,126,128,166,  0,140,  0,147,  0,127,
 	159,167,115,160,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
 	157,  0,114,166,168,  0,  0,213,155,  0, 98,113,  0,163,  0,138,
 	226,  0,  0,  0,  0,  0,153,140,  0,255, 96,  0,  0,  0,143,  0,
 	133,  0,116,  0,143,  0,174,133,  0,107,  0,105,102,  0,  0,112,
-	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119
+	110,111,108,112,106,103,129,119,  0,118,109,  0, 99,104,119
 };
 
 static unsigned char atkbd_set3_keycode[512] = {


__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
