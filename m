Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUEOAGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUEOAGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264662AbUENX4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:56:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:37583 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264562AbUENXqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:46:49 -0400
Date: Fri, 14 May 2004 16:48:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: chrisw@osdl.org, joern@wohnheim.fh-wedel.de, arjanv@redhat.com,
       benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-Id: <20040514164854.4d81a349.akpm@osdl.org>
In-Reply-To: <20040514161904.C21045@build.pdx.osdl.net>
References: <20040513145640.GA3430@dreamland.darkstar.lan>
	<1084488901.3021.116.camel@gaston>
	<20040513182153.1feb488b.akpm@osdl.org>
	<20040514094923.GB29106@devserv.devel.redhat.com>
	<20040514114746.GB23863@wohnheim.fh-wedel.de>
	<20040514151520.65b31f62.akpm@osdl.org>
	<20040514155643.G22989@build.pdx.osdl.net>
	<20040514161814.3e1f690e.akpm@osdl.org>
	<20040514161904.C21045@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Andrew Morton (akpm@osdl.org) wrote:
> > Well find .  -name '*.o' -a -not -name '*.mod.o' would fix that up but the
> > dupes are coming from the intermediate .o files which the build system
> > prepares.  sound/core/snd.o contains sound/core/snd-pcm.o contains
> > sound/core/pcm_native.o.
> 
> i wonder if limiting to vmlinux and .ko's would be clean?

Seems to work.

.PHONY: checkstack
checkstack:
	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
	$(PERL) scripts/checkstack.pl $(ARCH)

But we still get a little bit of misparsing:

0xc01e37a0 sys_semtimedop:				 sub    $0x1d4,%esp
0xc01d1d0f do_udf_readdir:				 sub    $0x1cc,%esp
0xc01bbc0c nfs_writepage_sync:				 sub    $0x1b8,%esp
0xc02d79c4 snd_mixer_oss_build_input:			 sub    $0x1a4,%esp
0xc031c7ec ip_getsockopt:				 sub    $0x194,%esp
0xc04c5dc0 snd_seq_oss_midi_lookup_ports:		 sub    $0x190,%esp
0xc04c5f88 snd_seq_system_client_init:			 sub    $0x190,%esp
 4c4:	81 ec 90 01 00 00    	sub    $0x190,%esp snd_virmidi_dev_attach_seq: sub    $0x190,%esp
0xc02c1783 snd_ctl_elem_add:				 sub    $0x190,%esp
0xc01a715c fat_search_long:				 sub    $0x190,%esp
0xc027c2a4 sg_ioctl:					 sub    $0x184,%esp
0xc017843c ep_send_events:				 sub    $0x184,%esp

