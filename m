Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbRGKWOZ>; Wed, 11 Jul 2001 18:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266816AbRGKWOP>; Wed, 11 Jul 2001 18:14:15 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29088 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266806AbRGKWOH>; Wed, 11 Jul 2001 18:14:07 -0400
Importance: Normal
Subject: Re: [PATCH] ACP Modem (Mwave)
To: linux-kernel@vger.kernel.org
Cc: "Mike Sullivan" <sullivam@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF080C19B9.CE6E4B6A-ON85256A86.00799C20@raleigh.ibm.com>
From: "Paul Schroeder" <paulsch@us.ibm.com>
Date: Wed, 11 Jul 2001 17:11:55 -0500
X-MIMETrack: Serialize by Router on D04NM208/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 07/11/2001 06:13:54 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch has been updated...  The updates primarily consist of Alan's
suggested changes below... (thank you)  It applies against the 2.4.6
kernel...

It can be gotten here:  http://oss.software.ibm.com/acpmodem/
Or directly:  http://oss.software.ibm.com/acpmodem/mwave_linux-2.4.6.patch

Comments, questions, suggestions are appreciated...

Cheers...Paul...


---
Paul B Schroeder  <paulsch@us.ibm.com>
Software Engineer, Linux Technology Center
IBM Corporation, Austin, TX


Alan Cox <alan@lxorguk.ukuu.org.uk> on 05/16/2001 07:11:34 PM

To:   Paul Schroeder/Austin/IBM@IBMUS
cc:   linux-kernel@vger.kernel.org, Mike Sullivan/Austin/IBM@IBMUS
Subject:  Re: [PATCH]  ACP Modem (Mwave)



> Please throw any comments, questions, suggestions, hard objects this
way...

First obvious comments

+    while (uCount-- != 0) {
+         unsigned short val_lo, val_hi;
+         cli();
+         val_lo = InWordDsp(DSP_MsaDataISLow);
+         val_hi = InWordDsp(DSP_MsaDataDSISHigh);
+         put_user(val_lo, pusBuffer++);
+         put_user(val_hi, pusBuffer++);
+         sti();
+


1.   Please use spinlocks not cli/sti as they will go away probably in 2.5

2.   You can't touch user space holding interrupts off as it can't handle
     page faults

+void PaceMsaAccess(unsigned short usDspBaseIO)
+{
+    schedule();
+    udelay(100);
+    schedule();
+}

If you are trying to be friendly then add

     if(current->need_resched)
          schedule()

just to be more efficient


+BOOLEAN dsp3780I_GetIPCSource(unsigned short usDspBaseIO,
+                    unsigned short *pusIPCSourc

s/BOOLEAN/int
s/TRUE/0
s/FALSE/-Eappropriateval

would be more in keeping. Not a bug by any means


The ioctl locking seems wrong. It doesnt look like the DSP accesses are
locked against one another and you can issue multiple ioctls in parallel in
different threads


If mwave_read/write do nothing then they should really be returning an
error
code. 0 is EOF, count on write is success.

+BOOLEAN smapi_init()

you want (void) or you get compiler warnings on some compiler revisions

+    PRINTK_1(TRACE_SMAPI, "smapi::smapi_init entry\n");
+
+    usSmapiID = CMOS_READ(0x7C);
+    usSmapiID |= (CMOS_READ(0x7D) << 8);

CMOS reads/writes must be done holding the lock against other cmos users

+int Initialize(THINKPAD_BD_DATA * pBDData)

Please dont have globals with names so generic


Hope those are useful

Alan




