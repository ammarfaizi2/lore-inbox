Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262563AbTCISRk>; Sun, 9 Mar 2003 13:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262565AbTCISRj>; Sun, 9 Mar 2003 13:17:39 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:16791 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262563AbTCISRj>;
	Sun, 9 Mar 2003 13:17:39 -0500
Date: Sun, 9 Mar 2003 21:27:26 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Memleak in iso9660 fs (rockridge extension) on read error
Message-ID: <20030309182726.GA29009@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   I am looking at fs/isofs/rock.c::MAYBE_CONTINUE() macros
   in latest 2.4 bk tree. (latest 2.5 have the same problem)

   Seems that it opens a memleak in case of read error of rock-ridge attribute.
   The caller of the macros assumes that when MAYBE_CONTINUE macros is over
   (and not jumping to "out" label), then buffer is freed. (The funny thing is
   that the macro only jumps to "out" if buffer allocation failed now, so
   nothing to free, and every caller tries to free buffer if possible).

   Perhaps something like following patch should help (applies to 2.4 and 2.5).

   Found with help of smatch and enchanced unfree script.

Bye,
    Oleg

===== fs/isofs/rock.c 1.6 vs edited =====
--- 1.6/fs/isofs/rock.c	Tue Feb  5 17:10:25 2002
+++ edited/fs/isofs/rock.c	Sun Mar  9 21:23:07 2003
@@ -81,6 +81,7 @@
       goto LABEL; \
     }    \
     printk("Unable to read rock-ridge attributes\n");    \
+    goto out;
   }}
 
 /* This is the inner layer of the get filename routine, and is called
