Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966471AbWKTTYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966471AbWKTTYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966482AbWKTTYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:24:53 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:20497 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S966477AbWKTTYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:24:52 -0500
Subject: Re: [PATCH -mm] fault-injection:
	reject-failure-if-any-caller-lies-within-specified range
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm <akpm@osdl.org>
In-Reply-To: <20061120105735.GA9795@APFDCB5C>
References: <455217df.719dec4f.2c80.ffffb500@mx.google.com>
	 <1163991847.2912.15.camel@localhost.localdomain>
	 <20061120105735.GA9795@APFDCB5C>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 11:24:22 -0800
Message-Id: <1164050662.2912.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 19:57 +0900, Akinobu Mita wrote:
> On Sun, Nov 19, 2006 at 07:04:07PM -0800, Don Mullis wrote:
> > /debug/fail_make_request can force a failure like the following:
> > 
> > 	FAULT_INJECTION: forcing a failure
> ...
> > 	Buffer I/O error on device hda2, logical block 5782
> > 	lost page write due to I/O error on hda2
> > 	Aborting journal on device hda2.
> > 	journal commit I/O error
> > 	ext3_abort called.
> > 	EXT3-fs error (device hda2): ext3_journal_start_sb: Detected aborted journal
> > 	Remounting filesystem read-only
> > 
> > The above read-only remount effectively ends the test run.  
> 
> This test is a little intentional.
> (Normal I/O may fail, but journal commit I/O doesn't fail)

I'm not sure in what sense the test could be called "intentional".
IIRC, the problematic test run used only the following changes to the
defaults:

        cd /debug/fail_make_request/
        echo -1 >times
        echo 9 >verbose
        echo 1 >probability
        echo 1 >/sys/block/hda/hda2/make-it-fail

> If you want to do this, you could put journal on the other device.

You could.  Generalizing the test tool might be preferable to requiring
the target configuration to change away from the default of the distro.

> > Implementation approach is to extend the existing
> > address-start/address-end mechanism specifying a range _required_ to
> > be found on the stack, by the addition of an address range to be
> > _rejected_.  
> 
> The only problem about this is, the users who set reject address range really
> don't want to insert failures from the address range. So they have to change
> stacktrace-depth large enough. It will cause large slow down by aggressive
> stacktrace and there is no guarantee to prevent from injecting failures the
> address range.

The patch raises the default stacktrace-depth from 10 to 32, and
although there is indeed no guarantee this is enough, in practice I
found the filesystem became hopelessly scrambled before ever hitting one
of the kjournald cases again.

Testing on a 400Mhz Pentium II, performance did not seem to be too much
of a problem; rather, logging failures over the serial line seemed the
bottleneck.

