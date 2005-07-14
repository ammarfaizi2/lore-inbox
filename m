Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263039AbVGNPBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbVGNPBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 11:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbVGNPBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 11:01:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11765 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263044AbVGNPBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 11:01:38 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17110.32325.532858.79690@tut.ibm.com>
Date: Thu, 14 Jul 2005 10:01:25 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       zanussi@us.ibm.com, linux-kernel@vger.kernel.org, karim@opersys.com,
       varap@us.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <Pine.LNX.4.61.0507131809120.3743@scrub.home>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050712022537.GA26128@infradead.org>
	<20050711193409.043ecb14.akpm@osdl.org>
	<Pine.LNX.4.61.0507131809120.3743@scrub.home>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
 > Hi,
 > 
 > On Mon, 11 Jul 2005, Andrew Morton wrote:
 > 
 > > > > Hi Andrew, can you please merge relayfs?  It provides a low-overhead
 > > > > logging and buffering capability, which does not currently exist in
 > > > > the kernel.
 > > > 
 > > > While the code is pretty nicely in shape it seems rather pointless to
 > > > merge until an actual user goes with it.
 > > 
 > > Ordinarily I'd agree.  But this is a bit like kprobes - it's a funny thing
 > > which other kernel features rely upon, but those features are often ad-hoc
 > > and aren't intended for merging.
 > 
 > I agree with Christoph, I'd like to see a small (and useful) example 
 > included, which can be used as reference. relayfs client still need some 
 > code of their own to communicate with user space. If I look at the example 
 > code I'm not really sure netlink is a good way to go as control channel.
 > kprobes has a rather simple interface, relayfs is more complex and I think 
 > it's a good idea to provide some sane and complete example code to copy 
 > from.
 > 

The netlink control channel seems to work very well, but I can
certainly change the examples to use something different.  Could you
suggest something?

 > Looking through the patch there are still a few areas I'm concerned about:
 > - the usage of atomic_t look a little silly, there is only a single 
 > writer and probably needs some cache line optimisations

The only things that are atomic are the counts of produced and
consumed buffers and these are only ever updated or read in the slow
buffer-switch path.  They're atomic because if they weren't, wouldn't
it be possible for the client to read an unfinished value if the
producer was in the middle of updating it?

 > - I would prefer "unsigned int" over just "unsigned"
 > - the padding/commit arrays can be easily managed by the client

Yes, I can move them out and update the examples to reflect that, but
I thought that if this was something that most clients would need to
do, it made some sense to keep it in relayfs and avoid duplication in
the clients.

 > - overwrite mode can be implemented via the buffer switch callback

The buffer switch callback is already where this is handled, unless
you're thinking of something else - one of the first checks in the
buffer switch is relay_buf_full(), which always returns 0 if the
buffer is in overwrite mode.

Tom


