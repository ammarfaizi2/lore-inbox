Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbUBXAAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUBXAAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:00:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:57305 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262096AbUBXAAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:00:11 -0500
Date: Mon, 23 Feb 2004 16:01:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Graham Swallow <Information-Cascade@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/kmsg  blocks with O_NONBLOCK, read() should return 0 with
 EAGAIN
Message-Id: <20040223160148.400895f3.akpm@osdl.org>
In-Reply-To: <20040223122410.6eb44df1.Information-Cascade@ntlworld.com>
References: <20040223122410.6eb44df1.Information-Cascade@ntlworld.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Graham Swallow <Information-Cascade@ntlworld.com> wrote:
>
> /proc/kmsg  blocks with O_NONBLOCK, read() should return 0 with EAGAIN
> 
> 	fd = open( "/proc/kmsg", O_RDONLY|O_NONBLOCK );
> 	...
> 	poll() -- says read it
> 
> 	len = read(fd,buff,len); // first read is fine
> 	...
> 	len = read(fd,buff,len); // second read blocks
> 
> I call read() a second time, because I'm feeling lucky,
> (this is library code, which also reads from sockets).
> 
> I expected it to return 0 with errno==EAGAIN.
> Instead it waits:  do_syslog(2,buf,count); 
> 

Does this work?


diff -puN fs/proc/kmsg.c~kmsg-nonblock fs/proc/kmsg.c
--- 24/fs/proc/kmsg.c~kmsg-nonblock	Mon Feb 23 16:00:48 2004
+++ 24-akpm/fs/proc/kmsg.c	Mon Feb 23 16:01:12 2004
@@ -32,6 +32,8 @@ static int kmsg_release(struct inode * i
 static ssize_t kmsg_read(struct file * file, char * buf,
 			 size_t count, loff_t *ppos)
 {
+	if ((file->f_flags & O_NONBLOCK) && !do_syslog(9, 0, 0))
+		return -EAGAIN;
 	return do_syslog(2,buf,count);
 }
 

_

