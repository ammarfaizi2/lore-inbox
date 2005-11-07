Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVKGQeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVKGQeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVKGQeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:34:44 -0500
Received: from host27-37.discord.birch.net ([65.16.27.37]:26568 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S964865AbVKGQen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:34:43 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Steven Timm'" <timm@fnal.gov>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: rpc-srv/tcp: nfsd: sent only -107 bytes (fwd)
Date: Mon, 7 Nov 2005 10:41:35 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcXjs5biNjhbUlf3T4y18AtpFjMxTAAAt7mQ
In-Reply-To: <Pine.LNX.4.62.0511070943420.6791@snowball.fnal.gov>
Message-ID: <EXCHG2003J6sJ9amqkh000005bf@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 07 Nov 2005 16:29:43.0254 (UTC) FILETIME=[755E7760:01C5E3B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> > What kernel are you running?  I saw this issue on the 2.4 
> series, the 
> > large 2.6 things we have built avoided using TCP given that we had 
> > seen this issue.
> 
> Currently running 2.4.21-32.0.1 as put out by RedHat with XFS 
> file system patches.  will upgrade to 2.4.21-37 later this week.

I had the problem with a RHEL3 kernel, given what the base issue is,
I don't believe any later updates will change things much as it is not
a bug so much as a basic design problem.

If you have a few more nodes/mounts/activity then things get uglier.   It
does
expire "unused" ones when new ones are needed, but the code seems to
thrash quite badly when too many need to be used.  A few more nodes
and the server will go into  timeout mode where it won't respond to
requests (tcp or udp) for long periods of time
(minutes), and then will finally recover.  It is pretty ugly.

The code is in net/sunrpc/svcsock.c and looks something like this:
(sv_nrthreads+3)*10   Given that you need 700 you would need at least
70 threads, but things still get funny below that.   You could try changing
the *10 to be a larger number, and I don't know that the later versions
of RH still use *10 they may use something smaller.  You could also change
the number of threads up a bit more, but at some point the number of
threads seems to cause resource issues also.  256 on the machines we were
testing was causing some other modules loads to fail, that did not fail
with nfsd set smalller.   I have not tried change the *10 to something
larger, it may or may not work.

>From what I can tell, basically the reuse code does not work the
best (or maybe at all) with large groups of machines being heavily
active.

> >
> Are you suggesting in such a scenario we would need 300 nfsd?

Not 300.   The situation I had was more machines, and more mounts
per machine.

You can watch the current count with netstat and counting the number of
nfs connections, when things hit the limit you will start getting
the message, and things will start getting messy.  Things get worse
if you have open executables on the machines across nfs as these have
a higher utilization of the resource, and cause more thrashing.

I could duplicate the error by doing a "fornodes ls -l ..." with it listing
the top level of each nfs mount.

> 
> > The solution that I came to was to use UDP mounts, as this limit
> > is not there.   In the situation I had we would have had to change
> > the number of nfsd to 256 and even that was going to be 
> close, and the 
> > 256 caused some other failures.  To not have the issue you 
> will need 
> > to use UDP mounts everywere if you have enough tcp mounts 
> to cause the 
> > error it will affect the udp mounts in a similar bad way.
> >
> > We also could have changed the thread to resource count, but we had 
> > some other process starvation issue with TCP that seemed to not be 
> > duplicatable with UDP.
> 
> We had changed from UDP to TCP due to our network's 
> propensity to drop UDP packets.  The same mount options we 
> are using now against a Linux server were working fine when 
> our NFS server was a much-less-powerful SGI IRIX server.  No 
> doubt, as you say, that switching back to UDP would make this 
> rpc-srv/tcp message go away.
> 
> Steve Timm


The SGI implements nfs differently.  Were you using tcp against
the SGI?

No way to fix the network to stop the dropping udp packets?

 
                   Roger

