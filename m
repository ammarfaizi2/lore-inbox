Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUCXVeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUCXVeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:34:44 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:38868 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261996AbUCXVei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:34:38 -0500
Date: Wed, 24 Mar 2004 16:29:42 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PnPBIOS: Unknown tag '0x82'
Message-ID: <20040324162942.GA16164@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Meelis Roos <mroos@linux.ee>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20040322160252.GA6414@neo.rr.com> <Pine.GSO.4.44.0403231149120.18934-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0403231149120.18934-100000@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 11:50:04AM +0200, Meelis Roos wrote:
> > > PnPBIOS: Scanning system for PnP BIOS support...
> > > PnPBIOS: Found PnP BIOS installation structure at 0xc00f2480
> > > PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x1d2a, dseg 0xf0000
> > > pnp: 00:09: ioport range 0x4d0-0x4d1 has been reserved
> > > pnp: 00:09: ioport range 0xcf8-0xcff could not be reserved
> > > PnPBIOS: Unknown tag '0x82', length '18': 82 12 00 49 6e 74 65 6c 20 46 69 72 6d 77 61 72 65 20 .
> > > pnp: 00:0b: ioport range 0x800-0x87f has been reserved
> > > PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
> >
> > In this case it should be harmless.  Typically when one tag is
> > corrupted (or incorrectly interpreted) it will also complain
> > about the following tag because of size checks.  Where did the
> > unknown tag occur?  Perhaps in pnpbios_parse_resource_option_data?
> 
> It's in pnpbios_parse_compatible_ids.

Could you please try this patch.

Thanks,
Adam

--- a/drivers/pnp/pnpbios/rsparser.c	2004-03-11 02:55:25.000000000 +0000
+++ b/drivers/pnp/pnpbios/rsparser.c	2004-03-24 16:24:17.000000000 +0000
@@ -505,6 +505,11 @@
 
 		switch (tag) {
 
+		case LARGE_TAG_ANSISTR:
+			strncpy(dev->name, p + 3, len >= PNP_NAME_LEN ? PNP_NAME_LEN - 2 : len);
+			dev->name[len >= PNP_NAME_LEN ? PNP_NAME_LEN - 1 : len] = '\0';
+			break;
+
 		case SMALL_TAG_COMPATDEVID: /* compatible ID */
 			if (len != 4)
 				goto len_err;
