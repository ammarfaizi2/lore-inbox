Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUEFT6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUEFT6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUEFT6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 15:58:16 -0400
Received: from d61.wireless.hilander.com ([216.241.32.61]:9951 "EHLO
	ramirez.hilander.com") by vger.kernel.org with ESMTP
	id S262451AbUEFT6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 15:58:14 -0400
Date: Thu, 06 May 2004 13:58:10 -0600
From: "Alec H. Peterson" <ahp@hilander.com>
To: root@chaos.analogic.com
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: pci_request_regions() failure
Message-ID: <5DF8ED7E3F54B1367C978AB4@[192.168.0.100]>
In-Reply-To: <Pine.LNX.4.53.0405061527590.19721@chaos>
References: <01D138A0E5F192A9DBDB9432@[192.168.0.100]>
 <85E9D28402CA2A4C4E8093BE@[192.168.0.100]>
 <Pine.LNX.4.53.0405061527590.19721@chaos>
X-Mailer: Mulberry/3.1.3 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Spam-Score: -4.8 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1BLp0V-0007jj-1G*UAA6xVo8mQU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, May 6, 2004 3:50 PM -0400 "Richard B. Johnson" 
<root@chaos.analogic.com> wrote:

>
> The BIOS should have aligned everything correctly.
> 0xec108fff - 0xec107000 = 0x1fff (0x2000 bytes)
>
> 0xec107000 / 0x2000 = 0x76083, * 0x2000 = 0xec106000
> (where it should have been). Check to see if that region is
> clear and if it is, write that address to the PCI
> BAR. If it isn't, check the next higher address
> (ex106000 + 0x2000), etc.

That region of memory is actually pretty tightly packed, but I think I have 
managed to solve the problem.

In drivers/pcmcia/yenta.c, it seems that the regions of memory in question 
are also too small in yenta_allocate_res() (BRIDGE_SIZE_MIN) in addition to 
not being properly aligned.  So, I added the following clause to check for 
both cases (since yenta_allocate_res() will find a new block if necessary):


        start = config_readl(socket, offset) & mask;
        end = config_readl(socket, offset+4) | ~mask;
#if 1
        if (!(type & IORESOURCE_IO) && (((end - start) < BRIDGE_SIZE_MIN) ||
            (start & (end - start))))
        {
                printk(KERN_INFO "yenta %s: Preassigned resource start %lx 
end %lx too small or not aligned.\n", socket->dev->slot_name, start, end);
                res->start = res->end = 0;
        }
        else
#endif
        if (start && end > start) {
                res->start = start;

Now everything is working perfectly, at least for me.  I realize that this 
sort of thing might break other stuff, but it seems to me that this sort of 
check is a good idea regardless.

Note that this is my first attempt at a kernel patch, so please let me know 
if this is horribly wrong or otherwise just a bad idea.

Thanks!

Alec

