Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWAPWeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWAPWeD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWAPWeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:34:02 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:9375 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751229AbWAPWeA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:34:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZBRwDIOxKB+PQbo3Yq5Z8mhNJ8qUyrwGiube914w+yWVOHtq4arU9Reqj756b1CmHT33egWFtQ8J7YPPsgVzu6qTYm074ASnV4hBxGI86LF1ljnNxTe4MFEEyvLUZAcms0wZdI+xE4V2SqpK22/nMApv36MgE0JXbSnN/kZSSVc=
Message-ID: <bdfc5d6e0601161433g1c51dd4dpbc5da4cd7581d5d6@mail.gmail.com>
Date: Mon, 16 Jan 2006 17:33:59 -0500
From: Andy Gospodarek <andy@greyhouse.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [patch] networking ipv4: remove total socket usage count from /proc/net/sockstat
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net
In-Reply-To: <9a8748490601161308g5f941c30o870042e6d9811c58@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060116200432.GB14060@gospo.rdu.redhat.com>
	 <1137442446.19444.20.camel@mindpipe>
	 <bdfc5d6e0601161225h53554b1ahde794af93af52bdf@mail.gmail.com>
	 <9a8748490601161235k2defec82sa51a17e4fc14b22f@mail.gmail.com>
	 <bdfc5d6e0601161255w4e1a6ac5oaa6844a6e1bbd0aa@mail.gmail.com>
	 <9a8748490601161308g5f941c30o870042e6d9811c58@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> Maybe if you described "your current problem" someone could suggest a
> solution...
>

Sure, I'd be glad to.  If I add up all the entries from the procfiles
(in /proc/net) on my system

packet = 1
netlink = 6
raw = 0
raw6 = 0
tcp = 5
tcp6 = 3
udp = 9
udp6 = 1
unix = 29

I find there are a total of 54 sockets open on my system.

Now this seems to differ from the value in /proc/net/sockstat:
# cat sockstat
sockets: used 59
TCP: inuse 5 orphan 0 tw 0 alloc 8 mem 1
UDP: inuse 9
RAW: inuse 0
FRAG: inuse 0 memory 0

So we are off by 5.  I added some code around the stat collection used
in sockstat to get more detailed info about those sockets and the
output is here.  The values are family[protocol family][socket
family].

family[1][1] = 17        (UNIX/LOCAL,STREAM)
family[1][2] = 12        (UNIX/LOCAL,DGRAM)
family[2][1] = 5         (INET,STREAM)
family[2][2] = 9         (INET,DGRAM)
family[2][3] = 2         (INET,RAW)
family[10][1] = 3        (INET6,STREAM)
family[10][2] = 1        (INET6,DGRAM)
family[10][3] = 3        (INET6,RAW)
family[16][2] = 6        (NETLINK/ROUTE,DGRAM)
family[17][10] = 1       (PACKET,PACKET)
Total = 59

All of these numbers match up with what we saw above, except the
INET/RAW and INET6/RAW sockets.  It seems they aren't being counted
correctly -- which accounts for the 5 missing sockets.  The
decrementing of these values is in sock_release() and seems to get
done correctly other times RAW sockets are created, but not for the 5
sockets in question.

Since the total socket usage seems out of place in that file -- and
quite possibly wrong, it seemed like a nice idea to get rid of it
(prior to understanding the reasoning behind keeping it).  Now it
seems the goal will be to fix the discrepancy between these files.

-andy
