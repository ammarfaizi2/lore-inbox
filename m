Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752099AbWCCHZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbWCCHZS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 02:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbWCCHZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 02:25:18 -0500
Received: from mx02.qsc.de ([213.148.130.14]:41350 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1752099AbWCCHZQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 02:25:16 -0500
From: =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: MAX_USBFS_BUFFER_SIZE
Date: Fri, 3 Mar 2006 08:27:45 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <200603012116.25869.rene@exactcode.de> <mailman.1141249502.22706.linux-kernel2news@redhat.com> <20060302130519.588b18a2.zaitcev@redhat.com>
In-Reply-To: <20060302130519.588b18a2.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603030827.46003.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Thursday 02 March 2006 22:05, Pete Zaitcev wrote:
	> On Wed, 1 Mar 2006 22:42:35 +0100,  =?ISO-8859-1?Q?=20Ren=C3=A9?= Rebe <rene@exactcode.de>
	wrote: > > > > > drivers/usb/core/devio.c:86 > > > > #define
	MAX_USBFS_BUFFER_SIZE 16384 > > > So, queing alot URBs is the
	recommended way to sustain the bus? Allowing > > way bigger buffers will
	not be realistic? > > Have you ever considered how many TDs have to be
	allocated to transfer > a data buffer this big? No, seriously. If your
	application cannot deliver > the tranfer speeds with 16KB URBs, we ought
	to consider if the combination > of our USB stack, usbfs, libusb and the
	application ought to get serious > performance enhancing surgery. The
	problem is obviously in the software > overhead. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 02 March 2006 22:05, Pete Zaitcev wrote:
> On Wed, 1 Mar 2006 22:42:35 +0100, René Rebe <rene@exactcode.de> wrote:
> 
> > > > drivers/usb/core/devio.c:86
> > > > #define MAX_USBFS_BUFFER_SIZE   16384
> 
> > So, queing alot URBs is the recommended way to sustain the bus? Allowing
> > way bigger buffers will not be realistic?
> 
> Have you ever considered how many TDs have to be allocated to transfer
> a data buffer this big? No, seriously. If your application cannot deliver
> the tranfer speeds with 16KB URBs, we ought to consider if the combination
> of our USB stack, usbfs, libusb and the application ought to get serious
> performance enhancing surgery. The problem is obviously in the software
> overhead.

As I already wrote, queing multiple URBs in parallel solved the problem for me.
I'll post the libusb patch later. So the problem just was time of no pending
URBs wasted a lot of time slots where no URB was exchanged with the scanner.

Queueing N = size / 16k URBs in parallel gets the maximal possible thruput with
the scanner - a 2x speedup. The driver is now even slightly faster than the
vendor Windows one by about 20%.

For even further improvements a _async interface would be needed in libusb
(and sanei_usb) so I can queue the prologue and epilogue URBs of the protocol
of communication into the kernel and thus elleminate some more wasted time
slots. I estimate that the driver would then be over 30% faster compared with
the Windows one.

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
