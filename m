Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267398AbUHDTkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267398AbUHDTkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUHDTkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:40:31 -0400
Received: from mail.aei.ca ([206.123.6.14]:29152 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267398AbUHDTkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:40:12 -0400
Subject: Re: [PATCH] fix readahead breakage for sequential after random
	reads
From: Shane Shrybman <shrybman@aei.ca>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, miklos@szeredi.hu,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1091641117.15334.89.camel@localhost.localdomain>
References: <E1BmKAd-0001hz-00@dorka.pomaz.szeredi.hu>
	 <20040726162950.7f4a3cf4.akpm@osdl.org>
	 <1090886218.8416.3.camel@dyn319181.beaverton.ibm.com>
	 <20040726170843.3fe5615c.akpm@osdl.org>
	 <1090901926.8416.13.camel@dyn319181.beaverton.ibm.com>
	 <1091641117.15334.89.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1091648391.3486.13.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 15:39:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-04 at 13:38, Ram Pai wrote:
> On Mon, 2004-07-26 at 21:18, Ram Pai wrote:
> > On Mon, 2004-07-26 at 17:08, Andrew Morton wrote:
> > > Ram Pai <linuxram@us.ibm.com> wrote:
> > > >
> > > > Andrew,
> > > > 	Yes the patch fixes a valid bug.
> > > > 
> > > 
> > > Please don't top-post :(
> > > > RP
> > > > 
> > > > On Mon, 2004-07-26 at 16:29, Andrew Morton wrote:
> > > > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > > >
> > > > > > Current readahead logic is broken when a random read pattern is
> > > > > >  followed by a long sequential read.  The cause is that on a window
> > > > > >  miss ra->next_size is set to ra->average, but ra->average is only
> > > > > >  updated at the end of a sequence, so window size will remain 1 until
> > > > > >  the end of the sequential read.
> > > > > > 
> > > > > >  This patch fixes this by taking the current sequence length into
> > > > > >  account (code taken from towards end of page_cache_readahead()), and
> > > > > >  also setting ra->average to a decent value in handle_ra_miss() when
> > > > > >  sequential access is detected.
> > > > > 
> > > > > Thanks.   Do you have any performance testing results from this patch?
> > > > > 
> > > > Ram Pai <linuxram@us.ibm.com> wrote:
> > > >
> > > > Andrew,
> > > > 	Yes the patch fixes a valid bug.
> > > 
> > > Fine, but the readahead code is performance-sensitive, and it takes quite
> > > some time for any regressions to be discovered.  So I'm going to need to
> > > either sit on this patch for a very long time, or extensively test it
> > > myself, or await convincing test results from someone else.
> > > 
> > > Can you help with that?
> > 
> > yes I will run all my standard testsuites before we take this patch.
> > (DSS workload, iozone, sysbench). I will get back with some results
> > sooon. Probably by the end of this week.
> 
> Ok I have enclosed the results. The summary is: there is no significant
> improvement or decrease in performance of (DSS workload, iozone,
> sysbench) The increase or decrease is in the margin of errors.
> 
> I have also enclosed a patch that partially backs off Miklos's fix. 
> Shane Shrybman correctly pointed out that the real fix is to set
> ra->average value to max/2 when we move from readahead-off mode to
> readahead-on mode. The other part of Miklos's fix becomes irrelevent.
> 

The patch looks fine to me.
>  
> Sorry it took some time to get back on this. Its almost automated so
> turnaround time should be quick now-on-wards.
> 

For these types of bugs the difference is not in the IO performance
numbers but in the processing overhead. Does it make sense to track
processor statistics (sys/user/io-wait...) during the benchmarks. So we
could say that this patch doesn't change IO performance but uses 1% less
system time?

Maybe use /usr/bin/time -v sysbench ...

> RP

Regards,

Shane

