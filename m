Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263297AbTCNJWA>; Fri, 14 Mar 2003 04:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263293AbTCNJWA>; Fri, 14 Mar 2003 04:22:00 -0500
Received: from sunny.pacific.net.au ([203.2.228.40]:59365 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S263292AbTCNJVy>; Fri, 14 Mar 2003 04:21:54 -0500
From: "David Luyer" <david@luyer.net>
To: "'Florian Weimer'" <fw@deneb.enyo.de>, <linux-kernel@vger.kernel.org>
Subject: RE: NetFlow export
Date: Fri, 14 Mar 2003 20:32:35 +1100
Message-ID: <002a01c2ea0c$a5af9550$638317d2@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <87llzj8jmr.fsf@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer wrote:
> Jakob Oestergaard <jakob@unthought.net> writes:
> 
> > You asked for netflow data export. Netramet can give you something
> > similar to netflow (I never used netflow, but from what I 
> > hear, netramet is similar only more flexible).
> 
> I need the NetFlow data format, not something else.

NetFlowMet is the NetFlow module for netramet.  But it's only a
receiver, not a transmitter.

However, 'ntop' can generate NetFlow packets from a Linux system,
using libpcap.

I suggest you read http://www.switch.ch/tf-tant/floma/software.html

> > With 10 lines of Perl you could do full ASN-1   ;)
> 
> NetFlow is not based on ASN.1.  It's a completely different format (an
> industry standard which is implemented by quite a few vendors).

NetFlow interacts with SNMP a little though.  The interface ID numbers
in NetFlow come from the SNMP interface index table.

> > Point being; if what you want is flow information from a 
> > Linux router, excellent user space software (both "meter" and
> > retrieval/filtering tools) already exist for that.
> 
> I fear the performance impact of copying all packet headers to user
> space.

It's only the headers, not the packets.

NetFlow in Cisco routers is a route caching path which happens to
keep counters that it can export as flow export packets.  It can
also be used to do things such as caching policy routing (reducing
ACL lookups and so on).  But chances are there are patents covering
the use of NetFlow route caching.

> > If you want something else, then I have completely misread 
> > your mails.  Please elaborate, in that case  :)
> 
> I'd like to see something which has virtually no impact on forwarding,
> so that it's a no-brainer to enable it.  I doubt copying all the
> packet headers to user space falls into this category.

Maybe you should try ntop and see what impact it has (preferably in a
test lab first, if you have a performance testing lab)?  If the impact
is too high, you could consider an alternate approach (eg, using some
form of kernel IP accounting and periodically scanning the accounting
table and exporting the flows as NetFlow packets).

Personally I considered once implementing a kernel *receiver* for
NetFlow packets as receiving NetFlow packets is an extremely critical
application for me.  However in the end I wrote a userspace NetFlow
receiver that's a mix of assembler and C (but not using libc) and
is careful to accumulate data into 128k blocks before writing it to
a RAID array optimized for 128k writes, and it can receive an insane
amount of NetFlow data (compared to older utilities running on
mid-range DEC Alpha or Sun systems on commercial operating systems,
which had problems keeping up with one busy router, this runs on an
aging Intel ISP2150 and collects from over 50 busy routers, still
at low load) so I never had to actually go down the kernel path.

David.

