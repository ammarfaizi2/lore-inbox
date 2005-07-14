Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbVGNWgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbVGNWgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVGNWeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:34:11 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:47536 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263159AbVGNWdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:33:19 -0400
Date: Fri, 15 Jul 2005 02:33:23 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: John Rose <johnrose@austin.ibm.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: pci_size() error condition
Message-ID: <20050715023323.C613@den.park.msu.ru>
References: <20050714034019.B25768@jurassic.park.msu.ru> <1121357040.9265.1.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1121357040.9265.1.camel@sinatra.austin.ibm.com>; from johnrose@austin.ibm.com on Thu, Jul 14, 2005 at 11:04:00AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 11:04:00AM -0500, John Rose wrote:
> Okay, point taken :)  So for cases of base == maxbase, why would we ever
> want to return a nonzero value?  What is the intended purpose of the
> second part of that conditional?

Well, just two examples (both for PCI IO limited to 16 bits for simplicity,
but still from real life):
1. Consider some BAR that defines 16 bytes of IO space. It's
   perfectly valid for the PCI firmware to program this BAR to
   its max value, so after writing all 1s during the probe and proper
   masking we have base == maxbase == 0xfff0. But, since all high
   order bits are all 1s, (((base | size) & mask) != mask) is false,
   and we return correct value of 16.
2. Another BAR of some broken PCI device (typically, IDE controller)
   has *read-only* value of 0x1f0, for instance. After writing 0xffff
   we still read back the same 0x1f0, so base == maxbase == 0x1f0.
   But the second part of that "if" clause is now true, so we return 0,
   which means that the BAR is invalid and must be ignored.

Ivan.
