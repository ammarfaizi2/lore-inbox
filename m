Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbUDBS1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 13:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbUDBS1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 13:27:32 -0500
Received: from prosun.first.gmd.de ([194.95.168.2]:38301 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262263AbUDBS13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 13:27:29 -0500
Subject: solved (was Re: xterm scrolling speed - scheduling weirdness in
	2.6 ?!)
From: Soeren Sonnenburg <kernel@nn7.de>
To: Kenneth Johansson <ken@kenjo.org>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Willy Tarreau <willy@w.ods.org>,
       szonyi calin <caszonyi@yahoo.com>, azarah@nosferatu.za.org,
       Con Kolivas <kernel@kolivas.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
In-Reply-To: <1073296227.8535.34.camel@tiger>
References: <1073227359.6075.284.camel@nosferatu.lan>
	 <20040104225827.39142.qmail@web40613.mail.yahoo.com>
	 <20040104233312.GA649@alpha.home.local>
	 <20040104234703.GY1882@matchmail.com>  <1073296227.8535.34.camel@tiger>
Content-Type: text/plain
Message-Id: <1080930132.1720.38.camel@localhost>
Mime-Version: 1.0
Date: Fri, 02 Apr 2004 20:22:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 10:50, Kenneth Johansson wrote:
> On Mon, 2004-01-05 at 00:47, Mike Fedyk wrote:
> > On Mon, Jan 05, 2004 at 12:33:12AM +0100, Willy Tarreau wrote:
> > > at a time. I have yet to understand why 'ls|cat' behaves
> > > differently, but fortunately it works and it has already saved
> > > me some useful time.
> > 
> > cat probably does some buffering for you, and sends the output to xterm in
> > larger blocks.
> 
> you can try with "ls |dd bs=1"
> 
> I also see this problem but it is not constant. I noticed that "ps ax"
> sometimes takes like 10 times longer than usual. But I can only get this
> in a gnome-terminal not in xterm. The problem is that it should really
> not be that big difference when the load of the system is the same. 

Ok, there is indeed an issue in the *terminals. As above pointed out
buffering the programs output helps. Also a usleep of 5ms in the read
loop of the *terms would help.

I fixed this issue in multi-gnome-terminal by using a buffer of 32kb.
It is filled as long as there is input comming in within 10ms.
If the buffer is full or 10ms passed the buffer is written out to the
screen. This makes it also 2-3 times faster on kernel 2.4.

So in my eyes it is definitely not a scheduler bug, but in every single
terminal out there. However it seems as if kernel 2.6 s scheduling is so
fast that data can be continously outputted. And the busy loop in the
terminal makes it eat up all cpu time instead of jump scrolling take
place.

 static void
 zvt_term_readdata (gpointer data, gint fd, GdkInputCondition condition) {
[...]  
+  while ( (count>0) && (select_retval==1) && (total_count<32768) )
+  {
+         count=0;
+         int maxread=32768-total_count;
+         if (maxread>4096)
+                 maxread=4096;
+
+         count = read (fd, &buffer[total_count], maxread);
+         saveerrno=errno;
[...]
+         if (count>0)
+                 total_count+=count;
+
+         FD_ZERO(&rfds);
+         FD_SET(fd, &rfds);
+         tv.tv_sec = 0;
+         tv.tv_usec = 10000;
+         select_retval = select(fd+1, &rfds, NULL, NULL, &tv);
[...]
+  }

Soeren.

