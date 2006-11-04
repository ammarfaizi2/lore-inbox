Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWKDMwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWKDMwr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 07:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWKDMwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 07:52:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19901 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932563AbWKDMwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 07:52:46 -0500
Date: Sat, 4 Nov 2006 12:52:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Luugi Marsan <luugi.marsan@amd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Workaround for SB600 SATA ODD issue
Message-ID: <20061104125245.GB5787@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Luugi Marsan <luugi.marsan@amd.com>, linux-kernel@vger.kernel.org
References: <20061103190004.9ED8DCBD48@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061103190004.9ED8DCBD48@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 02:00:04PM -0500, Luugi Marsan wrote:
> From: conke.hu@amd.com
> 
> There was an ASIC bug in the SB600 SATA controller of low revision (<=13) and CD burning may hang (only SATA ODD has this issue, and SATA HDD works well). The patch provides a workaround for this issue.

Please make the code ahear to Documentation/CodingStyle (aka the style
used everywhere else in ahci.c..)

Something like:

static int ahci_check_atapi_dma(struct ata_queued_cmd *qc)
{
	struct pci_dev *pdev = to_pci_dev(qc->ap->host->dev);

	/*
	 * Walkaround for ATI/AMD SB600 SATA ODD isue.
	 */
	if (pdev->vendor = PCI_VENDOR_ID_ATI && pdev->device == 0x4380) {
		struct ahci_host_priv *priv = qc->ap->host->private_data;

		if (priv->rev < 14) {
			u32 rq_len = qc->scsicmd->request_bufflen;
			u32 low_8k = rq_len & 0x1fff;

			if ((rq_len & 0xffffe000) && low_8k && low_8k < 512)
        	               	return 1;
		}
	}

	return 0;
}
