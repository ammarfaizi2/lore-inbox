Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWDNAVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWDNAVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWDNAVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:21:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:9122 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965069AbWDNAVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:21:53 -0400
Subject: Current git Oopsen with pcmcia/cardbus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ben Collins <ben.collins@ubuntu.com>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 10:21:40 +1000
Message-Id: <1144974101.5006.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current git is giving me Oopses when inserting a cardbus card. The setup
is a ppc laptop running some recent ubuntu dapper. It's supposedly
running pcmciautils but I do get messages about deprecated ioctl's being
called and the crash is in one of pcmcia_ioctl, thus something is still
calling the old cardctl I suppose, not sure what. In any case, it
shouldn't crash...

The crash happens every second or so, thus it could be some daemon
polling the slots using an old ioctl, unless it's a really old
pcmciautils ? (Version: 012-1ubuntu4)

The Oops is due to get_pcmcia_device() returning NULL in
DS_GET_CONFIGURATION_INFO (though it could happen in DS_GET_STATUS as
well since it doesn't test the result. I think the quick fix (if we
don't completely remove pcmcia_ioctl) is to test for NULL and return
some error instead of calling  pccard_get_configuration_info() with a
NULL argument.

Now, why does it return NULL, I don't know ... I suspect maybe somethign
gets wrong with the "Function" search vs. cardbus cards ? Anything I can
do to help track that one down ?

[  195.930988]  <1>Unable to handle kernel paging request for data at address 0x00000009
[  195.951180] Faulting instruction address: 0xc225c36c
[  195.951974] Oops: Kernel access of bad area, sig: 11 [#3]
[  195.952740]
[  195.953426] Modules linked in: prism54 dm_mod md_mod therm_adt746x bcm43xx pcmcia firmware_class ohci1394 ieee1394 ehci_hcd ieee80211softmac
 uninorth_agp agpgart yenta_socket rsrc_nonstatic pcmcia_core ieee80211 ieee80211_crypt
[  195.955753] NIP: C225C36C LR: C225E9C8 CTR: 00000000
[  195.956526] REGS: bff21dc0 TRAP: 0300   Not tainted  (2.6.17-rc1)
[  195.957316] MSR: 00009032 <EE,ME,IR,DR>  CR: 40048442  XER: 00000000
[  195.958281] DAR: 00000009, DSISR: 40000000
[  195.959020] TASK = bfeb32c0[3552] 'cardctl' THREAD: bff20000
[  195.959198] GPR00: 00018018 BFF21E70 BFEB32C0 00000014 00000000 818FA400 818FA444 00000000
[  195.960281] GPR08: 00009032 00000008 818F9584 818F9584 80000448 1001B4A0 100D0000 100D0000
[  195.961371] GPR16: 00000000 10000000 10000000 10000000 7FD91454 43300000 7FD91778 00000048
[  195.962454] GPR24: 10010000 10010000 7FD91A80 818FA400 818F9428 818F9428 7FD91454 818FA400
[  195.964161] NIP [C225C36C] pccard_get_configuration_info+0x2c/0x240 [pcmcia]
[  195.965022] LR [C225E9C8] ds_ioctl+0x5e8/0x860 [pcmcia]
[  195.965829] Call Trace:
[  195.966512] [BFF21E70] [8006ADF4] vma_merge+0x174/0x200 (unreliable)
[  195.967374] [BFF21E90] [C225E9C8] ds_ioctl+0x5e8/0x860 [pcmcia]
[  195.968217] [BFF21ED0] [80094BC4] do_ioctl+0x84/0x90
[  195.969013] [BFF21EE0] [80094C5C] vfs_ioctl+0x8c/0x460
[  195.969827] [BFF21F10] [80095070] sys_ioctl+0x40/0x80
[  195.970641] [BFF21F40] [8000FBB4] ret_from_syscall+0x0/0x38
[  195.971470] --- Exception: c01 at 0xff6a258
[  195.972226]     LR = 0xffed510
[  195.972919] Instruction dump:
[  195.973626] 60000000 7c0802a6 9421ffe0 90010024 bfa10014 7c7d1b78 7cbf2b78 60000000
[  195.974677] 80030010 38600014 70090008 41820064 <88040009> 98050000 60000000 60000000


Cheers,
Ben.


