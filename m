Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312634AbSCZSCN>; Tue, 26 Mar 2002 13:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312643AbSCZSCE>; Tue, 26 Mar 2002 13:02:04 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:62094 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312634AbSCZSBy>;
	Tue, 26 Mar 2002 13:01:54 -0500
Message-ID: <3CA0B784.6050809@us.ibm.com>
Date: Tue, 26 Mar 2002 10:01:40 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: agx@sigxcpu.org
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: indydog driver race
Content-Type: multipart/mixed;
 boundary="------------060709040603040401070508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060709040603040401070508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

indydog_open has a race

indydog_open(struct inode *inode, struct file *file)
{
         if( indydog_alive )
		return -EBUSY;	
	...
	 indydog_alive = 1;
         return 0;
}

If 2 opens happen simultaneously, there can be 2 tasks which both see 
indydog_alive as 0 and both set it to 1, successfully opening the 
device.  Block and char devices hold the BKL before calling the driver's 
open function, but misc devices don't do the same.

The BKL is not needed in the release function, as far as I can see. 
Alan's softdog.c driver uses atomic ops without BKL to do the same thing 
as your driver.  Patch to fix attached.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------060709040603040401070508
Content-Type: text/plain;
 name="indydog.bklfix.2.4.19-pre4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="indydog.bklfix.2.4.19-pre4.patch"

--- linux-2.4.19-pre4-clean/drivers/char/indydog.c	Tue Mar  5 15:19:28 2002
+++ linux/drivers/char/indydog.c	Tue Mar 26 09:38:32 2002
@@ -24,7 +24,7 @@
 #include <asm/uaccess.h>
 #include <asm/sgi/sgimc.h>
 
-static int indydog_alive;
+static unsigned long indydog_alive;
 static struct sgimc_misc_ctrl *mcmisc_regs; 
 
 static void indydog_ping()
@@ -41,7 +41,7 @@
 {
 	u32 mc_ctrl0;
 	
-	if(indydog_alive)
+	if( test_and_set_bit(0,&indydog_alive) )
 		return -EBUSY;
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 	MOD_INC_USE_COUNT;
@@ -55,7 +55,6 @@
 	mcmisc_regs->cpuctrl0 = mc_ctrl0;
 	indydog_ping();
 			
-	indydog_alive=1;
 	printk("Started watchdog timer.\n");
 	return 0;
 }
@@ -66,7 +65,6 @@
 	 *	Shut off the timer.
 	 * 	Lock it in if it's a module and we defined ...NOWAYOUT
 	 */
-	 lock_kernel();
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
 	{
 	u32 mc_ctrl0 = mcmisc_regs->cpuctrl0; 
@@ -75,8 +73,7 @@
 	printk("Stopped watchdog timer.\n");
 	}
 #endif
-	indydog_alive=0;
-	unlock_kernel();
+	clear_bit(0,&indydog_alive);
 	return 0;
 }
 

--------------060709040603040401070508--

