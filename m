Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRGEVAy>; Thu, 5 Jul 2001 17:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262682AbRGEVAo>; Thu, 5 Jul 2001 17:00:44 -0400
Received: from typhoon.mail.pipex.net ([158.43.128.27]:2215 "HELO
	typhoon.mail.pipex.net") by vger.kernel.org with SMTP
	id <S262389AbRGEVAb>; Thu, 5 Jul 2001 17:00:31 -0400
From: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "bvermeul@devel.blackstar.nl" <bvermeul@devel.blackstar.nl>
Date: Thu, 05 Jul 2001 21:08:27 +0000
Reply-To: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
X-Mailer: PMMail 1.96a For OS/2
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: Initio 9100 Driver for Linux
Message-Id: <20010705210038Z262389-17720+11226@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2001 11:32:12, bvermeul@devel.blackstar.nl wrote:

> > I have a problem with the driver for Initio SCSI Controller 9100 SCSI,
> > a dual channel UW SCSI-Controller. On checking the SCSI bus the systems
> > has problems to initialize the CD-RW Sanyo (aka Brainwave) BP4-N SCSI
> > The CD-RW has SCSI-ID 6 on the second Controller. It is shown on
> > system startup an GENERIC CRD-BP4
> >
> > I had this problem both with Kernel 2.2.17 and 2.2.19.
>  
> Check your termination. The initio drivers are very sensitive to
> termination errors (use active if possible), and make sure you follow all
> the normal rules regarding scsi.
>  
> Most problems I've seen are caused by lousy termination, or using three
> way busses. I've also seen some problems with some cd writers (Yamaha to
> be exact), that I haven't been able to solve yet.

There's a bug in i91uscsi.c, init_tulip where it cycles through the onboard NVRAM 
config. On the controller there's a single byte per device but it cycles through the 
NVRAM in words. Since x86 words are two bytes a piece this means that the 
code uses the NVRAM config for the device on twice the SCSI id - the only one 
that's right is the one on id 0.

The patch below has been working here since January - though I've just extracted 
this one fix from a much larger modification that I've done to the driver - proc fs
support, merging of i91uscsi.h and ini9100u.h since they contain many of the
same definitions but the two definitions are different which looks extremely
dangerous to me! i91uscsi.h is no more here. 

I may have missed something with this one fix.

--- drivers/scsi/i91uscsi.cold	Thu Jul  5 20:50:04 2001
+++ drivers/scsi/i91uscsi.c	Thu Jul  5 20:55:03 2001
@@ -590,8 +590,8 @@
 int init_tulip(HCS * pCurHcb, SCB * scbp, int tul_num_scb, BYTE * pbBiosAdr, int seconds)
 {
 	int i;
-	BYTE *pwFlags;
 	BYTE *pbHeads;
+	UCHAR *pTarg;
 	SCB *pTmpScb, *pPrevScb = NULL;
 
 	pCurHcb->HCS_NumScbs = tul_num_scb;
@@ -673,12 +673,12 @@
 	TUL_WR(pCurHcb->HCS_Base + TUL_GCTRL1,
 	       ((pCurHcb->HCS_Config & HCC_AUTO_TERM) >> 4) | (TUL_RD(pCurHcb->HCS_Base, TUL_GCTRL1) & 0xFE));
 
+	pTarg = &i91unvramp->NVMSCSIInfo[0].MVM_Targ0Config;
 	for (i = 0,
-	     pwFlags = & (i91unvramp->NVM_SCSIInfo[0].NVM_Targ0Config),
 	     pbHeads = pbBiosAdr + 0x180;
 	     i < pCurHcb->HCS_MaxTar;
-	     i++, pwFlags++) {
-		pCurHcb->HCS_Tcs[i].TCS_Flags = *pwFlags & ~(TCF_SYNC_DONE | TCF_WDTR_DONE);
+	     i++) {
+		pCurHcb->HCS_Tcs[i].TCS_Flags = *(pTarg+i);
 		if (pCurHcb->HCS_Tcs[i].TCS_Flags & TCF_EN_255)
 			pCurHcb->HCS_Tcs[i].TCS_DrvFlags = TCF_DRV_255_63;
 		else


Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com

