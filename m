Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWKAXQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWKAXQT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWKAXQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:16:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:27290 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750975AbWKAXQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:16:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Cq8GOoKTUE+dSYydeSmrqd+Sfu4WEHs/1Jou/aS9PHFLX3N9z7l0m1jZQbKy4QfHjhMey8cSBsrECz+D9xgRSwDONfs8SCYpDbx9sMkgig1h8KeFOwreLZ6b3yrf0UtdCSVJhRwpAGzmxC/3y9ogkur2Rx1EuZZ2z6TNJTT8jKw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove pointless test of task == NULL from i386 dump_trace()
Date: Thu, 2 Nov 2006 00:17:58 +0100
User-Agent: KMail/1.9.4
Cc: Gareth Hughes <gareth@valinux.com>, Linus Torvalds <torvalds@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611020017.58897.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/i386/kernel/traps.c::dump_trace() there's a line that reads
  if (task && task != current)
but at the start of the function we have
  if (!task)
  	task = current;
So 'task' will never be NULL (since 'current' will never be NULL unless 
I'm very much mistaken). Which renders the test of 'task == NULL' utter 
pointless.

Removing the check should provide a microscopic speedup due to a saved 
cycle or two and in addition it certainly does save a few bytes of .text 
for traps.o  :  

before:
   text    data     bss     dec     hex filename
  11887    2284      52   14223    378f arch/i386/kernel/traps.o
after:
   text    data     bss     dec     hex filename
  11871    2284      52   14207    377f arch/i386/kernel/traps.o


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
index 00489b7..6355ce1 100644
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -214,7 +214,7 @@ void dump_trace(struct task_struct *task
 	if (!stack) {
 		unsigned long dummy;
 		stack = &dummy;
-		if (task && task != current)
+		if (task != current)
 			stack = (unsigned long *)task->thread.esp;
 	}
 

