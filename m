Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWFILjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWFILjp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 07:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWFILjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 07:39:45 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:54712 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S965087AbWFILjp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 07:39:45 -0400
Subject: Re: 2.6.17-rc6-rt1
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <1149852951.7421.7.camel@Homer.TheSimpsons.net>
References: <20060607211455.GA6132@elte.hu>
	 <1149842550.7585.27.camel@Homer.TheSimpsons.net>
	 <1149847951.3829.26.camel@frecb000686>
	 <1149852951.7421.7.camel@Homer.TheSimpsons.net>
Date: Fri, 09 Jun 2006 13:44:28 +0200
Message-Id: <1149853468.3829.33.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/06/2006 13:43:19,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/06/2006 13:43:20,
	Serialize complete at 09/06/2006 13:43:20
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 13:35 +0200, Mike Galbraith wrote:
> On Fri, 2006-06-09 at 12:12 +0200, Sébastien Dugué wrote:
> > On Fri, 2006-06-09 at 10:42 +0200, Mike Galbraith wrote:
> 
> > > After boot, it takes a very long time for KDE to finish loading... more
> > > than five minutes for the desktop background to finally appear.  Tasks
> > > which are doing nothing but a ~50ms gettimeofday() select() idle loop
> > > show up in top as using 1 to 3 percent cpu, though strace of these looks
> > > fine.  Starting any threaded app takes ages, whereas plain-jane things
> > > like gcc work fine.  For example, if I fire up xmms, the gui comes up
> > > quickly, but it takes over three minutes from the time I poke play until
> > > the first sound is emitted.  Starting evolution takes even longer.
> > > 
> > > Hoping that something might show up while running glibc-2.4 make check
> > > to save me from wading through huge truckloads of strace, I tried it.
> > > It repeatedly goes boom.  RT29 goes boom the same way, but doesn't
> > > exhibit the slow threaded app symptom.  Drat.
> > > 
> > 
> >   Yep noticed that here too. As you pointed out it seems to be related
> > to threaded apps. ls, vi, ... work fine whereas xemacs or others are
> > real slow, portmapper fails to respond, ...
> > 
> >   I've got no indication in the logs that something went wrong, nor
> > do I see any kernel BUG or WARNING.
> > 
> >   My box is a dual 2.8GHz HT xeon w/ 2GB mem.
> > 
> >   rt29 was fine as is 2.6.17-rc6.
> > 
> >   I feel a bit perplexed here.
> 
> I found xmms problem.
> 
> [pid  8498] 12:53:49.936186 socket(PF_INET, SOCK_STREAM, IPPROTO_IP <unfinished ...>
> [pid  8498] 12:53:49.936551 <... socket resumed> ) = 9 <0.000301>
> [pid  8498] 12:53:49.936774 fcntl64(9, F_SETFD, FD_CLOEXEC <unfinished ...>
> [pid  8498] 12:53:49.937287 <... fcntl64 resumed> ) = 0 <0.000465>
> [pid  8498] 12:53:49.937451 setsockopt(9, SOL_SOCKET, SO_REUSEADDR, [1], 4 <unfinished ...>
> [pid  8498] 12:53:49.937630 <... setsockopt resumed> ) = 0 <0.000110>
> [pid  8498] 12:53:49.937893 connect(9, {sa_family=AF_INET, sin_port=htons(16001), sin_addr=inet_addr("127.0.0.1")}, 16 <unfinished ...>
> [pid  8498] 12:56:58.902958 <... connect resumed> ) = -1 ETIMEDOUT (Connection timed out) <188.964934>
> 
> which should have been...
> 
> [pid  7385] 13:21:38.715146 socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 9 <0.000011>
> [pid  7385] 13:21:38.715192 fcntl64(9, F_SETFD, FD_CLOEXEC) = 0 <0.000007>
> [pid  7385] 13:21:38.715237 setsockopt(9, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000008>
> [pid  7385] 13:21:38.715283 connect(9, {sa_family=AF_INET, sin_port=htons(16001), sin_addr=inet_addr("127.0.0.1")}, 16) = -1 ECONNREFUSED (Connection refused) <0.000060>
> 
> So much for the easy part.
> 

  I'm starting to believe that it's network related. Pinging my box from
a remote host gives a ~.3 ms round trip whereas pinging localhost gives
~500ms. Something real weird is going on here.

  I'm trying to dig deeper but I'm no expert here.

  Sébastien.



