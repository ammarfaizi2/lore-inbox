Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVEKRoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVEKRoo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVEKRoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:44:44 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:7593 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262005AbVEKRoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:44:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Carsten Otte <cotte@freenet.de>
Subject: Re: [RFC/PATCH 2/5] mm/fs: add execute in place support
Date: Wed, 11 May 2005 19:31:09 +0200
User-Agent: KMail/1.7.2
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, schwidefsky@de.ibm.com,
       Andrew Morton <akpm@osdl.org>
References: <428216F7.30303@de.ibm.com> <1115826428.26913.1069.camel@dyn318077bld.beaverton.ibm.com> <4282307D.8060307@freenet.de>
In-Reply-To: <4282307D.8060307@freenet.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505111931.11799.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 11 Mai 2005 18:19, Carsten Otte wrote:
> Badari Pulavarty wrote:
> >you may want to look into some how eliminating few
> >function pointer de-refs and checks for those who don't care.
> >(#ifdef, unlikely(), or some arch & config magic).
> >  
> >
> I do agree that addidional pointer derefs would be a nightmare
> from the performance perspective. But afaics the patch does not
> add such, and for checks I did already add likeleyness for the non-xip
> case. Could you be more precise and specify which code path(es) you
> mean?

I guess what Badari means is that you could add a function like

#ifdef CONFIG_FS_XIP
static inline int mapping_has_xip(struct address_space *mapping)
{
	return __unlikely(mapping->a_ops->get_xip_page != NULL);
}
#else
#define mapping_has_xip(x) (0)
#endif

Using this in the hot path should result identical binary code to the
current version as long as XIP is not enabled, while otherwise you
need to access four data cache lines every time.

I wouldn't expect much benefit from this since all these cache lines
should be pretty hot and the branch gets predicted correctly anyway,
but it surely doesn't hurt to do the abstraction.

	Arnd <><
