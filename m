Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVLUSiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVLUSiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVLUSiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:38:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751158AbVLUSiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:38:10 -0500
Date: Wed, 21 Dec 2005 10:37:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?Hanno_B=C3=B6ck?= <mail@hboeck.de>
cc: Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Karol Kozimor <sziwan@hell.org.pl>,
       Christian Aichinger <Greek0@gmx.net>
Subject: Re: asus_acpi still broken on Samsung P30/P35
In-Reply-To: <200512211611.51977.mail@hboeck.de>
Message-ID: <Pine.LNX.4.64.0512211035370.4827@g5.osdl.org>
References: <200512211611.51977.mail@hboeck.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-456525677-1135190223=:4827"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-456525677-1135190223=:4827
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Wed, 21 Dec 2005, Hanno Böck wrote:
> 
> This is not "some minor issue", this completely breaks the usage of current 
> vanilla-kernels on certain Hardware. Can please, please, please anyone in the 
> position to do this take care that this patch get's accepted before 2.6.15?
> 
> The patch is available inside mm-sources or here:
> http://www.int21.de/samsung/p30-2.6.14.diff
> 
> If I should send it to anyone else or if there's anything I can do to help 
> fixing this, I'm glad to help.

Last I saw this patch, I wrote this reply (the patch above is still 
broken). Nobody ever came back to me on it.

			Linus

---
Date: Tue, 13 Dec 2005 21:15:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
cc: Greg KH <greg@kroah.com>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    stable@kernel.org, acpi-devel <acpi-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Fix oops in asus_acpi.c on Samsung P30/P35 Laptops

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

--21872808-456525677-1135190223=:4827--
