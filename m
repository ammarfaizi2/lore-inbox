Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270032AbTGPBfB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 21:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270034AbTGPBfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 21:35:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29911 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270032AbTGPBe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 21:34:58 -0400
Date: Tue, 15 Jul 2003 18:39:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] e1000 TSO parameter
Message-Id: <20030715183911.1c18cc15.davem@redhat.com>
In-Reply-To: <16148.34787.633496.949441@napali.hpl.hp.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229169@orsmsx402.jf.intel.com>
	<20030714214510.17e02a9f.davem@redhat.com>
	<16147.37268.946613.965075@napali.hpl.hp.com>
	<20030714223822.23b78f9b.davem@redhat.com>
	<16148.34787.633496.949441@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 16:01:55 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> >>>>> On Mon, 14 Jul 2003 22:38:22 -0700, "David S. Miller" <davem@redhat.com> said:
> 
>   DaveM> But I don't think that's what is happening here, rather the
>   DaveM> PCI controller is "talking" to the CPU's L2 cache with
>   DaveM> coherency transactions on all the data of every packet going
>   DaveM> to the chip.
> 
> That's true.  But shouldn't it be true for both the TSO and non-TSO
> case?

The transfers are each longer in the TSO case, so need more
to transfer more data from the bus just to get _one_ of
the sub-packets of the large TSO frame out.  It thus makes it
more likely they'll be a delay.

>   DaveM> I know how this can be fixed, can you use L2-bypassing stores
>   DaveM> in your csum_and_copy_from_user() and copy_from_user()
>   DaveM> implementations like we do on sparc64?  That would exactly
>   DaveM> eliminate this situation where the card is talking to the
>   DaveM> cpu's L2 cache for all the data during the PCI DMA transation
>   DaveM> on the send side.
> 
> We could, but would it always be a win?  Especially for
> copy_from_user().  Most of the time, that data remains cached, so I
> don't think we'd want to use non-temporal stores on those (in
> general).  csum_and_copy_from_user() isn't well optimized yet.  Let's
> see if I can find a volunteer... ;-)

No, I mean "bypass L2 cache on miss" for stores.  Don't
tell me IA64 doesn't have that? 8) I certainly didn't mean
"always bypass L2 cache" for stores :-)
