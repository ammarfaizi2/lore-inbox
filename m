Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269935AbTGOWrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269940AbTGOWrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:47:20 -0400
Received: from palrel10.hp.com ([156.153.255.245]:4542 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S269935AbTGOWrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:47:15 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.34787.633496.949441@napali.hpl.hp.com>
Date: Tue, 15 Jul 2003 16:01:55 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, scott.feldman@intel.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [patch] e1000 TSO parameter
In-Reply-To: <20030714223822.23b78f9b.davem@redhat.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229169@orsmsx402.jf.intel.com>
	<20030714214510.17e02a9f.davem@redhat.com>
	<16147.37268.946613.965075@napali.hpl.hp.com>
	<20030714223822.23b78f9b.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 14 Jul 2003 22:38:22 -0700, "David S. Miller" <davem@redhat.com> said:

  DaveM> But I don't think that's what is happening here, rather the
  DaveM> PCI controller is "talking" to the CPU's L2 cache with
  DaveM> coherency transactions on all the data of every packet going
  DaveM> to the chip.

That's true.  But shouldn't it be true for both the TSO and non-TSO
case?

  DaveM> Whereas with a sendfile() type setup, the PCI controller is
  DaveM> going straight to main memory for the data part of the
  DaveM> packets since the CPU is unlikely to have each page cache
  DaveM> page in it's L2 caches.

But sendfile() was _not_ used in any of the tests.  The ftp server
installed no the machine doesn't use it (not to my knowledge, at
least) and netperf only uses it for the SENDFILE test.

  DaveM> I know how this can be fixed, can you use L2-bypassing stores
  DaveM> in your csum_and_copy_from_user() and copy_from_user()
  DaveM> implementations like we do on sparc64?  That would exactly
  DaveM> eliminate this situation where the card is talking to the
  DaveM> cpu's L2 cache for all the data during the PCI DMA transation
  DaveM> on the send side.

We could, but would it always be a win?  Especially for
copy_from_user().  Most of the time, that data remains cached, so I
don't think we'd want to use non-temporal stores on those (in
general).  csum_and_copy_from_user() isn't well optimized yet.  Let's
see if I can find a volunteer... ;-)

	--david
