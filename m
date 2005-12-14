Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVLNFQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVLNFQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 00:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVLNFQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 00:16:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751185AbVLNFQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 00:16:09 -0500
Date: Tue, 13 Dec 2005 21:15:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, acpi-devel <acpi-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Fix oops in asus_acpi.c on Samsung P30/P35 Laptops
In-Reply-To: <439FA436.50107@gmx.net>
Message-ID: <Pine.LNX.4.64.0512132104140.4184@g5.osdl.org>
References: <4395D945.6080108@gmx.net> <20051206192136.GA22615@kroah.com>
 <4395F0AB.1080408@gmx.net> <20051208033841.GA25008@kroah.com> <439A23CB.50102@gmx.net>
 <439FA436.50107@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Dec 2005, Carl-Daniel Hailfinger wrote:
> 
> The patch has been tested and verified, is shipped in the
> SUSE 10.0 kernel and does not cause any regressions.

I'd be _much_ happier if

 - the patch wasn't totally whitespace-damaged (your mailer seems 
   to not only remove spaces at the end of lines, it _also_ adds them to 
   the beginning when there was another space there, as far as I can tell)

   Being right "on average" thanks to having two different bugs does not a 
   good mailer make.

 - you were to separate out the oops-fixing code from the code that adds 
   handling for that (strange?) model type logic.

   It seems that the _oops_ is because the later paths just assume that 
   it's a ACPI_TYPE_STRING and will dereference "model->string.pointer" 
   regardless of whether that is true or not. And you add a test for 
   ACPI_TYPE_INTEGER, however, you do _not_ fix the oops for any other 
   type, so the exact _same_ bug is still waiting to happen if there is 
   some other strange ACPI table entry some day.

So I think the proper fix is to _first_ just do something like

	if (model->type != ACPI_TYPE_STRING)
		goto unknown;

which should fix the oops (no?), and then handling ACPI_TYPE_INTEGER above 
that as one case would be a separate patch.

		Linus
