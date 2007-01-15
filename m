Return-Path: <linux-kernel-owner+w=401wt.eu-S932099AbXAOXq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbXAOXq4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 18:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbXAOXq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 18:46:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:38178 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932099AbXAOXqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 18:46:55 -0500
X-Authenticated: #5039886
Date: Tue, 16 Jan 2007 00:46:51 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Robert Hancock <hancockr@shaw.ca>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070115234650.GA2124@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Robert Hancock <hancockr@shaw.ca>, jeff@garzik.org,
	linux-kernel@vger.kernel.org, htejun@gmail.com,
	jens.axboe@oracle.com
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AAC039.1020808@shaw.ca> <20070115211723.GA3750@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070115211723.GA3750@atjola.homenet>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.15 22:17:24 +0100, Björn Steinbrink wrote:
> On 2007.01.14 17:43:53 -0600, Robert Hancock wrote:
> > Björn Steinbrink wrote:
> > >Hi,
> > >
> > >with 2.6.20-rc{2,4,5} (no other tested yet) I see SATA exceptions quite
> > >often, with 2.6.19 there are no such exceptions. dmesg and lspci -v
> > >output follows. In the meantime, I'll start bisecting.
> > 
> > ...
> > 
> > >ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > >ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 in
> > >         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> > >ata1: soft resetting port
> > >ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > >ata1.00: configured for UDMA/133
> > >ata1: EH complete
> > >SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
> > >sda: Write Protect is off
> > >sda: Mode Sense: 00 3a 00 00
> > >SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
> > >support DPO or FUA
> > 
> > Looks like all of these errors are from a FLUSH CACHE command and the 
> > drive is indicating that it is no longer busy, so presumably done. 
> > That's not a DMA-mapped command, so it wouldn't go through the ADMA 
> > machinery and I wouldn't have expected this to be handled any 
> > differently from before. Curious..
> 
> My latest bisection attempt actually led to your sata_nv ADMA commit. [1]
> I've now backed out that patch from 2.6.20-rc5 and have my stress test
> running for 20 minutes now ("record" for a bad kernel surviving that
> test is about 40 minutes IIRC). I'll keep it running for at least 2 more
> hours.

Yep, that one seems to be guilty. 2.6.20-rc5 with that commit backed out
survived about 3 hours of testing, while the average was around 5
minutes for a failure, sometimes even before I could log in.
I took a look at the patch, but I can't really tell anything.
nv_adma_check_atapi_dma somehow looks like it should not negate its
return value, so that it returns 0 (atapi dma available) when
adma_enable was 1. But I'm not exactly confident about that either ;)
Will it hurt if I try to remove the negation?

Thanks,
Björn
