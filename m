Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbUEAXLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUEAXLc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 19:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUEAXLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 19:11:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:33950 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262579AbUEAXLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 19:11:19 -0400
Date: Sat, 1 May 2004 16:10:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: bunk@fs.tum.de, eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-Id: <20040501161035.67205a1f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<408F9BD8.8000203@eyal.emu.id.au>
	<20040501201342.GL2541@fs.tum.de>
	<Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Sat, 1 May 2004, Adrian Bunk wrote:
> > 
> > It seems the DVB updates broke this.
> > 
> > Please _undo_ the patch below.
> 
> No, there's something wrong. Nobody should use a global "errno" variable, 
> and we should fix the real bug (it's probably some buggy system call 
> "interface" function that is being used).
> 
> Can somebody who sees this problem please try to figure out where the 
> buggy user of "errno" is?

It's using open() and lseek(), via KERNEL_SYSCALLS.

Maybe we should change __syscall_return() to return the -ve errno rather
than -1?


diff -puN include/asm-i386/unistd.h~a include/asm-i386/unistd.h
--- 25/include/asm-i386/unistd.h~a	2004-05-01 16:09:35.115389384 -0700
+++ 25-akpm/include/asm-i386/unistd.h	2004-05-01 16:09:49.513200584 -0700
@@ -295,10 +295,6 @@
 
 #define __syscall_return(type, res) \
 do { \
-	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
-		errno = -(res); \
-		res = -1; \
-	} \
 	return (type) (res); \
 } while (0)
 

_

