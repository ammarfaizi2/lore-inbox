Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUGMUyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUGMUyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUGMUyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:54:16 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:59255 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S265887AbUGMUwt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:52:49 -0400
X-Ironport-AV: i="3.81R,166,1083560400"; 
   d="scan'208"; a="56041687:sNHT30990320"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
Date: Tue, 13 Jul 2004 15:52:43 -0500
Message-ID: <7A8F92187EF7A249BF847F1BF4903C046304CF@ausx2kmpc103.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
Thread-Index: AcRpGkYu9iVGLNY9SFWZUX+1GOlxbQAAO8OA
From: <Stuart_Hayes@Dell.com>
To: <whbeers@mbio.ncsu.edu>, <david-b@pacbell.net>
Cc: <olh@suse.de>, <Gary_Lerhaupt@Dell.com>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Jul 2004 20:52:44.0714 (UTC) FILETIME=[58BEA8A0:01C4691B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Beers wrote:
>  > though maybe 500 msec is too short a period to wait.
>  > See if 5000 msec helps.
> 
> I went all the way up to 20000 msec and it still didn't help.  I'm
> sure it's a bad idea, but removing that whole if-block below it makes
> it work (which is effectively what switching the and/or did).  I
> don't know enough about it to judge whether it's correct, but what
> exactly is it checking for there?    
> 
> -Will

Without the patch, Linux would just ignore the BIOS handoff--Linux was
writing "0" to the bit that it was supposed to wait for the BIOS to
clear, so it never waited for the BIOS to let go of the controller.

I bet you have a bad BIOS that won't hand off, but I would try the other
thing David suggested--change the write to a byte write.  It seems
unlikely, but, since Linux is writing a "1" to the "BIOS owns the
controller" bit right now, you might be hitting something like this, if
the system is breaking up the write into multiple smaller writes:

the "OS wants the controller" bit is getting written to 1 (first part of
the Linux write, which the system broke into pieces)
the system BIOS (SMI handler) sees that bit set to 1, and clears the
"BIOS owns" bit
the "BIOS owns" bit is getting written back to a 1 (the second part of
the Linux write)
Linux waits in vain for BIOS to clear the "BIOS owns" bit\

Again, seems unlikely, but worth a try if you're recompiling and
testing.


