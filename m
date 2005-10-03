Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVJCTDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVJCTDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVJCTDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:03:24 -0400
Received: from magic.adaptec.com ([216.52.22.17]:51887 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S964773AbVJCTDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:03:22 -0400
Message-ID: <43418076.4020706@adaptec.com>
Date: Mon, 03 Oct 2005 15:03:18 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org> <433D8542.1010601@adaptec.com> <433DD0F8.4000501@pobox.com> <43413CE8.1090306@adaptec.com> <434154F0.9070105@pobox.com> <43415AFC.5080501@adaptec.com> <434160ED.7050803@pobox.com>
In-Reply-To: <434160ED.7050803@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 19:03:19.0499 (UTC) FILETIME=[1E3899B0:01C5C84D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/05 12:48, Jeff Garzik wrote:
> No, transport class is its name.  Think about a standard object-oriented 

Not according to Kconfig:

menu "SCSI Transport Attributes"
	depends on SCSI

config SCSI_SPI_ATTRS
	tristate "Parallel SCSI (SPI) Transport Attributes"
	depends on SCSI
	help
	  If you wish to export transport-specific information about
	  each attached SCSI device to sysfs, say Y.  Otherwise, say N.

config SCSI_FC_ATTRS
	tristate "FiberChannel Transport Attributes"
	depends on SCSI
	help
	  If you wish to export transport-specific information about
	  each attached FiberChannel device to sysfs, say Y.
	  Otherwise, say N.

config SCSI_ISCSI_ATTRS
	tristate "iSCSI Transport Attributes"
	depends on SCSI
	help
	  If you wish to export transport-specific information about
	  each attached iSCSI device to sysfs, say Y.
	  Otherwise, say N.

config SCSI_SAS_ATTRS
	tristate "SAS Transport Attributes"
	depends on SCSI
	help
	  If you wish to export transport-specific information about
	  each attached SAS device to sysfs, say Y.

endmenu

> paradigm.  Each transport has unique characteristics.  The proper place 
> to export these and manage these characteristics is the transport layer, 
> as SAM agrees.

But:

>  The manifestation of the transport layer is the 
> transport class.

Bzzzt!  Wrong.

This is where you and James Bottomley make the wrong assesment.

Having the SCSI host template in the LLDD tells everyone immeditealy
that you have it all wrong as far as anything SAM/SPC is concerned.

Look at any transport spec, how little SCSI Host template is there.

You need to understand that declaring the host template in the
LLDD is, and has always been, the _exception_, not the rule.
The reason is legacy Parallel SCSI.

It is MPT based drivers who are the exception, not the rule,
and JB's "transport attributes" makes it the rule, and a
transport layer (what you call libsas), the exception.

It is wrong for a host template to "branch out" to a
transport layer as you're doing it now.  Think about it.
The layering infrastructure is upside down.

> You have to look beyond the current code, to see this.

Eh, well, not that you put it like this, I expect that
you'll completely pull out the implementation from my code
and put it in the "transport attributes" and call it your own.

I don't want to look beyond the current code, I'm discussing
things now, as they are.  How many times is JB going to change
the "transport attributes" just because FC needed one more thing
or because of, as often has been recently seen, "brown paper bag"
fix?

> An implementation of a transport class, in conjunction with helper 
> functions common to all transports (SCSI core), combines to form the 
> transport layer for a specific transport.

Should:

The transport layer sits below SCSI Core and above the LLDD.
SCSI Core is completely unaware of the transport layer.
The LLDD communicates with the transport layer via
the event interface (as shown in the SAS Transport layer)
and the transport layer communicates with the LLDD via
the Execute Command SCSI RPC and TMF.  All as outlined here:
http://marc.theaimsgroup.com/?l=linux-scsi&m=112629423714248&w=2

>>b) It sits across SCSI Core, i.e. on the same level.
>>c) It was never intended to add management.
> 
> 
> SCSI core is nothing but a set of helper functions and support code that 
> enable the transport class and LLDD to implement the transport layer.

Again you fail to see that the LLDD should _not_ implement
the host template as has been traditionally done.
The reason with this is that simply the LLDD has nothing to do
with the host template.  Unless you're dealing with MPT-based
LLDD which implement everything in FW and export LUs to
SCSI Core (which is fine too, as long as they do not dictate
how SCSI Core should work).

Notice that for MPT-based solution, SCSI Core wouldn't even
do LU discovery (unless you can turn that off via FW dependent
ways).

>>d) Its inteface to SCSI Core is badly defined and an "invention",
>>   (and very poor at that).
> 
> Strongly disagree.  This invention is defined by -needs-, as is other 
> code in Linux.  If we have new needs, we change the code.

You defence of your friends architecture is duly noted.
But if, as has been pointed out, you take a look at the
evolvement of this "invention" you'll see how it was and still
is _meandering_ in the technological maze to find its place.

All the while a transport layer like USB/SPB/SAS and maybe
iSCSI just sits "right".  Think about it.

>>The reason for d) is that
>>2) does _not_ follow _any_ spec or standard.
> 
> 
> That's fine, since its an internal kernel API.

Now, lets shove it down the throat of eveybody.

You forgot to say something about
1) it tries to unify different _transports_.
I don't expect a blurb on that, btw.


	Luben
