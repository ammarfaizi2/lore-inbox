Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270420AbTGVVYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270823AbTGVVYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:24:12 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:55764 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S270420AbTGVVYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:24:08 -0400
Subject: Re: [RFC] File backed target for device-mapper
From: Christophe Saout <christophe@saout.de>
To: dm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1058908659.17049.9.camel@chtephan.cs.pocnet.net>
References: <1058908659.17049.9.camel@chtephan.cs.pocnet.net>
Content-Type: text/plain
Message-Id: <1058909948.17049.12.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Jul 2003 23:39:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, 2003-07-22 um 23.17 schrieb Christophe Saout:

> I just wrote a dm target uses a file as backend instead of another block
> device.
> 
> It's heavily based on the linux 2.5 loop device (so it uses the inode
> operation sendfile for read operations and the address space operations
> prepare_write and commit_write for write operations).

Umm... lalala... (a cleanup and a *fix*) :D

--- dm-file.c.orig      2003-07-22 23:36:57.639746368 +0200
+++ dm-file.c   2003-07-22 23:37:26.203404032 +0200
@@ -87,17 +87,16 @@
 {
        char *src;
        char *dst = (char *)desc->buf;
-       unsigned long count = desc->count;
  
-       if (size > count)
-               size = count;
+       if (size > desc->count)
+               size = desc->count;
  
        src = kmap(page) + offset;
        if (src != dst) /* FIXME: is src == dst possible? */
                memcpy(dst, src, size);
        kunmap(page);
  
-       desc->count = count - size;
+       desc->count -= size;
        desc->written += size;
        (char *)desc->buf += size;
  
@@ -127,8 +126,6 @@
  
                if (r < 0)
                        break;
-
-               pos += bv->bv_len;
        }
  
        return 0;


--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

