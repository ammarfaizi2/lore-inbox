Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVBXPKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVBXPKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVBXPJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:09:02 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:19924 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262395AbVBXPDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:03:46 -0500
Message-ID: <421DECCF.8080203@acm.org>
Date: Thu, 24 Feb 2005 09:03:43 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Mickey Stein <yekkim@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c.h: Fix another gcc 4.0 compile failure
References: <42177048.2000109@pacbell.net> <20050219223711.GB12713@kroah.com> <4218AF68.3010500@pacbell.net> <20050223175251.GM13081@kroah.com>
In-Reply-To: <20050223175251.GM13081@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------050003010108070200020401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050003010108070200020401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg, Mickey,

Since I already some of this patch done in the stuff I was working on, I 
finished it out.  Here's a patch that cleans up all of them and a few 
other small things I found.

-Corey

Greg KH wrote:

>On Sun, Feb 20, 2005 at 07:40:24AM -0800, Mickey Stein wrote:
>  
>
>>Greg KH wrote:
>>
>>    
>>
>>>On Sat, Feb 19, 2005 at 08:58:48AM -0800, Mickey Stein wrote:
>>>
>>>
>>>      
>>>
>>>>From: Mickey Stein
>>>>Versions:   linux-2.6.11-rc4-bk7, gcc4 (GCC) 4.0.0 20050217 (latest fc 
>>>>rawhide from 19Feb DL)
>>>>
>>>>gcc4 cvs seems to dislike "include/linux/i2c.h file":
>>>>
>>>>Error msg:   include/linux/i2c.h:{55,194} error: array type has 
>>>>incomplete element type
>>>>
>>>>A. Daplas has recently done a workaround for this on another header 
>>>>file. A thread discussing this
>>>>can be found by following the link below:
>>>>
>>>>http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html
>>>>
>>>>The patch changes the array declaration from "struct x y[]" format to 
>>>>"struct x *y".
>>>>I realize its only a workaround, but the gcc guys seem to be aware of 
>>>>this.
>>>>** Note: I'm a noob at this, so feel free to make chopped liver out of 
>>>>this if its incorrect.
>>>>patch below is also attached since I'm not sure formatting survives 
>>>>the cut&paste.
>>>>  
>>>>
>>>>        
>>>>
>>>The patch looks sane, but before I apply it, care to also fix up all of
>>>the function pointers that are affected by this patch?  Also the
>>>i2c_transfer() function itself should be changed (not just the header
>>>file.)
>>>
>>>thanks,
>>>
>>>greg k-h
>>>
>>>
>>>
>>>      
>>>
>>Greg,
>>
>>I took a look for other references similar to those in my first take at 
>>this and found a couple more files.
>>Attached is another patch that hopefully addresses the all the similar 
>>cases.  I tried it on today's (-bk8) kernel,
>>with all i2c switches enabled.
>>    
>>
>
>What about the i2c drivers that implement the master_xfer function?  You
>will now have a bunch of compiler warnings if you build them with this
>patch, right?
>
>thanks,
>
>greg k-h
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


--------------050003010108070200020401
Content-Type: text/plain;
 name="i2c_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_cleanup.diff"

Clean up some general I2C things.  Convert all the msg[] in functions
to *msg, fix some grammar, put () around all the #defines that
are compound to avoid nasty side-effects, and convert some
initializations to C99 versions to make them more change-resistant.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc4/include/linux/i2c.h
===================================================================
--- linux-2.6.11-rc4.orig/include/linux/i2c.h
+++ linux-2.6.11-rc4/include/linux/i2c.h
@@ -55,7 +55,7 @@
 
 /* Transfer num messages.
  */
-extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],int num);
+extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num);
 
 /*
  * Some adapter types (i.e. PCF 8584 based ones) may support slave behaviuor. 
@@ -190,11 +190,11 @@
 	char name[32];				/* textual description 	*/
 	unsigned int id;
 
-	/* If an adapter algorithm can't to I2C-level access, set master_xfer
+	/* If an adapter algorithm can't do I2C-level access, set master_xfer
 	   to NULL. If an adapter algorithm can do SMBus access, set 
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
 	   using common I2C messages */
-	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg msgs[], 
+	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg *msgs, 
 	                   int num);
 	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr, 
 	                   unsigned short flags, char read_write,
@@ -423,22 +423,22 @@
 #define I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC  0x40000000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC 0x80000000 /* SMBus 2.0 */
 
-#define I2C_FUNC_SMBUS_BYTE I2C_FUNC_SMBUS_READ_BYTE | \
-                            I2C_FUNC_SMBUS_WRITE_BYTE
-#define I2C_FUNC_SMBUS_BYTE_DATA I2C_FUNC_SMBUS_READ_BYTE_DATA | \
-                                 I2C_FUNC_SMBUS_WRITE_BYTE_DATA
-#define I2C_FUNC_SMBUS_WORD_DATA I2C_FUNC_SMBUS_READ_WORD_DATA | \
-                                 I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BLOCK_DATA I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
-                                  I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
-#define I2C_FUNC_SMBUS_I2C_BLOCK I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
-                                  I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
-#define I2C_FUNC_SMBUS_I2C_BLOCK_2 I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
-                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2
-#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
-                                      I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC
-#define I2C_FUNC_SMBUS_WORD_DATA_PEC  I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
-                                      I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC
+#define I2C_FUNC_SMBUS_BYTE (I2C_FUNC_SMBUS_READ_BYTE | \
+                             I2C_FUNC_SMBUS_WRITE_BYTE)
+#define I2C_FUNC_SMBUS_BYTE_DATA (I2C_FUNC_SMBUS_READ_BYTE_DATA | \
+                                  I2C_FUNC_SMBUS_WRITE_BYTE_DATA)
+#define I2C_FUNC_SMBUS_WORD_DATA (I2C_FUNC_SMBUS_READ_WORD_DATA | \
+                                  I2C_FUNC_SMBUS_WRITE_WORD_DATA)
+#define I2C_FUNC_SMBUS_BLOCK_DATA (I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
+                                   I2C_FUNC_SMBUS_WRITE_BLOCK_DATA)
+#define I2C_FUNC_SMBUS_I2C_BLOCK (I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
+                                  I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)
+#define I2C_FUNC_SMBUS_I2C_BLOCK_2 (I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
+                                    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2)
+#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC (I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
+                                       I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC)
+#define I2C_FUNC_SMBUS_WORD_DATA_PEC  (I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
+                                       I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC)
 
 #define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
 #define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
@@ -447,14 +447,14 @@
 #define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
 #define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
 
-#define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \
-                            I2C_FUNC_SMBUS_BYTE | \
-                            I2C_FUNC_SMBUS_BYTE_DATA | \
-                            I2C_FUNC_SMBUS_WORD_DATA | \
-                            I2C_FUNC_SMBUS_PROC_CALL | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
-                            I2C_FUNC_SMBUS_I2C_BLOCK
+#define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
+                             I2C_FUNC_SMBUS_BYTE | \
+                             I2C_FUNC_SMBUS_BYTE_DATA | \
+                             I2C_FUNC_SMBUS_WORD_DATA | \
+                             I2C_FUNC_SMBUS_PROC_CALL | \
+                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
+                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
+                             I2C_FUNC_SMBUS_I2C_BLOCK)
 
 /* 
  * Data for SMBus Messages 
Index: linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-bit.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/algos/i2c-algo-bit.c
+++ linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-bit.c
@@ -466,7 +466,7 @@
 }
 
 static int bit_xfer(struct i2c_adapter *i2c_adap,
-		    struct i2c_msg msgs[], int num)
+		    struct i2c_msg *msgs, int num)
 {
 	struct i2c_msg *pmsg;
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
Index: linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-pcf.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/algos/i2c-algo-pcf.c
+++ linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-pcf.c
@@ -332,7 +332,7 @@
 }
 
 static int pcf_xfer(struct i2c_adapter *i2c_adap,
-		    struct i2c_msg msgs[], 
+		    struct i2c_msg *msgs, 
 		    int num)
 {
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
Index: linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-pca.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/algos/i2c-algo-pca.c
+++ linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-pca.c
@@ -178,7 +178,7 @@
 }
 
 static int pca_xfer(struct i2c_adapter *i2c_adap,
-                    struct i2c_msg msgs[],
+                    struct i2c_msg *msgs,
                     int num)
 {
         struct i2c_algo_pca_data *adap = i2c_adap->algo_data;
Index: linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-ite.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/algos/i2c-algo-ite.c
+++ linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-ite.c
@@ -600,7 +600,7 @@
  * verify that the bus is not busy or in some unknown state.
  */
 static int iic_xfer(struct i2c_adapter *i2c_adap,
-		    struct i2c_msg msgs[], 
+		    struct i2c_msg *msgs, 
 		    int num)
 {
 	struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
@@ -713,14 +713,11 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm iic_algo = {
-	"ITE IIC algorithm",
-	I2C_ALGO_IIC,
-	iic_xfer,		/* master_xfer	*/
-	NULL,				/* smbus_xfer	*/
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	iic_func,			/* functionality	*/
+	.name		= "ITE IIC algorithm",
+	.id		= I2C_ALGO_IIC,
+	.master_xfer	= iic_xfer,
+	.ioctl		= algo_control,
+	.functionality	= iic_func,
 };
 
 
Index: linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-sgi.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/algos/i2c-algo-sgi.c
+++ linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-sgi.c
@@ -131,7 +131,7 @@
 	return 0;
 }
 
-static int sgi_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[],
+static int sgi_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		    int num)
 {
 	struct i2c_algo_sgi_data *adap = i2c_adap->algo_data;
Index: linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-sibyte.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/algos/i2c-algo-sibyte.c
+++ linux-2.6.11-rc4/drivers/i2c/algos/i2c-algo-sibyte.c
@@ -136,14 +136,11 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm i2c_sibyte_algo = {
-	"SiByte algorithm",
-	I2C_ALGO_SIBYTE,
-	NULL,                           /* master_xfer          */
-	smbus_xfer,                   	/* smbus_xfer           */
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	bit_func,			/* functionality	*/
+	.name		= "SiByte algorithm",
+	.id		= I2C_ALGO_SIBYTE,
+	.smbus_xfer	= smbus_xfer,
+	.ioctl		= algo_control,
+	.functionality	= bit_func,
 };
 
 /* 
Index: linux-2.6.11-rc4/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/busses/i2c-mpc.c
+++ linux-2.6.11-rc4/drivers/i2c/busses/i2c-mpc.c
@@ -233,7 +233,7 @@
 	return length;
 }
 
-static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_msg *pmsg;
 	int i;
Index: linux-2.6.11-rc4/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/busses/i2c-s3c2410.c
+++ linux-2.6.11-rc4/drivers/i2c/busses/i2c-s3c2410.c
@@ -534,7 +534,7 @@
 */
 
 static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
-			struct i2c_msg msgs[], int num)
+			struct i2c_msg *msgs, int num)
 {
 	struct s3c24xx_i2c *i2c = (struct s3c24xx_i2c *)adap->algo_data;
 	int retry;
Index: linux-2.6.11-rc4/drivers/i2c/busses/i2c-au1550.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/busses/i2c-au1550.c
+++ linux-2.6.11-rc4/drivers/i2c/busses/i2c-au1550.c
@@ -253,7 +253,7 @@
 }
 
 static int
-au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
+au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_au1550_data *adap = i2c_adap->algo_data;
 	struct i2c_msg *p;
Index: linux-2.6.11-rc4/drivers/i2c/busses/i2c-iop3xx.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/busses/i2c-iop3xx.c
+++ linux-2.6.11-rc4/drivers/i2c/busses/i2c-iop3xx.c
@@ -361,7 +361,7 @@
  * master_xfer() - main read/write entry
  */
 static int 
-iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], 
+iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, 
 				int num)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
Index: linux-2.6.11-rc4/drivers/i2c/busses/i2c-keywest.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/busses/i2c-keywest.c
+++ linux-2.6.11-rc4/drivers/i2c/busses/i2c-keywest.c
@@ -399,7 +399,7 @@
  */
 static int
 keywest_xfer(	struct i2c_adapter *adap,
-		struct i2c_msg msgs[], 
+		struct i2c_msg *msgs, 
 		int num)
 {
 	struct keywest_chan* chan = i2c_get_adapdata(adap);
Index: linux-2.6.11-rc4/drivers/i2c/busses/i2c-ibm_iic.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/busses/i2c-ibm_iic.c
+++ linux-2.6.11-rc4/drivers/i2c/busses/i2c-ibm_iic.c
@@ -549,7 +549,7 @@
  * Generic master transfer entrypoint. 
  * Returns the number of processed messages or error (<0)
  */
-static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
     	struct ibm_iic_private* dev = (struct ibm_iic_private*)(i2c_get_adapdata(adap));
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
Index: linux-2.6.11-rc4/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-rc4/drivers/i2c/i2c-core.c
@@ -583,7 +583,7 @@
  * ----------------------------------------------------
  */
 
-int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg msgs[],int num)
+int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs,int num)
 {
 	int ret;
 
Index: linux-2.6.11-rc4/drivers/media/video/bttv-i2c.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/media/video/bttv-i2c.c
+++ linux-2.6.11-rc4/drivers/media/video/bttv-i2c.c
@@ -245,7 +245,7 @@
        	return retval;
 }
 
-static int bttv_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
+static int bttv_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 {
 	struct bttv *btv = i2c_get_adapdata(i2c_adap);
 	int retval = 0;

--------------050003010108070200020401--
