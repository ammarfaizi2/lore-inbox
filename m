Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJC5F>; Tue, 9 Jan 2001 21:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130475AbRAJC4z>; Tue, 9 Jan 2001 21:56:55 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:55563 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129431AbRAJC4k>; Tue, 9 Jan 2001 21:56:40 -0500
Date: Tue, 9 Jan 2001 18:56:33 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
        <hch@caldera.de>, <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: storage over IP (was Re: [PLEASE-TESTME] Zerocopy networking patch,
 2.4.0-1)
In-Reply-To: <Pine.LNX.4.30.0101091051460.1159-100000@e2>
Message-ID: <Pine.LNX.4.30.0101091826200.10428-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Ingo Molnar wrote:

> On Mon, 8 Jan 2001, Rik van Riel wrote:
>
> > Having proper kiobuf support would make it possible to, for example,
> > do zerocopy network->disk data transfers and lots of other things.
>
> i used to think that this is useful, but these days it isnt.

this seems to be in the general theme of "network receive is boring".
which i mostly agree with... except recently i've been thinking about an
application where it may not be so boring, but i haven't researched all
the details yet.

the application is storage over IP -- SAN using IP (i.e. gigabit ethernet)
technologies instead of fiberchannel technologies.  several companies are
doing it or planning to do it (for example EMC, 3ware).

i'm taking a wild guess that SCSI over FC is arranged conveniently to
allow a scatter request to read packets off the FC NIC such that the
headers go one way and the data lands neatly into the page cache (i.e.
fixed length headers).  i've never investigated the actual protocols
though so maybe the solution used was to just push a lot of the detail
down into the controllers.

a quick look at the iSCSI specification
<http://www.ietf.org/internet-drafts/draft-ietf-ips-iscsi-02.txt>, and the
FCIP spec
<http://www.ietf.org/internet-drafts/draft-ietf-ips-fcovertcpip-01.txt>
show that both use TCP/IP.  TCP/IP has variable length headers (or am i on
crack?), which totally complicates the receive path.

the iSCSI requirements document seems to imply they're happy with pushing
this extra processing down to a special storage NIC.  that kind of sucks
-- one of the benefits of storage over IP would be the ability to
redundantly connect a box to storage and IP with only two NICs (instead of
4 -- 2 IP and 2 FC).

is NFS receive single copy today?

anyone tried doing packet demultiplexing by grabbing headers on one pass
and scattering the data on a second pass?

i'm hoping i'm missing something.  anyone else looked around at this stuff
yet?

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
