Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311206AbSCPXh5>; Sat, 16 Mar 2002 18:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311205AbSCPXhr>; Sat, 16 Mar 2002 18:37:47 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:50703 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S311198AbSCPXhh>; Sat, 16 Mar 2002 18:37:37 -0500
X-mailer: xrn 8.03-beta-26
From: Paul Menage <pmenage@ensim.com>
Subject: Re: [PATCH] Speedup SMP kernel on UP box
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel@vger.kernel.org
X-Newsgroups: 
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D238DE0@nasdaq.ms.ensim.com>
Message-Id: <E16mNjq-0002xW-00@pmenage-dt.ensim.com>
Date: Sat, 16 Mar 2002 15:37:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D238DE0@nasdaq.ms.ensim.com>,
you write:
>@@ -9,9 +9,15 @@
>  */
> 
> #ifdef CONFIG_SMP
>-#define LOCK "lock ; "
>+#define LOCK "\n1:\tlock ; "
>+#define LOCK_ADDR	"\n" \
>+			".section .lock.init,\"a\"\n\t" \
>+			".align 4\n\t" \
>+			".long 1b\n" \
>+			".previous\n"


Why not do:

#define LOCK "1: lock ; \n" \
	 	".section .lock.init,\"a\"\n" \
		".align 4\n"\
		".long 1b\n"\
		".previous\n" 

Then you don't need the LOCK_ADDR macro, so most of atomic.h can be
left as is. The assembler doesn't seem to care that there's a section
change between the lock prefix and the instruction that it's locking.

Paul
