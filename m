Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUBPAE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 19:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUBPAE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 19:04:29 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:41635 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265269AbUBPAEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 19:04:21 -0500
Subject: Re: kthread vs. dm-daemon
From: Christophe Saout <christophe@saout.de>
To: Mike Christie <mikenc@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <402FEF1F.2030308@us.ibm.com>
References: <402A4B52.1080800@centrum.cz>
	 <1076866470.20140.13.camel@leto.cs.pocnet.net>
	 <20040215180226.A8426@infradead.org>
	 <1076870572.20140.16.camel@leto.cs.pocnet.net>
	 <20040215185331.A8719@infradead.org>
	 <1076873760.21477.8.camel@leto.cs.pocnet.net>
	 <20040215194633.A8948@infradead.org>
	 <1076876668.21968.22.camel@leto.cs.pocnet.net>
	 <402FEF1F.2030308@us.ibm.com>
Content-Type: text/plain
Message-Id: <1076889854.5525.22.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 01:04:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 15.02.2004 schrieb Mike Christie um 23:13:

> > Making dm-daemon use the kthread primitives would make dm-daemon a very
> > small and stupid wrapper. Changing all dm targets to handle worker
> > thread notification themselves would result in unnecessary code
> > duplication.
> 
> When dm-multipath is more stable it could be using a work queue (my 
> patch was prematurely sent). Imagine a large number of dm-mp devices 
> multipathing across two fabrics and one switch failing. Every dm-mp 
> device could be resubmitting io at the same time.

I've thought of workqueues but at least for the snapshot and crypt
target they're overkill. I've switched dm-crypt to kthread and the
overhead is minimal. I hope I got it right though but it seems to work
just fine.

> If every write for every dm-raid1 device is going through 
> a single dm-daemon, it could become a bottleneck.

Hmm. The read decryption in dm-crypt is also a only-one-cpu-at-a-time
thing. Didn't anybody notice that? Cryptoloop has the same limitation.
I don't know how that could be handled differently. Every successful
read gets dispatched to the next free cpu and decrypted? What about
writes? They are currently running in the caller context (usually
pdflush).

> I guess you could also just do a thread per target instance, but maybe 
> this was ruled as excessive for thousands of DM devices?

Probably. I originally had one thread per device too for dm-crypt
because I didn't think about it but Joe changed it a single dm-daemon
thread (after porting the dm-daemon code to 2.6). He was right because
the different requests can't depend on each other and deadlock because
the daemon will never wait for io.


