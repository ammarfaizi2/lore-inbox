Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTDRQQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTDRQQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:16:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:274 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263160AbTDRQON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:14:13 -0400
Date: Fri, 18 Apr 2003 09:26:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: akpm@digeo.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct loop_info64
In-Reply-To: <UTC200304181304.h3ID4tU00820.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0304180922370.2950-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Apr 2003 Andries.Brouwer@cwi.nl wrote:
> +struct loop_info64 {
> +	int		   lo_number;		/* ioctl r/o */
> +	unsigned long long lo_device; 		/* ioctl r/o */
> +	unsigned long	   lo_inode; 		/* ioctl r/o */
> +	unsigned long long lo_rdevice; 		/* ioctl r/o */

Make these be explicitly sized, and try to put the 64-bit members at the 
beginning to avoid alignment and structure packing problems. Ie something 
more like

	struct loop_info64 {
		u64	lo_device;
		u64	lo_rdevice;
		u64	lo_inode;
		u32	lo_number;
		...

> +	int		   lo_offset;

Any reason to keep an "offset" as "int"? It should probably be "u64" as 
well.

If you call a structure "info64", make the fact that it's 64-bit
_explicit_. That way it will look and work the same on things like x86 and
x86-64, without the need to have translation layers for binary
compatibility.

We should literally have the rule that any user-visible data structures 
cannot use _any_ types other than u8/u16/u32/u64 (and _maybe_ the signed 
ones, if there is any real reason to).

		Linus

