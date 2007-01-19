Return-Path: <linux-kernel-owner+w=401wt.eu-S932781AbXASALl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbXASALl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932783AbXASALk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:11:40 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:63827 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932781AbXASALk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:11:40 -0500
Date: Thu, 18 Jan 2007 18:09:50 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <fa.O3RzvckSjB73Y0uL8P1nTXDRd6U@ifi.uio.no>
To: linux-kernel@vger.kernel.org
Cc: Larry Walton <lwalton@real.com>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       jeff@garzik.org, htejun@gmail.com, jens.axboe@oracle.com
Message-id: <45B00C4E.4040803@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.U/G88R1fWKOeQK3EBPHKK4MeRsQ@ifi.uio.no>
 <fa.2D0TIXbVTOgZmGg9ZJU+R7te70k@ifi.uio.no>
 <fa.hMhdefkReYJ4idUyqqEWJFnWUBE@ifi.uio.no>
 <fa.8TPWeOrcwkkHutPX5NOcJsTBO8Y@ifi.uio.no>
 <fa.b92BqwV090pDj7q0iBG6BChksbI@ifi.uio.no>
 <fa.O3RzvckSjB73Y0uL8P1nTXDRd6U@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I heard from Larry Walton who was apparently seeing this problem as 
well. He tried my recent "sata_nv: cleanup ADMA error handling v2" patch 
and originally thought it fixed the problem, but it turned out to only 
make it happen less often.

I wouldn't expect that patch to have an effect on this problem. If it 
seems to reduce the frequency that would tend to be further evidence of 
  some kind of timing-related issue where the code change just happens 
to make a difference.

I'll see if I can come up with a debug patch for people having this 
problem to try, which prints out when a flush command is issued and what 
interrupts happen when a flush is pending.

There is one important difference between ADMA and non-ADMA mode for 
non-DMA commands like flushes, which didn't come to mind before: ADMA 
mode uses MMIO registers on the controller whereas non-ADMA mode uses 
legacy IO registers. Posted write flushing is a concern with MMIO 
registers but not with PIO, the libata core is supposed to handle this 
but maybe it doesn't in some case(s). In fact, just looking at 
libata-sff.c there's this comment on the ata_exec_command_mmio function:

  *      FIXME: missing write posting for 400nS delay enforcement

That seems a bit suspicious..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

