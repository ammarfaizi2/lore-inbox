Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVKMTku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVKMTku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 14:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVKMTkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 14:40:49 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:10114 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750988AbVKMTks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 14:40:48 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
To: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
       Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sun, 13 Nov 2005 20:41:04 +0100
References: <58c2Z-8jG-23@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EbNir-0006ky-DP@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas <adaplas@gmail.com> wrote:

> +++ b/drivers/video/console/vgacon.c
> +#define VGA_FONTWIDTH       8   /* VGA does not support fontwidths != 8 */

This is not true, VGA cards do support fontwidth=9, but the ninth column
can only be blank or (optionally and only in the range of the IBM block
chars) copied from the eighth column, cloning the behaviour of the MDA
graphics card. If you disable this feature, you'll get 90x25 text resolution
within standard VGA timings.

BTW while looking at this file:

1) I see ORIG_VIDEO_EGA_BX (defined to (screen_info.orig_video_ega_bx)
being checked to be 0x10, but I don't find a place where the associated
variable is set to this value. Nor do I get the meaning of this variable
by reading it's name.

2) If the videomode is 7, the card is asumed not to be a VGA card.
VGA does support videomode 7, so this test is wrong. However, I don't
asume this mode to be used on normal systems as nobody complained.

I asume from the fragments I read that the correct fix would be to read
the Display Combination Code for VGA (detects additional CGA and MDA
adapters), then detect EGA (if it is, don't forget to check to check bit
3 of 0x487) and use the return code and finally to use the CRTC address
from the BIOS (The video mode may be set to 5 or 6 in order to make a
mouse driver work in Hercules graphics). In case of EGA, we'll
have to detect additional adapters manually. (Unfortunaly I threw away my
EGA-compatible monitor, so I don't know if I can test it.)

3) Having a text mode is tested by a blacklist of graphic modes. I don't
think this is good, but I've not yet read everything in this file.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
