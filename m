Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbUBPB3U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 20:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUBPB3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 20:29:20 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:36260 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265280AbUBPB3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 20:29:19 -0500
Subject: Re: kthread vs. dm-daemon
From: Christophe Saout <christophe@saout.de>
To: Mike Christie <mikenc@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <40301713.50609@us.ibm.com>
References: <402A4B52.1080800@centrum.cz>
	 <1076866470.20140.13.camel@leto.cs.pocnet.net>
	 <20040215180226.A8426@infradead.org>
	 <1076870572.20140.16.camel@leto.cs.pocnet.net>
	 <20040215185331.A8719@infradead.org>
	 <1076873760.21477.8.camel@leto.cs.pocnet.net>
	 <20040215194633.A8948@infradead.org>
	 <1076876668.21968.22.camel@leto.cs.pocnet.net>
	 <402FEF1F.2030308@us.ibm.com> <1076889854.5525.22.camel@leto.cs.pocnet.net>
	  <40301713.50609@us.ibm.com>
Content-Type: text/plain
Message-Id: <1076894950.7630.17.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 02:29:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb Mike Christie um 02:04:

> > I've thought of workqueues but at least for the snapshot and crypt
> > target they're overkill. 
> 
> It is a bigger problem for targets submitting io becuase the underlying 
> device's queue could hit nr_requests.

You mean beacause the caller can block and this affects other devices
with free requests too. Hmm.

> > Hmm. The read decryption in dm-crypt is also a only-one-cpu-at-a-time
> > thing. Didn't anybody notice that? Cryptoloop has the same limitation.
> > I don't know how that could be handled differently. Every successful
> > read gets dispatched to the next free cpu and decrypted? 
> 
> You do not have to create a work_struct for every read. Why not just 
> have a bio-successful-reads-queue and a workstruct per device?

I have to call queue_work with a work_struct. queue_work will most
likely be called from interrupt context. The bio will be decrypted on
the same cpu as the interrupt occurs. If the driver returns a bunch of
bio's at once they would all be decrypted on the same cpu sequentally.
So it depends on the irq balancing.

What could be done (probably not with work queues) is: If there is a bio
to decrypt the end_io handler finds a free cpu (empty queue) and puts
the bio there. Another possibility: If there is work it gets just added
to a global list and all threads on all cpu's get fired. The fastest one
will pick a bio, the next one the second... monster cache trashing? I
don't know.


