Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWCZUI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWCZUI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 15:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWCZUI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 15:08:28 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:1744 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751528AbWCZUI2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 15:08:28 -0500
Date: Sun, 26 Mar 2006 13:08:26 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bodo Eggert <7eggert@gmx.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
Message-ID: <20060326200826.GB3486@parisc-linux.org>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz> <1143402698.3055.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143402698.3055.28.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 09:51:38PM +0200, Arjan van de Ven wrote:
> On Sun, 2006-03-26 at 21:28 +0200, Bodo Eggert wrote:
> > Having a SCSI ID is a generic SCSI property, therefore reading it should 
> > not be restricted to sg. The SCSI_IOCTL_GET_IDLUN from scsi is limited 
> > below the kernel data types, so it isn't an adequate replacement.
> > 
> > This patch moves SG_GET_SCSI_ID from sg to scsi while renaming it to
> > SCSI_IOCTL_GET_PCI. Additionally, I renamed struct sg_scsi_id to struct
> > scsi_ioctl_id, since it is no longer restricted to sg. The corresponding 
> > typedef will be gone.
> 
> To be honest, I think this is the wrong direction; this ioctl seems to
> be a bad idea (it exposes the SPI parameters... while SPI is only one of
> many nowadays). Expanding the use of such a thing... please no.

What's SPI specific?

+struct scsi_ioctl_id { /* used by SCSI_IOCTL_GET_ID ioctl() */
+    int host_no;        /* as in "scsi<n>" where 'n' is one of 0, 1, 2
etc */
+    int channel;
+    int scsi_id;        /* scsi id of target device */
+    int lun;
+    int scsi_type;      /* TYPE_... defined in scsi/scsi.h */
+    short h_cmd_per_lun;/* host (adapter) maximum commands per lun */
+    short d_queue_depth;/* device (or adapter) maximum queue length */
+    int unused[2];      /* unused part should be zero */
+}; /* 32 bytes long on i386 */

Everything has to support HCIL, even if it's through some kind of
mapping.  Yes, I know it might not make much *sense* for some
transports, but we do need to support it.  Type isn't SPI-specific.
cmd_per_lun isn't SPI-specific either, and neither is d_queue_depth,
although neither may make too much sense for some adapters or targets.
