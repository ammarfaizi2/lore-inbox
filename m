Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVKLFqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVKLFqX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 00:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVKLFqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 00:46:23 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:3762 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932144AbVKLFqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 00:46:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Gy3G73GggDnOdGhiNoeUIF28jO9GDBilRk/U1rOgw8UB6Mpi/pQWPwcx/gl6VPlDbUhpRTVrTHTxyoWPV4trKBhTvG+TGlN+s6AEQyk8q82HVvY2p1kdQiXDTBYhdw0S73XnjBWHxUPyCVqc9JBAeo7H2Hpn4lLGTpG9YPuGU/0=  ;
Message-ID: <20051112054619.57154.qmail@web31801.mail.mud.yahoo.com>
Date: Fri, 11 Nov 2005 21:46:19 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: SAS + Adaptec 94xx git tree updated
To: Jeff Garzik <jgarzik@pobox.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <437474FB.2030407@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> Due to a horribly broken git merge, I was forced to rebase the sas-2.6 
> tree against the latest upstream tree, rather than scsi-misc-2.6.
> 
> So, people interested in SAS and Adaptec 94xx, please pull from 'ALL' 
> branch of
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/sas-2.6.git
> 
> to receive Adaptec's SAS & 94xx code, plus my layering and code 
> duplication fixes.

Jeff,

Your change history is all gone.
Commit 6590bd27f4a1f94e7d5f6566b8a5de5d952ae4a5 just
dumps the whole thing from your old tree as one blob,
while in your old tree you could see what you've actually
done, step by step, patch by patch -- you know, the way
you want people to submit patches to you.

I was hoping that you'd actually post a _patch_ showing
the differences and your development process, similarly
to how you want other people to submit patches to you.

Now as to your commit 6590bd27f4a1f94e7d5f6566b8a5de5d952ae4a5
you say:

    Add new aic94xx driver, and SAS software stack.
    
    Vast majority of code written by Adaptec.

1. But a simple diff reveals that the only thing added is
stuffing the host template down into the aic94xx PCI
device driver.  Remember the aic94xx is a PCI driver, not
yet a SCSI "host".  A la this, in aic94xx_init.c:

+static const struct scsi_host_template aic94xx_sht = {
+       .module                 = THIS_MODULE,
+       /* .name is initialized */
+       .name                   = "aic94xx",
+       .queuecommand           = sas_queuecommand,
+       .eh_strategy_handler    = sas_scsi_recover_host,
+       .eh_timed_out           = sas_scsi_timed_out,
+       .slave_alloc            = sas_slave_alloc,
+       .slave_configure        = sas_slave_configure,
+       .slave_destroy          = sas_slave_destroy,
+       .change_queue_depth     = sas_change_queue_depth,
+       .change_queue_type      = sas_change_queue_type,
+       .bios_param             = sas_bios_param,
+       /* .can_queue is initialized */
+       .this_id                = -1,
+       .sg_tablesize           = SG_ALL,
+       .max_sectors            = SCSI_DEFAULT_MAX_SECTORS,
+       /* .cmd_per_lun is initilized to .can_queue */
+       .use_clustering         = ENABLE_CLUSTERING,
+};
+

Taken straight from drivers/scsi/sas/sas_scsi_host.c and
put into aic94xx_init.c.

2. Also a simple diff of the "new" SAS stack reveals that
among a bunch of #if 0 ... #else or #endif's in
sas_discover.c, you have also _exported_ a bunch more
functions.

Before your changes, the only exported symbols
of _all_ of the SAS stack were _only_ those two (2!):

EXPORT_SYMBOL_GPL(sas_register_ha);
EXPORT_SYMBOL_GPL(sas_unregister_ha);

Now you also export those nine (9) symbols, polluting
the kernel name space unnecessarily:

EXPORT_SYMBOL_GPL(sas_queuecommand);
EXPORT_SYMBOL_GPL(sas_scsi_recover_host);
EXPORT_SYMBOL_GPL(sas_scsi_timed_out);
EXPORT_SYMBOL_GPL(sas_slave_alloc);
EXPORT_SYMBOL_GPL(sas_slave_configure);
EXPORT_SYMBOL_GPL(sas_slave_destroy);
EXPORT_SYMBOL_GPL(sas_change_queue_depth);
EXPORT_SYMBOL_GPL(sas_change_queue_type);
EXPORT_SYMBOL_GPL(sas_bios_param);

Bringing the total from 2 to 11 (eleven!).
(Plus the fact the by the definition of their interface,
those exported functions are SCSI Host specific only.)

While this may allow you to stick to the old "architecture"
of SCSI Core, it breaks the Object Oriented nature of the
SAS stack.  Thus making things more messy, whereby you
have a whole lot of symbols exported and various places
in the kernel calling them.  E.g. libata exports 51
(fifty-one!) symbols.

One reason to keep things in an object oriented manner
as shown in the SAS stack, is _context_, e.g.:

Entity registers for service -->
  Entity gets context -->
     Entity is allowed to call methods of the context -->
     Entity releases context --->
  Entity unregisters the service -->
Entity is ready to be unregistered itself (wlg).

Establishing "context" allows you also to keep "refs" in
check, whereby allowing you to know usage counts of
whole layers, who is using them and when.

But when you throw a bunch of functions out of code,
(exporting them), and have anyone call them at random,
you may have a "ref" problem in the future.

> Since it needs my bare minimum merge goals -- use scsi_scan_target() and 

I was hoping that you'd add support for a "SCSI device
with a SCSI Target port" as my comments in sas_discover.c::
sas_do_lu_discovery() and sas_scsi_host.c::sas_slave_alloc()
point out.

Currently there is still the HCIL hack, as SCSI Core
is still SPI centric, supporting only HCIL.  Bottom
line: nothing has improved in this regard, only SCSI
Core deficiencies masked out.

> put host template in aic94xx -- and since the upstream SAS transport 
> class may require a few changes to fully work with a all-software SAS 
> stack,

"to fully work with a all software SAS stack", hmm?

Listen to the requrements.  E.g. SDI is maybe all that
you want which will
 1) umbrella all implementations,
 2) do it cheaply and easily for the vendors, and
 3) do it cheaply and easily for the customers.

The reason is that, as I've pointed out before, the
transport layer implmentation could be completely done
in FW, as is the case for Fusion MPT, or it could be
split between a FW and the OS.  It would be _messy_
to umbrella them all.

But if you listen to what is required to be "shown",
then SDI would satisfy.  And you can export SDI from
both the SAS stack (it would register a service)
and from Fusion MPT (it would also register for service:

                      SDI
                       ^
                       |
HW --> aic94xx --> SAS Stack --> SCSI Core --> ULD

HW/FW (SAS Stack) --> Fusion MPT --> SCSI Core --> ULD
                             |
                             \/
                             SDI

   Luben


> I'm leaning towards pushing this sooner rather than later.
> 
> That will get everybody working on the same codebase, which providing a 
> working driver for hardware that's already in the field.
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


