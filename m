Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTK0AZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 19:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTK0AZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 19:25:36 -0500
Received: from [63.205.85.133] ([63.205.85.133]:13295 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S263189AbTK0AZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 19:25:35 -0500
Date: Wed, 26 Nov 2003 16:30:17 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fast timestamps
Message-ID: <20031127003017.GB70073@gaz.sfgoth.com>
References: <p73fzgbzca6.fsf@verdi.suse.de> <20031126113040.3b774360.davem@redhat.com> <3FC505F4.2010006@google.com> <20031126120316.3ee1d251.davem@redhat.com> <20031126232909.7e8a028f.ak@suse.de> <20031126143620.5229fb1f.davem@redhat.com> <20031126235641.36fd71c1.ak@suse.de> <20031126151352.160b4734.davem@redhat.com> <3FC53A40.8010904@candelatech.com> <20031126160129.32855a15.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031126160129.32855a15.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Ben Greear <greearb@candelatech.com> wrote:
> > I'll try to write up a patch that uses the TSC and lazy conversion
> > to timeval as soon as I get the rx-all and rx-fcs code happily
> > into the kernel....
> > 
> > Assuming TSC is very fast and the conversion is accurate enough, I think
> > this can give good results....
> 
> I'm amazed that you will be able to write a fast_timestamp
> implementation without even seeing the API I had specified
> to the various arch maintainers :-)

Also, anyone interested in doing this should probably re-read the thread
on netdev from a couple months back about this, since we hashed out some
implementation details wrt SMP efficiency:
  http://oss.sgi.com/projects/netdev/archive/2003-10/msg00032.html

Although reading this thread I'm feeling that Andi is probably right -
are there really any apps that coudn't cope with a small inaccuracy of the
first ioctl-fetched timestamp?  I really doubt it.  Basically there's
two common cases:
  1. System under reasonably network load: in this case the tcpdump (or
     whatever) probably will get the packet soon after it arrived, so
     the timestamp we compute for the first packet won't be very far off.
  2. System under heavy network load: the card's hardware rx queues are
     probably pretty full so our timestamps won't be very accurate
     no matter what we do

Given that the timestamp is already inexact it seems like a fine idea to
trade a tiny amount of accuracy for a potentially significant performance
improvement.

-Mitch
