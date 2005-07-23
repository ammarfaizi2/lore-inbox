Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVGWCdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVGWCdp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 22:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVGWCdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 22:33:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:20463 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262313AbVGWCcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 22:32:03 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17121.44053.855399.587966@tut.ibm.com>
Date: Fri, 22 Jul 2005 21:31:49 -0500
To: karim@opersys.com
Cc: Tom Zanussi <zanussi@us.ibm.com>, Roman Zippel <zippel@linux-m68k.org>,
       Steven Rostedt <rostedt@goodmis.org>, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Merging relayfs?
In-Reply-To: <42E17EEC.5070102@opersys.com>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050712022537.GA26128@infradead.org>
	<20050711193409.043ecb14.akpm@osdl.org>
	<Pine.LNX.4.61.0507131809120.3743@scrub.home>
	<17110.32325.532858.79690@tut.ibm.com>
	<Pine.LNX.4.61.0507171551390.3728@scrub.home>
	<17114.32450.420164.971783@tut.ibm.com>
	<1121694275.12862.23.camel@localhost.localdomain>
	<Pine.LNX.4.61.0507181607410.3743@scrub.home>
	<42DBBD69.3030300@opersys.com>
	<Pine.LNX.4.61.0507181706430.3728@scrub.home>
	<17115.53671.326542.392470@tut.ibm.com>
	<17121.23125.981162.389667@tut.ibm.com>
	<42E17EEC.5070102@opersys.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour writes:
 > 
 > Tom Zanussi wrote:
 > > - removed the deliver() callback
 > > - removed the relay_commit() function
 > 
 > This breaks LTT. Any reason why this needed to be removed? In the end,
 > the code will just end up being duplicated in ltt and all other users.
 > IOW, this is not some potential future use, but something that's
 > currently being used.

Because I realized that like the padding and commit arrays, they're
not really necessary.

In all the examples, the padding is saved in space reserved at the
beginning of the sub-buffer via subbuf_start_reserve(), except that
now the padding is passed into the subbuf_start() callback rather than
kept in an array.  The padding value passed in is then directly saved
in the reserved padding space.

Similarly, in the case of the reserve/commit example, extra space is
also reserved for the commit count using subbuf_start_reserve().
After space for an event is reserved using relay_reserve() and
completely written, the event length is added to that commit value.
In userspace, the sub-buffer reading loop looks at the commit value in
the sub-buffer, and if it matches (sub-buffer size - padding), the
buffer has been completely written and can be saved, otherwise it's
not yet complete and is checked again the next time around.  This way,
there's no need for a deliver() callback, the relay_commit() is
replaced with the increment of the reserved commit value, the arrays
aren't needed and you get the same result in the end in a much simpler
way, IMHO.

But if you see a problem with it or have any suggestions to make it
better/different, please let me know...

Tom


