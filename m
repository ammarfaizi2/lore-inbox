Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317979AbSGWHQO>; Tue, 23 Jul 2002 03:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSGWHQO>; Tue, 23 Jul 2002 03:16:14 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:17645 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S317979AbSGWHQN>;
	Tue, 23 Jul 2002 03:16:13 -0400
Date: Tue, 23 Jul 2002 09:19:15 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: support <support@promise.com.tw>
Cc: Hank <hanky@promise.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc2-ac2 pdc202xx.c update
Message-ID: <20020723091915.A29237@fafner.intra.cogenit.fr>
References: <01b801c22f0b$c02cc360$47cba8c0@promise.com.tw> <01ee01c2312e$22976900$47cba8c0@promise.com.tw> <20020722083548.A27973@fafner.intra.cogenit.fr> <000d01c231e5$10f8ae40$47cba8c0@promise.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000d01c231e5$10f8ae40$47cba8c0@promise.com.tw>; from support@promise.com.tw on Tue, Jul 23, 2002 at 09:05:30AM +0800
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

support <support@promise.com.tw> :
> We think there is no problems, Acturally it is
> 
> if (speed == XFER_UDMA_2) {
>         OUT_BYTE((thold + adj), indexreg);
>         OUT_BYTE((IN_BYTE(datareg) & 0x7f), datareg);
> }
> 
> So,
> if (speed == XFER_UDMA_2)
>         set_2regs(thold, (IN_BYTE(datareg) & 0x7f));

set_2regs() is a macro. Macro have side effects.

Before the change, assuming speed != XFER_UDMA_2

if (speed == XFER_UDMA_2) {
	OUT_BYTE((thold + adj), indexreg); 		<- not executed
	OUT_BYTE((IN_BYTE(datareg) & 0x7f), datareg);	<- not executed
}

-> the block isn't executed

After the change, the code is:

if (speed == XFER_UDMA_2)
        OUT_BYTE((thold + adj), indexreg);              <- not executed
        OUT_BYTE((IN_BYTE(datareg) & 0x7f), datareg);   <- executed, damn it !

-> only the first statement of the macro is executed.

Put a pair of {} after the "if", a "do {...} while (0)" in the macro
declaration. Please, please, think about it a few minutes.

-- 
Ueimor
