Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTIWUOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTIWUOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:14:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:54663 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262050AbTIWUOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:14:00 -0400
Date: Tue, 23 Sep 2003 13:13:50 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, greg@kroah.com
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030923131350.D20572@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> Leaks if devices == 0 ?  Error_end only frees mdevs if (devices > 0), 
> but for mdevs=kmalloc(0), the slab allocator may still actually return memory
> [FILE:  2.6.0-test5/drivers/usb/class/usb-midi.c]
> [FUNC:  alloc_usb_midi_device]
> [LINES: 1621-1772]
> [VAR:   mdevs]
> 1616:	devices = inDevs > outDevs ? inDevs : outDevs;
> 1617:	devices = maxdevices > devices ? devices : maxdevices;
> 1618:
> 1619:	/* obtain space for device name (iProduct) if not known. */
> 1620:	if ( ! u->deviceName ) {
> START -->
> 1621:		mdevs = (struct usb_mididev **)
> 1622:			kmalloc(sizeof(struct usb_mididevs *)*devices
> 1623:				+ sizeof(char) * 256, GFP_KERNEL);
<snip>
> GOTO -->
> 1715:			goto error_end;
<snip>
> END -->
> 1772:	return -ENOMEM;
> [FILE:  2.6.0-test5/drivers/usb/class/usb-midi.c]
> START -->
> 1625:		mdevs = (struct usb_mididev **)
> 1626:			kmalloc(sizeof(struct usb_mididevs *)*devices, GFP_KERNEL);
<snip>
> GOTO -->
> 1715:			goto error_end;
<snip>
> END -->
> 1772:	return -ENOMEM;

Yes, these are bugs.  Patch below.  Greg, this look ok?

thanks,
-chris

===== drivers/usb/class/usb-midi.c 1.22 vs edited =====
--- 1.22/drivers/usb/class/usb-midi.c	Tue Sep  2 11:40:27 2003
+++ edited/drivers/usb/class/usb-midi.c	Tue Sep 23 11:36:03 2003
@@ -1750,7 +1750,7 @@
 	return 0;
 
  error_end:
-	if ( mdevs != NULL && devices > 0 ) {
+	if ( mdevs != NULL ) {
 		for ( i=0 ; i<devices ; i++ ) {
 			if ( mdevs[i] != NULL ) {
 				unregister_sound_midi( mdevs[i]->dev_midi );
