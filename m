Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285556AbRLSWaE>; Wed, 19 Dec 2001 17:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285557AbRLSW3y>; Wed, 19 Dec 2001 17:29:54 -0500
Received: from femail5.sdc1.sfba.home.com ([24.0.95.85]:6142 "EHLO
	femail5.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S285556AbRLSW3k>; Wed, 19 Dec 2001 17:29:40 -0500
Date: Wed, 19 Dec 2001 17:29:29 -0500
From: Willem Riede <wriede@home.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Tape driver rationalization for Linux 2.5?
Message-ID: <20011219172929.A23227@linnie.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Being the maintainer of the driver for Onstream tape drives (osst) and
wanting to stay abreast with the kernel evolution, I've been reading up on 
some of the changes that are being made to the scsi sub-system in the 2.5.x 
kernel series, and that has got me thinking...

I've never really understood why there are separate high level drivers for
tape drives -- or cdroms for that matter (other than "it just happened that
way").

Also, I find the fact that the user needs to tell the kernel at boot time
whether (s)he is going to use ide-scsi or not awkward. You should be able
to point any appropriate driver to a device by loading the corresponding
module (and maybe tell the module specifically not to touch some compatible
device, but preferably just gracefully shared and locked (think sg)).

I'm not alone here, quoting Linus from the Scheduler thread:
   'And even more important than performance is being able to read and write
   to CD-RW disks without having to know about things like "ide-scsi" etc,
   and do it sanely over different bus architectures etc.'

Case in point for osst -- it handles IDE (DI-x0), SCSI (SC-x0), USB (USBx0)
and (not quite, but soon) Firewire (FW-x0) drives (it could in theory support
parallel port drives too given the right mid-level driver). So here you have 
a universal high level driver for a certain device type, usable regardless 
of the actual physical interface you use on your PC.

Yet there is ide-tape, which drives (only) DI-x0's too (but it is out of date).
Too often I read complaints on l-k about ide-tape. It is very complex, with
the pipeline, which I believe at today's PC performance has no added value.

The same tension exists between st and ide-tape. Why shouldn't st be the 
driver of choice for each and every QIC-157 compliant drive? (QIC-157 is a 
standard for a common SCSI/ATAPI command set for streaming tape, which in
turn is a subset of the SCSI standard for sequential access devices; 
I believe that's what st supports).

Ide-scsi -- which I feel should be renamed the "atapi" driver needs to be
enhanced to use Atapi Overlap and/or DSC on drives that support it, and then
st and ide-tape minus Onstream support and cdrom-c and sr.c (anything else?)
can be merged... No more ide-tape -- less bloat. (I admit to not knowing 
enough about cdrom drivers to know if the strategy would work there).

What do people think? 

Thanks, Willem Riede.
