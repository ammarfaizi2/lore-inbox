Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVCIX7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVCIX7D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVCIX5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:57:34 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:24465 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S262092AbVCIXu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:50:57 -0500
Message-ID: <422F8BDC.9000005@am.sony.com>
Date: Wed, 09 Mar 2005 15:50:52 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Luck <tony.luck@intel.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add timing information to printk messages
References: <200503092136.j29La5E26081@unix-os.sc.intel.com>
In-Reply-To: <200503092136.j29La5E26081@unix-os.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Luck wrote:
> Setting CONFIG_PRINTK_TIME=y I see (the "<NUL>" pieces are actually
> each a single ASCII '\0' character):

Tony,

Can you try the patch below? (inspired by a patch from Tom Zanussi -
gotta give credit where credit is due... :-)

This solves the problem for me but I'd like independent confirmation.

BTW, this also fixes a problem with the return value for printk,
which is supposed to be the actual amount printed.  This was incorrect
in the printk-times=y case, but also in the '=n' case where a log-level
tag is inserted by printk automatically.  This looks like a longstanding
bug.  (Although I doubt a very important one, since no one appears
to ever look at the printk return value.)

Thanks,
 -- Tim

Fix for null character processing with printk-times option on:
---------------------------------
diff -pruN printk-1/kernel/printk.c printk-fix1/kernel/printk.c
--- printk-1/kernel/printk.c	2005-03-09 15:42:04.550944124 -0800
+++ printk-fix1/kernel/printk.c	2005-03-09 15:36:18.928567360 -0800
@@ -579,6 +579,7 @@ asmlinkage int vprintk(const char *fmt,
 				   p[1] <= '7' && p[2] == '>') {
 					loglev_char = p[1];
 					p += 3;
+					printed_len += 3;
 				} else {
 					loglev_char = default_message_loglevel
 						+ '0';
@@ -593,6 +594,7 @@ asmlinkage int vprintk(const char *fmt,

 				for (tp = tbuf; tp < tbuf + tlen; tp++)
 					emit_log_char (*tp);
+				printed_len += tlen - 3;
 			} else {
 				if (p[0] != '<' || p[1] < '0' ||
 				   p[1] > '7' || p[2] != '>') {
@@ -601,8 +603,11 @@ asmlinkage int vprintk(const char *fmt,
 						+ '0');
 					emit_log_char('>');
 				}
+				printed_len += 3;
 			}
 			log_level_unknown = 0;
+			if (!*p)
+				break;
 		}
 		emit_log_char(*p);
 		if (*p == '\n')
