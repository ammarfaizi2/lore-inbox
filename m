Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264011AbTDJIxi (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 04:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbTDJIxi (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 04:53:38 -0400
Received: from marstons.services.quay.plus.net ([212.159.14.223]:22430 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264011AbTDJIxf (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 04:53:35 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Linus Torvalds" <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-English user messages
Date: Thu, 10 Apr 2003 10:05:17 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAGEPFCFAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002D_01C2FF48.B03A1580"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <b72n7h$fgd$1@penguin.transmeta.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_002D_01C2FF48.B03A1580
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Linus.

 >> I wish to suggest a possible 2.6 or 2.7 feature (too late for
 >> 2.4.x and 2.5.x, I believe) that I believe would be helpful.
 >> Currently, printk messages are all in English, and I was
 >> wondering if printk could be modified to print out user
 >> messages that are in the default language of the machine.

 > This has come up before.
 >
 > The answer is: go ahead and do it, but don't do it in the kernel.
 > Do it in klogd or similar.
 >
 > I refuse to clutter the kernel with inane and fragile (and totally
 > unmaintainable) internationalization code. The string lookup can
 > equally well be done in user space where it isn't a stability and
 > complexity issue.

Whilst I agree with the general sentiments above, any such code would
require some sort of code attached to each message for it to look up,
with the standard English message tagged on to the end for systems
where the translation code isn't in use.

At the moment, printk() calls are supposed to have a string along the
lines of "<2>" prepended onto each line. Can I ask whether you have
any objection in principle to this being changed to something along
the lines of <2:xxxx> where the xxxx is a code to enable translation
systems to index that message?

This would probably require the current macros used to prepend the
relevant string to be changed to macro functions such that...

	printk(KERN_ERR "Sample error message.\n");

...would become...

	printk(KERN_NO(KERN_NO_ERR,"1234") "Sample error message.\n");

...and would result in...

	"<3:1234>Sample error message.\n"

...being printed out. The change of macro name is specifically for
backwards compatibility, and the resulting system would allow the
actual messages to be changed over time rather than all at once.

If this is acceptable, then the patch to make all relevant changes
against the 2.5.67 kernel tree is attached. This patch assigns the
message number 0000 to all current messages, thus reserving that
number as "Not yet numbered" as far as translation software is
concerned.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.470 / Virus Database: 268 - Release Date: 8-Apr-2003

------=_NextPart_000_002D_01C2FF48.B03A1580
Content-Type: application/octet-stream;
	name="Linux-Logging-2.5.67.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Linux-Logging-2.5.67.diff"

--- include/linux/kernel.h~	Mon Apr  7 18:30:33 2003=0A=
+++ include/linux/kernel.h	Thu Apr 10 09:58:13 2003=0A=
@@ -29,18 +29,29 @@=0A=
 #define STACK_MAGIC	0xdeadbeef=0A=
 =0A=
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))=0A=
 #define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))=0A=
 =0A=
-#define	KERN_EMERG	"<0>"	/* system is unusable			*/=0A=
+#define	KERN_NO_EMERG	"0"	/* system is unusable			*/=0A=
-#define	KERN_ALERT	"<1>"	/* action must be taken immediately	*/=0A=
+#define	KERN_NO_ALERT	"1"	/* action must be taken immediately	*/=0A=
-#define	KERN_CRIT	"<2>"	/* critical conditions			*/=0A=
+#define	KERN_NO_CRIT	"2"	/* critical conditions			*/=0A=
-#define	KERN_ERR	"<3>"	/* error conditions			*/=0A=
+#define	KERN_NO_ERR	"3"	/* error conditions			*/=0A=
-#define	KERN_WARNING	"<4>"	/* warning conditions			*/=0A=
+#define	KERN_NO_WARNING	"4"	/* warning conditions			*/=0A=
-#define	KERN_NOTICE	"<5>"	/* normal but significant condition	*/=0A=
+#define	KERN_NO_NOTICE	"5"	/* normal but significant condition	*/=0A=
-#define	KERN_INFO	"<6>"	/* informational			*/=0A=
+#define	KERN_NO_INFO	"6"	/* informational			*/=0A=
-#define	KERN_DEBUG	"<7>"	/* debug-level messages			*/=0A=
+#define	KERN_NO_DEBUG	"7"	/* debug-level messages			*/=0A=
+=0A=
+#define	KERN_NO(x,y)	"<" x ":" y ">"=0A=
+=0A=
+#define	KERN_EMERG	KERN_NO(KERN_NO_EMERG,  "0000")=0A=
+#define	KERN_ALERT	KERN_NO(KERN_NO_ALERT,  "0000")=0A=
+#define	KERN_CRIT	KERN_NO(KERN_NO_CRIT,   "0000")=0A=
+#define	KERN_ERR	KERN_NO(KERN_NO_ERR,    "0000")=0A=
+#define	KERN_WARNING	KERN_NO(KERN_NO_WARNING,"0000")=0A=
+#define	KERN_NOTICE	KERN_NO(KERN_NO_NOTICE, "0000")=0A=
+#define	KERN_INFO	KERN_NO(KERN_NO_INFO,   "0000")=0A=
+#define	KERN_DEBUG	KERN_NO(KERN_NO_DEBUG,  "0000")=0A=
 =0A=
 extern int console_printk[];=0A=
 =0A=
 #define console_loglevel (console_printk[0])=0A=
 #define default_message_loglevel (console_printk[1])=0A=

------=_NextPart_000_002D_01C2FF48.B03A1580--

