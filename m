Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129071AbRBTATQ>; Mon, 19 Feb 2001 19:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129084AbRBTATG>; Mon, 19 Feb 2001 19:19:06 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:57349 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129071AbRBTAS4>; Mon, 19 Feb 2001 19:18:56 -0500
Date: Mon, 19 Feb 2001 16:18:40 -0800
Message-Id: <200102200018.f1K0IeC32394@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Dragan Stancevic <visitor@valinux.com>,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: eepro100 + 2.2.18 + laptop problems
In-Reply-To: <20010219144935.D21425@saw.sw.com.sg>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001 14:49:35 -0800, Andrey Savochkin <saw@saw.sw.com.sg> wrote:

> On Tue, Feb 20, 2001 at 09:21:06AM +1100, CaT wrote:
>> 
>> It happened again. Same deal. Once was after a reboot and this time
>> was after a resume. :/
> 
> In my experiments wait_for_cmd timeouts almost always were related to
> DumpStats command.
> I think, we need to investigate what time constraints are related to this
> command.

Nothing documented...

CaT, can you apply this debugging patch and let us know what you get in the
logs? It should allow us to pinpoint the error a bit more precisely.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
------------------------------------------
--- /mnt/3/linux-2.2.19pre/drivers/net/eepro100.c	Thu Feb 15 16:09:19 2001
+++ linux-2.2.18/drivers/net/eepro100.c	Mon Feb 19 16:13:45 2001
@@ -368,9 +368,16 @@
 #define outl writel
 #endif
 
+static char *cmdwait_string = "wait_for_cmd_done timed out at %s:%d\n";
+#define wait_for_cmd_done(ioaddr) \
+  do { \
+    if (do_wait_for_cmd_done(ioaddr)) \
+	  printk(cmdwait_string, __FUNCTION__, __LINE__); \
+  } while (0)
+
 /* How to wait for the command unit to accept a command.
    Typically this takes 0 ticks. */
-static inline void wait_for_cmd_done(long cmd_ioaddr)
+static inline int do_wait_for_cmd_done(long cmd_ioaddr)
 {
 	int wait = 20000;
 	char cmd_reg1, cmd_reg2;
@@ -383,10 +390,10 @@
 		if(cmd_reg2){
 			printk(KERN_ALERT "eepro100: cmd_wait for(%#2.2x) timedout with(%#2.2x)!\n",
 				cmd_reg1, cmd_reg2);
-		
+			return 1;
 		}
 	}
-
+	return 0;
 }
 
 /* Offsets to the various registers.
