Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265933AbRGFHzz>; Fri, 6 Jul 2001 03:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266273AbRGFHzf>; Fri, 6 Jul 2001 03:55:35 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:18703 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S266282AbRGFHz0>; Fri, 6 Jul 2001 03:55:26 -0400
From: bvermeul@devel.blackstar.nl
Date: Fri, 6 Jul 2001 09:57:46 +0200 (CEST)
To: Trevor Hemsley <Trevor-Hemsley@dial.pipex.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Initio 9100 Driver for Linux
In-Reply-To: <200107052057.WAA06239@arnhem.blackstar.nl>
Message-ID: <Pine.LNX.4.33.0107060902450.13082-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's a bug in i91uscsi.c, init_tulip where it cycles through the
> onboard NVRAM config. On the controller there's a single byte per
> device but it cycles through the NVRAM in words. Since x86 words are
> two bytes a piece this means that the code uses the NVRAM config for
> the device on twice the SCSI id - the only one that's right is the one
> on id 0.
>
> The patch below has been working here since January - though I've just
> extracted this one fix from a much larger modification that I've done
> to the driver - proc fs support, merging of i91uscsi.h and ini9100u.h
> since they contain many of the same definitions but the two definitions
> are different which looks extremely dangerous to me! i91uscsi.h is no
> more here.

'k. What I don't get about your patch is the following:

1. There seems to be a typo in there (You change NVM_SCSIInfo
   into NVMSCSIInfo, without patching the header file, which just won't
   work). Another type is changing NVM into MVM on the same line.
2. You change the pwFlags into pTarg, without actually changing anything,
   since pwFlags is defined as BYTE, which is defined as unsigned char
   in i91uscsi.h. The name may be confusing, but then please just change
   the name.
3. The original code (which was not written by me, of which I *know* that
   it's butt-ugly, but that works for my situation) filters out
   TCF_SYNC_DONE and TCF_WDTR_DONE. So the only thing you changed is
   not filtering out those flags. If that's what you want to do,
   please just do that.

On another note, if you'd like to get the documentation for the chipset,
so you can rewrite the driver from scratch, please just let me know.
I don't really have the time to get this thing properly updated, and it
would be a pity if it dropped out of 2.5.

The same goes for the Initio A100 driver. If you're serious, I'm willing
to send you the card and documentation I have.

Regards,

Bas Vermeulen

> --- drivers/scsi/i91uscsi.cold	Thu Jul  5 20:50:04 2001
> +++ drivers/scsi/i91uscsi.c	Thu Jul  5 20:55:03 2001
> @@ -590,8 +590,8 @@
>  int init_tulip(HCS * pCurHcb, SCB * scbp, int tul_num_scb, BYTE * pbBiosAdr, int seconds)
>  {
>  	int i;
> -	BYTE *pwFlags;
>  	BYTE *pbHeads;
> +	UCHAR *pTarg;
>  	SCB *pTmpScb, *pPrevScb = NULL;
>
>  	pCurHcb->HCS_NumScbs = tul_num_scb;
> @@ -673,12 +673,12 @@
>  	TUL_WR(pCurHcb->HCS_Base + TUL_GCTRL1,
>  	       ((pCurHcb->HCS_Config & HCC_AUTO_TERM) >> 4) | (TUL_RD(pCurHcb->HCS_Base, TUL_GCTRL1) & 0xFE));
>
> +	pTarg = &i91unvramp->NVMSCSIInfo[0].MVM_Targ0Config;
>  	for (i = 0,
> -	     pwFlags = & (i91unvramp->NVM_SCSIInfo[0].NVM_Targ0Config),
>  	     pbHeads = pbBiosAdr + 0x180;
>  	     i < pCurHcb->HCS_MaxTar;
> -	     i++, pwFlags++) {
> -		pCurHcb->HCS_Tcs[i].TCS_Flags = *pwFlags & ~(TCF_SYNC_DONE | TCF_WDTR_DONE);
> +	     i++) {
> +		pCurHcb->HCS_Tcs[i].TCS_Flags = *(pTarg+i);
>  		if (pCurHcb->HCS_Tcs[i].TCS_Flags & TCF_EN_255)
>  			pCurHcb->HCS_Tcs[i].TCS_DrvFlags = TCF_DRV_255_63;
>  		else
>
>
> Trevor Hemsley, Brighton, UK.
> Trevor-Hemsley@dial.pipex.com
>

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson


