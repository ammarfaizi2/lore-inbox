Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTLEGz4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 01:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTLEGz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 01:55:56 -0500
Received: from thunk.org ([140.239.227.29]:56990 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263269AbTLEGzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 01:55:53 -0500
Date: Fri, 5 Dec 2003 01:55:22 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Simon Kirby <sim@netnation.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux-raid maillist <linux-raid@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       LKML <linux-kernel@vger.kernel.org>, linux-lvm@sistina.com
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
Message-ID: <20031205065522.GA28825@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Simon Kirby <sim@netnation.com>, Linus Torvalds <torvalds@osdl.org>,
	Linux-raid maillist <linux-raid@vger.kernel.org>,
	Jens Axboe <axboe@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
	"Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-lvm@sistina.com
References: <3FCB4AFB.3090700@backtobasicsmgmt.com> <20031201141144.GD12211@suse.de> <3FCB4CFA.4020302@backtobasicsmgmt.com> <20031201155143.GF12211@suse.de> <3FCC0EE0.9010207@backtobasicsmgmt.com> <20031202082713.GN12211@suse.de> <Pine.LNX.4.58.0312021009070.1519@home.osdl.org> <20031204011236.GA5622@simulated.ca> <Pine.LNX.4.58.0312031721210.2055@home.osdl.org> <20031204043106.GA19017@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204043106.GA19017@netnation.com>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 08:31:06PM -0800, Simon Kirby wrote:
> 
> Without the patches, the box gets as far as assembling the array and
> activating it, but dies on "mke2fs".  Running mke2fs through strace shows
> that it stops during the early stages, before it even tries to write
> anything.  mke2fs appears to seek through the whole device and do a bunch
> of small reads at various points, and as soon as it tries to read from an
> offset > 2 TB, it hangs.

It sounds like mke2fs tried using BLKGETSIZE ioctl, but given that
this returns the number of 512 byte sectors in a device in a 4 byte
word, the BLKGETSIZE ioctl quite rightly threw up its hands and said,
"sorry, I can't tell you the correct size."

The mke2fs fell back to its backup algorithm, which uses a modified
binary search to find the size of the device.  It started to see if
the device was at least 1k, and checks to see if the device is at
least 2k, 4k, 8k, 16k, 32k, 64k, 128k, etc.  So it sounds like it's
dieing when it tries to seek past 2TB using llseek(). 

It would probably be worthwhile to write a little test program which
opens the disk, llseeks to 2TB+1, and then tries reading a byte.  If
that fiailes, then there's definitely a bug somewhere in the device
driver....

						- Ted
