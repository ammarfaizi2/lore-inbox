Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWAPTkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWAPTkV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 14:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWAPTkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 14:40:20 -0500
Received: from flock1.newmail.ru ([212.48.140.157]:53679 "HELO
	flock1.newmail.ru") by vger.kernel.org with SMTP id S1751155AbWAPTkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 14:40:19 -0500
From: Andrey Borzenkov <arvidjaar@newmail.ru>
To: Rudolf Marek <r.marek@sh.cvut.cz>
Subject: Re: [lm-sensors] 2.6.15: lm90 0-004c: Register 0x13 read failed (-1)
Date: Mon, 16 Jan 2006 22:40:05 +0300
User-Agent: KMail/1.9.1
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
References: <200601142223.35838.arvidjaar@newmail.ru> <200601152248.07800.arvidjaar@newmail.ru> <43CAB1B7.6020903@sh.cvut.cz>
In-Reply-To: <43CAB1B7.6020903@sh.cvut.cz>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601162240.09985.arvidjaar@newmail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 January 2006 23:33, Rudolf Marek wrote:
> Well it seems this ali 15x3 has maybe same hardware bug? It was mentioned
> already here: http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=2030
>
[...]
> Since I dont own the motherboard with this chip (nor the datasheet) and the
> resulting driver was hard to read I just left this issue. I hope it can
> help now.

Actually it did. I realized that 15x3 you sent attempted recovery while 
current 1535 not. After some experiments I came up with this patch (it is not 
meant for inclusion but only for discussion) that seems to work. I had hard 
rime finding the exact place where to retry command but now I get

Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=10, CMD=01, ADD=99, DAT0=05, DAT1=10
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=14, 
TYP=10, CMD=01, ADD=99, DAT0=2c, DAT1=10
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04, 
TYP=10, CMD=10, ADD=98, DAT0=2c, DAT1=10
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Error: command never 
completed
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=04, 
TYP=10, CMD=10, ADD=98, DAT0=2c, DAT1=10
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Adapter hung, retrying after 
reset
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=00, 
TYP=00, CMD=10, ADD=98, DAT0=2c, DAT1=10
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=14, 
TYP=00, CMD=10, ADD=98, DAT0=2c, DAT1=10

so it appears to recover nicely. Does it look like it returns correct value 
after retry?

I intend to squash errors, leaving only the first occurence but making it more 
verbose. Probably:

Error: command never completed. It is probably hardware bug
Command will be retried after controller is reset
further occurences of this error won't be reported as long as retry is 
sucessful

is wording OK (I am not native english speaker)?

regards

- -andrey

- --- linux-2.6.15/drivers/i2c/busses/i2c-ali1535.c	2006-01-03 
06:21:10.000000000 +0300
+++ i2c-ali1535.c	2006-01-16 22:22:51.000000000 +0300
@@ -311,8 +311,8 @@ static int ali1535_transaction(struct i2
 	}
 
 	/* check to see if the "command complete" indication is set */
- -	if (!(temp & ALI1535_STS_DONE)) {
- -		result = -1;
+	if (!result && !(temp & ALI1535_STS_DONE)) {
+		result = -2;
 		dev_err(&adap->dev, "Error: command never completed\n");
 	}
 
@@ -344,6 +344,7 @@ static s32 ali1535_access(struct i2c_ada
 	int temp;
 	int timeout;
 	s32 result = 0;
+	int retry = 1;
 
 	down(&i2c_ali1535_sem);
 	/* make sure SMBus is idle */
@@ -360,6 +361,7 @@ static s32 ali1535_access(struct i2c_ada
 	/* clear status register (clear-on-write) */
 	outb_p(0xFF, SMBHSTSTS);
 
+retry:
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
 		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
@@ -424,7 +426,14 @@ static s32 ali1535_access(struct i2c_ada
 		break;
 	}
 
- -	if (ali1535_transaction(adap)) {
+	if (((result = ali1535_transaction(adap)) == -2) && retry--) {
+		/* Adapter hung and was reset; retry */
+		dev_dbg(&adap->dev, "Adapter hung, retrying after reset\n");
+		result = 0;
+		goto retry;
+	}
+
+	if (result) {
 		/* Error in transaction */
 		result = -1;
 		goto EXIT;
 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD4DBQFDy/aZR6LMutpd94wRAoBlAJ0ZLlhPMIBC5Fmz0Iw4NBoNjM7wfwCUCB0t
+sFjdErqBnZatcpLmiPTKA==
=MW/Q
-----END PGP SIGNATURE-----
