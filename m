Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263378AbTCNQBb>; Fri, 14 Mar 2003 11:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263382AbTCNQBb>; Fri, 14 Mar 2003 11:01:31 -0500
Received: from air-2.osdl.org ([65.172.181.6]:52400 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263378AbTCNQB2>;
	Fri, 14 Mar 2003 11:01:28 -0500
Date: Fri, 14 Mar 2003 08:09:30 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Joern Engel <joern@wohnheim.fh-wedel.de>
Cc: braam@clusterfs.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix stack usage in fs/intermezzo/journal.c
Message-Id: <20030314080930.5ff3cc80.rddunlap@osdl.org>
In-Reply-To: <20030314155352.GD27154@wohnheim.fh-wedel.de>
References: <20030314155352.GD27154@wohnheim.fh-wedel.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003 16:53:52 +0100 Joern Engel <joern@wohnheim.fh-wedel.de> wrote:

| Hi!
| 
| This moves two 4k buffers from stack to heap. Compiles, untested, but
| looks trivial.
| -- 
| 
| --- linux-2.5.64/fs/intermezzo/journal.c	Mon Feb 24 20:05:05 2003
| +++ linux-2.5.64-i2o/fs/intermezzo/journal.c	Thu Mar 13 13:14:12 2003
| @@ -1245,6 +1245,7 @@
|          struct file *f;
|          int len;
|          loff_t read_off, write_off, bytes;
| +        char *buf;
|  
|          ENTRY;
|  
| @@ -1255,15 +1256,18 @@
|                  return f;
|          }
|  
| +        buf = kmalloc(4096, GFP_KERNEL);
| +        if (!buf)
| +                return ERR_PTR(-ENOMEM);
| +
|          write_off = 0;
|          read_off = start;
|          bytes = fset->fset_kml.fd_offset - start;
|          while (bytes > 0) {
| -                char buf[4096];
|                  int toread;
|  
| -                if (bytes > sizeof(buf))
| -                        toread = sizeof(buf);
| +                if (bytes > sizeof(*buf))
| +                        toread = sizeof(*buf);

I guess one of us needs some guidance here.
I thought that sizeof(*buf) == 1 here, not 4096.  Anybody?
I don't see how sizeof() can determine the kmalloc-ed size,
so I would use BUF_SIZE instead, with
#define BUF_SIZE	4096


Same for <record> below (snipped).

--
~Randy
