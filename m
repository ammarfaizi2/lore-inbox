Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267593AbUHTHEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267593AbUHTHEe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUHTHEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:04:34 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:29932 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S267593AbUHTHEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:04:23 -0400
Date: Fri, 20 Aug 2004 00:02:38 -0700
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Possible dcache BUG
Message-ID: <20040820000238.55e22081@laptop.delusion.de>
In-Reply-To: <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	<20040810211849.0d556af4@laptop.delusion.de>
	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
	<20040812180033.62b389db@laptop.delusion.de>
	<Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__20_Aug_2004_00_02_38_-0700_2PMyX.2QUSlUXlPb"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__20_Aug_2004_00_02_38_-0700_2PMyX.2QUSlUXlPb
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 12 Aug 2004 18:31:31 -0700 (PDT) Linus Torvalds (LT) wrote:

LT> Your slab usage seems to be:
LT> 
LT> 	cumulative	     usage	name
LT> 	=========	    ======	====
LT> 		.....
LT> 	  2,021,428	   151,552	pgd
LT> 	  2,182,804	   161,376	size-96
LT> 	  2,367,124	   184,320	biovec-(256)
LT> 	  2,559,124	   192,000	biovec-128
LT> 	  2,751,124	   192,000	biovec-64
LT> 	  2,997,076	   245,952	ext3_inode_cache
LT> 	  3,255,124	   258,048	size-1024
LT> 	  3,545,940	   290,816	size-512
LT> 	  3,843,468	   297,528	radix_tree_node
LT> 	  4,153,932	   310,464	inode_cache
LT> 	  4,494,972	   341,040	dentry_cache
LT> 	  4,994,684	   499,712	size-8192
LT> 	  5,912,188	   917,504	size-32768
LT> 	105,397,820	99,485,632	size-64
LT> 
LT> Something pretty much stands out.
LT> 
LT> What the _heck_ is doing 64-byte allocations and leaking them?
LT> 
LT> Can you figure out what triggers it for you? If nothing obvious comes to 
LT> mind, could you do something really silly like this

[...]

Linus,

So far I have had serious trouble reproducing the slab misbehaviour quoted
above. However, I've just come across what appears to be a serious VM or USB
problem which may or may not be related to that, and I can reproduce it.

I've tried to download 700 MB of data from a digital camera via USB using
"gphoto2 --get-all-files" and I can repeatedly run my 128 MB box out of
memory using either Linux 2.4.26 or 2.6.8.1 for that.


2.4.26 fails with

Aug 19 23:02:05 laptop kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Aug 19 23:02:05 laptop kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Aug 19 23:02:05 laptop kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)

2.6.8.1 fails with

Aug 19 21:27:41 laptop kernel: usb 1-1: usbfs: interface 0 claimed while 'gphoto2' sets config #1
Aug 19 21:46:43 laptop kernel: oom-killer: gfp_mask=0x1d2                                        
Aug 19 21:46:43 laptop kernel: DMA per-cpu:
Aug 19 21:46:43 laptop kernel: cpu 0 hot: low 2, high 6, batch 1 
Aug 19 21:46:43 laptop kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 19 21:46:43 laptop kernel: Normal per-cpu:
Aug 19 21:46:43 laptop kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 19 21:46:43 laptop kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 19 21:46:43 laptop kernel: HighMem per-cpu: empty             
Aug 19 21:46:43 laptop kernel: 
Aug 19 21:46:43 laptop kernel: Free pages:        1324kB (0kB HighMem)
Aug 19 21:46:43 laptop kernel: Active:1315 inactive:27343 dirty:0 writeback:0 unstable:0 free:331 slab:1606 mapped:1555 pagetables:241
Aug 19 21:46:43 laptop kernel: DMA free:704kB min:44kB low:88kB high:132kB active:0kB inactive:10720kB present:16384kB                
Aug 19 21:46:43 laptop kernel: protections[]: 22 178 178
Aug 19 21:46:43 laptop kernel: Normal free:620kB min:312kB low:624kB high:936kB active:5260kB inactive:98652kB present:114688kB
Aug 19 21:46:43 laptop kernel: protections[]: 0 156 156
Aug 19 21:46:43 laptop kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Aug 19 21:46:43 laptop kernel: protections[]: 0 0 0
Aug 19 21:46:43 laptop kernel: DMA: 0*4kB 2*8kB 5*16kB 5*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 704kB   
Aug 19 21:46:43 laptop kernel: Normal: 1*4kB 3*8kB 3*16kB 1*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 620kB
Aug 19 21:46:43 laptop kernel: HighMem: empty
Aug 19 21:46:43 laptop kernel: Swap cache: add 366080, delete 339455, find 219744/259874, race 0+0
Aug 19 21:46:43 laptop kernel: Out of Memory: Killed process 10239 (gphoto2).        

-Udo.

--Signature=_Fri__20_Aug_2004_00_02_38_-0700_2PMyX.2QUSlUXlPb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJaISnhRzXSM7nSkRAiBhAJ9QmWMjBk09fLFOWP93NWKnO9HjCwCdEVNp
wuxIxe9AUcWrmtxEN4Gsa4k=
=Ndez
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Aug_2004_00_02_38_-0700_2PMyX.2QUSlUXlPb--
