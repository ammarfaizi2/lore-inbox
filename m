Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVDAGu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVDAGu7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 01:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVDAGu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 01:50:59 -0500
Received: from colo.lackof.org ([198.49.126.79]:39863 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262462AbVDAGtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 01:49:31 -0500
Date: Thu, 31 Mar 2005 23:51:20 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jim Gifford <maillist@jg555.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       pdh@colonel-panic.org
Subject: Re: 64bit build of tulip driver
Message-ID: <20050401065120.GD29734@colo.lackof.org>
References: <424AE9E0.8040601@jg555.com> <20050331161206.GB19219@colo.lackof.org> <424CC566.3080007@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424CC566.3080007@jg555.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 07:52:06PM -0800, Jim Gifford wrote:
> Grant
>    Thanx for your feedback. I got it working, but I don't think the 
> patch is the best. Here is the patch, and the information, but if you 
> can recommend a different way to fix it, let me know.

I can not "reccomend" one. I can suggest other things to try
since I'm very skeptical this patch will get accepted by
the maintainer (Jeff Garzik). He's normally wants a much
better explanation of the problem than "this works".


> The patch was done by Peter Horton.
> Here is the link to the full patch, 
> http://ftp.jg555.com/patches/raq2/linux/linux-2.6.11.6-raq2_fix-2.patch
> but here is the section for this issue

Jim,
You have other changes to tulip_core.c:
+                               /* Avoid a chip errata by prefixing a dummy entr
y. Don't do
+                                  this on the ULI526X as it triggers a differen
t problem */
....


Picking a few nits:
o comment extends past 80 columns - please wrap before 80 columns
o *Which* chip errata?
o *Which* other problem?
o I prefer diffs with "-p" when reviewing patches so I know which
  function is getting mangled.

-                       /* No media table either */
-                       tp->flags &= ~HAS_MEDIA_TABLE;
+                      /* Ensure our media table fixup get's applied */
+                      memcpy(ee_data + 16, ee_data, 8);

This isn't likely to get far either unless it's better explained.
You don't have to explain it to me, now. But have something handy
if you want jgarzik to accept it.


> @@ -1628,6 +1631,16 @@
>                 }
>         }
> 
> +#if defined(CONFIG_MIPS_COBALT) && defined(CONFIG_MIPS64)
> +        /*
> +         * something very bad is happening. without this
> +         * cache flush the PHY can't be read. I've tried
> +         * various ins & outs, delays etc but only a call
> +         * to printk or this flush seems to fix it ... help!
> +         */
> +        flush_cache_all();
> +#endif

The code immediately before this calls tulip_select_media().
Code paths exist in tulip_select_media() where the last thing the
driver does to the NIC is io_write(). This could easily be a posted
write flush problem. Does replacing flush_cache_all() with 
"ioread32(ioaddr + CSR12)" also work?

Can you find out how long one has to wait after banging
on CSR12 before it's safe to call tulip_find_mii()?

How long does flush_cache_all() take in microseconds?

It's possible this is a very fast PPC chip and it's executing the
code path between tulip_select_media() and tulip_find_mii()
faster than the chips can finish dealing with the writes to CSR12.
I'd consider this issue if flushing posted PCI writes doesn't help.

The tulip changes I maintain in parisc-linux port deal with
similar issues where the driver is not following the specified
timing requirements.
Search google for "tulip 802.3 22.2.4 Management functions"
or look into http://cvs.parisc-linux.org/linux-2.6/.


> +
>         /* Find the connected MII xcvrs.
>            Doing this in open() would allow detecting external xcvrs
>            later, but takes much time. */
> 
> >Are there any config option differences? 
> >e.g. MWI or MMIO options enabled on 64-bit but not 32-bit?
>
> I verified that there are no differences.

ok. thanks.

...
> Applied the patch, here is the output
> 
> 0000:00:07.0: tulip_stop_rxtx() failed (CSR5 0xf0660000 CSR6 0xb3862002)
...

Sorry, I don't have time to decode what these mean right now.
But I think the publicly available tulip chips docs sufficiently
explain what the registers mean and what state the chip is in.

> I was able to get some more information on the bootup sequence with the 
> updates.
> Here is the output now from the driver
> 
> Linux Tulip driver version 1.1.13 (May 11, 2002)
> PCI: Enabling device 0000:00:07.0 (0045 -> 0047)
> tulip0: Old format EEPROM on 'Cobalt Microserver' board.  Using 
> substitute media control info.
> tulip0:  EEPROM default media type Autosense.
> tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
> tulip0: ***WARNING***: No MII transceiver found!

ok. I assume this is unpatched.

thanks,
grant

> eth0: Digital DS21143 Tulip rev 65 at ffffffffb0001400, 
> 00:10:E0:00:32:DE, IRQ 19.
> PCI: Enabling device 0000:00:0c.0 (0005 -> 0007)
> tulip1: Old format EEPROM on 'Cobalt Microserver' board.  Using 
> substitute media control info.
> tulip1:  EEPROM default media type Autosense.
> tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
> tulip1: ***WARNING***: No MII transceiver found!
> eth1: Digital DS21143 Tulip rev 65 at ffffffffb0001480, 
> 00:10:E0:00:32:DF, IRQ 20.
> 
> 
> -- 
> ----
> Jim Gifford
> maillist@jg555.com
