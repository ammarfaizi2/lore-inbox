Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbVL1TG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVL1TG5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVL1TG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:06:57 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:3792 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964878AbVL1TG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:06:56 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17330.59716.136146.729098@tut.ibm.com>
Date: Wed, 28 Dec 2005 13:36:36 -0600
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, fche@redhat.com,
       linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
       systemtap@sources.redhat.com
Subject: Re: Better pagecache statistics ?
In-Reply-To: <20051228013325.GA4144@dmt.cnet>
References: <1133377029.27824.90.camel@localhost.localdomain>
	<20051201152029.GA14499@dmt.cnet>
	<20051228013325.GA4144@dmt.cnet>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:

[...]

 > 
 > b) ERROR: MAXACTION exceeded near identifier 'log' at ttfp_delay.stp:49:3
 > 
 > The array size is capped to a maximum. Is there any way to configure
 > SystemTap to periodically dump-and-zero the arrays? This makes lots of
 > sense to any statistical gathering code.
 > 
 > c) Hash tables
 > 
 > It would be better to store the log entries in a hash table, the present
 > script uses the "current" pointer as a key into a pair of arrays,
 > incrementing the key until a free one is found (which can be very
 > inefficient).
 > 
 > A hash table would be much more efficient, but allocating memory inside
 > the scripts is tricky. A pre-allocated, pre-sized pool of memory could 
 > work well for this purpose. The "dump-array-entries-to-userspace" action
 > could be used to free them.
 > 
 > So both b) and c) could be fixed with the same logic:
 > 
 > - dump entries to userspace if memory pool is getting short 
 > on free entries.
 > - periodically dump entries to userspace (akin to "bdflush").

Hi,

There's a sytemtap example that does something similar to what you're
describing - see the kmalloc-stacks/kmalloc-top examples in the
testsuite:

systemtap/tests/systemtap.samples/kmalloc-stacks.stp
systemtap/tests/systemtap.samples/kmalloc-top

Basically, the kmalloc-stacks.stp script hashes data in a systemtap
hash and periodically formats the current contents of the hash table
into a convenient form and writes it to userspace, then clears the
hash for the next go-round.  kmalloc-top is a companion Perl script
'daemon' that sits around in userspace waiting for new batches of hash
data, which it then adds to a continuously accumulating Perl hash in
the user-side script.  There's a bit more detail about the script(s)
here:

http://sourceware.org/ml/systemtap/2005-q3/msg00550.html

HTH,

Tom


