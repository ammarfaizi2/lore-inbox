Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUENWNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUENWNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 18:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUENWNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 18:13:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:36494 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263003AbUENWNN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 18:13:13 -0400
Date: Fri, 14 May 2004 15:15:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: arjanv@redhat.com, benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-Id: <20040514151520.65b31f62.akpm@osdl.org>
In-Reply-To: <20040514114746.GB23863@wohnheim.fh-wedel.de>
References: <20040513145640.GA3430@dreamland.darkstar.lan>
	<1084488901.3021.116.camel@gaston>
	<20040513182153.1feb488b.akpm@osdl.org>
	<20040514094923.GB29106@devserv.devel.redhat.com>
	<20040514114746.GB23863@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
>
> On Fri, 14 May 2004 11:49:23 +0200, Arjan van de Ven wrote:
> > On Fri, May 14, 2004 at 11:47:39AM +0200, Andrew Morton wrote:
> > > There's a `make buildcheck' target in -mm (from Arjan) into which we could
> > > integrate such a tool.  Although probably it should be a different make
> > > target.
> > 
> > I added it to buildcheck for now, based on Keith Owens' check-stack.sh
> > script. I added a tiny bit of perl (shudder) to it to 
> > 1) Make it print in decimal not hex
> > 2) Filter the stack users to users of 400 bytes and higher
> > 
> > I arbitrarily used 400; that surely is debatable.
> 
> Keith' script has the major disadvantage of not working on anything
> but i386.  Here is my old script that works on a few more.

That's nice and simple.  All due respect to Keith, this is something
which humans have a chance of understanding too ;)

I removed the `vmlinux FORCE' targets from the makefile - that was forcing
a full rebuild after I'd just done one.  Just let it check ./vmlinux and if
it's not there, it errors out...

It doesn't do modules, and hence requires a prior allyesconfig.  I think it
would be better to do:

find . -name '*.o' | xargs objdump -d | perl scripts/checkstack.pl i386

but that produces slightly screwy output and, for some reason, duplicated
output:


0x    387c zconf_fopen:					 sub    $0x101c,%esp
0x     3c0 huft_build:					 sub    $0x5ac,%esp
0x       0 huft_build:					 sub    $0x5ac,%esp
0x       0 huft_build:					 sub    $0x59c,%esp
0x     d30 inflate_dynamic:				 sub    $0x528,%esp
0x    10f0 inflate_dynamic:				 sub    $0x528,%esp
0x     c10 inflate_dynamic:				 sub    $0x524,%esp
0x      23 zconfparse:					 sub    $0x50c,%esp
   3:	81 ec fc 04 00 00    	sub    $0x4fc,%esp yyparse:	 sub    $0x4fc,%esp
0x     f9c inflate_fixed:				 sub    $0x490,%esp
0x     bdc inflate_fixed:				 sub    $0x490,%esp
0x     abc inflate_fixed:				 sub    $0x490,%esp
0x    3d54 conf_read:					 sub    $0x41c,%esp
0x    fca0 snd_pcm_hw_params_old_user:			 sub    $0x358,%esp
0x    fc28 snd_pcm_hw_refine_old_user:			 sub    $0x358,%esp
0x    6c58 snd_pcm_hw_refine_old_user:			 sub    $0x358,%esp
0x   10448 snd_pcm_hw_refine_old_user:			 sub    $0x358,%esp
0x   104c0 snd_pcm_hw_params_old_user:			 sub    $0x358,%esp
0x    54e0 snd_pcm_hw_params_old_user:			 sub    $0x358,%esp
0x    5468 snd_pcm_hw_refine_old_user:			 sub    $0x358,%esp
0x    6cd0 snd_pcm_hw_params_old_user:			 sub    $0x358,%esp
0x    42db conf_write:					 sub    $0x30c,%esp
0x      c8 nlmclnt_proc:				 sub    $0x280,%esp
0x    1b54 snd_pcm_oss_get_formats:			 sub    $0x280,%esp
0x   1d074 snd_pcm_oss_get_formats:			 sub    $0x280,%esp
0x   761c8 nlmclnt_proc:				 sub    $0x280,%esp
0x   1c854 snd_pcm_oss_get_formats:			 sub    $0x280,%esp
0x     4b8 nlmclnt_proc:				 sub    $0x280,%esp
0x    1b54 snd_pcm_oss_get_formats:			 sub    $0x280,%esp


You wanna take a look at that please?


