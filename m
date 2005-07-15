Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbVGOSE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbVGOSE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 14:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbVGOSBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 14:01:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:64499 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263359AbVGOSBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 14:01:04 -0400
Date: Fri, 15 Jul 2005 11:00:32 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Amrut Joshi <amrut.joshi@gmail.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SCSI luns
Message-ID: <20050715180032.GA28755@us.ibm.com>
References: <1ba727770507120422562d525d@mail.gmail.com> <1121168331.3171.21.camel@laptopd505.fenrus.org> <1121185078.4825.17.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121185078.4825.17.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 12:17:53PM -0400, James Bottomley wrote:
> Thanks for redirecting to the correct list.
> 
> On Tue, 2005-07-12 at 13:38 +0200, Arjan van de Ven wrote:
> > On Tue, 2005-07-12 at 16:52 +0530, Amrut Joshi wrote:
> > > Currently linux scsi subsystem doesnt store the 8-byte luns which are
> > > recieved in REPORT_LUNS reply. This information is forver lost once
> > > the scan is over. In my LDD  I need this information. Currently I have
> > > to snoop REPORT_LUNS reply, do scsilun_to_int for all the luns and
> 
> Our current transformation routine scsilun_to_int is bijective as long
> as the original scsi_lun doesn't overrun 32 bits (which it might well do
> one day).
> 
> Why can't you simply do this by transforming back the lun?
> 
> In general, I'm not in favour of adding redundant information to the
> device structure, so if you can demonstrate we overrun our allotted 32
> bits, the solution is probably to take lun up to u64 and still do the
> back transform (the alternative being to substitute lun with it's
> structural equivalen which would entail a lot of pain throught the SCSI
> subsytem).

James -

There have been cases of going past 32 bits, though I have not seen
specifics, storage devices are instead being configured to avoid the
problem.

Using some of those configurations has bad consequences. For example, one
storage box enumerates the LUN numbering, but this means existing LUN
values can change when a new LU is added (ugh)!

Trying to have a compatible 64 bit LUN for all uses (change the current
lun to u64) looks hard, given all of the odd mappings, having to deal with
the high bits being set (for non-zero LU address methods), and trying to
figure out whether the 64 bit LUN can fit into 32 bits (really about 8
bits for SPI, and 16 bits for some HBA's).

Or by "back transform" did you mean change lun to u64, and conditionally
map to 32 bits for drivers (currently all) that don't support a 64 bit
LUN? Hmmmm ...

Printing the lun value for messages is odd/painful no matter how it is
added, since for example, 64 bit value for LUN 1 is something like 0001
0000 0000 0000. Having both 32 and 64 bit versions makes it even odder. An
sdev_printk() makes this easier, as we would have to print to
conditionally print lun in both formats (old and new) depending on HBA
support.

But just adding a 64 bit LUN in parallel does not help much if the scan
code is not modified (we'll fail to scan LUNs with higher bits set).

-- Patrick Mansfield
