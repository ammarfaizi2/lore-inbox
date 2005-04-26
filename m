Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVDZWYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVDZWYO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVDZWYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:24:14 -0400
Received: from smtp.istop.com ([66.11.167.126]:45780 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261819AbVDZWYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:24:05 -0400
From: Daniel Phillips <phillips@istop.com>
To: sdake@mvista.com
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Tue, 26 Apr 2005 18:24:22 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20050425165826.GB11938@redhat.com> <20050426054933.GC12096@redhat.com> <1114537223.31647.10.camel@persist.az.mvista.com>
In-Reply-To: <1114537223.31647.10.camel@persist.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504261824.22382.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 April 2005 13:40, Steven Dake wrote:
> Hate to admit ignorance, but I'm not really sure what SCTP does..  I
> guess point to point communication like tcp but with some other kind of
> characteristics..  I wanted to have some idea of how locking messages
> are related to the current membership.  I think I understand the system
> from your descriptions and reading the code.  One scenario I could see
> happeing is that there are 2 processors A, B.
>
> B drops out of membership
> A sends lock to lock master B (but A doens't know B has dropped out of
> membership yet)
> B gets lock request, but has dropped out of membership or failed in some
> way
>
> In this case the order of lock messages with the membership changes is
> important.  This is the essential race that describes almost every issue
> with distributed systems...  virtual synchrony makes this scenario
> impossible by ensuring that messages are ordered in relationship to
> membership changes.

It sounds great, but didn't somebody benchmark your virtual synchrony code and 
find that it only manages to deliver some tiny dribble of messages/second?  I 
could be entirely wrong about that, but I got the impression that your 
algorithm as implemented is not in the right performance ballpark for 
handling the cfs lock traffic itself.

If I'm right about the performance, there still might be a niche in the 
membership algorithms, but even there I'd be worried about performance.

Obviously, what you need to make your case with is a demo.  If anybody is 
going to write that, it will almost certainly be you.  You might consider 
using my csnap code for your demo, because it has a pluggable infrastructure 
interface which takes the form of a relatively simple C program 
("csnap-agent") of which an example is provided that uses the cman interface.  
You could simply replace the cman calls by virtual synchrony calls and show 
us how amazing this algorithm really is.

   http://sourceware.org/cluster/csnap/

All dependencies on cluster infrastructure - (g)dlm and cman - are 
concentrated in that one "agent" file.  Apart from that, the code depends 
only on what you would expect to find in a standard 2.6 setup.  You can even 
run a non-clustered filesystem like ext3 on the csnap block device, so you 
don't have to worry about setting up GFS either, for the time being.  This 
should be pretty much an ideal test platform for your ideas.

Regards,

Daniel
