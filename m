Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318391AbSGaPxX>; Wed, 31 Jul 2002 11:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318392AbSGaPxX>; Wed, 31 Jul 2002 11:53:23 -0400
Received: from 12-252-146-102.client.attbi.com ([12.252.146.102]:50700 "EHLO
	archimedes") by vger.kernel.org with ESMTP id <S318391AbSGaPxW>;
	Wed, 31 Jul 2002 11:53:22 -0400
Date: Wed, 31 Jul 2002 09:57:13 -0600
To: Kai Engert <kai.engert@gmx.de>
Cc: linux-kernel@vger.kernel.org, Ani Joshi <ajoshi@unixbox.com>
Subject: Re: Sync bit bug in drivers/video/radeonfb.c ?
Message-ID: <20020731155713.GA20670@galileo>
Mail-Followup-To: James Mayer <james@cobaltmountain.com>,
	Kai Engert <kai.engert@gmx.de>, linux-kernel@vger.kernel.org,
	Ani Joshi <ajoshi@unixbox.com>
References: <3D4689E5.5000504@gmx.de> <20020730143309.GA21219@galileo> <3D46A8A0.2020101@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D46A8A0.2020101@gmx.de>
User-Agent: Mutt/1.4i
From: James Mayer <james@cobaltmountain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 04:54:24PM +0200, Kai Engert wrote:
> That's strange! I'm using a C1MGP, german version.
> 
> See http://www.kuix.de/sonyc1/lspci for lspci output.
> 
> However, if you apply the patch below, and you have to manually set it 
> to vsync low, I guess this means your on boot mode was set to high, 
> which is what is requested in modedb.c, and it sounds like the patch 
> below is correct. But we probably need more entries in modedb.c to 
> support all models of the C1M.

I was the one who determined the modedb.c entry for the C1MV, using my
laptop's hardware, and the existing (original) radeonfb driver.

I don't have the equipment to open the laptop and scope the DFP's sync
line, so I opened up the XFree86 4.2.0 source and looked at their
Radeon driver instead:

xc/programs/Xserver/hw/xfree86/drivers/ati/radeon_driver.c, line 3774:

 save->crtc_v_sync_strt_wid = (((mode->CrtcVSyncStart - 1) & 0xfff)
				 | (vsync_wid << 16)
				 | ((mode->Flags & V_NVSYNC)
				    ? RADEON_CRTC_V_SYNC_POL
				    : 0));

RADEON_CRTC_V_SYNC_POL is defined as (1 << 23) in radeon_reg.h. 

I think when vertical sync is low (the V_NVSYNC flag is set), the
register bit is set to 1.  When vertical sync is high, the V_NVSYNC
flag is false, and the register bit is zero.

Looking at Ani's radeonfb code, we have two spots to consider:

drivers/video/radeonfb.c, line 2421:

sync = mode->sync;
h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;

and drivers/video/radeonfb.c, line 2472:

newmode.crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
				 (vsync_wid << 16) | (v_sync_pol  << 23));

Looking at this, I think if vertical sync is low, v_sync_pol is 1, and
v_sync_pol << 23 sets the register bit to 1.  If vertical sync is
high, v_sync_pol is 0, and the register bit is cleared.


The XFree86 4.2.0 code seems to agree with the existing radeonfb
driver, with the sense of the tests being inverted.


I couldn't find a programming manual for the card on ATI's site (might
not know where to look).  XFree86 4.2.0 worked for me before I tried
the framebuffer, and it configured itself just fine.

Hopefully Ani will have an answer...

  James 
