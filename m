Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264696AbTFEOT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 10:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTFEOT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 10:19:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17818 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264691AbTFEOTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 10:19:24 -0400
Subject: Re: [PATCH] megaraid driver fix for 2.5.70
From: Mark Haverkamp <markh@osdl.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: atulm@lsil.com, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <1054822044.1792.48.camel@mulgrave>
References: <1054650567.13617.12.camel@markh1.pdx.osdl.net>
	 <1054822044.1792.48.camel@mulgrave>
Content-Type: text/plain
Organization: 
Message-Id: <1054823593.13060.12.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Jun 2003 07:33:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 07:07, James Bottomley wrote:
> On Tue, 2003-06-03 at 10:29, Mark Haverkamp wrote:
> > A recent change to the megaraid driver to fix some memset calls resulted
> > in overflowing the arrays being cleared and causing a system panic. 
> > This patch fixes the problem by making sure that the arrays being
> > cleared are dimensioned to the correct size.  The patch has been tested
> > on osdl's stp machines that have megaraid controllers.
> 
> This patch doesn't quite look like a fix to me:  The megaraid mailboxes
> are always >16 bytes *but* none of the setting commands is supposed to
> touch any of the status parts (which begin at byte 15), so I don't see
> how your patch would prevent a panic.

In the memset cases, what fixed the panic was that the size of the
raw_mbox automatic was set to 16 and the memset was using
sizeof(mbox_t).  I just increased the size of the raw_mbox so it
wouldn't be overflowed.  It sounds like, from what you are saying, that
the size of raw_mbox should have been left at 16 and the memset changed
to fill 16 bytes and not the sizeof(mbox_t).

> 
> It also looks like the first fifteen (not sixteen) bytes are user data
> and the remaining 51 are for data from the card.
> 
> It thus looks like this memcpy in both issue_scb() and issue_scb_block()
> may be wrong
> 
> 	memcpy((char *)mbox, (char *)scb->raw_mbox, 16);
> 
> because it's overwriting the mbox->busy return.

This doesn't seem like it would hurt since issue_scb sets mbox->busy
just after the memcpy. and in issue_scb_block, the raw_mbox busy
location is set before the memcpy.


> 
> Logically, it looks like the mbox_t should be split up into an mbox_out
> (which is what all the routines want to set values in) and an mbox_in
> which is where the status is returned.
> 
> James
-- 
Mark Haverkamp <markh@osdl.org>

