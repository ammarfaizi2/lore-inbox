Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbTJFTcu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTJFTcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:32:50 -0400
Received: from mcomail04.maxtor.com ([134.6.76.13]:9231 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S261508AbTJFTcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:32:47 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB20A@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Daniel B.'" <dsb@smart.net>, linux-kernel@vger.kernel.org
Subject: RE: IDE DMA errors, massive disk corruption:  Why?  Fixed Yet?  W
	hy not  re-do failed op?
Date: Mon, 6 Oct 2003 13:32:47 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Daniel B. [mailto:dsb@smart.net]
> Sent: Monday, October 06, 2003 12:42 PM
> To: linux-kernel@vger.kernel.org
> Subject: IDE DMA errors, massive disk corruption: Why? Fixed Yet? Why
> not re-do failed op?
> 
> Doesn't the kernel keep track of uncompleted operations,
> retain the information needed to try again, and try again
> if there's a failure?  If not, why not?

If the disk has write cache enabled, this isn't necessarilly possible, since
there's nothing in the IDE specification that guarantees the order of writes
to the media without a FLUSH CACHE (EXT) command.

Hypothetically, if you were doing full-pack random writes continuously with
no idle time and no FLUSH CACHE, you can have writes that are days old still
in the drive's buffer and still un-attempted.  A write with write-cache
enabled reports ending status at the completion of the transfer.  There is
no mechanism to tell the host that a cached write failed, other than giving
an error on the next command.

Obviously, drive companies have techniques to prevent this (data staying in
buffer for too long) from happening, but they are all vendor specific and
not part of the specification.

The flip side of this, running your drive with write cache off, is rather
destructive to performance in a modern IDE drive... anywhere from 33% as
fast to .1% as fast, depending on the workload.


> If it can't try again, shouldn't the kernel at least abort after one 
> disk-write failure instead of performing additional writes, which
> frequently depend on the previous writes?  (E.g., if I try to read 
> block 1's data and write it to block 2, and then write something new 
> to block 1, if the first write fails but continue and do the second
> write, data gets destroyed.  If the first write fails and I 
> stop right 
> away, less is destroyed.)

If a modern IDE disk gets a fatal write, it is toast.  The lengths drives go
through attempting to reassign to a new location are rather heroic IMO.

Any drive that gets a "real" fatal write (0x71 status for example) as
opposed to a timeout needs to be RMA'd back to the vendor.  Some drives will
work in a read-only mode if they get power cycled, but it isn't always
guaranteed.  If you can get your data off, do so immediately, and replace
the drive.

--eric
