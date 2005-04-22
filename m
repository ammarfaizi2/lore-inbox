Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVDVHwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVDVHwL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVDVHwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:52:11 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:28043 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261239AbVDVHwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:52:06 -0400
Date: Fri, 22 Apr 2005 09:52:09 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/10] squashfs: add swabbing infrastructure
Message-ID: <20050422075209.GI10459@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <20050421010817.GB29755@wohnheim.fh-wedel.de> <20050421011045.GC29755@wohnheim.fh-wedel.de> <20050421011126.GD29755@wohnheim.fh-wedel.de> <20050422072037.GB10459@wohnheim.fh-wedel.de> <20050422072200.GC10459@wohnheim.fh-wedel.de> <20050422072251.GD10459@wohnheim.fh-wedel.de> <20050422072355.GE10459@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050422072355.GE10459@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 April 2005 09:23:56 +0200, Jörn Engel wrote:
> +
> +#define SQUASHFS_SWAB(XX)					\
> +u##XX squashfs_swab##XX(u##XX x)	{ return swab##XX(x); }	\
> +u##XX squashfs_ident##XX(u##XX x)	{ return x; }
> +
> +SQUASHFS_SWAB(16)
> +SQUASHFS_SWAB(32)
> +SQUASHFS_SWAB(64)
> +
> +

While it made one function somewhat nicer, I'm not entirely sure this
approach is a good idea in general.  With all the bitfields used,
simple byte-swabbing just doesn't cut it.  Really, the best strategy I
can think of would still be considered A Mess(tm).

It may be time to create a new version of the on-medium layout of the
filesystem.  The new layout is explicitly made big-endian (or
little-endian, whatever) and all structs consist exclusively of u8,
u16, u32 and u64, or their leXX or beXX counterparts.

Advantages:
Swapping is trivially done by beXX_to_cpu and friends.
Code size should decrease significantly.

Disadvantages:
New, incompatible layout.  FS compatibility and code shrinkage are
mutually exclusive.  The thing should be called squashfs2 and have a
completely different code base.
'Bitfield'-access is done by explicit masking and shifting.

Again, this option looks just as rotten as all the previous
alternatives.  The decision is up to you, Phillip.

Jörn

-- 
They laughed at Galileo.  They laughed at Copernicus.  They laughed at
Columbus. But remember, they also laughed at Bozo the Clown.
-- unknown
