Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262990AbTCLATe>; Tue, 11 Mar 2003 19:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262972AbTCLARC>; Tue, 11 Mar 2003 19:17:02 -0500
Received: from packet.digeo.com ([12.110.80.53]:26003 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262982AbTCLAQK>;
	Tue, 11 Mar 2003 19:16:10 -0500
Date: Tue, 11 Mar 2003 16:21:53 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Warning: dev (pts(136,0)) tty->count(5) != #fd's(4) in tty_open
Message-Id: <20030311162153.493a305e.akpm@digeo.com>
In-Reply-To: <45750000.1047426594@flay>
References: <45750000.1047426594@flay>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2003 00:26:46.0798 (UTC) FILETIME=[10CFAAE0:01C2E82E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> I'm getting lots of these messages whilst running big SDET runs on
> an 16-way machine ... anyone recognize them?
> (64-bk3 + a few patches).
> 
> dev (pts(136,0)) tty->count(4) != #fd's(3) in release_dev

The file_list_lock patches affect this.  Do you have those applied?

If so, and if it is repeatable, this might help.  (Unlikely, but it might).


diff -puN drivers/char/tty_io.c~tty_files-fixes drivers/char/tty_io.c
--- 25/drivers/char/tty_io.c~tty_files-fixes	2003-03-09 23:15:15.000000000 -0800
+++ 25-akpm/drivers/char/tty_io.c	2003-03-09 23:15:58.000000000 -0800
@@ -1037,7 +1037,9 @@ static void release_mem(struct tty_struc
 		}
 		o_tty->magic = 0;
 		(*o_tty->driver.refcount)--;
+		file_list_lock();
 		list_del(&o_tty->tty_files);
+		file_list_unlock();
 		free_tty_struct(o_tty);
 	}
 
@@ -1049,7 +1051,9 @@ static void release_mem(struct tty_struc
 	}
 	tty->magic = 0;
 	(*tty->driver.refcount)--;
+	file_list_lock();
 	list_del(&tty->tty_files);
+	file_list_unlock();
 	module_put(tty->driver.owner);
 	free_tty_struct(tty);
 }

_

