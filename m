Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264970AbUEYQxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbUEYQxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 12:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUEYQxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 12:53:46 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:27018
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S264970AbUEYQxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 12:53:43 -0400
Date: Tue, 25 May 2004 18:53:36 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Corey Minyard <minyard@mvista.com>
Subject: Re: IPMI hangup in 2.6.6-rc3
Message-ID: <20040525165335.GA28905@titan.lahn.de>
Mail-Followup-To: Holger Kiehl <Holger.Kiehl@dwd.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Corey Minyard <minyard@mvista.com>
References: <Pine.LNX.4.58.R0405040649310.15047@praktifix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.R0405040649310.15047@praktifix.dwd.de>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Holger, Corey, LKML!

On Tue, May 04, 2004 at 07:05:12AM +0200, Holger Kiehl wrote:
> When compiling in IPMI (not as modules) my system hangs just after
> it prints out detection of IPMI. 2.6.5 did work fine. Compiling
> it as a module and inserting it with modprobe causes modprobe
> to hang in D state, there is nothing unusual in /var/log/messages:
> 
> May  4 08:46:34 apollo kernel: ipmi message handler version v31
> May  4 08:46:34 apollo kernel: IPMI System Interface driver version v31, KCS version v31, SMIC version v31, BT version v31
> May  4 08:46:34 apollo kernel: ipmi_si: Found SMBIOS-specified state machine at I/O address 0xca2
> May  4 08:54:14 apollo kernel: ipmi device interface version v31

Same for me on one of our single Xeon with 2.6.7-rc1. Using SysRq-T I
was able to track it somehow down to the following situation:

modprobe      D C201AD20     0  3735   2415                     (NOTLB)
f6b51f0c 00000082 00000000 c201ad20 c201a0a0 00008124 00000002 00000000
       f7c03000 f6b51ee4 f8bda434 c04b5dc0 c201ad20 00000000 00000000 8ce9c0c0
       000f431a c03b8d80 f75fccd0 f75fce80 00000246 00000003 f6b50000 f7c03000
Call Trace:
 [<f8bdb46d>] ipmi_register_smi+0x22a/0x386 [ipmi_msghandler]
 [<f8b570a6>] init_one_smi+0x1e6/0x4c2 [ipmi_si]
 [<f8b270c2>] init_ipmi_si+0xc2/0x203 [ipmi_si]
 [<c0137910>] sys_init_module+0x116/0x24d
 [<c0106053>] syscall_call+0x7/0xb

modprobe hangs at linux-2.6.7-rc1/drivers/char/ipmi/ipmi_msghandler.c:1727
	wait_event((*intf)->waitq, ((*intf)->curr_channel>=IPMI_MAX_CHANNELS));

This event should be fired by channel_handler(), but isn't for some
unknown reason. I verified this by adding some printk() there, which
wheren't shown.

When I tried a 2.4 kernel with the patches from openipmi.sf.net, I
was somehow able to use IPMI, but got into problems later.

Any idea, what I can do to track the problem further down?

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
