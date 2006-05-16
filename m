Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWEPPgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWEPPgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWEPPgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:36:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:4179 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751265AbWEPPgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:36:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hCoAI3He42fwVq/4r7pj6hriLoIddlCj2cp9MUgB3IRMNZHA/mztd1gI9KXAFvu/CUoWYSLV3vC/2ieLwYfQ5NTsZgbgDICqbudYJYcuRhXM1+qkWyM8MWkqcmftI8gBaFwEAWIPnVbnKOGlURNlsz1cGIRCB3dACVbvnqBRf98=
Message-ID: <4469F169.2050708@gmail.com>
Date: Wed, 17 May 2006 00:36:09 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, jgarzik@pobox.com, torvalds@osdl.org
Subject: Re: PATCH: Fix broken PIO with libata
References: <1147790393.2151.62.camel@localhost.localdomain>
In-Reply-To: <1147790393.2151.62.camel@localhost.localdomain>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> #2	The core sets ATA_DFLAG_PIO to indicate PIO commands should be used
> on this channel. This same information is available in dev->dma_mode but
> for some reason we get two sources of the info. The ATA_DFLAG_PIO is set
> once during setup and then cleared but not re-computed by the revalidate
> function. This causes DMA commands to be issued when PIO would be and
> usually an Oops or hang

Hmmm... I tried to fix this problem in the following commit.  With it,
ATA_DFLAG_PIO isn't cleared over ata_dev_configure().  Only
ata_dev_set_mode() is allowed to diddle with it and does about the same
thing as your patch does.

diff-tree ea1dd4e13010eb9dd5ffb4bfabbb472bc238bebb (from
198e0fed9e59461fc1890dd
Author: Tejun Heo <htejun@gmail.com>
Date:   Sun Apr 2 18:51:53 2006 +0900

    [PATCH] libata: clear only affected flags during ata_dev_configure()

    ata_dev_configure() should not clear dynamic device flags determined
    elsewhere.  Lower eight bits are reserved for feature flags, define
    ATA_DFLAG_CFG_MASK and clear only those bits before configuring
    device.  Without this patch, ATA_DFLAG_PIO gets turned off during
    revalidation making PIO mode unuseable.

    Signed-off-by: Tejun Heo <htejun@gmail.com>
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

> Also contains a related bracketing fix

Is this agreed upon?  I tend to omit almost all unnecessary (by operator
precedence) parenthesis, so in new EH and all other stuff, the "a && b &
c" sort of lines are abundant.  If this is something that's agreed upon,
I can do a clean sweep over those.

-- 
tejun
