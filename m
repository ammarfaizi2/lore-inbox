Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVHDPp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVHDPp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVHDPnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:43:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31638 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262609AbVHDPlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:41:10 -0400
Date: Thu, 4 Aug 2005 11:40:23 -0400
From: Dave Jones <davej@redhat.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>,
       linux-scsi@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH 1/2] cpqfc: fix for "Using too much stach" in 2.6 kernel
Message-ID: <20050804154023.GA22886@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rolf Eike Beer <eike-kernel@sf-tec.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>,
	linux-scsi@vger.kernel.org, axboe@suse.de
References: <4221C1B21C20854291E185D1243EA8F302623BCC@bgeexc04.asiapacific.cpqcorp.net> <200508041138.38216@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508041138.38216@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 11:38:30AM +0200, Rolf Eike Beer wrote:
 > 
 > >+	  ulFibreFrame = kmalloc((2048/4), GFP_KERNEL);
 > The size bug was already found by Dave Jones. This never should be written 
 > this way (not your fault). The array should have been [2048/sizeof(ULONG)].

wasteful. We only ever use 2048 bytes of this array, so doubling
its size on 64bit is pointless, unless you make changes later on
in the driver. (Which I think don't make sense, as we just copy
32 64byte chunks).

Ermm, actually this looks totally bogus..
CpqTsGetSFQEntry() ...

    if( total_bytes <= 2048 )
    {
      memcpy( ulDestPtr,
              &fcChip->SFQ->QEntry[consumerIndex],
              64 );  // each SFQ entry is 64 bytes
      ulDestPtr += 16;   // advance pointer to next 64 byte block
    }

we're trashing the last 48 bytes of every copy we make.
Does this driver even work ?

		Dave

