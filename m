Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265897AbUGZUIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUGZUIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUGZUIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:08:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55007 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266078AbUGZTUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 15:20:11 -0400
Date: Sun, 25 Jul 2004 19:38:35 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Martins Krikis <mkrikis@yahoo.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC][PATCH] ataraid_end_request hides errors (all? 2.4 kernels)
Message-ID: <20040725223835.GA2170@dmt.cyclades>
References: <20040714041147.87993.qmail@web13708.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714041147.87993.qmail@web13708.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Martins,

On Tue, Jul 13, 2004 at 09:11:47PM -0700, Martins Krikis wrote:
> I know that interest in 2.4 kernels and ataraid at this point
> is probably minimal, and I myself don't use ataraid_end_request.
> 
> However, I would appreciate if somebody could tell me whether a
> patch like the one attached is acceptable or whether the use of
> the BH_PrivateStart flag (style issues aside) can introduce any
> new problems. In particular, I've noticed that ext3 and xfs also
> use this flag.
> 
> The bug that the patch attempts to solve is the following.
> Ataraid_end_request() uses the success/failure of the last
> one of component I/Os as the success/failure of the complete
> I/O (to a RAID volume). Thus, even if all the first components
> fail, as long as the last one succeeds, it will report the
> complete I/O as a success, and the user will not even get
> an indication of any errors. The code is used by all ataraid
> subdrivers except iswraid, as far as I know.

Right, ataraid uses the status ("uptodate") of the last component of 
an IO to inform the real buffer_head IO status, and that is quite bad.

The correct thing seems to pass IO error ("!uptodate") to the upper 
->b_end_io callback only in case both components of an IO operation have 
failed. As long as at least one of the mirrors have successfully 
finished the IO, we should continue operation, providing reliability,
AFAICS. 

About error reporting, indeed the current scheme is very bad and doesnt
correctly report errors. We should at least print some warning on 
ataraid_end_request() informing of IO errors. 

ataraid seems to have been designed with poor IO error handling from 
the beginning.

Arjan, could you please comment on this? 

> If using the BH_PrivateStart is not appropriate in this module,
> a different free bit from b_state can be chosen. Protection
> against component-I/O failure can also be achieved by introducing
> a new field in ataraid_bh_private. Ideally the subdrivers would
> also clear the flag/field, although for a truly unused flag
> in b_state this can be skipped, so a flag-based solution can
> be both quicker and need no extra space, I think.
> 
> Anyway, I'm very interested to hear whether anybody cares
> and whether it is OK to use BH_PrivateStart in block device
> drivers.

Its not OK to mess with BH_PrivateStart, no, jbd/xfs use it
for their own purposes.

Anyway, thanks for the bug report. 

