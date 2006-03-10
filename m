Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWCJUzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWCJUzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 15:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWCJUzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 15:55:35 -0500
Received: from ns2.suse.de ([195.135.220.15]:9399 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932094AbWCJUzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 15:55:35 -0500
Date: Fri, 10 Mar 2006 21:55:33 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-git14 crash in spin_bug on ppc64
Message-ID: <20060310205532.GA15596@suse.de>
References: <20060310173842.GA14924@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060310173842.GA14924@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Mar 10, Olaf Hering wrote:

> 
> I got this crash while hunting some other bug. dualcore 970mp. 
> 
> Welcome to SUSE Linux Enterprise Server 9.90 Beta7 (ppc) - Kernel 2.6.16-rc5-git
> 14-ppc64-defconfig (console).
> 
> 
> wels login: BUG: spinlock bad magic on CPU#1, gdm/4568
> cpu 0x1: Vector: 300 (Data Access) at [c0000000f3c2f5c0]
>     pc: c00000000020a7ec: .spin_bug+0x94/0x100

c0000000f40001f0 is *lock at 0xc0000000f217b738:
1:mon> d c0000000f40001f0
c0000000f40001f0 ffff000000000000 ffff000000000000  |................|
c0000000f4000200 ffff000000000000 ffff000000000000  |................|
c0000000f4000210 ffff000000000000 ffff000000000000  |................|
c0000000f4000220 ffff000000000000 ffff000000000000  |................|



anon_vma_link() *vma is 
1:mon> d c0000000f217b6b8 100
c0000000f217b6b8 c0000000f4c51800 000000000f6e5000  |.............nP.|
c0000000f217b6c8 000000000f6e9000 0000000000000000  |.....n..........|
c0000000f217b6d8 0000000000000113 0000000000100073  |...............s|
c0000000f217b6e8 c0000000f4edde78 0000000100000000  |.......x........|
c0000000f217b6f8 c000000007960d18 c00000000ff799a8  |................|
c0000000f217b708 c0000000f217cde8 c0000000f217cde8  |................|
c0000000f217b718 0000000000000000 c0000000f4f644a8  |..............D.|
c0000000f217b728 c0000000f4f64518 c0000000f4000208  |......E.........|
c0000000f217b738 c0000000f40001f0 c000000000607600  |.............`v.|
c0000000f217b748 000000000000007b c0000000f953fc80  |.......{.....S..|
c0000000f217b758 0000000000000000 0000000000000000  |................|
c0000000f217b768 c0000000f2186180 00000000f7fe1000  |......a.........|
c0000000f217b778 00000000f7fff000 c0000000f9127088  |..............p.|
c0000000f217b788 0000000000000117 0000000000000875  |...............u|
c0000000f217b798 c00000000ff79d18 0000000000000000  |................|
c0000000f217b7a8 0000000000000000 0000000000000000  |................|
1:mon> 

The whole area looks broken:


1:mon> d c0000000f4000000 400
c0000000f4000000 ffff000000000000 ffff000000000000  |................|
c0000000f4000010 ffff000000000000 ffff000000000000  |................|
...
c0000000f4000260 ffff000000000000 ffff000000000000  |................|
c0000000f4000270 ffff000000000000 ffff000000000000  |................|
c0000000f4000280 c0000000f4000280 c0000000f4000280  |................|
c0000000f4000290 00000000dead4ead ffffffff00000000  |......N.........|
c0000000f40002a0 ffffffffffffffff c0000000f40002a8  |................|
c0000000f40002b0 c0000000f40002a8 00000000dead4ead  |..............N.|
c0000000f40002c0 ffffffff00000000 ffffffffffffffff  |................|
c0000000f40002d0 c0000000f4f58a98 c0000000f4f58a98  |................|
c0000000f40002e0 00000000dead4ead ffffffff00000000  |......N.........|
c0000000f40002f0 ffffffffffffffff c0000000f21eaf68  |...............h|
c0000000f4000300 c0000000f21eaf68 00000000dead4ead  |.......h......N.|
c0000000f4000310 ffffffff00000000 ffffffffffffffff  |................|
c0000000f4000320 c0000000f4000320 c0000000f4000320  |....... ....... |
c0000000f4000330 00000000dead4ead ffffffff00000000  |......N.........|
c0000000f4000340 ffffffffffffffff c0000000f4000348  |...............H|
c0000000f4000350 c0000000f4000348 00000000dead4ead  |.......H......N.|
c0000000f4000360 ffffffff00000000 ffffffffffffffff  |................|
c0000000f4000370 c0000000f4000370 c0000000f4000370  |.......p.......p|
c0000000f4000380 00000000dead4ead ffffffff00000000  |......N.........|
c0000000f4000390 ffffffffffffffff c0000000f4442ca8  |.............D,.|
c0000000f40003a0 c0000000f4efeb48 00000000dead4ead  |.......H......N.|
c0000000f40003b0 ffffffff00000000 ffffffffffffffff  |................|
c0000000f40003c0 c0000000f40003c0 c0000000f40003c0  |................|
c0000000f40003d0 00000000dead4ead ffffffff00000000  |......N.........|
c0000000f40003e0 ffffffffffffffff c00000000f335e08  |.............3^.|
c0000000f40003f0 c00000000f3979e8 00000000dead4ead  |.....9y.......N.|

