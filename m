Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTLVTaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbTLVTaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:30:20 -0500
Received: from fmr06.intel.com ([134.134.136.7]:205 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264487AbTLVTaP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:30:15 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: minor e1000 bug
Date: Mon, 22 Dec 2003 11:30:09 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD75@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: minor e1000 bug
Thread-Index: AcPIoCuk7afa+el2Qo+vFvElPWMdJwAIcDoQ
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Ethan Weinstein" <lists@stinkfoot.org>
Cc: "Hans-Peter Jansen" <hpj@urpla.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Dec 2003 19:30:09.0970 (UTC) FILETIME=[0337B920:01C3C8C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This modification appears to somewhat remedy the problem, however, 
> bandwidth measurement seems to be much more accurate with many other 
> cards.  By what method does, say, the 3c59x card export its 
> statistics 
> to /proc/net/dev that makes it easier to measure?

e100 and e1000 both query h/w for stats on a timer (2 seconds) and cache
the results.  A call into the driver's get_stats function just returns
these cached values.  With e100, there is a problem in that issuing the
command to dump stats doesn't return right away, so rather than blocking
in the driver by waiting for the command to complete, the driver just
reads the results of the dump command 2 seconds prior, and then reissues
a new dump command.  So e100 stats are delayed by ~2 seconds.

3c59x (and others) query the h/w for stats in the driver's get_stats
function directly.  This gives up-to-date stats.  We could do this with
e1000, but it'll take a little bit of surgery because there is some
other code in the driver that is dependent on stats collected over 2
second period.  Nothing that can't be fixed.

-scott
