Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTF0I1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 04:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTF0I1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 04:27:15 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:40709 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262584AbTF0I1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 04:27:13 -0400
Date: Fri, 27 Jun 2003 10:41:25 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: write-caches, I/O stalls: MUST-FIX (was: [PATCH] io stalls)
Message-ID: <20030627084125.GD3818@merlin.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <1055356032.24111.240.camel@tiny.suse.com> <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au> <20030612012951.GG1500@dualathlon.random> <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au> <20030612024608.GE1415@dualathlon.random> <1056567822.10097.133.camel@tiny.suse.com> <20030625192523.GB19940@dualathlon.random> <1056572288.10091.161.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056572288.10091.161.camel@tiny.suse.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003, Chris Mason wrote:

> I've no preference really.  I didn't notice a throughput difference but
> my scsi drives only have 2MB of cache.

You shouldn't be using the drive's write cache in the first place!

The write cache, regardless of ATA or SCSI, can, as far as I know, not
be used safely with any Linux file systems (and my questions whether 2.6
will finally change that went unanswered so far), because the write
reordering the write cache can do can seriously damage file systems,
whether journalling or not.

Please conduct all your tests with write caches turned off because
that's what matters in REAL systems; in that case, these latencies
become a REAL pain in the back because writing is so much slower because
of all the seeks.

Optimizing for write cached behaviour can happen not a single second
before:

1. the file systems know how to queue "ordered tags" in the right places
   (write barrier to enforce proper ordering for on-disk consistency,
   which I assume will make for a lot of ordered tags for writing to the
   journal itself)

2. the device driver knows how to map "ordered tags" to flush or
   whatever operations for drives that don't do tagged command queueing
   (ATA mostly, or SCSI when TCQ is switched off).

All these "0-bytes in file" problems with XFS, ReiserFS, JFS, ext2 and
ext3 in data=writeback mode happen because the kernel doesn't care about
write ordering, and these broken files are a) occasionally hard to find,
b) another PITA.

I consider proper write ordering and enforcing thereof a MUST-FIX. This
is much more important than getting some extra latencies squished. It
must do the right thing in the first place, and then it can do the right
thing faster.

I am aware that you're not the only person responsible for the state
Linux is in, and I'd like to see the write barriers revived ASAP for at
least ext2/ext3/reiserfs, sym53c8xx, aic7xxx, tmscsim and IDE. I am
sorry not being able to offer any help on that, I'm not acquainted with
the kernel stuff and I can't donate money to anyone for me to do it.

SCNR.

-- 
Matthias Andree
