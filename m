Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbVISVYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbVISVYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVISVYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:24:20 -0400
Received: from main.gmane.org ([80.91.229.2]:64960 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932695AbVISVYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:24:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: p = kmalloc(sizeof(*p), )
Date: Mon, 19 Sep 2005 23:20:02 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.19.21.19.59.501960@smurf.noris.de>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local> <20050918171845.GL19626@ftp.linux.org.uk> <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org> <20050918174549.GN19626@ftp.linux.org.uk> <Pine.LNX.4.61.0509182222030.3743@scrub.home> <20050918211225.GP19626@ftp.linux.org.uk> <20050918215257.GA29417@ftp.linux.org.uk> <Pine.LNX.4.58.0509181513440.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus Torvalds wrote:

> Well, to be slightly more positive: it's not a very easy feature to do
> properly.

It's apparently an easy feature to do decidedly suboptimally.

This sample code

#include <malloc.h>
struct foo {
    char fill1[1000];
    int bar;
    char fill2[1000];
    int baz;
    char fill3[1000];
};
struct foo *get_foo() {
    struct foo *res = malloc(sizeof(struct foo));
    *res = (struct foo){.bar=5, .baz=7};
    return res;
}

calls memcpy _twice_ -- it initializes the object on the stack from a
couple of mostly-zero bytes in .rodata, and then memcpy's the thing to the
heap.
 
> So considering that almost nobody does this (certainly not SpecInt), and
> it would probably require re-organizations at many levels, I'm not
> surprised it hasn't gotten a lot of attention.
> 
This is gcc 4.0. Optimization levels (I tried 0, 3, and s) don't affect
this -- which surprised me; I'd have thought that gcc would decide on
the proper trade-off between programmed and static initialization a bit
later.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
O that my tongue were in the thunder's mouth! Then with a passion would I
shake the world.
					-- Shakespeare


