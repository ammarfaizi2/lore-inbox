Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWGIMKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWGIMKi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 08:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWGIMKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 08:10:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030459AbWGIMKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 08:10:37 -0400
Date: Sun, 9 Jul 2006 05:10:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>
Subject: Re: 2.6.18-rc1-mm1
Message-Id: <20060709051030.a73f832c.akpm@osdl.org>
In-Reply-To: <6bffcb0e0607090402m1f6c09c7hc9abc380bf36d460@mail.gmail.com>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<6bffcb0e0607090402m1f6c09c7hc9abc380bf36d460@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 13:02:48 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> TP hangs on
> 
> <<<test_output>>>
> setrlimit01    1  PASS  :  RLIMIT_NOFILE functionality is correct
> setrlimit01    0  WARN  :  caught signal 2, not SIGSEGV
> <<<execution_status>>>
> duration=1071 termination_type=driver_interrupt termination_id=1 corefile=no
> cutime=0 cstime=1
> <<<test_end>>>

Yep, thanks.


RLIMIT_FSIZE can cause generic_write_checks() to reduce `count'.  So we cannot
assume that `count' is equal to the total length size of the incoming iovec.

--- a/mm/filemap.c~add-address_space_operationsbatch_write-fix
+++ a/mm/filemap.c
@@ -2205,9 +2205,9 @@ generic_file_buffered_write(struct kiocb
 	do {
 		/* do not walk over current segment */
 		desc.buf = cur_iov->iov_base + iov_base;
-		desc.count = cur_iov->iov_len - iov_base;
+		desc.count = min(count, cur_iov->iov_len - iov_base);
 		if (desc.count > 0)
-			status = batch_write(file, &desc, &copied);
+			status = (*batch_write)(file, &desc, &copied);
 		else {
 			copied = 0;
 			status = 0;
_

