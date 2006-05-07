Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWEGMsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWEGMsM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 08:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWEGMsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 08:48:11 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:26768 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932142AbWEGMsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 08:48:10 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Leon Woestenberg <leonw@mailcan.com>
Subject: Re: [smartmontools-support]Re: LibPATA code issues / 2.6.16 (previously, 2.6.15.x)
Date: Sun, 7 May 2006 14:44:46 +0200
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       smartmontools-support@lists.sourceforge.net,
       Jeff Garzik <jgarzik@pobox.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, Mark Lord <lkml@rtr.ca>,
       David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de
References: <Pine.LNX.4.64.0602140439580.3567@p34> <Pine.LNX.4.64.0604211704120.3701@g5.osdl.org> <1146928152.2611.18.camel@dhcppc7>
In-Reply-To: <1146928152.2611.18.camel@dhcppc7>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071444.49225.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 6. May 2006 17:09, Leon Woestenberg wrote:
> However, for large files where parts may be bad sectors, I am still
> searching for a way to read, then re-write every physical sector
> occupied by the file. 
> 
> With the purpose to remap the bad sectors inside large MPEG files (where
> I would rather have a few zeroed holes than a read error in them).

This much easier to solve in the player software:
do {
	ret = read(fd, buffer, size)
	if (ret > 0) {
		playbuffer(buffer, ret)
	} else if (ret < 0) {
		switch(errno) {
		case EIO:
			playbuffer(allzeroesbuffer, size);
			/* skip over this frame because of disk problems */
			lseek(fd, size, SEEK_CUR);
			/* TODO: Handle return or lseek() here */
		}
	}
} while(ret != 0)

> Anyone know such tooling exists? I suspect it has to use filesystem
> specific IOCTL's to query for the blocks involved.

The (somewhat) portable ioctl() FIBMAP would suffice. 
That way you find out what blocks are this file is mapped to,
and could add some of these blocks to the badblock list of e2fsck.

Regards

Ingo Oeser
