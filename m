Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbULRDQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbULRDQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 22:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbULRDQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 22:16:15 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:23252 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S262825AbULRDQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 22:16:03 -0500
Message-ID: <41C3A108.7080602@verizon.net>
Date: Fri, 17 Dec 2004 22:16:24 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] ip2: fix compile warnings
References: <20041217214735.7127.91238.40236@localhost.localdomain> <20041218021457.GK21288@stusta.de>
In-Reply-To: <20041218021457.GK21288@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.220.243] at Fri, 17 Dec 2004 21:16:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Fri, Dec 17, 2004 at 03:47:13PM -0600, james4765@verizon.net wrote:
> 
> 
>>This fixes the following compile errors in the ip2 and ip2main drivers:
>>
>>  CC      drivers/char/ip2main.o
>>drivers/char/ip2main.c:470: warning: initialization from incompatible pointer type
>>drivers/char/ip2main.c: In function `ip2_tiocmget':
>>drivers/char/ip2main.c:2004: warning: unused variable `wait'
>>drivers/char/ip2/i2lib.c: At top level:
>>drivers/char/ip2/i2cmd.c:142: warning: `ct89' defined but not used
>>drivers/char/ip2main.c:205: warning: `set_modem_info' declared `static' but never defined
>>drivers/char/ip2/i2ellis.c:108: warning: `iiEllisCleanup' defined but not used
>>...
> 
> 
> This are not errors - they are only warnings.
>  
> 
>>--- linux-2.6.10-rc3-mm1-original/drivers/char/ip2main.c	2004-12-03 16:55:03.000000000 -0500
>>+++ linux-2.6.10-rc3-mm1/drivers/char/ip2main.c	2004-12-17 16:24:24.094730049 -0500
>>...
>>@@ -2001,7 +2000,6 @@
>> static int ip2_tiocmget(struct tty_struct *tty, struct file *file)
>> {
>> 	i2ChanStrPtr pCh = DevTable[tty->index];
>>-	wait_queue_t wait;
>> 
>> 	if (pCh == NULL)
>> 		return -ENODEV;
>>@@ -2018,6 +2016,8 @@
>> 		/\/\|=mhw=|\/\/			*/
>> 
>> #ifdef	ENABLE_DSSNOW
>>+	wait_queue_t wait;
>>+
>> 	i2QueueCommands(PTYPE_BYPASS, pCh, 100, 1, CMD_DSS_NOW);
>> 
>> 	init_waitqueue_entry(&wait, current);
> 
> 
> If someone will ever define ENABLE_DSSNOW your change broke compilation 
> with gcc 2.95 (variable declaration mixed with code).
> 

How about doing something like this:

#ifdef ENABLE_DSSNOW
#define DSSNOW_ENABLED 1
#else
#define DSSNOW_ENABLED 0
#endif

-blah-

static int ip2_tiocmget(struct tty_struct *tty, struct file *file)
{
	i2ChanStrPtr pCh = DevTable[tty->index];

	if (pCh == NULL)
		return -ENODEV;

if (DSSNOW_ENABLED) {
	if (ip2_tiocmget_dssnow() == -EINTR) return -EINTR;
	}

	return  ((pCh->dataSetOut & I2_RTS) ? TIOCM_RTS : 0)
	      | ((pCh->dataSetOut & I2_DTR) ? TIOCM_DTR : 0)
	      | ((pCh->dataSetIn  & I2_DCD) ? TIOCM_CAR : 0)
	      | ((pCh->dataSetIn  & I2_RI)  ? TIOCM_RNG : 0)
	      | ((pCh->dataSetIn  & I2_DSR) ? TIOCM_DSR : 0)
	      | ((pCh->dataSetIn  & I2_CTS) ? TIOCM_CTS : 0);
}

/*
	FIXME - the following code is causing a NULL pointer dereference in
	2.3.51 in an interrupt handler.  It's suppose to prompt the board
	to return the DSS signal status immediately.  Why doesn't it do
	the same thing in 2.2.14?
*/

/*	This thing is still busted in the 1.2.12 driver on 2.4.x
	and even hoses the serial console so the oops can be trapped.
		/\/\|=mhw=|\/\/			*/

static int ip2_tiocmget_dssnow (void)
{
	wait_queue_t wait;

	i2QueueCommands(PTYPE_BYPASS, pCh, 100, 1, CMD_DSS_NOW);

	init_waitqueue_entry(&wait, current);
	add_wait_queue(&pCh->dss_now_wait, &wait);
	set_current_state( TASK_INTERRUPTIBLE );

	serviceOutgoingFifo( pCh->pMyBord );

	schedule();

	set_current_state( TASK_RUNNING );
	remove_wait_queue(&pCh->dss_now_wait, &wait);

	if (signal_pending(current)) {
		return -EINTR;
	}

	return 0;
}

> cu
> Adrian
> 

