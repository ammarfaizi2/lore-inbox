Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUFAGjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUFAGjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 02:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUFAGjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 02:39:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2522 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264910AbUFAGjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 02:39:51 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1-mm1
References: <20040527015259.3525cbbc.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Jun 2004 00:38:14 -0600
In-Reply-To: <20040527015259.3525cbbc.akpm@osdl.org>
Message-ID: <m11xkzye95.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> add-i386-readq.patch
>   add i386 readq()/writeq()

- Again this is logically broken.

  On 32bit-PCI bursts (the basic unit of transfer) can be split and
  merged on 32bit boundaries so you can't be atomic on the bus.  But
  note even if a  64bit transaction is split (which is unlikely) the
  order of the operations on the device will remain the same because
  of pci ordering rules.

  On 64bit-PCI bursts can only be split on 64bit boundaries so there
  are 64bit atomic cycles on the bus.

  In PCI-X bursts can only be split when the address is a multiple
  of 128.  So cards can care about atomic 64bit cycles.

  In PCI-E switches do not touch the packets and devices are explicitly
  allowed to reject any packet they don't like.

So a readq or a writeq can on existing hardware be detected, and cared
about.

The strongest argument that this readq/writeq is broken
is this chunk of the hpet patch.

+#if BITS_PER_LONG == 64
+#define        write_counter(V, MC)    writeq(V, MC)
+#define        read_counter(MC)        readq(MC)
+#else
+#define        write_counter(V, MC)    writel(V, MC)
+#define        read_counter(MC)        readl(MC)
+#endif

The code still cares and does not trust the readq/writeq emulations
to do the same thing as their atomic counter parts.

So would a patch that names those helper functions readl2 and writel2
be acceptable?  Just so it is clear what they do?

Eric
