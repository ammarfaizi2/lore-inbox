Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbTK1RNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 12:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTK1RNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 12:13:30 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:1286 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262766AbTK1RNY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 12:13:24 -0500
To: Tore Anderson <tore@linpro.no>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] scheduling while atomic when lseek()ing in /proc/net/tcp
References: <1069974335.14367.17.camel@echo.linpro.no>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 29 Nov 2003 02:12:38 +0900
In-Reply-To: <1069974335.14367.17.camel@echo.linpro.no>
Message-ID: <87n0ag2z95.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tore Anderson <tore@linpro.no> writes:

>     #include <sys/types.h>
>     #include <sys/stat.h>
>     #include <fcntl.h>
>     #include <unistd.h>
>     #include <stdio.h>
> 
>     int main(void) {
>             char buf[8192];
>             int fd, chars;
>             fd = open("/proc/net/tcp", O_RDONLY);
>             chars = read(fd, buf, sizeof(buf));
>             lseek(fd, -chars+1, SEEK_CUR);
>             close(fd);
>             return 0;
>     }

This seems to need initialization of st->state in tcp_seq_start().
tcp_seq_stop() is run with previous st->state, so it call the unneeded
unlock etc.

 net/ipv4/tcp_ipv4.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN net/ipv4/tcp_ipv4.c~tcp_seq-oops-fix net/ipv4/tcp_ipv4.c
--- linux-2.6.0-test11/net/ipv4/tcp_ipv4.c~tcp_seq-oops-fix	2003-11-29 00:52:15.000000000 +0900
+++ linux-2.6.0-test11-hirofumi/net/ipv4/tcp_ipv4.c	2003-11-29 00:52:28.000000000 +0900
@@ -2356,6 +2356,7 @@ static void *tcp_get_idx(struct seq_file
 static void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct tcp_iter_state* st = seq->private;
+	st->state = TCP_SEQ_STATE_LISTENING;
 	st->num = 0;
 	return *pos ? tcp_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }

_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
