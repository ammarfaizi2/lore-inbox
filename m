Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUFSADl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUFSADl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265746AbUFRXzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:55:00 -0400
Received: from [81.187.239.184] ([81.187.239.184]:61893 "EHLO
	mail.newtoncomputing.co.uk") by vger.kernel.org with ESMTP
	id S265541AbUFRXwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:52:36 -0400
Date: Sat, 19 Jun 2004 00:52:23 +0100
From: matthew-lkml@newtoncomputing.co.uk
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars
Message-ID: <20040618235223.GB5286@newtoncomputing.co.uk>
References: <20040618205355.GA5286@newtoncomputing.co.uk> <Pine.LNX.4.58.0406181407330.6178@ppc970.osdl.org> <Pine.LNX.4.56.0406190032290.17899@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0406190032290.17899@jjulnx.backbone.dif.dk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 12:44:55AM +0200, Jesper Juhl wrote:
> On Fri, 18 Jun 2004, Linus Torvalds wrote:
> >
> > How about emitting them as \xxx, so that you see what they are. And using
> > a case-statement to make it easy and clear when to do exceptions (I think
> > we should accept \t too, no?).
> 
> Would there be any reason not to allow all the standard C escape sequences
> - true, they are hardly used atm (I see a few \f uses with grep, but not
> much else), but it's not unthinkable they could be useful somewhere in

I must admit, I don't think I've even seen a tab before (not that you'd
actually _see_ a tab). Oh, grep tells me that powernow uses it. By the
time that gets through syslog it's changed into "^I", so it would
probably be better to not actually use tabs, either (or fix syslog).

New patch below outputs as \xxx if it's not a "nice" character.  "Nice"
is now 32..126, \n and \t.


--- linux-2.6.7/kernel/printk.c.orig	2004-06-18 20:44:28.000000000 +0100
+++ linux-2.6.7/kernel/printk.c	2004-06-19 00:11:30.000000000 +0100
@@ -14,6 +14,8 @@
  *     manfreds@colorfullife.com
  * Rewrote bits to get rid of console_lock
  *	01Mar01 Andrew Morton <andrewm@uow.edu.au>
+ * Stop emit_log_char from emitting non-ASCII chars.
+ *  Matthew Newton, 18 June 2004 <matthew-lkml@newtoncomputing.co.uk>
  */
 
 #include <linux/kernel.h>
@@ -472,6 +474,17 @@
 }
 
 /*
+ * Emit character in numeric (octal) form
+ */
+static void emit_log_char_octal(char c)
+{
+	emit_log_char('\\');
+	emit_log_char(((c >> 6) & 3) + '0');
+	emit_log_char(((c >> 3) & 7) + '0');
+	emit_log_char((c & 7) + '0');
+}
+
+/*
  * Zap console related locks when oopsing. Only zap at most once
  * every 10 seconds, to leave time for slow consoles to print a
  * full oops.
@@ -538,7 +551,17 @@
 			}
 			log_level_unknown = 0;
 		}
-		emit_log_char(*p);
+		switch (*p) {
+			case '\n':
+			case '\t':
+				emit_log_char(*p);
+				break;
+			default:
+				if (*p > 31 && *p < 127)
+					emit_log_char(*p);
+				else
+					emit_log_char_octal(*p);
+		}
 		if (*p == '\n')
 			log_level_unknown = 1;
 	}



-- 
Matthew
