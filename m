Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317852AbSFMXk5>; Thu, 13 Jun 2002 19:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317853AbSFMXk4>; Thu, 13 Jun 2002 19:40:56 -0400
Received: from mail8.svr.pol.co.uk ([195.92.193.213]:6749 "EHLO
	mail8.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S317852AbSFMXk4>; Thu, 13 Jun 2002 19:40:56 -0400
Date: Fri, 14 Jun 2002 00:15:13 +0100
From: George Foot <gfoot@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: bug in matrox fb vsync code
Message-ID: <20020614001513.C1220@sutra.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Mailer: Mutt 0.95.4us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to mail this to Petr Vandrovec <vandrove@vc.cvut.cz> but
the domain does not resolve.

I'm using kernel 2.4.18, and noticed a bug in the matrox vsync
code...  Here's drivers/video/matrox/matroxfb_base.c from line
992 onwards:

    static int matroxfb_get_vblank(CPMINFO struct fb_vblank *vblank)
    {
        unsigned int sts1;
    
        memset(vblank, 0, sizeof(*vblank));
        vblank->flags = FB_VBLANK_HAVE_VCOUNT | FB_VBLANK_HAVE_VSYNC |
                FB_VBLANK_HAVE_VBLANK | FB_VBLANK_HAVE_HBLANK;
        sts1 = mga_inb(M_INSTS1);
        vblank->vcount = mga_inl(M_VCOUNT);
        /* BTW, on my PIII/450 with G400, reading M_INSTS1
           byte makes this call about 12% slower (1.70 vs. 2.05 us
           per ioctl()) */
        if (sts1 & 1)
            vblank->flags |= FB_VBLANK_HBLANKING;
        if (sts1 & 8)
            vblank->flags |= FB_VBLANK_VSYNCING;
****    if (vblank->count >= ACCESS_FBINFO(currcon_display)->var.yres)
            vblank->flags |= FB_VBLANK_VBLANKING;
        vblank->hcount = 0;
        vblank->count = 0;
        return 0;
    }

The line in question (marked ****) reads from vblank->count
which is zeroed by the memset and not changed since then.  I
believe it should be reading from vblank->vcount instead.

I'm sorry not to have checked whether this has been fixed; I
found that some Matrox bugs were fixed since 2.4.18 in the
2.4.19 prerelease changelog, but my Internet connection is only
a 56k modem so I can't afford to download either the prerelease
patch or the latest development branch.

I'd also be interested to know if there's any documentation of
the difference between VSYNC and VBLANK in the context of the
fbdev code -- I haven't found any references in the kernel
documentation, perhaps there's some resource online?

Thanks for your time,

George

