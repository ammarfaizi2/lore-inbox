Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315862AbSFJT2a>; Mon, 10 Jun 2002 15:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315883AbSFJT23>; Mon, 10 Jun 2002 15:28:29 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:24708 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315862AbSFJT21>; Mon, 10 Jun 2002 15:28:27 -0400
Message-ID: <3D04FDCE.110096E2@nortelnetworks.com>
Date: Mon, 10 Jun 2002 15:28:14 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <Pine.GSO.4.30.0206101033450.22559-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 
> On Mon, 10 Jun 2002, Mark Mielke wrote:

> > There *are* applications that would benefit from making this decision
> > at run time on a socket-by-socket basis. It is not a common requirement
> > for most desktop users, but it remains a valid requirement.
> >
> 
> I am confused as to which application needs this, do you have one in mind?
> AFAIK, UDP/RTP type apps already know how to determine packet loss
> on a per flow basis.


The purpose of this patch is to make it reallly easy to nail down exactly how
many packets were dropped *per socket*, and for what reason.  For me, the
information is then used to tune the application statically, but others could
use it dynamically.  Incoming packets can be dropped at the device, at the
device driver, in netif_rx, or at the socket buffer.  We've got stats on all of
these except for the socket buffer, so why not add them?

The cost in the normal case is incrementing a single variable in the socket
struct (which is likely already in cache since we're playing with it).  I can't
see this being that expensive.  In the failure path, we get a second increment. 
Again, this is not going to be noticeable.

Sure, you can try and figure out which applications had sockets open, and how
many packets they missed, and subtract that from the snmp counters to give how
many packets you missed.  But to do this you have to lock the box down--isn't it
a lot easier to just *know* because you've been keeping track?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
