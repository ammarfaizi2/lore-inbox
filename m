Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbVI3Sva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbVI3Sva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVI3Sva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:51:30 -0400
Received: from magic.adaptec.com ([216.52.22.17]:5553 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965074AbVI3Sv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:51:29 -0400
Message-ID: <433D892E.4090407@adaptec.com>
Date: Fri, 30 Sep 2005 14:51:26 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: "David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com,
       willy@w.ods.org, patmans@us.ibm.com, ltuikov@yahoo.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       linux-scsi@vger.kernel.org
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 18:51:26.0795 (UTC) FILETIME=[F62D59B0:01C5C5EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/05 03:36, Andre Hedrick wrote:
> I stated I would help with SAS adoption because there is a SAS-Transport
> model.  I asked about a possible libadaptec + libsas, and still waiting to
> see if you and adaptec are up for the task.  Right now the only path open
> is the one Jeff Garzik is putting forward along with James and Christop.
> I have a vested interest in seeing SAS-Transport, otherwise I would have
> cut and run a long time ago.

Hi Andre,

Let me know if this satisfies:

The infrastructure is broken into
	* SAS LLDD,
	* SAS Layer.

The SAS LLDD does phy/OOB management, and generates SAS events
to the SAS Layer.  Those events are *the only way* a SAS LLDD
communicates with the SAS Layer.  If you can generate 2 types
of event, then you can use this infrastructure.  The first two
are, loosely, "link was severed", "bytes were dmaed".  The third
kind is "received a primitive", used for domain revalidation.

A SAS LLDD should implement the Execute Command SCSI RPC and
at least one SCSI TMF (Task Management Function), in order for
the SAS Layer to communicate with the SAS LLDD.

The SAS Layer is concerned with
      * SAS Phy/Port/HA event management (LLDD generates,
        SAS Layer processes),
      * SAS Port management (creation/destruction),
      * SAS Domain discovery and revalidation,
      * SAS Domain device management,
      * SCSI Host registration/deregistration,
      * Device registration with SCSI Core (SAS) or libata
        (SATA/PI), and
      * Expander management and exporting expander control
        to user space.

The SAS Layer uses the Execute Command SCSI RPC, and the TMFs
implemented by the SAS LLDD in order to manage the domain and
the domain devices.

For details please see drivers/scsi/sas/README.

The SAS Layer represents the SAS domain in sysfs.  For each
object represented, its parent is the physical entity it attaches
to in the physical world.  So in effect, kobject_get, gets
the whole chain up on which that object depends on.

In effect, the sysfs representation of the SAS domain(s)
is what you'd see in the physical world.

Hot plugging and hot unplugging of devices, domains and subdomains
is supported.  Repeated hot plugging and hot unplugging is
also supported, naturally.

SAS introduces a new physical entity, an expander.
Expanders are _not_ SAS devices, and thus are _not_ SCSI devices.
Expanders are part of the Service Delivery Subsystem, in this case
SAS.

Expanders are controlled using the Serial Management Protocol (SMP).
Complete control is given to user space of all expanders found
in the domain, using an "smp_portal".  More of this in the second
and third email in this series.

A user space program, "expander_conf.c" is also presented to show
how one controls expanders in the domain.  It is located here:
drivers/scsi/sas/expanders_conf.c

Thank you,
	Luben

> 
> These long email threads where everyone is shout from the top of their
> hill never wins anything.  After a while the hill becomes flat (from all
> the stomping), and you become old and tired.
> 
> LSI pointed out they mask there SAS in firmware and make it show up in a
> scsi-like or scsi state.  They also pointed out other vendors have taken
> this road.  Even if Adaptec did not go this way in hardware, there still
> has to be a way to map into SCSI ... sheesh this is Adaptec known for
> SCSI.
> 
> Just an FYI, would suggest you cool your heels and listen for the quiet
> responses.  There is more heat than light right now; maybe this thread
> will offset some of the cost in the energy criss.  Will pass on advice
> handed to me (when I was a maintainer) relax and listen, nobody is out to
> get you (and they were right).
> 
> Cheers,
> 
> Andre
> 
> PS I didn't listen to that advice back then, don't make the same mistake.
> 
> 
> 

