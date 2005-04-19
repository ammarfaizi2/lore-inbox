Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVDSOOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVDSOOz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVDSOOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:14:50 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:5771 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261537AbVDSOOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:14:40 -0400
Subject: Re: Can a non-sg scsi write command be more than PAGE_SIZE length?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Olivier Galibert <galibert@pobox.com>,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050419092926.GA9785@infradead.org>
References: <20050419084730.GA96767@dspnet.fr.eu.org>
	 <20050419085008.GA9194@infradead.org>
	 <20050419092431.GA98975@dspnet.fr.eu.org>
	 <20050419092926.GA9785@infradead.org>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 09:14:33 -0500
Message-Id: <1113920073.4998.9.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-19 at 10:29 +0100, Christoph Hellwig wrote:
> Good question actually.  I know XFS does passed vmalloc'ed memory down
> the block I/O path, but that's as a scatter/gather request.  All non-s/g
> request should be contingous I think.
> 
> We really need to write down the rules about what memory can be passed
> down the block I/O path - XFS for example sends kmalloced memory down
> which all the iSCSI implementations don't like at all.

We have two rules and two cases in every driver: sg and non-sg.  (i.e.
use_sg == 0)  this is where we do the distinction between dma_map_sg and
dma_map_single.

If someone wants a project, it should be possible to eject our non-sg
path.  This would mean that all requests go as sg through the block
layer.  The advantages would be

1) internally we would no longer care about kmalloc vs vmalloc memory
2) we wouldn't need to know the gfp flag when allocating internal
requests (block would bounce for us if necessary) thus we could kill the
scsi isa dma flag
3) We could strip the special casing out of every driver ...
4) it should simplify the I/O traversal paths

James


