Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTBKWpg>; Tue, 11 Feb 2003 17:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbTBKWpg>; Tue, 11 Feb 2003 17:45:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:25016 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266638AbTBKWpf>;
	Tue, 11 Feb 2003 17:45:35 -0500
Date: Tue, 11 Feb 2003 14:54:15 -0800
From: Andrew Morton <akpm@digeo.com>
To: warp@mercury.d2dc.net, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.60
Message-Id: <20030211145415.71ccf594.akpm@digeo.com>
In-Reply-To: <20030211144724.25de5820.akpm@digeo.com>
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
	<20030211151615.GA1310@babylon.d2dc.net>
	<20030211144724.25de5820.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2003 22:55:16.0171 (UTC) FILETIME=[A49379B0:01C2D220]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> "Zephaniah E\. Hull" <warp@mercury.d2dc.net> wrote:
> >
> > Interesting BUG() on boot up.
> > 
> 
> The EATA driver's locking in there is so wrong I don't know how to begin to
> describe it ;)  Looks like a misguided cli() conversion.
> 
> Does this get you up and running?
> 

This one is better.

 drivers/scsi/eata.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff -puN drivers/scsi/eata.c~eata-detect-fix drivers/scsi/eata.c
--- 25/drivers/scsi/eata.c~eata-detect-fix	Tue Feb 11 14:50:03 2003
+++ 25-akpm/drivers/scsi/eata.c	Tue Feb 11 14:51:57 2003
@@ -1193,9 +1193,9 @@ static int port_detect \
    }
 #endif
 
-   spin_unlock(&driver_lock);
+   spin_unlock_irq(&driver_lock);
    sh[j] = scsi_register(tpnt, sizeof(struct hostdata));
-   spin_lock(&driver_lock);
+   spin_lock_irq(&driver_lock);
 
    if (sh[j] == NULL) {
       printk("%s: unable to register host, detaching.\n", name);
@@ -1450,9 +1450,8 @@ static void add_pci_ports(void) {
 
 static int eata2x_detect(Scsi_Host_Template *tpnt) {
    unsigned int j = 0, k;
-   unsigned long spin_flags;
 
-   spin_lock_irqsave(&driver_lock, spin_flags);
+   spin_lock_irq(&driver_lock);
 
    tpnt->proc_name = "eata2x";
 
@@ -1490,7 +1489,7 @@ static int eata2x_detect(Scsi_Host_Templ
       }
 
    num_boards = j;
-   spin_unlock_irqrestore(&driver_lock, spin_flags);
+   spin_unlock_irq(&driver_lock);
    return j;
 }
 

_

