Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSK3Xen>; Sat, 30 Nov 2002 18:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261318AbSK3Xen>; Sat, 30 Nov 2002 18:34:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261312AbSK3Xel>;
	Sat, 30 Nov 2002 18:34:41 -0500
Message-ID: <3DE94CAF.7060704@pobox.com>
Date: Sat, 30 Nov 2002 18:41:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: acc@cs.stanford.edu
CC: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 5 additional buffer overruns in 2.5.48
References: <20021124063756.GA14294@Xenon.stanford.edu>
In-Reply-To: <20021124063756.GA14294@Xenon.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Chou wrote:
> Here are 6 additional potential buffer overruns in 2.4.58.  Again, we 
> would appreciate feedback on whether these are really errors or not.
> 
> -Andy
> 
> 
> ---------------------------------------------------------
> [BUG] Forgot to malloc?
> /u1/acc/linux/2.5.48/fs/cifs/cifssmb.c:233:CIFSSMBLogoff: 
> ERROR:BUFFER:233:233:Deref uninitialized pointer pSMB
> 	if (atomic_read(&ses->inUse) > 0) {
> 		up(&ses->sesSem);
> 		return -EBUSY;
> 	}
>     if(ses->secMode & (SECMODE_SIGN_REQUIRED | SECMODE_SIGN_ENABLED))
> 
> Error --->
>         pSMB->hdr.Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
> 	rc = smb_init(SMB_COM_LOGOFF_ANDX, 2, 0 /* no tcon anymore */ ,
> 		      (void **) &pSMB, (void **) &smb_buffer_response);
> 	if (rc) {
> ---------------------------------------------------------
> [BUG] [GEM] base starts at offset 4 of buf
> /u1/acc/linux/2.5.48/drivers/cdrom/cdrom.c:1170:dvd_read_physical: 
> ERROR:BUFFER:1170:1170:Array bounds error: base[16] indexed with [16]
> 	layer->track_density = base[3] & 0xf;
> 	layer->linear_density = base[3] >> 4;
> 	layer->start_sector = base[5] << 16 | base[6] << 8 | base[7];
> 	layer->end_sector = base[9] << 16 | base[10] << 8 | base[11];
> 	layer->end_sector_l0 = base[13] << 16 | base[14] << 8 | base[15];
> 
> Error --->
> 	layer->bca = base[16] >> 7;
> 
> 	return 0;
> }
> ---------------------------------------------------------
> [BUG] Probably forgot to malloc in first branch.
> /u1/acc/linux/2.5.48/drivers/video/sstfb.c:795:sstfb_get_fix: 
> ERROR:BUFFER:795:795:Deref uninitialized pointer var
> 	fix->visual      = FB_VISUAL_TRUECOLOR;
> 	/*
> 	 *   According to the specs, the linelength must be of 1024 
> *pixels*.
> 	 * and the 24bpp mode is in fact a 32 bpp mode.
> 	 */
> 
> Error --->
> 	fix->line_length = (var->bits_per_pixel == 16) ? 2048 : 4096 ;
> 	return 0;
> #undef sst_info
> }
> ---------------------------------------------------------
> [BUG] Complex.
> /u1/acc/linux/2.5.48/drivers/net/sunhme.c:3218:happy_meal_pci_init: 
> ERROR:BUFFER:3218:3218:Array bounds error: qp->happy_meals[4] indexed with 
> [-1]
> err_out_free_res:
> 	pci_release_regions(pdev);
> 
> err_out_clear_quattro:
> 	if (qp != NULL)
> 
> Error --->
> 		qp->happy_meals[qfe_slot] = NULL;
> 

notabug, qfe_slot is clearly initialized to zero before this code is hit.


> ---------------------------------------------------------
> [BUG]
> /u1/acc/linux/2.5.48/drivers/net/ni52.c:1133:ni52_timeout: 
> ERROR:BUFFER:1133:1133:Array bounds error: p->xmit_cmds[1] indexed with 
> [1]

bug, fixed.

> ---------------------------------------------------------
> [BUG]
> /u1/acc/linux/2.5.48/drivers/net/3c523.c:1102:elmc_timeout: 
> ERROR:BUFFER:1102:1102:Array bounds error: p->xmit_cmds[1] indexed with 
> [1]

bug, fixed.

