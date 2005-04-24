Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVDXVZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVDXVZT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVDXVZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:25:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:44479 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262438AbVDXVZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:25:10 -0400
Date: Sun, 24 Apr 2005 14:24:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] fix race in __block_prepare_write (again)
Message-Id: <20050424142439.3b45bdbc.akpm@osdl.org>
In-Reply-To: <1114068704.12751.8.camel@imp.csi.cam.ac.uk>
References: <1114064046.5182.13.camel@npiggin-nld.site>
	<Pine.LNX.4.60.0504210757220.3348@hermes-1.csi.cam.ac.uk>
	<1114067401.11293.3.camel@imp.csi.cam.ac.uk>
	<1114068058.5182.22.camel@npiggin-nld.site>
	<1114068704.12751.8.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> mm/filemap.c::file_buffered_write():
> 
>  - It calls fault_in_pages_readable() which is completely bogus if
>  @nr_segs > 1.  It needs to be replaced by a to be written
>  "fault_in_pages_readable_iovec()".
> 
>  - It increments @buf even in the iovec case thus @buf can point to
>  random memory really quickly (in the iovec case) and then it calls
>  fault_in_pages_readable() on this random memory.  Ouch...

hmm, yes.  Like this?


diff -puN mm/filemap.c~generic_file_buffered_write-fixes mm/filemap.c
--- 25/mm/filemap.c~generic_file_buffered_write-fixes	2005-04-24 14:18:58.445943000 -0700
+++ 25-akpm/mm/filemap.c	2005-04-24 14:20:21.995241576 -0700
@@ -1944,7 +1944,7 @@ generic_file_buffered_write(struct kiocb
 		buf = iov->iov_base + written;
 	else {
 		filemap_set_next_iovec(&cur_iov, &iov_base, written);
-		buf = iov->iov_base + iov_base;
+		buf = cur_iov->iov_base + iov_base;
 	}
 
 	do {
@@ -2002,9 +2002,11 @@ generic_file_buffered_write(struct kiocb
 				count -= status;
 				pos += status;
 				buf += status;
-				if (unlikely(nr_segs > 1))
+				if (unlikely(nr_segs > 1)) {
 					filemap_set_next_iovec(&cur_iov,
 							&iov_base, status);
+					buf = cur_iov->iov_base + iov_base;
+				}
 			}
 		}
 		if (unlikely(copied != bytes))
_

