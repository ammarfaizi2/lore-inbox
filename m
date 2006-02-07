Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWBGECJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWBGECJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 23:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWBGECJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 23:02:09 -0500
Received: from clix.aarnet.edu.au ([192.94.63.10]:56529 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP id S964962AbWBGECI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 23:02:08 -0500
Message-ID: <43E81B66.5060502@aarnet.edu.au>
Date: Tue, 07 Feb 2006 14:30:38 +1030
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australia's Academic & Research Network
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kumar Gala <galak@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <20060206202654.GC2470@ucw.cz> <20060206205459.GB9388@flint.arm.linux.org.uk>
In-Reply-To: <20060206205459.GB9388@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -104.901 BAYES_00,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Noting that I know next-to-nothing about kernel programming,
  but I have been down this particular road before...]

Russell King wrote:
 > Maybe flush_old_exec() should be a little more careful
 > about what it copies, changing non-alphanumeric characters
 > to '?' ?

I'm not sure it can do that, if the kernel policy is to
be 8-bit clean (to allow UTF-8 to work without coding
UTF-8 knowledge into the kernel).

What the code could do is not printk() user-influenced strings
at all. For example, mm/oom_kill.c could print just the process
ID here:

   printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n",
          p->pid, p->comm);


The usual solution to this problem is to mark user-derived
strings as tainted and then check for the taint attribute
when strings are requested to be output.  But since this
is a kernel I don't suppose you'd be keen doing that :-)

I suppose you need a policy decision -- are strings scrubbed
on input (I've coded this once and it is really quite tricky).
And then do you need a scrubbed and non-scrubbed version of
p->comm (as comparing scrubbed p->comm for equality is
problematic and probably expolitable). Or do you simply not
output strings which have been tainted by contact with users.

-- 
  Glen Turner         Tel: (08) 8303 3936 or +61 8 8303 3936
  Australia's Academic & Research Network  www.aarnet.edu.au
