Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265866AbUAKMJN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265868AbUAKMJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:09:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13836 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265866AbUAKMJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:09:07 -0500
Date: Sun, 11 Jan 2004 12:09:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New FBDev patch
Message-ID: <20040111120903.D1931@flint.arm.linux.org.uk>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040108232621.B25760@flint.arm.linux.org.uk> <Pine.LNX.4.44.0401090035270.17957-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0401090035270.17957-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Fri, Jan 09, 2004 at 07:54:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 07:54:50PM +0000, James Simmons wrote:
> > sizeof(u32) != 32.  Proper fix is to place the pseudopalette array
> > inside cfb_info, and dispense with this addition here.
> 
> You have to make sure the struct fb_info pseudopalette points to the data 
> in cfb_info. Actually only drivers should allocate the pseudopalette at 
> boot time if the hardware doesn't support mode change. In the other case 
> the pseudopalette should be allocated in set_par. 

I respectfully disagree.  It is not possible to error out of the set_par()
function - for instance, fb_set_var() contains this code:

                        if (info->fbops->fb_set_par)
                                info->fbops->fb_set_par(info);

There isn't any error return checking (so why does fb_set_par return an
int when it isn't used?  It's fairly misleading.)

This all means that if the allocation of the pseudo_palette in set_par
fails, there's no way to abort the mode change - you _will_ oops in the
other fbcon layers due to a NULL pseudo_palette pointer.

Plus, we're only talking about an array of 16 32-bit words or 64 bytes.
That's hardly worth the extra code complexity to separately dynamically
allocate.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
