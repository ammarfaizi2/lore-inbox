Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263889AbUDPWCr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbUDPV7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:59:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:59570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263846AbUDPV6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:58:32 -0400
Date: Fri, 16 Apr 2004 14:58:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       bfennema@falcon.csc.calpoly.edu
Subject: Re: Fix UDF-FS potentially dereferencing null
In-Reply-To: <20040416214104.GT20937@redhat.com>
Message-ID: <Pine.LNX.4.58.0404161456140.3947@ppc970.osdl.org>
References: <20040416214104.GT20937@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Again, "dir" cannot be NULL here, that would be a much more fundamental 
bug and just impossible (the way we get to this thing is to follow the 
directory operations - which we find by looking at "dir").

Maybe we could tell the compiler that "dir" is safe to dereference some 
way? Or add a 'sparse' annotation about safe pointers?

I'd rather just remove the bogus check for a NULL dir pointer..

		Linus

On Fri, 16 Apr 2004, Dave Jones wrote:
>
> Move size instantiation after null check for 'dir', nearer
> to where its first used.
> 
> 		Dave
> 
> --- linux-2.6.5/fs/udf/namei.c~	2004-04-16 22:38:28.000000000 +0100
> +++ linux-2.6.5/fs/udf/namei.c	2004-04-16 22:39:25.000000000 +0100
> @@ -159,7 +159,7 @@
>  	char *nameptr;
>  	uint8_t lfi;
>  	uint16_t liu;
> -	loff_t size = (udf_ext0_offset(dir) + dir->i_size) >> 2;
> +	loff_t size;
>  	lb_addr bloc, eloc;
>  	uint32_t extoffset, elen, offset;
>  	struct buffer_head *bh = NULL;
> @@ -202,6 +202,8 @@
>  		return NULL;
>  	}
>  
> +	size = (udf_ext0_offset(dir) + dir->i_size) >> 2;
> +
>  	while ( (f_pos < size) )
>  	{
>  		fi = udf_fileident_read(dir, &f_pos, fibh, cfi, &bloc, &extoffset, &eloc, &elen, &offset, &bh);
> 
