Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTKAPrt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 10:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbTKAPrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 10:47:49 -0500
Received: from netrider.rowland.org ([192.131.102.5]:34825 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S263868AbTKAPrs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 10:47:48 -0500
Date: Sat, 1 Nov 2003 10:47:47 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 1412] Copy from USB1 CF/SM reader stalls, no actual content
 is read (only directory structure)
In-Reply-To: <1067633171.3886.1.camel@m70.net81-64-235.noos.fr>
Message-ID: <Pine.LNX.4.44L0.0311011039330.18079-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003, Nicolas Mailhot wrote:

> Le ven 31/10/2003 à 19:33, bugme-daemon@osdl.org a écrit :
> > ------- Additional Comments From stern@rowland.harvard.edu  2003-10-31 10:33 -------
> > Created an attachment (id=1303)
> >  --> (http://bugme.osdl.org/attachment.cgi?id=1303&action=view)
> > New diagnostic patch
> > 
> > Try using this diagnostic patch instead of the one sent earlier by Matt Dharm
> > in attachment #14.  It may reveal that the source of the problem is not in the
> > USB system but higher up.
> 
> Done. Do you want to be CCed on this bug ?

There's no need.  The output from that diagnostic is definitive -- this 
isn't a USB problem.  It's got to be a problem higher up, maybe in the 
SCSI layer but more likely in the block layer or the file system code.

Oct 31 21:12:09 rousalka kernel: usb-storage: READ_10: read page 160 pagect 8
Oct 31 21:12:09 rousalka kernel: usb-storage: sddr09_read_data: use_sg = 1, sg[0].page = c18c5b40, .offset = 0, sg_address = 00000000
Oct 31 21:12:09 rousalka kernel: usb-storage: Read 8 pages, from PBA 11 (LBA 5) page 0
Oct 31 21:12:09 rousalka kernel: usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=41 value=0000 index=00 len=12
Oct 31 21:12:09 rousalka kernel: usb-storage: Status code 0; transferred 12/12
Oct 31 21:12:09 rousalka kernel: usb-storage: -- transfer complete
Oct 31 21:12:09 rousalka kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 4096 bytes
Oct 31 21:12:09 rousalka kernel: usb-storage: Status code 0; transferred 4096/4096
Oct 31 21:12:09 rousalka kernel: usb-storage: -- transfer complete
Oct 31 21:12:09 rousalka kernel: usb-storage: us_copy_to_sgbuf: buffer = f38e6000, len = 4096, content = f7e01e40, *index = 0, *offset = 0, use_sg = 1
Oct 31 21:12:09 rousalka kernel: usb-storage: in loop, ptr = 00000000

The line where it says sg_address = 00000000 indicates that something has
asked us to read data from the device and store it at a virtual address
that isn't mapped to memory!  You can see the same thing in the last line,
where ptr = 00000000.  No wonder you get an oops.

This bug should be reassigned, but I don't know to whom.  Maybe someone on 
the linux-kernel mailing list can help.

Alan Stern

