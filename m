Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbULHRMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbULHRMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbULHRMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:12:15 -0500
Received: from embeddededge.com ([209.113.146.155]:34564 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S261269AbULHRL4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:11:56 -0500
In-Reply-To: <BC83A5D6-4933-11D9-96C5-000393C30512@freescale.com>
References: <48C50EC3-480D-11D9-8A5A-000393DBC2E8@freescale.com> <CC280DE6-485F-11D9-AEAC-003065F9B7DC@embeddededge.com> <BC83A5D6-4933-11D9-96C5-000393C30512@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <33BE8C06-493C-11D9-81C3-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>,
       Kumar Gala <kumar.gala@freescale.com>,
       Linux/PPC Development <linuxppc-dev@ozlabs.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Second Attempt: Driver model usage on embedded processors
Date: Wed, 8 Dec 2004 12:11:29 -0500
To: Andy Fleming <afleming@freescale.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 8, 2004, at 11:10 AM, Andy Fleming wrote:

> .....  An example is the gianfar driver for the 8540.  The driver 
> supports the two TSEC devices, as well as the FEC.

No, it doesn't.  The TSEC and CPM FCC are very different devices that 
are
supported by different drivers.  The FEC is used/shared on 8xx and 5xxx.
Some of us have chosen to design 85xx boards that use the TSEC0 for MDIO
control of all of the PHYs, even those on the FCC, but we aren't doing
to discuss that here :-)

>  In order to make the driver applicable to different processors with 
> different device configurations, the driver needs to be agnostic about 
> how many devices there are, and what features they have.

How can you be agnostic about features and still support them? :-)
A driver has to know exactly what features it can support, and can then
be configurable to support some subset in various combinations.


> Anyway, I like the idea of using feature_call.  Are we sure, though, 
> that it's not using a hammer for a screw?  I'm not very familiar with 
> the function's intent.

It's been proven to work very nicely on the PMac to solve the same kind
of configuration challenges.  Drivers have call outs to feature calls 
that
can manage the same logical feature although the boards have very
different underlying implementations.  With something like the 8xx(x),
externally the system can have very different IO pin usage for the
routing of signals for data/clocks, plus they often have external logic
with another level of switching and control.  Depending upon which
drivers you load, you can route the signals dynamically to use many
different functions.  Functionally, the driver still does the same 
thing,
it just needs places within the code to call these board specific
functions to do the management of IO pins.  Some boards may do
nothing, others may have to execute non-trivial code to get the bits
flowing.  The driver doesn't care, it just asks for it to be done 
through
the feature call.  The feature_call is implemented on PowerPC as
inline/macro with indirect function pointer.  Different architectures
could choose to define this differently in their machdep.h, making
it a no operation or extending it as necessary.

Trying to find some "driver model" data structure to make this happen
isn't likely.  This challenge has existed for years, we started to
address it with the old SCC Ethernet driver.  It never went anywhere
because people just kept hacking the driver to suit their needs.
There are reasons to use the OCP-like driver model for some
functional configuration, but you can't create data structures with
information and "agnostic" drivers that can do the special processing
needed across all of the embedded boards.  It failed when the
drivers were very platform specific, and now if you want to
expand the use of common drivers across more platforms,
it only makes it harder.

We are talking about solving two different problems.  One is
a generic " ... which peripherals do I want to configure and
where are they in the resource space ... "  and the other
is " .. how do I route the external signals, control
board specific external logic to make bits flow, and
retrieve external information ... "   The OCP does
the former, the feature call does the latter.

Thanks.


	-- Dan

