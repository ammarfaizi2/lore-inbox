Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUGZWio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUGZWio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUGZWio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:38:44 -0400
Received: from mail1.slu.se ([130.238.96.11]:41152 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S265499AbUGZWib convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:38:31 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16645.34772.760879.146784@robur.slu.se>
Date: Tue, 27 Jul 2004 00:38:12 +0200
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <Pine.LNX.4.44.0407270028170.11416-100000@silmu.st.jyu.fi>
References: <16645.13126.52445.630789@robur.slu.se>
	<Pine.LNX.4.44.0407270028170.11416-100000@silmu.st.jyu.fi>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pasi Sjoholm writes:

 > Hur är läget Robert?-)
   Tack bra!

 > >  In summary: High softirq loads can totally kill userland. The reason is that 
 > >  do_softirq() is run from many places hard interrupts, local_bh_enable etc 
 > >  and bypasses the ksoftirqd protection. It just been discussed at OLS with
 > >  Andrea and Dipankar and others. Current RCU suffers from this problem as well.
 > 
 > Ok, this explanation makes sense and my point of view I think this is 
 > quite critical problem if you can "crash" linux kernel just sending enough 
 > packets to network interface for an example.

 Well the packets also has to create hard softirq loads in practice this means route
 lookup or something else for normal traffic the RX_SOFIRQ is very well behaved
 and schedules itself to give other softirq's a chance to run also I'll guess you 
 have softirq's not only from the network. If you decrease your load a bit you come
 to more nomal operation?
 
 > I would be more than glad to help you in testing if you want to publish 
 > some patches. 

 Well maybe we should start to verify that this problem. Alexey did a litte program 
 doing gettimeofday to run to see how long user mode could be starved. Also note we 
 add new source of softirq's. 


#include <stdio.h> 
#include <sys/time.h>
#include <asm/types.h>

main()
{
	struct timeval tv, prev_tv;
	__s64 diff;
	__u32 i;
	__s32 maxlat = 50;

	  gettimeofday(&prev_tv, NULL);

	  printf("time control loop starting\n");

	  for (i=0;;i++) {
	      gettimeofday(&tv, NULL);
	      diff = (tv.tv_sec - prev_tv.tv_sec)*1000000 +
	             (tv.tv_usec - prev_tv.tv_usec);
	      if (diff > 1000000) 
		  printf("**%lld\n", diff);
	      prev_tv = tv;
	      if (diff > maxlat) {
		      maxlat = diff;
		      printf("new maxlat = %d\n", maxlat);
	      }
	      if(!(i % 1000000))
		      printf("timestamp diff = %lld, maxlat = %d\n", diff, maxlat);
	  }
}

Cheers.
							--ro

