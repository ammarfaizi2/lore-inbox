Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756037AbWKTLDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037AbWKTLDb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756171AbWKTLDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:03:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:5582 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1756134AbWKTLDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:03:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fGxfemz/k/Y72u/uU8J2Tl7jc29nH5nUOR+q2GHqKaAHtYS2FTMbO0fq+r5NkeG6JLCgDkbqfy+roT26fIuAcPVsI0yehJRJWx6LwEw3zVMAAQ2VYVEc+NIVtLsUkvdePTPljLZyMhLrICmJcXS0ZIpuLE2OY10b67jUtNI3PIM=
Date: Mon, 20 Nov 2006 19:57:35 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Don Mullis <dwm@meer.net>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm <akpm@osdl.org>
Subject: Re: [PATCH -mm] fault-injection: reject-failure-if-any-caller-lies-within-specified range
Message-ID: <20061120105735.GA9795@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Don Mullis <dwm@meer.net>, linux-kernel@vger.kernel.org, ak@suse.de,
	akpm <akpm@osdl.org>
References: <455217df.719dec4f.2c80.ffffb500@mx.google.com> <1163991847.2912.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163991847.2912.15.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 07:04:07PM -0800, Don Mullis wrote:
> /debug/fail_make_request can force a failure like the following:
> 
> 	FAULT_INJECTION: forcing a failure
...
> 	Buffer I/O error on device hda2, logical block 5782
> 	lost page write due to I/O error on hda2
> 	Aborting journal on device hda2.
> 	journal commit I/O error
> 	ext3_abort called.
> 	EXT3-fs error (device hda2): ext3_journal_start_sb: Detected aborted journal
> 	Remounting filesystem read-only
> 
> The above read-only remount effectively ends the test run.  

This test is a little intentional.
(Normal I/O may fail, but journal commit I/O doesn't fail)

If you want to do this, you could put journal on the other device.

> Implementation approach is to extend the existing
> address-start/address-end mechanism specifying a range _required_ to
> be found on the stack, by the addition of an address range to be
> _rejected_.  

The only problem about this is, the users who set reject address range really
don't want to insert failures from the address range. So they have to change
stacktrace-depth large enough. It will cause large slow down by aggressive
stacktrace and there is no guarantee to prevent from injecting failures the
address range.

