Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVDXJmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVDXJmr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 05:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVDXJmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 05:42:47 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:53253 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262295AbVDXJmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 05:42:43 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jesper Juhl <juhl-lkml@dif.dk>,
       Ben Fennema <bfennema@falcon.csc.calpoly.edu>
Subject: Re: [PATCH] udf: uint32_t can't be less than zero
Date: Sun, 24 Apr 2005 12:42:00 +0300
User-Agent: KMail/1.5.4
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0504232037060.2474@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504232037060.2474@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504241242.00619.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 April 2005 21:48, Jesper Juhl wrote:
> Here's a patch that removes a few bits from fs/udf/balloc.c that 
> test uint32_t values for being less than zero, which is impossible.
> 
> I know not everyone agree with this sort of cleanup, but I figured I'd do 
> the patch in any case, then leave it up to the maintainer to apply it or 
> drop it.
> 
> Please keep me on CC: when replying.
> -	if (bloc.logicalBlockNum < 0 ||
> -		(bloc.logicalBlockNum + count) > UDF_SB_PARTLEN(sb, bloc.partitionReferenceNum))
> +	if ((bloc.logicalBlockNum + count) > UDF_SB_PARTLEN(sb, bloc.partitionReferenceNum))

It is not immediately visible here that bloc.logicalBlockNum is unsigned.
One needs to check that by looking at the definition.

Also if later someone changes bloc.logicalBlockNum into signed entity, code
becomes buggy. Not good.

gcc already optimizes out such checks:

# gcc -O2 t.c -S -fomit-frame-pointer
# cat t.c t.s
extern unsigned v;

int f() {
    return v<0 || v>100 || v==50;
}
        .file   "t.c"
        .text
        .p2align 2,,3
.globl f
        .type   f, @function
f:
        movl    v, %edx
        xorl    %eax, %eax
        cmpl    $100, %edx
        ja      .L3
        cmpl    $50, %edx
        je      .L3
        ret
        .p2align 2,,3
.L3:
        movl    $1, %eax
        ret
        .size   f, .-f
        .section        .note.GNU-stack,"",@progbits
        .ident  "GCC: (GNU) 3.4.3"
--
vda

