Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310253AbSCLAwK>; Mon, 11 Mar 2002 19:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310252AbSCLAwA>; Mon, 11 Mar 2002 19:52:00 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:27868 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S310253AbSCLAvt>;
	Mon, 11 Mar 2002 19:51:49 -0500
Date: Tue, 12 Mar 2002 01:51:42 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203120051.BAA20236@harpo.it.uu.se>
To: marcelo@conectiva.com.br
Subject: Re: Linux 2.4.19-pre3
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo wrote in the 2.4.19-pre3 announcement:
>pre3:
>- Fix off-by-one error in bluesmoke			(Dave Jones)

NO NO NO! This is the same broken patch that somehow got into
2.2.21pre4 as well. The patch changes the code to write to the
IA32_MC0_CTL MSR, which is a big no-no. Intel's IA32 Vol3 manual
(#245472-03) sections 13.3.2.1 and 13.5 make that point quite clear.

I have several P6 boxes that hang hard in MCE init trying to boot
vanilla 2.2.21pre4 and 2.4.19-pre3. The issue is real.

Please apply the backup patch below.

/Mikael

--- linux-2.4.19-pre3/arch/i386/kernel/bluesmoke.c.~1~	Tue Mar 12 00:25:53 2002
+++ linux-2.4.19-pre3/arch/i386/kernel/bluesmoke.c	Tue Mar 12 01:11:58 2002
@@ -169,7 +169,7 @@
 	if(l&(1<<8))
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 	banks = l&0xff;
-	for(i=0;i<banks;i++)
+	for(i=1;i<banks;i++)
 	{
 		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
 	}
