Return-Path: <linux-kernel-owner+w=401wt.eu-S1754739AbWLRXHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbWLRXHK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbWLRXHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:07:10 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:47379 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbWLRXHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:07:08 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigel@nigel.suspend2.net
Subject: Re: [linux-pm] OOPS: divide error while s2dsk (2.6.20-rc1-mm1)
Date: Tue, 19 Dec 2006 00:09:08 +0100
User-Agent: KMail/1.9.1
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-pm@lists.osdl.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       linux-pm@osdl.org
References: <4586797B.3080007@gmail.com> <200612182338.24843.rjw@sisk.pl> <1166481878.5044.4.camel@nigel.suspend2.net>
In-Reply-To: <1166481878.5044.4.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612190009.09560.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 18 December 2006 23:44, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2006-12-18 at 23:38 +0100, Rafael J. Wysocki wrote:
> > On Monday, 18 December 2006 18:02, Jiri Slaby wrote:
> > > Rafael J. Wysocki wrote:
> > > > Hi,
> > > > 
> > > > On Monday, 18 December 2006 12:20, Jiri Slaby wrote:
> > > >> Hi.
> > > >>
> > > >> I got this oops while suspending:
> > > >> [  309.366557] Disabling non-boot CPUs ...
> > > >> [  309.386563] CPU 1 is now offline
> > > >> [  309.387625] CPU1 is down
> > > >> [  309.387704] Stopping tasks ... done.
> > > >> [  310.030991] Shrinking memory... -<0>divide error: 0000 [#1]
> > > >> [  310.456669] SMP
> > > >> [  310.456814] last sysfs file:
> > > >> /devices/pci0000:00/0000:00:1e.0/0000:02:08.0/eth0/statistics/collisions
> > > >> [  310.456919] Modules linked in: eth1394 floppy ohci1394 ide_cd ieee1394 cdrom
> > > >> [  310.457259] CPU:    0
> > > >> [  310.457260] EIP:    0060:[<c0150c9a>]    Not tainted VLI
> > > >> [  310.457261] EFLAGS: 00210246   (2.6.20-rc1-mm1 #207)
> > > >> [  310.457478] EIP is at shrink_slab+0x9e/0x169
> > > > 
> > > > Looks like we have a problem with slab shrinking here.
> > > > 
> > > > Could you please use gdb to check what exactly is at shrink_slab+0x9e?
> > > 
> > > Sure, but not till Friday, sorry (I am away).
> > 
> > I reproduced this on one box, but then it turned out that EIP was at line 195
> > of mm/vmscan.c where there was
> > 
> > do_div(delta, lru_pages + 1);
> > 
> > Well, I have no idea how this can lead to a divide error (lru_pages is
> > unsigned).
> > 
> > I'm unable to reproduce this on another i386 box, so it seems to be somewhat
> > configuration specific.
> > 
> > Does 2.6.20-rc1 work for you?
> 
> I have a patch in -mm that reduces lru_pages by what shrink_all_zones
> returns. Could shrink_all_zones perhaps be returning incorrect values
> such that lru_pages ends up becoming -1?

I don't think so, but look at the appended patch. ;-)

Greetings,
Rafael


---
Fix a (really bad) typo in shrink_all_memory().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 mm/vmscan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.20-rc1-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.20-rc1-mm1.orig/mm/vmscan.c
+++ linux-2.6.20-rc1-mm1/mm/vmscan.c
@@ -1569,7 +1569,7 @@ unsigned long shrink_all_memory(unsigned
 			sc.swap_cluster_max = nr_pages - ret;
 			freed = shrink_all_zones(nr_to_scan, prio, pass, &sc);
 			ret += freed;
-			lru_pages =- freed;
+			lru_pages -= freed;
 			nr_to_scan = nr_pages - ret;
 			if (ret >= nr_pages)
 				goto out;
