Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUCDFKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUCDFKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:10:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:54493 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261451AbUCDFKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:10:50 -0500
Date: Wed, 3 Mar 2004 21:10:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: peter@mysql.com, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
Message-Id: <20040303211042.33cd15ce.akpm@osdl.org>
In-Reply-To: <20040304045212.GG4922@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random>
	<Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
	<20040229014357.GW8834@dualathlon.random>
	<1078370073.3403.759.camel@abyss.local>
	<20040303193343.52226603.akpm@osdl.org>
	<1078371876.3403.810.camel@abyss.local>
	<20040303200704.17d81bda.akpm@osdl.org>
	<20040304045212.GG4922@dualathlon.random>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Wed, Mar 03, 2004 at 08:07:04PM -0800, Andrew Morton wrote:
>  > That's a larger difference than I expected.  But then, everyone has been
> 
>  mysql is threaded

There is a patch in -mm's 4g/4g implementation
(4g4g-locked-userspace-copy.patch) which causes all kernel<->userspace
copies to happen under page_table_lock.  In some threaded apps on SMP this
is likely to cause utterly foul performance.

That's why I'm keeping it as a separate patch.  The problem which it fixes
is very obscure indeed and I suspect most implementors will simply drop it
after they'e had a two-second peek at the profile results.

hm, I note that the changelog in that patch is junk.  I'll fix that up.

Something like:

  The current 4g/4g implementation does not guarantee the atomicity of
  mprotect() on SMP machines.  If one CPU is in the middle of a read() into
  a user memory region and another CPU is in the middle of an
  mprotect(!PROT_READ) of that region, it is possible for a race to occur
  which will result in that read successfully completing _after_ the other
  CPU's mprotect() call has returned.

  We believe that this could cause misbehaviour of such things as the
  boehm garbage collector.  This patch provides the mprotect() atomicity by
  performing all userspace copies under page_table_lock.


It is a judgement call.  Personally, I wouldn't ship a production kernel
with this patch.  People need to be aware of the tradeoff and to think and
test very carefully.

