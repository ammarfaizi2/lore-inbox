Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVLTWul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVLTWul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVLTWul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:50:41 -0500
Received: from [81.2.110.250] ([81.2.110.250]:45745 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750738AbVLTWuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:50:40 -0500
Subject: Re: ATA Write Error and Time-out Notification in User Space
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Treubig <jtreubig@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <BAY101-F33B48301330A7FFF7849A4DF3E0@phx.gbl>
References: <BAY101-F33B48301330A7FFF7849A4DF3E0@phx.gbl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Dec 2005 22:50:35 +0000
Message-Id: <1135119036.25010.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-20 at 15:55 -0600, John Treubig wrote:
> Where would I look in the LibATA/SCSI chain to permit Write Error and 
> Time-out notification to be passed back to user space without hanging the 
> system?


Some background first:

The 2.6 block layer can generally handle passing errors back up. It has
a load of problems with EOF on media that is variable size but block
that need fixing but the fundamental errors get back to the block layer.

Unfortunately although they get back to the block request the full error
is not propogated further up the stack. Thats actually tricky for the
general file system case as I/O as asynchronous to the actual file
system accesses and we may even hit errors on pages we didn't actually
need.

One result of that is that on write errors we generally mark a volume
offline and processes accessing it get stuck.

> drives.  When a SCSI disks report errors, the SCSI handlers perform as 
> expected, reporting the error and recovering.  When ATA drives report 
> errors, only read errors recover and we are able to capture the error.  
> Write and time-out errors hang the system.

The problem with the file system layer at this point is it isn't clear
how you get the device back. What you should see is a sequence of
retries and then the volume going offline.

I don't know how complete your log is but it doesn't end with the
expected 'giving up' and volume offlining. Is that because the final
messages don't hit the log or are they just not seen ? The promise
devices have some "interesting" behaviour when you reset the chip.

There is a second problem with PATA too. If the drive decides to keel
over asserting IORDY its game over. The bus transactions will hang and
the CPU get stuck. That would _not_ be my first suspicion however.



