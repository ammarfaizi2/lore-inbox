Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTKNISq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 03:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTKNISq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 03:18:46 -0500
Received: from users.linvision.com ([62.58.92.114]:33455 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261546AbTKNISo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 03:18:44 -0500
Date: Fri, 14 Nov 2003 09:18:42 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Andries.Brouwer@cwi.nl
Cc: aebr@win.tue.nl, konsti@ludenkalle.de, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: Weird partititon recocnising problem in 2.6.0-testX
Message-ID: <20031114081840.GA5485@bitwizard.nl>
References: <UTC200311101602.hAAG2an12276.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200311101602.hAAG2an12276.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 05:02:36PM +0100, Andries.Brouwer@cwi.nl wrote:
> 
> Boot a kernel that remaps, say vanilla 2.4.

[...]

> Now boot a kernel that does not remap. Since you won't see

[...]

All this rebooting into kernels that DO or DON'T remap would have been
unneccesary if the remapping would not have cloned block 1 to appear
in block 0, but would just have swapped them. 

In remapped mode, you now read block 1 wether you seek to block 0 or 1. 
If the remapping would have swapped them, just copying over the block
from block 1 to block 0 would have allowed the removal of the stupid
remapping. 

ide.c:1381
        /* Yecch - this will shift the entire interval,
           possibly killing some innocent following sector */
        if (block == 0 && drive->remap_0_to_1 == 1)
             block = 1;  /* redirect MBR access to EZ-Drive partn table */

should have been:

	if ((block <= 1)  && drive->remap_0_to_1) 
		block ^= 1;

(IMHO, it's not worth going in and fixing this for say 2.4 or 2.6
kernels(*), but it IS worth noting and not making the same mistake again in
the future.....)

	Roger. 

(*) For example because that would change established behaviour which is
bad and can lead to surprises. If we'd change it, Andries' "how to fix"
emails would become even longer: He'd have to start: IF you have a
modern kernel, you can just ... but otherwise you'll have to .... and
then comes the whole mess I didn't fully quote.....

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
