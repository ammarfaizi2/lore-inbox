Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268033AbUJNWmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268033AbUJNWmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUJNWmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:42:37 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:58534 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268148AbUJNWlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:41:11 -0400
Message-ID: <416EFFF8.2030408@watson.ibm.com>
Date: Thu, 14 Oct 2004 18:38:48 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, mbligh@aracnet.com,
       Simon.Derr@bull.net, colpatch@us.ibm.com, pwil3058@bigpond.net.au,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>	<20041002145521.GA8868@in.ibm.com>	<415ED3E3.6050008@watson.ibm.com>	<415F37F9.6060002@bigpond.net.au>	<821020000.1096814205@[10.10.2.4]>	<20041003083936.7c844ec3.pj@sgi.com>	<834330000.1096847619@[10.10.2.4]>	<835810000.1096848156@[10.10.2.4]>	<20041003175309.6b02b5c6.pj@sgi.com>	<838090000.1096862199@[10.10.2.4]>	<20041003212452.1a15a49a.pj@sgi.com>	<843670000.1096902220@[10.10.2.4]>	<Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>	<58780000.1097004886@flay>	<20041005172808.64d3cc2b.pj@sgi.com>	<1193270000.1097025361@[10.10.2.4]>	<20041005190852.7b1fd5b5.pj@sgi.com>	<1097103580.4907.84.camel@arrakis>	<20041007015107.53d191d4.pj@sgi.com>	<Pine.LNX.4.61.0410071439070.19964@openx3.frec.bull.fr>	<1250810000.1097160595@[10.10.2.4]>	<20041007105425.02e26dd8.pj@sgi.com>	<1344740000.1097172805@[10.10.2.4]>	<m1ekk1egdx.fsf@ebiederm.dsl.xmission.com> <20041014123956.518074f9.pj@sgi.com>
In-Reply-To: <20041014123956.518074f9.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul, there are also other means for gang scheduling then having
to architect a tightly synchronized global clock into the communication 
device.

Particularly, in a batch oriented environment of compute intensive 
applications, one does not really need/want to switch frequently.
Often, the communication devices are memory mapped straight into the
application OS involvement with limited available channels.

However, as shown in previous work, gang scheduling and other forms of 
scheduling tricks (e.g. backfilling) can provide for significant higher 
utilization. So, if a high context switching rate (read interactivity) 
is not required, then a user space daemon scheduling network can be used.

We have a slew of pubs on this. An example readup can be obtained here:

Y. Zhang, H. Franke, J. Moreira, A. Sivasubramaniam. Improving Parallel 
Job Scheduling by Combining Gang Scheduling and Backfilling Techniques. 
In Proceedings of the International Parallel and Distributed Processing 
Symposium (IPDPS), pages 113-142 May 2000.
http://www.cse.psu.edu/~anand/csl/papers/ipdps00.pdf

Or for a final sum up of that research as a journal.

Y. Zhang, H. Franke, J. Moreira, A. Sivasubramaniam. An Integrated 
Approach to Parallel Scheduling Using Gang-Scheduling, Backfilling and 
Migration. IEEE Transactions on Parallel and Distributed Systems, 
14(3):236-247, March 2003.

This was implemented for the IBM SP2 cluster and ASCI machine at 
Livermore National Lab in the late 90's.

If you are interested in short scheduling cycles we also discovered that
dependent on the synchronity of the applications gang scheduling is not 
necessarily the best.

Y. Zhang, A. Sivasubramaniam, J. Moreira, H. Franke. A Simulation-based 
Study of Scheduling Mechanisms for a Dynamic Cluster Environment. In 
Proceedings of the ACM International Conference on Supercomputing (ICS), 
pages 100-109, May 2000. http://www.cse.psu.edu/~anand/csl/papers/ics00a.pdf

If I remember correctly this tight gang scheduling based on slots was 
already implemented on IRIX in 95/96 ( read a paper on that ).

Moral of the story here is that its unlikely that Linux will support 
gang scheduling in its core anytime soon or will allow network adapters 
to drive scheduling strategies. So likely these are out.
An less frequent gang scheduling can be implemented with user level 
daemons, so an adequate solution is available for most instances.

-- Hubertus

Paul Jackson wrote:

> Kevin McMahon <n6965@sgi.com> pointed out to me a link to an interesting
> article on gang scheduling:
> 
>   http://www.linuxjournal.com/article.php?sid=7690
>   Issue 127: Improving Application Performance on HPC Systems with Process Synchronization
>   Posted on Monday, November 01, 2004 by Paul Terry Amar Shan Pentti Huttunen
> 
> It's amazingly current - won't even be posted for another couple of weeks ;).
> 

