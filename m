Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273814AbRIXGhh>; Mon, 24 Sep 2001 02:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273812AbRIXGh2>; Mon, 24 Sep 2001 02:37:28 -0400
Received: from [63.227.79.185] ([63.227.79.185]:9714 "EHLO
	marge.lubricants-oil.com") by vger.kernel.org with ESMTP
	id <S273813AbRIXGhR>; Mon, 24 Sep 2001 02:37:17 -0400
From: ddkilzer@theracingworld.com
Date: Mon, 24 Sep 2001 01:37:30 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ben Greear <greearb@candelatech.com>
Subject: Re: pre12 fails to compile: wakeup_bdflush issues
Message-ID: <20010924013730.A11591@lubricants-oil.com>
In-Reply-To: <3BAA2BA8.34873B27@candelatech.com> <20010920.113037.59650292.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010920.113037.59650292.davem@redhat.com>; from davem@redhat.com on Thu, Sep 20, 2001 at 13:30:37 EST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about the other two calls to wakeup_bdflush(0) in 
drivers/char/sysrq.c?  Should they be fixed using the patch below?

Dave


--- drivers/char/sysrq.c.orig	Sun Sep 23 17:24:55 2001
+++ drivers/char/sysrq.c	Mon Sep 24 01:11:07 2001
@@ -32,7 +32,6 @@
 
 #include <asm/ptrace.h>
 
-extern void wakeup_bdflush(int);
 extern void reset_vc(unsigned int);
 extern struct list_head super_blocks;
 
@@ -221,7 +220,7 @@
 static void sysrq_handle_sync(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	emergency_sync_scheduled = EMERG_SYNC;
-	wakeup_bdflush(0);
+	wakeup_bdflush();
 }
 static struct sysrq_key_op sysrq_sync_op = {
 	handler:	sysrq_handle_sync,
@@ -232,7 +231,7 @@
 static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	emergency_sync_scheduled = EMERG_REMOUNT;
-	wakeup_bdflush(0);
+	wakeup_bdflush();
 }
 static struct sysrq_key_op sysrq_mountro_op = {
 	handler:	sysrq_handle_mountro,


On Thu, Sep 20, 2001 at 13:30:37 EST, David S. Miller wrote:

>    From: Ben Greear <greearb@candelatech.com>
>    Date: Thu, 20 Sep 2001 10:47:20 -0700
> 
>    I get this error:
>    
>    sysrq.c:35: conflicting types for 'wakeup_bdflush'
>    /root/linux/include/linux/fs.h:1347: previous declaration of 'wakeup_bdflush'
>    
>    One says it takes a void argument, the other an int......
> 
> The fix is simple:
> 
> --- drivers/char/sysrq.c.~1~ Wed Sep 19 14:30:53 2001
> +++ drivers/char/sysrq.c Thu Sep 20 11:29:30 2001
> @@ -32,7 +32,6 @@
>  
>  #include <asm/ptrace.h>
>  
> -extern void wakeup_bdflush(int);
>  extern void reset_vc(unsigned int);
>  extern struct list_head super_blocks;
>  

