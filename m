Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWANOIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWANOIc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWANOIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:08:32 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:63689 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751441AbWANOIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:08:32 -0500
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] pktcdvd & udf bugfixes
References: <43C5D71B.1060002@cfl.rr.com>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jan 2006 15:08:12 +0100
In-Reply-To: <43C5D71B.1060002@cfl.rr.com>
Message-ID: <m3oe2e2983.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> writes:

> Attached is a patch to fix a few bugs in the pktcdvd driver and udf
> filesystem.  Ben Collins said I should post it to the list and cc Jens
> Axboe as he works on this area.  The patch is rather short, but fixes
> the following bugs:
> 
> 1) The pktcdvd driver was using an 8 bit field to store the packet
> length obtained from the disc track info.  This causes it to overflow
> packet length values of 128 sectors or more.  I changed the field to
> 32 bits to fix this.

The variable is unsigned, so it supports values up to 255, ie no need
to change it.

> 2) The pktcdvd driver defaulted to it's maximum allowed packet length
> when it detected a 0 in the track info field.  I changed this to fail
> the operation and refuse to access the media.  This seems more sane
> than attempting to access it with a value that almost certainly will
> not work.

That code is very old, I think Jens wrote it. I assume it wasn't just
for fun, but to be able to support drives with slightly
broken/non-standard firmware.

> 3) The pktcdvd driver uses a compile time macro constant to define the
> maximum supported packet length.  I changed this from 32 sectors to
> 128 sectors because that allows over 100 MB of additional usable space
> on a 700 MB cdrw, and increases throughput.

The current limit is 32 disc blocks, ie 64KB or 128 "linux sectors".

How do you make the packet size larger for a CDRW disc? Just changing
the constant is not going to help unless you can also format a disc
with larger packets.

> At some point I hope to find the time to refactor pktcdvd to properly
> allocate buffers of the length specified on the disc rather than the
> compile time maximum, but that will be a larger change and require
> more testing.

Might be a good idea. On DVD discs the block size is only 32KB, so
half of the allocated memory is unused.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
