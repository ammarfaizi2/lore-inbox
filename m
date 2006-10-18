Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422810AbWJRURs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWJRURs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422879AbWJRURr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:17:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:53216 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422889AbWJRURk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:17:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WAkoKwq0Jtej03E8WCWGyAUiRpyzjcsBWrEnwHSLCUD3X1VqkebUe1MbSq6XLnsVgvOz8LcJcqzwMwtESg/7v2vyoHHuolWwVbYTrNliiAhoCp0tmC8BTo6QaU0W2w6x4FZ82hCVUX+4CfltETcBfenrbIU/GrzLwR0id4j+Hcs=
Message-ID: <76bd70e30610181317w3e8315e5m75056305904a1bce@mail.gmail.com>
Date: Wed, 18 Oct 2006 16:17:37 -0400
From: "Chuck Lever" <chucklever@gmail.com>
To: "Frank van Maarseveen" <frankvm@frankvm.com>
Subject: Re: [NFS] NFS inconsistent behaviour
Cc: "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       "Mohit Katiyar" <katiyar.mohit@gmail.com>,
       "Linux NFS mailing list" <nfs@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061018200936.GA14733@janus>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com>
	 <20061016084656.GA13292@janus>
	 <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com>
	 <20061016093904.GA13866@janus>
	 <46465bb30610171822h3f747069ge9a170f1759af645@mail.gmail.com>
	 <20061018063945.GA5917@janus>
	 <1161194229.6095.81.camel@lade.trondhjem.org>
	 <20061018183807.GA12018@janus>
	 <1161199580.6095.112.camel@lade.trondhjem.org>
	 <20061018200936.GA14733@janus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/06, Frank van Maarseveen <frankvm@frankvm.com> wrote:
> On Wed, Oct 18, 2006 at 03:26:20PM -0400, Trond Myklebust wrote:
> > On Wed, 2006-10-18 at 20:38 +0200, Frank van Maarseveen wrote:
> > > I ran out of privileged ports due to treemounting on /net from about 50
> > > servers. The autofs program map for this uses the "showmount" command and
> > > that one apparently uses privileged ports too (buried inside RPC client
> > > libs part of glibc IIRC). The combination broke autofs and a number of
> > > other services because there were no privileged ports left anymore.
> >
> > Yeah. The RPC library appears to always try to grab a privileged port if
> > it can. One solution would be to have the autofs scripts drop all
> > privileges before calling showmount.
> >
> > I suppose we could also change the showmount program to create a socket
> > that is bound to an unprivileged port, then use
> > clnttcp_create()/clntudp_create().
> >
> > We could probably do the same in the "mount" program when doing things
> > like interrogating the portmapper, probing for rpc ports etc. The only
> > case where mount might actually need to use a privileged port is when
> > talking to mountd. Even then, it could be trained to first try using an
> > unprivileged port.
>
> If we could fix why there are that many connections in state TIME_WAIT
> then using privileged ports would not be a problem either.

Some discussion on both FreeBSD and Linux mailing lists suggests that
ignoring TIME_WAIT has some risk to it, so that may not be an
advisable path to take.  However, there are probably some cases where
it is safe, such as idle timeouts, where the client is certain there
is no traffic in flight.

Both client implementations (kernel and glibc) should re-use port
numbers or connections aggressively.  To that end, the kernel RPC
client is already doing this.  I know Red Hat has suggested using a
connection manager for user-level RPC applications to share.  In
addition the kernel NFS client is sharing connections to a server
between all mount points going to that server.

-- 
"We who cut mere stones must always be envisioning cathedrals"
   -- Quarry worker's creed
