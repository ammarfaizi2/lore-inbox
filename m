Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262160AbREQAPC>; Wed, 16 May 2001 20:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262163AbREQAOw>; Wed, 16 May 2001 20:14:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3342 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262160AbREQAOj>; Wed, 16 May 2001 20:14:39 -0400
Subject: Re: [PATCH]  ACP Modem (Mwave)
To: paulsch@us.ibm.com (Paul Schroeder)
Date: Thu, 17 May 2001 01:11:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, sullivam@us.ibm.com (Mike Sullivan)
In-Reply-To: <OFFB4ACBFF.EBAF6CD2-ON85256A4E.0070AD91@raleigh.ibm.com> from "Paul Schroeder" at May 16, 2001 03:40:01 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150BOA-0004i7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please throw any comments, questions, suggestions, hard objects this way...

First obvious comments

+	while (uCount-- != 0) {
+		unsigned short val_lo, val_hi;
+		cli();
+		val_lo = InWordDsp(DSP_MsaDataISLow);
+		val_hi = InWordDsp(DSP_MsaDataDSISHigh);
+		put_user(val_lo, pusBuffer++);
+		put_user(val_hi, pusBuffer++);
+		sti();
+


1.	Please use spinlocks not cli/sti as they will go away probably in 2.5

2.	You can't touch user space holding interrupts off as it can't handle
	page faults

+void PaceMsaAccess(unsigned short usDspBaseIO)
+{
+	schedule();
+	udelay(100);
+	schedule();
+}

If you are trying to be friendly then add

	if(current->need_resched)
		schedule()

just to be more efficient


+BOOLEAN dsp3780I_GetIPCSource(unsigned short usDspBaseIO,
+			      unsigned short *pusIPCSourc

s/BOOLEAN/int
s/TRUE/0
s/FALSE/-Eappropriateval

would be more in keeping. Not a bug by any means


The ioctl locking seems wrong. It doesnt look like the DSP accesses are
locked against one another and you can issue multiple ioctls in parallel in
different threads


If mwave_read/write do nothing then they should really be returning an error
code. 0 is EOF, count on write is success.

+BOOLEAN smapi_init()

you want (void) or you get compiler warnings on some compiler revisions

+	PRINTK_1(TRACE_SMAPI, "smapi::smapi_init entry\n");
+
+	usSmapiID = CMOS_READ(0x7C);
+	usSmapiID |= (CMOS_READ(0x7D) << 8);

CMOS reads/writes must be done holding the lock against other cmos users

+int Initialize(THINKPAD_BD_DATA * pBDData)

Please dont have globals with names so generic


Hope those are useful

Alan


