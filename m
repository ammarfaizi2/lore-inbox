Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbSJ2HFO>; Tue, 29 Oct 2002 02:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261608AbSJ2HFO>; Tue, 29 Oct 2002 02:05:14 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:10741 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261607AbSJ2HFN>; Tue, 29 Oct 2002 02:05:13 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 29 Oct 2002 00:08:31 -0700
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, chrisl@vmware.com,
       Christoph Rohland <cr@sap.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, chrisl@gnuchina.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021029070831.GF28982@clusterfs.com>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, chrisl@vmware.com,
	Christoph Rohland <cr@sap.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, chrisl@gnuchina.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20021028192214.GI13972@dualathlon.random> <Pine.LNX.4.33L2.0210282204030.13622-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0210282204030.13622-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 28, 2002  22:10 -0800, Randy.Dunlap wrote:
> On Mon, 28 Oct 2002, Andrea Arcangeli wrote:
> | that's a silly restriction of mkswap, the kernel doesn't care, it can
> | handle way more than 2G (however there's an high bound at some
> | unpractical level, to go safe the math limit should be re-encoded in
> | mkswap, of course it changes for every arch because the pte layout is
> | different).
> 
> Heh, you hit one of my personal todo list items (larger swap spaces :),
> so I'll be looking into it, or trying to help anyone else on it
> if they want it.

If you start playing with the swap code, could you please change the
on-disk swap struct definition to look like:

union swap_header {
	:
	:
	struct {
		char         bootbits[1024];    /* Space for disklabel etc. */
		unsigned __u32 version;
		unsigned __u32 last_page;
		unsigned __u32 nr_badpages;
		char           volume_label[16];
		unsigned __u32 padding[121];
		unsigned __u32 badpages[1]; 
	} info;
};

1) change all of the "int" definitions in info to be __u32, because this
   is written to disk and we want the sizes to be unambiguous
2) the volume label field has been previously discussed and doesn't
   impose any compatibility, but allows one to "swapon by label"
   (old patch URL at http://user.it.uu.se/~mikpe/linux/swap-label/)

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

