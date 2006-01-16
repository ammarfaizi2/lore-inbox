Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWAPVSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWAPVSJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWAPVSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:18:09 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:29109 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S1751211AbWAPVSI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:18:08 -0500
Message-ID: <43CC0D7B.4090309@sh.cvut.cz>
Date: Mon, 16 Jan 2006 22:17:47 +0100
From: Rudolf Marek <r.marek@sh.cvut.cz>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@newmail.ru>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org, klingler@newtec.de
Subject: Re: [lm-sensors] 2.6.15: lm90 0-004c: Register 0x13 read failed (-1)
References: <200601142223.35838.arvidjaar@newmail.ru> <200601152248.07800.arvidjaar@newmail.ru> <43CAB1B7.6020903@sh.cvut.cz> <200601162240.09985.arvidjaar@newmail.ru>
In-Reply-To: <200601162240.09985.arvidjaar@newmail.ru>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

> Actually it did. I realized that 15x3 you sent attempted recovery while 
> current 1535 not. After some experiments I came up with this patch (it is not 
> meant for inclusion but only for discussion) that seems to work. I had hard 
> rime finding the exact place where to retry command but now I get
> 
> so it appears to recover nicely. Does it look like it returns correct value 
> after retry?

This can be possible. I may know why this is happening. I have now the datasheets
for both ali 1535 and 15x3. I found that there are special bits that are used to
control somehow when bus is considered idle.

Those bits are in PCI config space of same device as the smbus base addr is.

For the ali 15x3 the register is located at 0xe2 and bits are:

Bit        Description
7-5 (001b) SMB Clock Select.
           [7:5] : "clock"
           000 :     149K
           001 :     74K (recommended)
           010 :      37K
           100 :     223K
           101 :     111K
           110 :     55K
           These three bits are used to select the base clock for internal state machine. All the
           timings will be based on this clock. The clock is derived from OSC14M.
4-3 (0h)   Idle Delay Setting.
           [4:3] :   "idle time"
           00 :       BaseClk*64 53.76 us ref. 1.19M base clock. (default)
           01 :       BaseClk*32
           10 :       BaseClk*128
           Others : Reserved
           These two bits are used to decide the idle time to qualify SMBus is in idle state. The
           time is calculated based on the base clock defined in bits[7:5].
2-0 (0h)   Reserved.

For the 1535 is the register offset 0xF2

Bit       Description
7-5 (001) The base clock referenced by the SMB host controller.
          000: 149K.
          001: 74K.
          010: 31K.
          100: 223K.
          101: 111K.
          110: 55K.
4-3       Bus Delay Timer Setting. The base clock is set in the previous field. This timer decides
          when the SMB bus is actually idle.
          00: Base Clock × 4.
          01: Base Clock × 2.
          10: Base Clock × 8.
          11: Reserved.
2-0       Reserved.

What is interresting both drivers sets this to 0x20, overwriting two reserved bits - this is no good.
       /* set SMB clock to 74KHz as recommended in data sheet */
        pci_write_config_byte(dev, SMBCLK, 0x20);

Andrey and Claudio,
please can you send back output of lscpi -d 10b9:7101 -x -x -x  before you load the ali driver?

Also you both can try to change the delay a bit, after the driver loads (or kill the above line that sets it).

for andrey (1535):  setpci -d 10b9:7101 f2.b=28
(this should set it to base*8)

for Claudio:
I dont know if you want to dig into this, but if you want so please try with such driver that reports that it reset the controller.
setpci -d 10b9:7101 e2.b=28
(this should set it to base*128)

when done please load your chip device driver and let it run, observe if it resets more or less often. You may play with the smbus clock too if you want.
I hope this helps.

> I intend to squash errors, leaving only the first occurence but making it more 
> verbose. Probably:
> 
> Error: command never completed. It is probably hardware bug
> Command will be retried after controller is reset
> further occurences of this error won't be reported as long as retry is 
> sucessful
> 
> is wording OK (I am not native english speaker)?

I guess best would be to to emit some kind of error after all retries, but question
is how to do it cleanly.


> regards
> 
> -andrey
> 
> --- linux-2.6.15/drivers/i2c/busses/i2c-ali1535.c	2006-01-03 
> 06:21:10.000000000 +0300
> +++ i2c-ali1535.c	2006-01-16 22:22:51.000000000 +0300
> @@ -311,8 +311,8 @@ static int ali1535_transaction(struct i2
>  	}
>  
>  	/* check to see if the "command complete" indication is set */
> -	if (!(temp & ALI1535_STS_DONE)) {
> -		result = -1;
> +	if (!result && !(temp & ALI1535_STS_DONE)) {
> +		result = -2;
>  		dev_err(&adap->dev, "Error: command never completed\n");

Perhaps this dev_err can be move down

>  	}
>  
> @@ -344,6 +344,7 @@ static s32 ali1535_access(struct i2c_ada
>  	int temp;
>  	int timeout;
>  	s32 result = 0;
> +	int retry = 1;
>  
>  	down(&i2c_ali1535_sem);
>  	/* make sure SMBus is idle */
> @@ -360,6 +361,7 @@ static s32 ali1535_access(struct i2c_ada
>  	/* clear status register (clear-on-write) */
>  	outb_p(0xFF, SMBHSTSTS);
>  
> +retry:
>  	switch (size) {
>  	case I2C_SMBUS_PROC_CALL:
>  		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
> @@ -424,7 +426,14 @@ static s32 ali1535_access(struct i2c_ada
>  		break;
>  	}
>  
> -	if (ali1535_transaction(adap)) {
> +	if (((result = ali1535_transaction(adap)) == -2) && retry--) {
> +		/* Adapter hung and was reset; retry */
> +		dev_dbg(&adap->dev, "Adapter hung, retrying after reset\n");
> +		result = 0;
> +		goto retry;
> +	}
> +
> +	if (result) {

perhaps here to test if result is -2 and tell user that never completed?

>  		/* Error in transaction */
>  		result = -1;
>  		goto EXIT;
>  

Thats all from me,

regards
Rudolf
