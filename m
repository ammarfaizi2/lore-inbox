Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWH0URn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWH0URn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWH0URn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 16:17:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750993AbWH0URm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 16:17:42 -0400
Date: Sun, 27 Aug 2006 13:17:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4 1/5] ieee1394: sbp2: workaround for write
 protect bit of Initio firmware
In-Reply-To: <tkrat.94cecc462a778dde@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0608271308360.27779@g5.osdl.org>
References: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de>
 <tkrat.94cecc462a778dde@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Aug 2006, Stefan Richter wrote:
>
> Yet another mode pages related bug of Initio firmwares was seen.
> INIC-1530 with a firmware by Initio responded with garbage to MODE SENSE
> (10).  Some HDDs were therefore incorrectly marked as write protected:
> http://bugzilla.kernel.org/show_bug.cgi?id=6947

Why does sbp2scsi_slave_configure() set "use_10_for_ms" in the first 
place?

Almost all the other SCSI code seems to default to using the 6-byte 
version, and then only uses the 10-byte version if they have some specific 
reason to do so.

I don't think there really is _ever_ any reason to use the 10-byte version 
if the 6-byte version is expected to work. Is there?

Examples:

 - scsi_add_lun() only sets the 10-byte MS for things that are 
   black-listed to set it (BLIST_USE_10_BYTE_MS)

   In fact, I don't see _anything_ in the source code that actually does 
   set that, so as far as I can see, scsi_add_lun() _never_ asks to use 
   the 10-byte modesense.

 - libata does set the 10-byte modesense for all SATA devices (but 
   scsi_lib.c might clear it if we get a bad status back).

 - USB devices set the 10-byte version _only_ if it's a non-disk device, 
   or if the subclass of the device is not SCSI.

Anyway, it would appear that sbp2 is the odd man out in setting up for a 
10-byte modesense, and then having to have strange magic rules for 
clearing it again.

Is there _really_ any reason to use the 10-byte version at all in the 
first place?

		Linus
