Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWBHXGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWBHXGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWBHXGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:06:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:29108 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030382AbWBHXGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:06:00 -0500
Date: Wed, 8 Feb 2006 23:05:59 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 7/8] don't mangle INQUIRY if cmddt or evpd bits are set
Message-ID: <20060208230559.GK27946@ftp.linux.org.uk>
References: <E1F6vyJ-00009k-3Z@ZenIV.linux.org.uk> <43EA7226.60306@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EA7226.60306@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 11:35:18PM +0100, Stefan Richter wrote:
> I tested the patch with 8 different SBP-2 bridges, based on 6 or 7 
> different bridge chips. Works for me.
> 
> In fact, not a single one of these bridges is affected by the code 
> change since the additional expression which was added always evaluates 
> true.

The hell it does.  Try scsiinfo -s and you'll see.  All INQUIRY generated
by scsi midlayer have both flags set to 0.  Userland ones do not; example
I've mentioned (scsiinfo -s) will send an INQUIRY with EVPD=1 and page
code 0x80 (that's cmnd[2]), which results in response of form
	(periph_qualifier << 5) | device_type
	0x80
	<reserved>
	page length
	unit serial number (page length - 3 bytes)

Similar for page 0x83 (device identification descriptors), etc.  Userland
gets to those via SG_IO and yes, it's really used.
