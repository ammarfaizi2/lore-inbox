Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261954AbSIPOOs>; Mon, 16 Sep 2002 10:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261960AbSIPOOs>; Mon, 16 Sep 2002 10:14:48 -0400
Received: from puerco.nm.org ([129.121.1.22]:20488 "HELO puerco.nm.org")
	by vger.kernel.org with SMTP id <S261954AbSIPOOp>;
	Mon, 16 Sep 2002 10:14:45 -0400
Date: Mon, 16 Sep 2002 08:16:47 -0600 (MDT)
From: todd-lkml@osogrande.com
X-X-Sender: todd@gp
Reply-To: linux-kernel@vger.kernel.org
To: "David S. Miller" <davem@redhat.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "hadi@cyberus.ca" <hadi@cyberus.ca>,
       "tcw@tempest.prismnet.com" <tcw@tempest.prismnet.com>,
       "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
       "pfeather@cs.unm.edu" <pfeather@cs.unm.edu>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <20020913.150439.27187393.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209160805360.7184-100000@gp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david,

comments/questions below...

On Fri, 13 Sep 2002, David S. Miller wrote:

> 1) You register a IPV4 src_addr/dst_addr TCP src_port/dst_port cookie
>    with the hardware when TCP connections are openned.

intriguing architecture.  are there any standards in progress to support 
this.  bascially, people doing high performance computing have been 
customizing non-commodity nics (acenic, myrinet, quadrics, etc.) to do 
some of this cookie registration/scanning.  it would be nice if there were 
a standard API/hardware capability that took care of at least this piece.

(frankly, it would also be nice if customizable, almost-commodity nics 
based on processor/memory/firmware architecture rather than just asics
(like the acenic) continued to exist).

>    not also make the api for apps to allocate a buffer in userland that (for
>    nics that support it) the nic can dma directly into?  it seems likely
>    notification that the buffer was used would have to travel through the
>    kernel, but it would be nice to save the interrupts altogether.
>    
> This is already doable with sys_sendfile() for send today.  The user
> just does the following:
> 
> 1) mmap()'s a file with MAP_SHARED to write the data
> 2) uses sys_sendfile() to send the data over the socket from that file
> 3) uses socket write space monitoring to determine if the portions of
>    the shared area are reclaimable for new writes
> 
> BTW Apache could make this, I doubt it does currently.
> 
> The corrolary with sys_receivefile would be that the use:
> 
> 1) mmap()'s a file with MAP_SHARED to write the data
> 2) uses sys_receivefile() to pull in the data from the socket to that file
> 
> There is no need to poll the receive socket space as the successful
> return from sys_receivefile() is the "data got received successfully"
> event.

the send case has been well described and seems work well for the people 
for whom that is the bottleneck.  that has not been the case in HPC, since 
sends are relatively cheaper (in terms of cpu) than receives.  

who is working on this architecture for receives?  i know quite a few 
people who would be interested in working on it and willing to prototype 
as well.

>    totally agreed.  this is a must for high-performance computing now (since 
>    who wants to waste 80-100% of their CPU just running the network)?
>    
> If send side is your bottleneck and you think zerocopy sends of
> user anonymous data might help, see the above since we can do it
> today and you are free to experiment.

for many of the applications that i care about, receive is the bottleneck, 
so zerocopy sends are somewhat of a non-issue (not that they're not nice, 
they just don't solve the primary waste of processor resources).

is there a beginning implementation yet of zerocopy receives as you
describe above, or you you be interested in entertaining implementations
that work on existing (1Gig-e) cards?

what i'm thinking is something that prototypes the api to the nic that you 
are proposing and implements the NIC-side functionality in firmware on the 
acenic-2's (which have available firmware in at least two 
implementations--the alteon version and pete wyckoff's version (which may 
be less license-encumbered).

this is obviously only feasible if there already exists some consensus on 
what the os-to-hardware API should look like (or there is willingness to 
try to build a consensus around that now).

t.

-- 
todd underwood, vp & cto
oso grande technologies, inc.
todd@osogrande.com

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin

