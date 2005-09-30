Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbVI3SfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVI3SfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbVI3SfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:35:04 -0400
Received: from magic.adaptec.com ([216.52.22.17]:38829 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965036AbVI3SfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:35:01 -0400
Message-ID: <433D8542.1010601@adaptec.com>
Date: Fri, 30 Sep 2005 14:34:42 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: "David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com,
       willy@w.ods.org, patmans@us.ibm.com, ltuikov@yahoo.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 18:34:42.0863 (UTC) FILETIME=[9FC97BF0:01C5C5ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/05 03:36, Andre Hedrick wrote:
> I stated I would help with SAS adoption because there is a SAS-Transport
> model.  I asked about a possible libadaptec + libsas, and still waiting to
> see if you and adaptec are up for the task.  Right now the only path open
> is the one Jeff Garzik is putting forward along with James and Christop.
> I have a vested interest in seeing SAS-Transport, otherwise I would have
> cut and run a long time ago.
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

Hi Andre,

Let me know if this 4 section write up satisfies:

Section 1: MPT, SCSI Core and JB's "transport attributes"
---------------------------------------------------------

SPI drivers (say 5 years ago)
-----------------------------
 hardware implementation     (bus connect)
     firmware implementation   (transport: SPI)
        LLDD                     (exports SCSI devices (LUs))
           SCSI Core
              Command Sets


MPT-based drivers (now)
-----------------------
 hardware implementation     (interconnect/physical)
-->  Transport Layer           (firmware: FC/SPI/SAS/etc)  <--
        LLDD                     (exports SCSI devices (LUs))
           SCSI Core
              Command Sets

As you can see SCSI Core is _unaware_ of the transport.
The transport is completely implemented in FIRMWARE, relieving
the LLDD from worrying about it.  Theoretically/ideally the same
LLDD would work for _all_ transports, since the FW would
export LUs to the LLDD, which would in turn register
those with SCSI Core.

The layout is the same as before, achieving 100% backward
software compatibility.


MPT-based drivers + James Bottomley's "transport attributes"
-------------------------------------------------------------
 hardware implementation
     Transport Layer               <------+ FW/Transport dependent access method
        LLDD                  <---------- + LLDD dependent access method
           SCSI Core ---------------------'
              Command Sets

This picture is _identical_ to the one above, but
I've also shown what the "transport attributes" achieve:
They hook to the _LLDD_ to get to LLDD dependent way of
accessing "transport attributes" (any transport).  This is
JB's template unifying _all_ transports.

Note that this isn't a _management_ layer or infrastructure,
since, it _does not lie between_ the LLDD and SCSI Core.
It merely implements attribute exporting.


Section 2: USB/SBP/SAS and SCSI Core
------------------------------------

  hardware implementation            (interconnect/physical)
      firmware implementation           (SDS: TMFs + Execute Command SCSI RPC)*
          LLDD                             (Coherent interface to SDS)
-->         Transport Layer                   (Transport common to LLDDs) <--
                 SCSI Core
                    Command Sets

* SDS, Service Delivery Subsystem (see SAM 4.6)
  TMF, Task Management Function (see SAM 7)
  Execute Command SCSI RPC (see SAM 5.1)

Most immediate difference from Section 1 is that
  - the Transport Layer is _above_ the LLDD (in top-down).
  - no need for LLDD/Firmware dependent access method
    to the Transport,
  - Transport is accessed in the same way across all
    LLDDs of the same transport (USB/SBP/SAS).

Now since, the LLDDs all implement TMFs + Exec Cmnd SCSI RPC,
you can have 
  - a transport common error handling and
  - a transport common "attribute" access (sysfs),
across all LLDD of the same transport directly from userspace.

The reason the LLDDs all implement TMFs + Exec Cmnd SCSI RPC,
is that the Firmware implements it, and the reason that
the Firmware implements it is that the chip implements
it (following the transport spec).

That is, you can have _different_ LLDDs connecting you
to the _same place_ (maybe not at the same time, depending
on the transport).

SCSI Core should be completely unaware of the
Transport being used and Transport specific
Error handling is common to all such Transport
specific LLDDs (via TMFs): one for SBP, one for
USB, one for SAS. 

The whole point of this USB/SBP/SAS Transport
Layering is that you can access at each level,
thus you can add new abstractions, e.g. SATL (libata),
as is shown in the SATr06 spec.

Furthermore, when you look at the USB/SBP/SAS chips
you will see nothing about "scsi_host", and all about
"transport".

And the sysfs representation of the SAS domain is analogous
to, say, the USB representation of the USB domain.


Section 3: Legacy Thinking or Thinking Legacy
---------------------------------------------

Traditionally Error Handling has been done in
SCSI Core.  The reason for this is that the first
and only SCSI was Parallel SCSI and no other
SCSI was around (and that SAM didn't exist back then).

This is how we have the SPI-centric EH methods
in the scsi host template right now:
	int (* eh_abort_handler)(struct scsi_cmnd *);
	int (* eh_device_reset_handler)(struct scsi_cmnd *);
	int (* eh_bus_reset_handler)(struct scsi_cmnd *);
	int (* eh_host_reset_handler)(struct scsi_cmnd *);

This is fine for Parallel SCSI (SPI) but for other
transports it doesn't quite satisfy.

Let's admit it, with HCIL and with the EH, SCSI Core
is still very SPI centric.

But we should _not_ break legacy drivers and backward
support, yet we have to face the future.

The way we do this is we slowly, without disruption
to older drivers introduce, in parallel, emerge
a new, simpler, slimmer, faster SCSI Core, whereby
we accommodate new infrastructures, yet, have 100%
backward compatibility, via the current older
SCSI Core.  After all, both would be a bunch of
functions in a bunch of files.

If X works with Y, do not disrupt it.  Fix it if
it's broken.  Introduce innovation, functionality,
better design, but not at the expense of breaking
legacy.

To eliminate bugs, tweak old as little as possible,
since you cannot test on _all_ hardware the old code
works on.

To achieve maximum innovation and relevance in the fast
changing world of storage, create, innovate new
better, more accommodating design and infrastructures.

Section 4: Politics
-------------------

Let's face it: SAS is a new emerging technology.
It will be the technology for the next 10-15 years,
and *everybody* in Linux SCSI wants a piece of it.
Everybody wants their name and contribution to it.

This is fine, but we need people who clearly understand
the technology and clearly understand what, how
and why it works.  We need well-read and well educated
people.  Linux dedication is fine, but protocol knowlege
is needed too.

Can Linux afford people who have never even read SAS
to write SAS Code for Linux.  Yes, sure.  It is the
Linux's ideology: "specs are cr@p".

Conclusion
----------

Even though the SAS Transport Layer follows an _already_
establised layering infrastructure for more (less?) exotic
transports such as USB and SBP, James Bottomley has resisted
its inclusion in Linux SCSI.

Have we lost our touch with the new calling it
"non-traditional"?  Will Linux become a dinosaur?

I'm not sure how many times one can split the SAS code?
Will there be enough for everyone?

> Just an FYI, would suggest you cool your heels and listen for the quiet
> responses.  There is more heat than light right now; maybe this thread
> will offset some of the cost in the energy criss.  Will pass on advice
> handed to me (when I was a maintainer) relax and listen, nobody is out to
> get you (and they were right).

Thank you Andre for the warm advice.

James, Linus, can we have this driver in the kernel now, please?

Thank you,
	Luben

