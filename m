Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWEBO6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWEBO6Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWEBO6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:58:25 -0400
Received: from test-iport-3.cisco.com ([171.71.176.78]:10936 "EHLO
	test-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S964858AbWEBO6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:58:25 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5 of 13] ipath - use proper address translation routine
X-Message-Flag: Warning: May contain useful information
References: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com>
	<ada3bftvatf.fsf@cisco.com>
	<1146509646.20760.63.camel@laptopd505.fenrus.org>
	<aday7xltvtb.fsf@cisco.com> <20060502133507.GA26704@infradead.org>
	<adaaca0mrn1.fsf@cisco.com>
	<1146581705.3519.61.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 02 May 2006 07:58:22 -0700
In-Reply-To: <1146581705.3519.61.camel@localhost.localdomain> (Alan Cox's message of "Tue, 02 May 2006 15:55:04 +0100")
Message-ID: <ada64komq29.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 May 2006 14:58:24.0036 (UTC) FILETIME=[DC342640:01C66DF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Alan> For most drivers properly, but you are making assumptions
    Alan> again. Why can't a driver which is doing its own mapping not
    Alan> also do its own rdma cookie handling ? You opt out of
    Alan> mapping being done for you, then you get opted out of
    Alan> defaults for other stuff too.

You're right, and that was what I was driving at in my earlier message
when I talked about overriding the dma mapping operations for a
device.  That would let ipath or whatever create its own RDMA cookies,
and keep track of the struct page or kernel virtual address of the
original memory, so it can do memcpy when needed.

I don't think the idea lets you push mapping down into the low-level
driver, though.  Take the SRP initiator as a specific example.  The
SCSI midlayer gives SRP a SCSI command to send.  The SRP initiator
formats that into an SRP message, with a "memory descriptor" (address
and RDMA cookie) for the buffer associated with the SCSI command, and
tells the low-level driver to send that message to the target.  The
target then performs RDMA into that buffer, sending back only the RDMA
cookie and address.

So unless you teach every low-level driver how to snoop inside SRP
messages (along with NFS/RDMA, iSER and all the other protocols), I
don't see where the low-level driver has a chance to do the mapping.

 - R.
