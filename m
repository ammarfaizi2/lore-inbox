Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279570AbRK0OLk>; Tue, 27 Nov 2001 09:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279790AbRK0OLb>; Tue, 27 Nov 2001 09:11:31 -0500
Received: from [195.66.192.167] ([195.66.192.167]:11539 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S279570AbRK0OLP>; Tue, 27 Nov 2001 09:11:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Date: Tue, 27 Nov 2001 16:03:54 -0200
X-Mailer: KMail [version 1.2]
Cc: mathijs@knoware.nl (Mathijs Mohlmann), bulb@ucw.cz (Jan Hudec),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <E168SMG-0006k2-00@the-village.bc.nu>
In-Reply-To: <E168SMG-0006k2-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01112716035401.00872@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 November 2001 18:28, Alan Cox wrote:
> > > MODINC(x,y) (x = (x % y) + 1)
> >
> > drivers/message/i2o/i2o_config.c:#define MODINC(x,y) (x = x++ % y)
> >
> > Alan, can you clarify what this macro is doing?
> > What about making it less confusing?
>
> Nothing to do with me 8). I didnt write that bit of the i2o code. I agree
> its both confusing and buggy. Send a fix ?

This is a test to be sure my replacement is equivalent:
--------------------
#include <stdio.h>
#define MODINC(x,y) (x = x++ % y)
#define MODULO_INC(x,y) ((x) = ((x)%(y))+1)
int main() {
    int x1=1;
    int x2=1;
    int y=7;
    int i;
    for(i=0;i<22;i++) {
	printf("%d,%d -> ",x1,x2);
	MODINC(x1,y);
	MODULO_INC(x2,y);
	printf("%d,%d\n",x1,x2);
    }
}

Patch is below
--
vda


--- i2o_config.c.new	Mon Oct 22 13:39:56 2001
+++ i2o_config.c.orig	Tue Nov 27 16:03:19 2001
@@ -45,7 +45,7 @@
 static spinlock_t i2o_config_lock = SPIN_LOCK_UNLOCKED;
 struct wait_queue *i2o_wait_queue;

-#define MODINC(x,y) (x = x++ % y)
+#define MODULO_INC(x,y) ((x) = ((x)%(y))+1)

 struct i2o_cfg_info
 {
@@ -144,10 +144,10 @@
 				inf->event_q[inf->q_in].data_size);

 		spin_lock(&i2o_config_lock);
-		MODINC(inf->q_in, I2O_EVT_Q_LEN);
+		MODULO_INC(inf->q_in, I2O_EVT_Q_LEN);
 		if(inf->q_len == I2O_EVT_Q_LEN)
 		{
-			MODINC(inf->q_out, I2O_EVT_Q_LEN);
+			MODULO_INC(inf->q_out, I2O_EVT_Q_LEN);
 			inf->q_lost++;
 		}
 		else
@@ -803,7 +803,7 @@
 	}

 	memcpy(&kget.info, &p->event_q[p->q_out], sizeof(struct i2o_evt_info));
-	MODINC(p->q_out, I2O_EVT_Q_LEN);
+	MODULO_INC(p->q_out, I2O_EVT_Q_LEN);
 	spin_lock_irqsave(&i2o_config_lock, flags);
 	p->q_len--;
 	kget.pending = p->q_len;
