Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWAUVDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWAUVDT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWAUVDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:03:19 -0500
Received: from flock1.newmail.ru ([212.48.140.157]:37330 "HELO
	flock1.newmail.ru") by vger.kernel.org with SMTP id S932255AbWAUVDS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:03:18 -0500
From: Andrey Borzenkov <arvidjaar@newmail.ru>
To: Rudolf Marek <r.marek@sh.cvut.cz>
Subject: Re: [lm-sensors] 2.6.15: lm90 0-004c: Register 0x13 read failed (-1)
Date: Sun, 22 Jan 2006 00:02:43 +0300
User-Agent: KMail/1.9.1
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org, klingler@newtec.de
References: <200601142223.35838.arvidjaar@newmail.ru> <200601162240.09985.arvidjaar@newmail.ru> <43CC0D7B.4090309@sh.cvut.cz>
In-Reply-To: <43CC0D7B.4090309@sh.cvut.cz>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601220002.44702.arvidjaar@newmail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 17 January 2006 00:17, Rudolf Marek wrote:
> Hello all,
>
> > Actually it did. I realized that 15x3 you sent attempted recovery while
> > current 1535 not. After some experiments I came up with this patch (it is
> > not meant for inclusion but only for discussion) that seems to work. I
> > had hard rime finding the exact place where to retry command but now I
> > get
> >
> > so it appears to recover nicely. Does it look like it returns correct
> > value after retry?
>
> This can be possible. I may know why this is happening. I have now the
> datasheets for both ali 1535 and 15x3.

Any chance I can see it (for 1535)?

> I found that there are special bits 
> that are used to control somehow when bus is considered idle.
>
> Those bits are in PCI config space of same device as the smbus base addr
> is.
>
> For the ali 15x3 the register is located at 0xe2 and bits are:
>
> Bit        Description
> 7-5 (001b) SMB Clock Select.
>            [7:5] : "clock"
>            000 :     149K
>            001 :     74K (recommended)
>            010 :      37K
>            100 :     223K
>            101 :     111K
>            110 :     55K
>            These three bits are used to select the base clock for internal
> state machine. All the timings will be based on this clock. The clock is
> derived from OSC14M. 4-3 (0h)   Idle Delay Setting.
>            [4:3] :   "idle time"
>            00 :       BaseClk*64 53.76 us ref. 1.19M base clock. (default)
>            01 :       BaseClk*32
>            10 :       BaseClk*128
>            Others : Reserved
>            These two bits are used to decide the idle time to qualify SMBus
> is in idle state. The time is calculated based on the base clock defined in
> bits[7:5]. 2-0 (0h)   Reserved.
>
> For the 1535 is the register offset 0xF2
>
> Bit       Description
> 7-5 (001) The base clock referenced by the SMB host controller.
>           000: 149K.
>           001: 74K.
>           010: 31K.
>           100: 223K.
>           101: 111K.
>           110: 55K.
> 4-3       Bus Delay Timer Setting. The base clock is set in the previous
> field. This timer decides when the SMB bus is actually idle.
>           00: Base Clock × 4.
>           01: Base Clock × 2.
>           10: Base Clock × 8.
>           11: Reserved.
> 2-0       Reserved.
>
> What is interresting both drivers sets this to 0x20, overwriting two
> reserved bits - this is no good.

Fixed in attached patch.

> /* set SMB clock to 74KHz as recommended 
> in data sheet */
>         pci_write_config_byte(dev, SMBCLK, 0x20);
>
> Andrey and Claudio,
> please can you send back output of lscpi -d 10b9:7101 -x -x -x  before you
> load the ali driver?
>

It is exactly 0x20 as set by driver anyway.

> Also you both can try to change the delay a bit, after the driver loads (or
> kill the above line that sets it).
>
> for andrey (1535):  setpci -d 10b9:7101 f2.b=28
> (this should set it to base*8)
>

This did not completely eliminated problems but made them far less frequent 
then before. Combining with patch below it results in something like:

i2c_adapter i2c-0: Error: adapter did not idle after transaction
i2c_adapter i2c-0: adapter not idle before command; retrying
i2c_adapter i2c-0: adapter not idle before command; retrying
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Adapter hung, retrying after reset
i2c_adapter i2c-0: Error: adapter did not idle after transaction
i2c_adapter i2c-0: adapter not idle before command; retrying
i2c_adapter i2c-0: adapter not idle before command; retrying
i2c_adapter i2c-0: adapter not idle before command; retrying
i2c_adapter i2c-0: Failed to execute command after 3 retries status: 00
lm90 0-004c: Register 0x1 read failed (-1)
i2c_adapter i2c-0: adapter not idle before command; retrying
i2c_adapter i2c-0: adapter not idle before command; retrying
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Adapter hung, retrying after reset

So sometimes it still could not be recovered. Unfortunately I cannot do much 
at this stage without having data sheet, as everything else is just a 
guesswork.

> I guess best would be to to emit some kind of error after all retries, but
> question is how to do it cleanly.
>

below is peroposed patch. After it has been sufficiently dicussed and tested I 
intend to replace most of dev_{err,info,warn} in retry path with dev_dbg and 
leave only one message after retry failed. Could you comment on it now you 
have datasheet? Is there better way to reset adapter after error?

regards

- -andrey 


Subject: [PATCH] ali1535 error recovery cleanup, PCI config fix

- - fix interpretation of BUSY flag. Old code apparently assumed it was
  asserted during transaction was active. My test shows it is asserted
  in response to transaction start command if it could not be initiated
  sucessfully

- - introduced retry logic. If transaction did not complete, retry. Same goes
  for waiting for idle condition. Number of retries is rather arbitrary.

- - preseve reserved bits in PCI config byte f2 (clock timing), suggested
  by Rudolf Marek

- - set bus delay multiplier to x8, suggested by Rudolf Marek

- - restructured overall code; after that is actually became very similar
  to patch for ali15x3 from Claudion Klinger, except I try to insure
  adapter is in sane state before command is started

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>

- ---

 drivers/i2c/busses/i2c-ali1535.c |  203 
++++++++++++++++++++------------------
 1 files changed, 109 insertions(+), 94 deletions(-)

10f6fcf00b69ea2861eb2321e2f4d204a9fcfa2c
diff --git a/drivers/i2c/busses/i2c-ali1535.c 
b/drivers/i2c/busses/i2c-ali1535.c
index 3eb4789..ae48573 100644
- --- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -50,7 +50,6 @@
     This driver does not use interrupts.
 */
 
- -
 /* Note: we assume there can only be one ALI1535, with one SMBus interface */
 
 #include <linux/module.h>
@@ -86,6 +85,9 @@
 
 /* Other settings */
 #define MAX_TIMEOUT		500	/* times 1/100 sec */
+#define MAX_RETRIES		3	/* times to retry hung transaction */
+#define STATUS_SET		1
+#define STATUS_UNSET		0
 #define ALI1535_SMB_IOSIZE	32
 
 #define ALI1535_SMB_DEFAULTBASE	0x8040
@@ -138,6 +140,22 @@ static struct pci_driver ali1535_driver;
 static unsigned short ali1535_smba;
 static DECLARE_MUTEX(i2c_ali1535_sem);
 
+static inline s32 ali1535_wait_for_status(int set, int status)
+{
+	int timeout = 0;
+	int temp = 0;
+
+	/* clear status register (clear-on-write) */
+	outb_p(0xFF, SMBHSTSTS);
+	do {
+		msleep(1);
+		timeout += 1;
+		temp = inb_p(SMBHSTSTS);
+	} while (!!(temp & status) != set && timeout <= MAX_TIMEOUT);
+
+	return temp;
+}
+
 /* Detect whether a ALI1535 can be found, and initialize it, where necessary.
    Note the differences between kernels with the old PCI BIOS interface and
    newer kernels with the real PCI interface. In compat.h some things are
@@ -184,7 +202,11 @@ static int ali1535_setup(struct pci_dev 
 	}
 
 	/* set SMB clock to 74KHz as recommended in data sheet */
- -	pci_write_config_byte(dev, SMBCLK, 0x20);
+	/* set bus delay multiplier to x8 as suggested by Rudolf Marek
+	 * also preserve reserved bits (also from Rudolf Marek)
+	 */
+	pci_read_config_byte(dev, SMBCLK, &temp);
+	pci_write_config_byte(dev, SMBCLK, (temp & 3) | 0x28);
 
 	/*
 	  The interrupt routing for SMB is set up in register 0x77 in the
@@ -210,83 +232,18 @@ static int ali1535_transaction(struct i2
 {
 	int temp;
 	int result = 0;
- -	int timeout = 0;
 
 	dev_dbg(&adap->dev, "Transaction (pre): STS=%02x, TYP=%02x, "
 		"CMD=%02x, ADD=%02x, DAT0=%02x, DAT1=%02x\n",
 		inb_p(SMBHSTSTS), inb_p(SMBHSTTYP), inb_p(SMBHSTCMD),
 		inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
 
- -	/* get status */
- -	temp = inb_p(SMBHSTSTS);
- -
- -	/* Make sure the SMBus host is ready to start transmitting */
- -	/* Check the busy bit first */
- -	if (temp & ALI1535_STS_BUSY) {
- -		/* If the host controller is still busy, it may have timed out
- -		 * in the previous transaction, resulting in a "SMBus Timeout"
- -		 * printk.  I've tried the following to reset a stuck busy bit.
- -		 *   1. Reset the controller with an KILL command. (this
- -		 *      doesn't seem to clear the controller if an external
- -		 *      device is hung)
- -		 *   2. Reset the controller and the other SMBus devices with a
- -		 *      T_OUT command. (this clears the host busy bit if an
- -		 *      external device is hung, but it comes back upon a new
- -		 *      access to a device)
- -		 *   3. Disable and reenable the controller in SMBHSTCFG. Worst
- -		 *      case, nothing seems to work except power reset.
- -		 */
- -
- -		/* Try resetting entire SMB bus, including other devices - This
- -		 * may not work either - it clears the BUSY bit but then the
- -		 * BUSY bit may come back on when you try and use the chip
- -		 * again.  If that's the case you are stuck.
- -		 */
- -		dev_info(&adap->dev,
- -			"Resetting entire SMB Bus to clear busy condition (%02x)\n",
- -			temp);
- -		outb_p(ALI1535_T_OUT, SMBHSTTYP);
- -		temp = inb_p(SMBHSTSTS);
- -	}
- -
- -	/* now check the error bits and the busy bit */
- -	if (temp & (ALI1535_STS_ERR | ALI1535_STS_BUSY)) {
- -		/* do a clear-on-write */
- -		outb_p(0xFF, SMBHSTSTS);
- -		if ((temp = inb_p(SMBHSTSTS)) &
- -		    (ALI1535_STS_ERR | ALI1535_STS_BUSY)) {
- -			/* This is probably going to be correctable only by a
- -			 * power reset as one of the bits now appears to be
- -			 * stuck */
- -			/* This may be a bus or device with electrical problems. */
- -			dev_err(&adap->dev,
- -				"SMBus reset failed! (0x%02x) - controller or "
- -				"device on bus is probably hung\n", temp);
- -			return -1;
- -		}
- -	} else {
- -		/* check and clear done bit */
- -		if (temp & ALI1535_STS_DONE) {
- -			outb_p(temp, SMBHSTSTS);
- -		}
- -	}
- -
 	/* start the transaction by writing anything to the start register */
 	outb_p(0xFF, SMBHSTPORT);
 
 	/* We will always wait for a fraction of a second! */
- -	timeout = 0;
- -	do {
- -		msleep(1);
- -		temp = inb_p(SMBHSTSTS);
- -	} while (((temp & ALI1535_STS_BUSY) && !(temp & ALI1535_STS_IDLE))
- -		 && (timeout++ < MAX_TIMEOUT));
- -
- -	/* If the SMBus is still busy, we give up */
- -	if (timeout >= MAX_TIMEOUT) {
- -		result = -1;
- -		dev_err(&adap->dev, "SMBus Timeout!\n");
- -	}
+	temp = ali1535_wait_for_status(STATUS_SET,
+			ALI1535_STS_ERR | ALI1535_STS_DONE | ALI1535_STS_BUSY);
 
 	if (temp & ALI1535_STS_FAIL) {
 		result = -1;
@@ -311,9 +268,16 @@ static int ali1535_transaction(struct i2
 	}
 
 	/* check to see if the "command complete" indication is set */
- -	if (!(temp & ALI1535_STS_DONE)) {
- -		result = -1;
- -		dev_err(&adap->dev, "Error: command never completed\n");
+	if (!result) {
+		if (temp & ALI1535_STS_BUSY) {
+			result = -2;
+			dev_err(&adap->dev, "Error: adapter busy\n");
+		} else if (!(temp & ALI1535_STS_DONE)) {
+			result = -2;
+			dev_err(&adap->dev, "Error: command never completed\n");
+		}
+		if (!(temp & ALI1535_STS_IDLE))
+			dev_err(&adap->dev, "Error: adapter did not idle after transaction\n");
 	}
 
 	dev_dbg(&adap->dev, "Transaction (post): STS=%02x, TYP=%02x, "
@@ -321,41 +285,83 @@ static int ali1535_transaction(struct i2
 		inb_p(SMBHSTSTS), inb_p(SMBHSTTYP), inb_p(SMBHSTCMD),
 		inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
 
- -	/* take consequent actions for error conditions */
- -	if (!(temp & ALI1535_STS_DONE)) {
- -		/* issue "kill" to reset host controller */
- -		outb_p(ALI1535_KILL,SMBHSTTYP);
- -		outb_p(0xFF,SMBHSTSTS);
- -	} else if (temp & ALI1535_STS_ERR) {
- -		/* issue "timeout" to reset all devices on bus */
- -		outb_p(ALI1535_T_OUT,SMBHSTTYP);
- -		outb_p(0xFF,SMBHSTSTS);
- -	}
- -
 	return result;
 }
 
+static void ali1535_reset(struct i2c_adapter *adap)
+{
+	int temp = inb_p(SMBHSTSTS);
+
+	dev_dbg(&adap->dev, "reset(pre): STS=%02x\n", temp);
+
+	/* If the host controller is still busy, it may have timed out
+	 * in the previous transaction, resulting in a "SMBus Timeout"
+	 * printk.  I've tried the following to reset a stuck busy bit.
+	 *   1. Reset the controller with an KILL command. (this
+	 *      doesn't seem to clear the controller if an external
+	 *      device is hung)
+	 *   2. Reset the controller and the other SMBus devices with a
+	 *      T_OUT command. (this clears the host busy bit if an
+	 *      external device is hung, but it comes back upon a new
+	 *      access to a device)
+	 *   3. Disable and reenable the controller in SMBHSTCFG. Worst
+	 *      case, nothing seems to work except power reset.
+	 */
+
+	/* Try resetting entire SMB bus, including other devices - This
+	 * may not work either - it clears the BUSY bit but then the
+	 * BUSY bit may come back on when you try and use the chip
+	 * again.  If that's the case you are stuck.
+	 */
+
+	if ((temp & ALI1535_STS_ERR) || !(temp & ALI1535_STS_IDLE))
+		outb_p(ALI1535_T_OUT, SMBHSTTYP);
+	else if (!(temp & ALI1535_STS_DONE))
+		outb_p(ALI1535_KILL, SMBHSTTYP);
+
+	dev_dbg(&adap->dev, "reset(post): STS=%02x\n", inb_p(SMBHSTSTS));
+}
+
+static inline s32 ali1535_wait_for_idle(struct i2c_adapter *adap)
+{
+	int temp;
+
+	temp = inb_p(SMBHSTSTS);
+
+	dev_dbg(&adap->dev, "wait_for_idle(pre): STS=%02x\n", temp);
+
+	temp = ali1535_wait_for_status(STATUS_SET, ALI1535_STS_IDLE);
+
+	dev_dbg(&adap->dev, "wait_for_idle(post): STS=%02x\n", temp);
+
+	return !(temp & ALI1535_STS_IDLE);
+}
+
 /* Return -1 on error. */
 static s32 ali1535_access(struct i2c_adapter *adap, u16 addr,
 			  unsigned short flags, char read_write, u8 command,
 			  int size, union i2c_smbus_data *data)
 {
 	int i, len;
- -	int temp;
- -	int timeout;
 	s32 result = 0;
+	int retry = 0;
 
 	down(&i2c_ali1535_sem);
+retry:
+	if (retry >= MAX_RETRIES) {
+		dev_err(&adap->dev, "Failed to execute command after %d retries"
+			" status: %02x\n", MAX_RETRIES, inb_p(SMBHSTSTS));
+		result = -1;
+		goto EXIT;
+	}
+
 	/* make sure SMBus is idle */
- -	temp = inb_p(SMBHSTSTS);
- -	for (timeout = 0;
- -	     (timeout < MAX_TIMEOUT) && !(temp & ALI1535_STS_IDLE);
- -	     timeout++) {
- -		msleep(1);
- -		temp = inb_p(SMBHSTSTS);
+	if (ali1535_wait_for_idle(adap)) {
+		dev_warn(&adap->dev, "adapter not idle before command; retrying\n");
+		retry++;
+		ali1535_reset(adap);
+		goto retry;
 	}
- -	if (timeout >= MAX_TIMEOUT)
- -		dev_warn(&adap->dev, "Idle wait Timeout! STS=0x%02x\n", temp);
 
 	/* clear status register (clear-on-write) */
 	outb_p(0xFF, SMBHSTSTS);
@@ -424,7 +430,16 @@ static s32 ali1535_access(struct i2c_ada
 		break;
 	}
 
- -	if (ali1535_transaction(adap)) {
+	if ((result = ali1535_transaction(adap)) == -2) {
+		/* Adapter hung and was reset; retry */
+		dev_err(&adap->dev, "Adapter hung, retrying after reset\n");
+		result = 0;
+		retry++;
+		ali1535_reset(adap);
+		goto retry;
+	}
+
+	if (result) {
 		/* Error in transaction */
 		result = -1;
 		goto EXIT;
- -- 
1.1.3
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0qF0R6LMutpd94wRAqJZAKCGgz7BKIZBsZFZWy4xUdPnidt3AgCfRrA9
3vT8vnL7YWJf2iOGBF1I9RI=
=ZFOW
-----END PGP SIGNATURE-----
