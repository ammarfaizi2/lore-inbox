Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267143AbSKMEIm>; Tue, 12 Nov 2002 23:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267144AbSKMEIm>; Tue, 12 Nov 2002 23:08:42 -0500
Received: from fmr02.intel.com ([192.55.52.25]:8691 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267143AbSKMEIl>; Tue, 12 Nov 2002 23:08:41 -0500
Message-ID: <001401c28acb$47ab2d70$77d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>,
       "Rusty Lynch" <rusty@linux.co.intel.com>
Cc: <vamsi@in.ibm.com>, <rusty@rustcorp.com.au>,
       "lkml" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33L2.0211121906540.29150-100000@dragon.pdx.osdl.net>
Subject: Re: [PATCH] kprobes for 2.5.47
Date: Tue, 12 Nov 2002 20:15:20 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I'm not verifying the address correctly because I need to verify
a kernel mapped address is valid, not a user space address.

Anyone know how to verify a kernel space address is valid?

    -rustyl

----- Original Message -----
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Rusty Lynch" <rusty@linux.co.intel.com>
Cc: <vamsi@in.ibm.com>; <rusty@rustcorp.com.au>; "lkml"
<linux-kernel@vger.kernel.org>
Sent: Tuesday, November 12, 2002 7:08 PM
Subject: Re: [PATCH] kprobes for 2.5.47


> On Tue, 12 Nov 2002, Rusty Lynch wrote:
>
> | When register_kprobe() is called with a bad addr, we crash the kernel.
> | Should it be the reponsibility of the caller, or the kernel to make sure
the
> | addr is ok?
> |
> | The kernel could check by adding a
> |
> | +unsigned short tmp;
> | ....
> | +if(__get_user(tmp, (unsigned short *)p->addr)) {
> | +        ret = -EINVAL;
> | +        goto out;
> | +}
> |
> | to register_kprobe()
>
> This looks good to me.  Kernel should check user addresses.
>
> | > +int register_kprobe(struct kprobe *p)
> | > +{
> | > + int ret = 0;
> | > +
> | > + spin_lock_irq(&kprobe_lock);
> | > + if (get_kprobe(p->addr)) {
> | > + ret = -EEXIST;
> | > + goto out;
> | > + }
> | > + list_add(&p->list, &kprobe_table[hash_ptr(p->addr,
KPROBE_HASH_BITS)]);
> | > +
> | > + p->opcode = *p->addr;
> | > + *p->addr = BREAKPOINT_INSTRUCTION;
> | > + flush_icache_range(p->addr, p->addr + sizeof(kprobe_opcode_t));
> | > + out:
> | > + spin_unlock_irq(&kprobe_lock);
> | > + return ret;
> | > +}
> |
> | BTW, I have a stupid little sample char driver that reads in
address/message
> | pairs and then adds a probe that printk's the message at the address.
This
> | was just my way of learning how to use kprobes.  Should I post it?  I
would
> | love to get feedback on what I did wrong, but I hate to spam the list.
>
> I'd like to see it, but from a learning POV instead of telling
> you what you did wrong with it.
>
> Thanks.
> --
> ~Randy
>   "I read part of it all the way through." -- Samuel Goldwyn

