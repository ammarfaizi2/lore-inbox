Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVDCBiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVDCBiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 20:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDCBiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 20:38:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63382 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261418AbVDCBiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 20:38:00 -0500
Date: Sun, 3 Apr 2005 02:37:57 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: iomapping a big endian area
Message-ID: <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
References: <1112475134.5786.29.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112475134.5786.29.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 02:52:14PM -0600, James Bottomley wrote:
> This driver has had it's own different infrastructure for doing this for
> ages, but it's time it used the common one.

Thanks.  I'd been looking at this for a while but hadn't got round tuit yet.

>  #ifdef CONFIG_53C700_LE_ON_BE
>  #define bE	(hostdata->force_le_on_be ? 0 : 3)
>  #define	bSWAP	(hostdata->force_le_on_be)
> +/* This is terrible, but there's no raw version of ioread32.  That means
> + * that on a be board we swap twice (once in ioread32 and once again to 
> + * get the value correct) */
> +#define bS_to_io(x)	((hostdata->force_le_on_be) ? (x) : cpu_to_le32(x))

I raised this with Linus back when he did the original iomap() stuff.
Unfortunately, I think he ignored the question ;-)

My thought on this is that we should encode the endianness of the
registers in the ioremap cookie.  Some architectures (sparc, I think?) can
do this in their PTEs.  The rest of us can do it in our ioread/writeN
methods.  I've planned for this in the parisc iomap implementation but
not actually implemented it.

It doesn't look too hard so I'll commit something to the parisc tree
later that'll let you iomap a BE area.  Do we have any cards that need to be
accessed in a BE way on a LE machine?  (ie x86)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
