Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVJULcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVJULcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 07:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVJULcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 07:32:36 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:50972 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S964828AbVJULcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 07:32:35 -0400
Date: Fri, 21 Oct 2005 09:36:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: ddaney@avtrex.com, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Patch: ATI Xilleon port 2/11 net/e100 Memory barriers and write flushing
Message-ID: <20051021083653.GB17881@linux-mips.org>
References: <17239.12568.110253.404667@dl2.hq2.avtrex.com> <4807377b0510201201i685efd46qf4c548da34b996cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4807377b0510201201i685efd46qf4c548da34b996cb@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 12:01:01PM -0700, Jesse Brandeburg wrote:

> > @@ -584,6 +584,7 @@ static inline void e100_write_flush(stru
> >  {
> >         /* Flush previous PCI writes through intermediate bridges
> >          * by doing a benign read */
> > +       wmb();
> >         (void)readb(&nic->csr->scb.status);
> >  }
> 
> I find it odd that this is needed, the readb is meant to flush all
> posted writes on the pci bus, if your bus is conforming to pci
> specifications, this must succeed.  wmb is for host side (processor
> memory) writes to complete, and since we're usually only try to force
> a writeX command to execute immediately with the readb (otherwise lazy
> writes work okay) we shouldn't need a wmb *here*.  not to say it might
> not be missing somewhere else.

wmb is defined as a sync instruction which will only complete once the
write has actually left the CPU, that is citing the spec "has become
globally visible".  Uncached stores such as writeX() may be held in a
writeback buffers potencially infinitely, until this buffer is needed
by another write operation.  The real surprise is to see such behaviour
in a modern piece of silicon; the only that I knew of were the R3000-class
processors and that era has ended over a decade ago, so ATI seems to have
done something funny here.

  Ralf
