Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264958AbUEVL7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbUEVL7w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 07:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUEVL7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 07:59:52 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:51415 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264958AbUEVL7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 07:59:50 -0400
Date: Sat, 22 May 2004 13:59:46 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-ID: <20040522115946.GA7385@merlin.emma.line.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040522013636.61efef73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522013636.61efef73.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2004, Andrew Morton wrote:

> - Implementation of request barriers for IDE and SCSI.  The idea here is
>   that a filesystem can tag an IO request as a barrier and the disk will not
>   reorder writes across the barrier.  It provides additional integrity
>   guarantees for the journalling filesystems.  The feature is enabled for
>   reiserfs and ext3.
> 
>   On reiserfs do `mount /dev/hda /wherever -o barrier=flush' or
>   `barrier=none'.
> 
>   On ext3 do `mount ... -o barrier=1' or `barrier=0'.
> 
>   ext3 also supports `mount -o remount,barrier=N'.  I didn't check whether
>   reiserfs supports switching at remount time and nobody tells me these
>   things.

Ah, progress!

What SCSI low level drivers will translate barriers to tags?

Of particular personal egoistic interest for me are, in decreasing order
of importance: sym53c8xx_2 megaraid aic7xxx tmscsim


How will the system handle the Queue Algorithm Modifier? Appearently,
allowing command reordering is a matter of the device, not of the
individual partitions, so the barrier stuff is a property that would
belong into the block driver rather than into partition handling. Upon
mounting, the file system would have to query if the underlying block
device requires write barriers or will execute commands in order
(control mode page, queue algorithm modifier). If I need to operate the
target with "restricted reordering" algorithm for any other partition
that is mounted without barriers or with a barriers-unaware file system,
we won't gain much by all this barrier stuff for the target mustn't
reorder operations anyways.

The potential benefits of Queue Algorithm Modifier "Unrestricted
Reordering allowed" however requires that all file systems inform the
target about their write ordering requirements. IMHO, the barrier
"switch" does not belong into the file systems -- I don't see OTOH how
using these on a device that performs writes in order will matter, so
using these always will probably not harm (it's still useful for testing
probably).

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95
