Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWIFGiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWIFGiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 02:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWIFGiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 02:38:23 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:2178 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751239AbWIFGiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 02:38:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HSli2teF7GGPZlLYKE+KBOHhqZ9duAr3kiAa1SCKFZUN65725yYHyyc4N6fUGou5ZR5e56/3uL92JUw4kTtQWcoQwrLcSDznRBYCRyfHQRS4wlH5GBiizhhCG7XilnazQSWH98P9G3Z1Aed/cEsdZGY05tIxJrOU6dhhey4aObg=  ;
Message-ID: <44FE6CD6.4040809@yahoo.com.au>
Date: Wed, 06 Sep 2006 16:38:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Kimball Murray <kimball.murray@gmail.com>
CC: linux-kernel@vger.kernel.org, akpm@digeo.com, ak@suse.de
Subject: Re: [Feature] x86_64 page tracking for Stratus servers
References: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
In-Reply-To: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kimball Murray wrote:

>Attached is a git patch that implements a feature that is used by Stratus
>fault-tolerant servers running on Intel x86_64 platforms.  It provides the
>kernel mechanism that allows a loadable module to be able to keep track of
>recently dirtied pages for the purpose of copying live, currently active
>memory, to a spare memory module.
>
>In Stratus servers, this spare memory module (and CPUs) will be brought into
>lockstep with the original memory (and CPUs) in order to achieve fault
>tolerance.
>
>In order to make this feature work, it is necessary to track pages which have
>been recently dirtied.  A simplified view of the algorithm used in the kernel
>module is this:
>
>1. Turn on the tracking functionality.
>2. Copy all memory from active to spare memory module.
>3. Until done:
>	a) Identify all pages that were dirtied in the active memory since
>	   the last copy operation.
>	b) Copy all pages identified in 3a to the spare memory module.
>	c) If number of pages still dirty is less than some threshhold,
>		i.  "black out" the system (enter SMI)
>		ii.  copy remaining pages in blackout context
>		iii. goto step 4
>	   Else
>		goto 3a.
>4. synchronize cpus
>5. leave SMI, return to OS
>6. System is now "Duplexed", and fault tolerant.
>

Silly question, why can't you do all this from stop_machine_run context (or
your SMI) that doesn't have to worry about other CPUs dirtying memory?

>Please consider this feature for inclusion in the kernel tree, as it is very
>important to Stratus.
>

Given that it doesn't touch core mm/ code, I don't really care about it[*]
except that it doesn't make sense to have the tracking hooks in generic code
because it is pretty specific to your module.

Also, as far as a "notifier" goes, it is of course completely broken unless
your module is the only one that is ever going to use it. Which I suspect
may be the case ;) But you do really need to at least WARN_ON or fail if
someone is going to break it like this.

[*] Though if it gets included, it would not stop me lamenting the
proliferation of complexities to support *tiny* obscure userbases. Can
we wait until your hardware is smart enough to snoop the cc? :)

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
