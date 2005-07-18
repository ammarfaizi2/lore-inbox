Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVGRP7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVGRP7L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 11:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVGRP6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 11:58:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52210 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261823AbVGRP6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 11:58:39 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17115.53671.326542.392470@tut.ibm.com>
Date: Mon, 18 Jul 2005 10:58:31 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Karim Yaghmour <karim@opersys.com>, Steven Rostedt <rostedt@goodmis.org>,
       Tom Zanussi <zanussi@us.ibm.com>, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Merging relayfs?
In-Reply-To: <Pine.LNX.4.61.0507181706430.3728@scrub.home>
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
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
 > Hi,
 > 
 > On Mon, 18 Jul 2005, Karim Yaghmour wrote:
 > 
 > > I guess I just don't get the point here. Why cut something away if many
 > > users will need it. If it's that popular that you're ready to provide a
 > > library function to do it, then why not just leave it to boot? One of the
 > > goals of relayfs is to avoid code duplication with regards to buffering
 > > in general.
 > 
 > The road to bloatness is paved with lots of little features.
 > There aren't that many users anyway (none of the examples use that 
 > feature). I'd prefer to concentrate on a simple and correct relayfs layer 
 > and we can still think about other features as more users appear.
 > Starting a design by implementing every little feature which _might_ be 
 > needed is a really bad idea.
 > 

OK, if we got rid of the padding counts and commit counts and let the
client manage those, we can simplify the buffer switch slow path and
make the API simpler in the process.  Here's a first proposal for
doing that - I won't know until I actually do it what snags I may run
into, but if this looks like the right direction to go, I'll go ahead
with it...

- get rid of the padding counts - the client can manage those if it
wants to, but in any case pass the padding for the previous sub-buffer
in to the subbuf_start callback.

- get rid of the commit counts - the client can manage those.  Also,
get rid of the related API functions that deal with those
i.e. relay_commit() and the deliver() callback.

- change the buffer_start() callback to something like the following
(the body shows an example of what would typically be done by a
client):

/*
 * subbuf_start() callback.
 *
 * Return 1 to allow logging to continue, 0 to stop.
 */
static int subbuf_start_default_callback (struct rchan_buf *buf,
                                          void *subbuf,
                                          void *prev_subbuf,
					  int prev_padding)
{
	*((int *)prev_subbuf) = prev_padding;
	
	if (relay_buf_full(buf))
		return 0;

	relay_reserve(subbuf, sizeof (int));

        return 1;
}

- add a relay_reserve() function for the client to use to reserve
space at the beginning of the sub-buffer (it can use this reserved
space to save the padding among other things).  This would be used by
the client in the subbuf_start callback, rather than returning it via
an outparam or struct.

- remove the buf_full() callback - the client can determine this in
the subbuf_start() callback.

Also, as far as the netlink/ioctl/proc file communication, I'll have
to think more about it, but will play around with something when I
update the example code.

Let me know if this sounds ok, or if you have better suggestions.

Thanks,

Tom




