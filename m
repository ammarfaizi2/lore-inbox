Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbUAZF7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 00:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbUAZF7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 00:59:31 -0500
Received: from dp.samba.org ([66.70.73.150]:30855 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265533AbUAZF72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 00:59:28 -0500
Date: Mon, 26 Jan 2004 16:56:33 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Philippe Elie <phil.el@wanadoo.fr>, linux-kernel@vger.kernel.org,
       levon@movementarian.org
Subject: Re: [PATCH] oprofile per-cpu buffer overrun
Message-ID: <20040126055633.GY11236@krispykreme>
References: <20040126023715.GA3166@zaniah> <20040125200701.3c7b769a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125200701.3c7b769a.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>   It helps if the buffer size is a power of two, of course, but integer
>   modulus is pretty quick.

If its something thats hit real hard, the way the modulus is done can
make a difference. We've seen it in various places (eg disabling tigon 1
support in the acenic changes the driver from using a variable to a
compile time constant and you can actually see it in the profile):

quickest == power of 2 compile time constant (results in a mask)
quickish == compile time constant (results in the multiplication by
		an inverse trick)
slow == run time (results in a divide)

Of course you can do like the printk stuff and use a variable but
enforce a power of 2 value and & it.

Anton

--

unsigned long i, j, k;

int quickest()
{
        j = i % 2;
}

int quickish()
{
        j = i % 3;
}

int slow()
{
        j = i % k;
}

--

quickest:
        lis 9,i@ha
        lwz 0,i@l(9)
        lis 9,j@ha
        rlwinm 0,0,0,31,31
        stw 0,j@l(9)
        blr
quickish:
        lis 9,i@ha
        lis 0,0xaaaa
        lwz 11,i@l(9)
        ori 0,0,43691
        lis 9,j@ha
        mulhwu 0,11,0
        srwi 0,0,1
        mulli 0,0,3
        subf 11,0,11
        stw 11,j@l(9)
        blr
slow:
        lis 9,i@ha
        lis 11,k@ha
        lwz 10,i@l(9)
        lwz 9,k@l(11)
        divwu 0,10,9
        mullw 0,0,9
        lis 9,j@ha
        subf 10,0,10
        stw 10,j@l(9)
        blr
