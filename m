Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288618AbSADMYE>; Fri, 4 Jan 2002 07:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288615AbSADMX4>; Fri, 4 Jan 2002 07:23:56 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:43269 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S288618AbSADMXm>;
	Fri, 4 Jan 2002 07:23:42 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Urban Widmark <urban@teststation.com>
Date: Fri, 4 Jan 2002 13:22:57 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] smbfs fsx'ed
CC: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <DEEF6861A2B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Jan 02 at 0:48, Urban Widmark wrote:
> On Thu, 3 Jan 2002, Petr Vandrovec wrote:
> 
> > On  3 Jan 02 at 13:37, Linus Torvalds wrote:
> > > 
> > > (Not as horrible as the NCPFS thing that doesn't understand about the page
> > > cache at all, but still..)
> > 
> > Unfortunately it is not easy for me to add pagecache support
> > to ncpfs, as couple of ncpfs users uses ncpfs in shared environment
> > with database record locking, and if I'll now read full 4KB instead of
> > 128B record, it can clash with records locked by other clients.
> 
> Does the locks prevent you from even looking? You could read only the
> parts requested if the file has locks and fill the rest with 0. Only using
> the page cache if there are no locks. Not too pretty but ...

It results in short read when there is partial overlap, or error if
overlap is complete.

> A write of 128 bytes to a file cause a commit_write of 128 bytes, if I am
> reading generic_file_write correctly. So that should not cause it to write
> the full page and that would be ok for the locking case.

OK. Thanks.
 
> > I can for sure add `leases' like Novell Client for Windows does for
> > possibility of file caching, but I'm not sure whether size of code
> > needed for supporting this (and for supporting server driven
> > cache flushes) is worth of effort.
> 
> smbfs needs these for cooperating clients to work. It can only cache data
> if it has a lease. If someone else is also accessing the file then each
> smb_file_read must re-read the page.

It is same for Netware, with minor difference that NW4 refuses 'leases' 
by default, and on NW5 it should be disabled by default, as otherwise
server can go mad when some client errors happen.

> > P.S.: And as NCP protocol is totally synchronous (even if it uses
> > TCP, I explicitly asked in Utah), only local file caching can increase
> > ncpfs performance, as there is no such thing like asynchronous file
> > read/write...
> 
> SMB has no async read/write, but all requests are marked with an ID and it
> is allowed to have a certain number of simultaneous requests in transit.

That's difference. With NCP you can have only one request in flight.
For sure on IPX and UDP, and according to Novell even on TCP.
 
> Even without multiple requests you could let ncpfs accept one read
> request, send that to the server and return without waiting for the reply.

On IPX maximum compatible block size is 1024 bytes... so reading one page
requires 4 exchanges. On UDP/TCP it is easier, but unfortunately majority
of installed servers is still IPX-only (at least I have this feedback
from users).

> The readahead code may then queue up the next request for ncpfs, and ncpfs
> could process that while the previously read page is returned to the user.

It would require either another kernel thread doing readahead, or I have
to submit new request from IPX/UDP data_ready callbacks (for TCP it needs
another thread without discussion, as data_ready callback documentation
says that I cannot read data/send new data directly from it... or maybe
special ncpfs bottomhalf).
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
