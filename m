Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUAXBDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 20:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUAXBDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 20:03:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:14300 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266831AbUAXBDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 20:03:41 -0500
Subject: Re: swsusp vs  pgdir
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0401230839420.11276-100000@monsoon.he.net>
References: <1074833921.975.197.camel@gaston>
	 <20040123073426.GA211@elf.ucw.cz> <1074843781.878.1.camel@gaston>
	 <20040123075451.GB211@elf.ucw.cz>
	 <Pine.LNX.4.50.0401230759180.11276-100000@monsoon.he.net>
	 <1074874219.835.32.camel@gaston>
	 <Pine.LNX.4.50.0401230839420.11276-100000@monsoon.he.net>
Content-Type: text/plain
Message-Id: <1074906182.835.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 24 Jan 2004 12:03:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-24 at 03:45, Patrick Mochel wrote:

> A new pgdir is allocated on resume that does not overlap with any pages
> being restored. See relocate_pagedir() in the code..

Looking at the code, this is not a real HW pgdir but rather the
page copy list specific to swsusp. AFAIK, the HW pgdir is copied over.

> We assume that the kernel version is the same, and therefore that the code
> and static data are in same locations in memory. So, even if the kernel
> page tables get overwritten, we can still access the pointer to the pgdir.

Yes, the pgdir is there, but 1) it's getting overwriten, so if it
doesn't contain the same large page mapping on old and new, we are
screwed and 2) if accessing the linear mapping (when copying pages)
require going one level deeper into the page tables, then we are
possibly screwed too since those will be partly overwriten and won't
ever be in a "sane" state until the full copy is done.

Note that I don't have that problem with my current PPC hacks, as I
disable the MMU for the copy :)

Ben.


