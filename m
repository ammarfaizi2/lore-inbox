Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbUCJQBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbUCJQBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:01:16 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:34768 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262673AbUCJQBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:01:09 -0500
Message-ID: <404F3BC3.2090906@acm.org>
Date: Wed, 10 Mar 2004 10:01:07 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Davis, Todd C" <todd.c.davis@intel.com>
Subject: Re: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
References: <20040307223221.0f2db02e.akpm@osdl.org> <20040309013917.GH14833@fs.tum.de>
In-Reply-To: <20040309013917.GH14833@fs.tum.de>
Content-Type: multipart/mixed;
 boundary="------------050509040001070001080109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050509040001070001080109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

You need to run off the panic events, the config flag IPMI_PANIC_EVENT, 
and it should compile fine.  This is a flag that causes the driver to 
put some information about the panic into an event log in the IPMI 
controller so it can be fetched later.

To do this, the driver needs a way to run each operation to completion 
without scheduling, interrupts. or the like.  It needs this to do send 
the panic event (since you cannot schedule during a panic), although it 
also really needs it to do things like extend the watchdog timer time at 
panic time.  The I2C driver does not currently have this, so it doesn't 
work with this option and the SMBus driver.

I have included a patch from Todd Davis at Intel that adds this function 
to the I2C driver.  I believe Todd has been working on getting this in 
through the I2C driver writers, although the patch is fairly non-intrusive.

However, I have no real way to test this patch.

-Corey

Adrian Bunk wrote:

>On Sun, Mar 07, 2004 at 10:32:21PM -0800, Andrew Morton wrote:
>  
>
>>... 
>>+ipmi-updates-3.patch
>>+ipmi-socket-interface.patch
>>
>> IPMI driver updates
>>...
>>    
>>
>
>This causes the following compile error:
>
><--  snip  -->
>
>...
>  CC      drivers/char/ipmi/ipmi_smb.o
>drivers/char/ipmi/ipmi_smb.c: In function `smbus_client_read_block_data':
>drivers/char/ipmi/ipmi_smb.c:224: warning: implicit declaration of 
>function `i2c_set_spin_delay'
>...
>  LD      .tmp_vmlinux1
>drivers/built-in.o(.text+0x1342eb): In function 
>`smbus_client_read_block_data':
>: undefined reference to `i2c_set_spin_delay'
>drivers/built-in.o(.text+0x13448d): In function 
>`smbus_client_write_block_data':
>: undefined reference to `i2c_set_spin_delay'
>drivers/built-in.o(.text+0x134b7f): In function `set_run_to_completion':
>: undefined reference to `i2c_set_spin_delay'
>make: *** [.tmp_vmlinux1] Error 1
>
><--  snip  -->
>
>
>cu
>Adrian
>
>  
>


--------------050509040001070001080109
Content-Type: text/plain;
 name="linux-ipmi-2.6.3-i2c-spin.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-ipmi-2.6.3-i2c-spin.diff"

--- linux-v31/drivers/i2c/i2c-core.c	2004-02-19 19:31:07.000000000 -0600
+++ linux/drivers/i2c/i2c-core.c	2004-03-10 09:48:08.000000000 -0600
@@ -1256,6 +1256,12 @@
 	return (func & adap_func) == func;
 }
 
+int i2c_spin_delay;
+void i2c_set_spin_delay(int val)
+{
+	i2c_spin_delay = val;
+}
+
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
@@ -1292,6 +1298,8 @@
 
 EXPORT_SYMBOL(i2c_get_functionality);
 EXPORT_SYMBOL(i2c_check_functionality);
+EXPORT_SYMBOL(i2c_set_spin_delay);
+EXPORT_SYMBOL(i2c_spin_delay);
 
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
--- linux-v31/include/linux/i2c.h	2003-12-17 20:58:16.000000000 -0600
+++ linux/include/linux/i2c.h	2004-03-10 09:47:21.000000000 -0600
@@ -600,10 +600,24 @@
         ((adapptr)->algo->id == I2C_ALGO_ISA)
 
 /* Tiny delay function used by the i2c bus drivers */
+
+extern void i2c_set_spin_delay(int val);
+extern int i2c_spin_delay;
+#include <asm/delay.h>
 static inline void i2c_delay(signed long timeout)
 {
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(timeout);
+	if( i2c_spin_delay ) {
+		/* spin delay is needed for panic threads and
+		   shutdowns to avoid processing switching so IPMI
+		   messages can be sent to the Baseboard Management
+		   Controllers on the SMBus*/
+		int i;
+		for( i=0 ; i<100 ; i++ )
+			udelay(timeout*(1000000/HZ/100));
+	} else {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(timeout);
+	}
 }
 
 #endif /* _LINUX_I2C_H */

--------------050509040001070001080109--

