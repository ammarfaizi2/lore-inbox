Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbVG3ABL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbVG3ABL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVG2X6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 19:58:53 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:8592 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S262827AbVG2X4m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 19:56:42 -0400
Date: Sat, 30 Jul 2005 01:56:32 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Andrew Morton <akpm@osdl.org>
cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, linux-kernel@vger.kernel.org,
       markh@osdl.org
Subject: Re: AACRAID failure with 2.6.13-rc1
In-Reply-To: <20050729125928.18d41cf7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0507300141090.21995@kepler.fjfi.cvut.cz>
References: <60807403EABEB443939A5A7AA8A7458B017927DC@otce2k01.adaptec.com>
 <20050729125928.18d41cf7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Jul 2005, Andrew Morton wrote:

> "Salyzyn, Mark" <mark_salyzyn@adaptec.com> wrote:
> >
> > Martin may be overplaying the performance angle.
> > 
> > A previous patch took the adapter from 64K to 4MB transaction sizes
> > across the board. This caused Martin's adapter and drive combination to
> > tip-over. We had to scale back to 128KB sized transactions to get
> > stability on his system. All systems handled the 4MB I/O size in our
> > tests, but the tests that were done some time ago were not performed
> > with the latest kernel, which contributed to a change in testing
> > corners.
> 
> Confused.  The above appears to indicate that we should put the workaround
> into 2.6.13, yes?

Yes. The thing is, that to make the 2.6.13-rc4 work here, I have to either 
use this:

---------------
diff -Napur a/driver/scsi/aacraid/aacraid.h b/driver/scsi/aacraid/aacraid.h
--- a/driver/scsi/aacraid/aacraid.h     2005-07-30 01:09:27.000000000 +0200
+++ b/driver/scsi/aacraid/aacraid.h     2005-07-30 01:44:02.000000000 +0200
@@ -19,7 +19,7 @@
  *  max_sectors is an unsigned short, otherwise limit is 0x100000000 / 512
  * Linux has starvation problems if we permit larger than 4MB I/O ...
  */
-#define AAC_MAX_32BIT_SGBCOUNT ((unsigned short)8192)
+#define AAC_MAX_32BIT_SGBCOUNT ((unsigned short)512)

 /*
  * These macros convert from physical channels to virtual channels
----------------

or the new Adaptec aacraid driver that uses the new comm. Since the latter 
is unlikely to make it into mainline before 2.6.13, the above patch 
should.

However I may add, that the 512 value was found to be the maximum 
acceptable for my configuration only (AAC 2410SA + 3xWD1200JD + 
1xWD1600SD). If there is anyone else out there having similar problems it 
would be nice if they tested the value. Perhaps for some other 
configurations the value would have to be even lower. (??)

So, from my POV the value should be set to at most 512 for the 2.6.13 and 
after 2.6.13 is out, the new driver should be pushed in before the next 
freeze.

Martin
