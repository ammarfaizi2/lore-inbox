Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130468AbQJ0VSe>; Fri, 27 Oct 2000 17:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130559AbQJ0VSZ>; Fri, 27 Oct 2000 17:18:25 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:44039 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130515AbQJ0VSK>; Fri, 27 Oct 2000 17:18:10 -0400
Message-ID: <39F9F032.FE847D86@timpanogas.org>
Date: Fri, 27 Oct 2000 15:14:26 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: NCPFS flags all files executable on NetWare Volumes wit
In-Reply-To: <B2B7DE64537@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Petr Vandrovec wrote:
> 
> On 27 Oct 00 at 13:46, Jeff V. Merkey wrote:
> > Here's the complete set of 3.x/4.x/5.x Namespace NCP calls with proper
> > return codes.  I'll run down the huge-data info and post a bit later.
> 
> Thanks. Main problem with hardlinks is that unlink through NFS namespace
> kills server (at least up to 5.0, I did not checked it during last few
> months), and unlink through DOS (or OS2) namespace removes all instances
> of hardlinked file :-( A bit unfortunate behavior.

Where are you doing this in the code?  I'll go look at it and attempt a
fix.  It's killing the server because the linkage fields are probably
not getting set.  If NFSSERV is loaded, and the
links ever get hosed, you will get an Abend on 3.x and 4.x, and a
"process suspended" error on 5.x (which also hangs the server).  If the
wrong pipe of fifo octals get set in mode,
it will also hang the server.  If it is removing the entire namespace
with hardlinks, it's 
also because these linkage fields are not getting set properly.  It does
not work this way 
with the NetWare NFSSERV.NLM mounted as an NFS client from Linux.

> 
> > let me know.  I have a 600 page document I wrote two years ago that
> > details every single NCP and NDS NCP used,
> > and can send it to you via UPS in .cz.   It's too big to fax, or post.
> 
> Not for now.


> 
> > 2222/6804       Return Bindery Context (you need to implement this one
> > -- I did not see it in your code)
> 
> ncpfs 2.2.0.18 implements this (lib/ds/bindctx.c:NWDSGetBinderyContext),
> but does not use it itself...

It should.  It will allow you to use NDS with your existing code and NCP
suite.  I guess 
doug's next project at TRG will be to put in NDS support in NCPFS and
submit the patches to you.

> 
> > 2222/6805       Monitor NDS Connection (this one will allow you to
> > intercept NDS replica packets and suck an NDS replica local)
> 
> Novell documentation is a bit - hmm - unclear on this one...

There's some undocumented diagnostic calls in NDS that basically render
it totally unsuitable for the internet and make it easy to hack.  It's
great for LANs in an organization where the
servers can all be locked up, and employees can get fired for hacking. 
On the internet, it's
a piece of "swiss cheese" and is vulnerable in many respects.

> 
> > 2222/1631       Open Data Stream (this NCP will allow you to open the
> > MAC namespace data fork and read it remotely for MAC clients)
> 
> Userspace ncpfs (specifically ncopy) uses
> (lib/filemgmt.c:ncp_ns_open_create_entry) NCP 87,30 or 87,33 for this
> (and NW3.x is out of luck, AFAIK). Kernel code does not support MAC
> forks (and ACL and extended attributes), as up to now there is no
> vfs API for this... You have to use ncopy,nwdir/nwrights,
> nwtrustee,...,nwdir/eaops,nwdir for accessing MAC(&FTAM)/ACL/EAs for now.
> (for EAs you must have post-August 27 ncpfs, betas are on
> ftp://platan.vc.cvut.cz/private/ncpfs)


You can expose these as .files the way HFS likes to see them, and MAC
clients to a Linux box 
will be able to see and store their data in native MAC format -- with
finder info.

Jeff

>                                         Thanks,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
