Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVGLWpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVGLWpe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVGLWnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:43:41 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:20266 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261828AbVGLWlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:41:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tYNtdGigoFdcI9IJLWJzK2KcMwyjeXq7P1D0Zm+QvJgWkUwSainoWCuzzfs67ODxz8eP5D1gm2J7Zii0UVxiKZM9UoTBTEwfW2B/BjwONlsd/3LWQgLlWohaxJfZHoKlFPx52czHSTBGe4pqHl66cYJRmgnvzEUiEd0u/sBpNAk=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>, Tom Duffy <tduffy@sun.com>
Subject: Re: [PATCH 3/27] Add MAD helper functions
Date: Wed, 13 Jul 2005 02:48:07 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
References: <1121203934.14638.27.camel@duffman> <20050712221725.GB14316@mellanox.co.il>
In-Reply-To: <20050712221725.GB14316@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507130248.08387.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 July 2005 02:17, Michael S. Tsirkin wrote:
> Quoting r. Tom Duffy <tduffy@sun.com>:
> > These seem to be mostly coming from cpu_to_be*() and be*_to_cpu().  Is
> > there a good rule of thumb for fixing these warnings?
> 
> Yes.
> Use attributes like __be32 and friends appropriately.

ITYM types. ;-)

Tom, see, for example, drivers/infiniband/core/sysfs.c:
----------------------------------------------------------------------------
   313          in_mad->mad_hdr.attr_id       = cpu_to_be16(0x12); /* PortCounters */
----------------------------------------------------------------------------
drivers/infiniband/core/sysfs.c:313:32: warning: incorrect type in assignment (different base types)
drivers/infiniband/core/sysfs.c:313:32:    expected unsigned short [unsigned] [usertype] attr_id
drivers/infiniband/core/sysfs.c:313:32:    got restricted unsigned short [usertype] [force] <noident>
----------------------------------------------------------------------------
Grepping for attr_id in drivers/infiniband/ shows that:
1) in_mad->attr_id is set to IB_SMP_ATTR_NODE_INFO (network order)
2) mad->mad_hdr.attr_id is compared with IB_SMP_ATTR_PORT_INFO (network order)
3) *->mad_hdr.attr_id is set to big-endian value

All this suggests that struct ib_mad_hdr::attr_id should be __be16 instead of
u16. So, if attr_id is really something big-endian (infiniband people should
know), convert it. If not (unlikely) all those cpu_to_be16() and htons() are
bogus.

HO-WE-VER, be careful and don't blindly shut up sparse. Its warnings exist to
uncover real bugs.
