Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbSKMDGt>; Tue, 12 Nov 2002 22:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbSKMDGs>; Tue, 12 Nov 2002 22:06:48 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267120AbSKMDGq>;
	Tue, 12 Nov 2002 22:06:46 -0500
Date: Tue, 12 Nov 2002 19:08:12 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: <vamsi@in.ibm.com>, <rusty@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kprobes for 2.5.47
In-Reply-To: <004b01c28ab8$2f89a2c0$77d40a0a@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.33L2.0211121906540.29150-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2002, Rusty Lynch wrote:

| When register_kprobe() is called with a bad addr, we crash the kernel.
| Should it be the reponsibility of the caller, or the kernel to make sure the
| addr is ok?
|
| The kernel could check by adding a
|
| +unsigned short tmp;
| ....
| +if(__get_user(tmp, (unsigned short *)p->addr)) {
| +        ret = -EINVAL;
| +        goto out;
| +}
|
| to register_kprobe()

This looks good to me.  Kernel should check user addresses.

| > +int register_kprobe(struct kprobe *p)
| > +{
| > + int ret = 0;
| > +
| > + spin_lock_irq(&kprobe_lock);
| > + if (get_kprobe(p->addr)) {
| > + ret = -EEXIST;
| > + goto out;
| > + }
| > + list_add(&p->list, &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
| > +
| > + p->opcode = *p->addr;
| > + *p->addr = BREAKPOINT_INSTRUCTION;
| > + flush_icache_range(p->addr, p->addr + sizeof(kprobe_opcode_t));
| > + out:
| > + spin_unlock_irq(&kprobe_lock);
| > + return ret;
| > +}
|
| BTW, I have a stupid little sample char driver that reads in address/message
| pairs and then adds a probe that printk's the message at the address.  This
| was just my way of learning how to use kprobes.  Should I post it?  I would
| love to get feedback on what I did wrong, but I hate to spam the list.

I'd like to see it, but from a learning POV instead of telling
you what you did wrong with it.

Thanks.
-- 
~Randy
  "I read part of it all the way through." -- Samuel Goldwyn

