Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSK0OyB>; Wed, 27 Nov 2002 09:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbSK0OyB>; Wed, 27 Nov 2002 09:54:01 -0500
Received: from pc-62-31-66-70-ed.blueyonder.co.uk ([62.31.66.70]:41090 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S262877AbSK0OyA>; Wed, 27 Nov 2002 09:54:00 -0500
Date: Wed, 27 Nov 2002 15:00:53 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
Message-ID: <20021127150053.A2948@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com> <shsptsrd761.fsf@charged.uio.no> <1038387522.31021.188.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1038387522.31021.188.camel@ixodes.goop.org>; from jeremy@goop.org on Wed, Nov 27, 2002 at 12:58:42AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 27, 2002 at 12:58:42AM -0800, Jeremy Fitzhardinge wrote:
> On Tue, 2002-11-26 at 19:26, Trond Myklebust wrote:
> > >>>>> " " == Jeremy Fitzhardinge <jeremy@goop.org> writes:
> > 
> >      > It looks to me like some sort of problem managing the NFS
> >      > readdir cookies, but it isn't clear to me whether this is the
> >      > NFS server/ext3 generating bad cookies, or the NFS client
> >      > handling them wrongly.
> > 
> > In order to determine which of the two needs to be fixed, it would
> > help if you could print out the cookies from that listing or better
> > still: if you could provide us with the raw tcpdump output. Please
> > remember to use an 8k snaplen for the tcpdump...
> 
> Here's a pcap dump file of the transaction.  I changed [rw]size to 1024
> because I couldn't work out how to get ethereal to reassemble the
> fragments.  It doesn't seem to have affected the behaviour at all.

The dump looks problematic, but I'm not sure whether it's a client or
a server problem.

Frame 6 is a READDIR reply, ending with 

    Entry: file ID 294052, name vg_include.h~51-kill-inceip
        File ID: 294052
        Name: vg_include.h~51-kill-inceip
            length: 27
            contents: vg_include.h~51-kill-inceip
            fill bytes: opaque data
        Cookie: 1611747420
    Value Follows: No
    EOF: 0

There follows in frame 7 a request for the next chunk, starting with
the same cookie, and the reply in frame 8 ends with:

    Entry: file ID 298407, name vg_libpthread.vs
        File ID: 298407
        Name: vg_libpthread.vs
            length: 16
            contents: vg_libpthread.vs
        Cookie: 1611747420
    Value Follows: No
    EOF: 1

Now, this final frame has EOF = 1, so the client should not be looking
for any more data after it.  If the client _does_ try to progress,
though, it will use that final cookie for the next request, and will
naturally find the results already in cache so will repeat the final
chunk of directory entries.

So I suspect that this is a root a client problem --- the client has
repeated a READDIR despite being told that the previous reply was EOF
--- but that the best solution is actually to change the server to
poke a dedicated EOF cookie into the final dirent of the stream.  One
of the reasons we need to do that is to cope with the unclear
situation when an application is using telldir/seekdir to reposition
the directory stream (tcsh is really bad for trying to do that with
32-bit offsets when globbing, for example, although the right answer
there is "use readdir64".)

Cheers,
 Stephen
