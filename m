Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262397AbTDAKXo>; Tue, 1 Apr 2003 05:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262399AbTDAKXo>; Tue, 1 Apr 2003 05:23:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26899 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262397AbTDAKXn>; Tue, 1 Apr 2003 05:23:43 -0500
Date: Tue, 1 Apr 2003 11:35:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Peter Oberparleiter <oberpapr@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partition check order in fs/partition/check.c?
Message-ID: <20030401113503.A30470@flint.arm.linux.org.uk>
Mail-Followup-To: Peter Oberparleiter <oberpapr@softhome.net>,
	linux-kernel@vger.kernel.org
References: <200304010934.h319Y5TR270722@d06relay02.portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304010934.h319Y5TR270722@d06relay02.portsmouth.uk.ibm.com>; from oberpapr@softhome.net on Tue, Apr 01, 2003 at 11:33:03AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 11:33:03AM +0200, Peter Oberparleiter wrote:
> Now for the actual questions: what is the reason for the order of partition 
> checks as it is?

It's all to do with getting the right detection of the partitioning
scheme.  If the order is wrong, you either can't detect a scheme, or
you mis-detect a scheme every time.

> Couldn't the acorn tests be moved further down in the list to solve
> this particular problem?

Unfortunately not (on both counts.)

There are several partitioning schemes for Acorn drives (thanks to Acorn
never defining a decent partitioning method, vendors went off and each
did their own thing.)  So, we have the following schemes:

	Scheme			512-byte sector offset
1.	ICS			0
2.	PowerTec		0
3.	EESOX			7
4.	Cumana			3
5.	ADFS			3

Schemes 1 through 3 may (or may not) contain valid ADFS information at
sector 3.  Scheme 4 definitely has valid ADFS information at sector 3.
Therefore, to correctly identify all in this list, ADFS must come last
in this list.

However, there are a large percentage of drives which have an old x86
BIOS partition table at sector 0.  To prevent mis-detecting these
drives (which would render the ADFS partition check useless) the x86
BIOS partition check must come after ADFS.

So, there are three dependencies - ICS, PowerTec, EESOX before Cumana,
Cumana before ADFS, ADFS before x86 BIOS.  This means PowerTec must
come before x86 BIOS.

> Also, is there a way to make the acorn test more specific?

s/acorn/powertec/

We may be able to check that start,start+size lies within the overall
drive size.  Whether this solves the problem will depend upon the contents
of sector 0 for the x86 drives which clash.  However, as drive sizes
increase, this test will become less and less effective (and at 2TiB
it doesn't help at all.)

Another solution would be to pass a kernel parameter like
"partition=hda:msdos,hdb:adfs" to force specific partition interpretation.
However, this could cause issues with hotplug stuff.  Another alternative
is to just turn off the troublesome powertec scheme if you don't have any
drives using that scheme.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

