Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422761AbWJRSiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422761AbWJRSiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbWJRSiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:38:10 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:5317 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1161266AbWJRSiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:38:08 -0400
Date: Wed, 18 Oct 2006 20:38:07 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Mohit Katiyar <katiyar.mohit@gmail.com>, linux-kernel@vger.kernel.org,
       Linux NFS mailing list <nfs@lists.sourceforge.net>
Subject: Re: NFS inconsistent behaviour
Message-ID: <20061018183807.GA12018@janus>
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com> <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com> <20061016084656.GA13292@janus> <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com> <20061016093904.GA13866@janus> <46465bb30610171822h3f747069ge9a170f1759af645@mail.gmail.com> <20061018063945.GA5917@janus> <1161194229.6095.81.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161194229.6095.81.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 01:57:09PM -0400, Trond Myklebust wrote:
> On Wed, 2006-10-18 at 08:39 +0200, Frank van Maarseveen wrote:
> > On Wed, Oct 18, 2006 at 10:22:44AM +0900, Mohit Katiyar wrote:
> > > I checked it today and when i issued the netstat -t ,I could see a lot
> > > of tcp connections in TIME_WAIT state.
> > > Is this a normal behaviour?
> > 
> > yes... but see below
> > 
> > > So we cannot mount and umount infinitely
> > > with tcp option? Why there are so many connections in waiting state?
> > 
> > I think it's called the 2MSL wait: there may be TCP segments on the
> > wire which (in theory) could disrupt new connections which reuse local
> > and remote port so the ports stay in use for a few minutes. This is
> > standard TCP behavior but only occurs when connections are improperly
> > shutdown. Apparently this happens when umounting a tcp NFS mount but
> > also for a lot of other tcp based RPC (showmount, rpcinfo).  I'm not
> > sure who's to blame but it might be the rpc functions inside glibc.
> > 
> > I'd switch to NFS over udp if this is problem.
> 
> Just out of interest. Why does anyone actually _want_ to keep
> mount/umounting to the point where they run out of ports? That is going
> to kill performance in all sorts of unhealthy ways, not least by
> completely screwing over any caching.

I ran out of privileged ports due to treemounting on /net from about 50
servers. The autofs program map for this uses the "showmount" command and
that one apparently uses privileged ports too (buried inside RPC client
libs part of glibc IIRC). The combination broke autofs and a number of
other services because there were no privileged ports left anymore.

So it can happen in practice.

> Note also that you _can_ change the range of ports used by the NFS
> client itself at least. Just edit /proc/sys/sunrpc/{min,max}_resvport.
> On the server side, you can use the 'insecure' option in order to allow
> mounts that originate from non-privileged ports (i.e. port > 1024).

Increasing the privileged port range in the kernel might be doable in
some cases. It might be useful to extend it to include port 2049 too.

-- 
Frank
