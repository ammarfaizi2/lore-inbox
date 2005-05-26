Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVEZRQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVEZRQa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVEZRMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:12:55 -0400
Received: from brick.kernel.dk ([62.242.22.158]:43471 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261631AbVEZRKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:10:34 -0400
Date: Thu, 26 May 2005 19:11:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050526171132.GV1419@suse.de>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050526170658.GT1419@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526170658.GT1419@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26 2005, Jens Axboe wrote:
> On Thu, May 26 2005, Jeff Garzik wrote:
> > > static void ahci_qc_prep(struct ata_queued_cmd *qc)
> > > {
> > > 	struct ahci_port_priv *pp = qc->ap->private_data;
> > >-	u32 opts;
> > >+	void *port_mmio = (void *) qc->ap->ioaddr.cmd_addr;
> > > 	const u32 cmd_fis_len = 5; /* five dwords */
> > >+	dma_addr_t cmd_tbl_dma;
> > >+	u32 opts;
> > >+	int offset;
> > >+
> > >+	if (qc->flags & ATA_QCFLAG_NCQ) {
> > >+		pp->sactive |= (1 << qc->tag);
> > >+
> > >+		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
> > >+		readl(port_mmio + PORT_SCR_ACT);	/* flush */
> > >+	}
> > 
> > Wrong, you should do this in ahci_qc_issue not here.
> 
> Are you sure, I moved this on purpose? I think the reason I did this was
> the wording at the back of the the sata-ii spec (appendix b) that says
> something ala 'preset the active bit and transmit a register FIS'. Feel
> free to point me at the authoritative wording in the ACHI spec.
> 
> One thing that I definitely think _was_ wrong with the sactive bit
> before, is that you set it unconditionally of whether this was an NCQ
> command or not. The maxtor drives don't clear sactive on non-fpdma
> commands, which confused me at first.

Re-reading AHCI spec, it does indicate that you want to set SActive
after building the command. I'll move it back, but keep the conditional
of setting SActive on queued commands.

-- 
Jens Axboe

