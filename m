Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbUDVFFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUDVFFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 01:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUDVFFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 01:05:44 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:14866 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263457AbUDVFFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 01:05:42 -0400
Date: Thu, 22 Apr 2004 07:04:12 +0200
From: Willy Tarreau <w@w.ods.org>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
Message-ID: <20040422050411.GM596@alpha.home.local>
References: <20040421132047.026ab7f2.davem@redhat.com> <Xine.LNX.4.44.0404212042540.20483-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Xine.LNX.4.44.0404212042540.20483-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 08:45:42PM -0400, James Morris wrote:
> On Wed, 21 Apr 2004, David S. Miller wrote:
> 
> > On Wed, 21 Apr 2004 19:03:40 +0200
> > Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> > 
> > > Heise.de made it appear, as if the only news was that with tcp
> > > windows, the propability of guessing the right sequence number is not
> > > 1:2^32 but something smaller.  They said that 64k packets would be
> > > enough, so guess what the window will be.
> > 
> > Yes, that is their major discovery.  You need to guess the ports
> > and source/destination addresses as well, which is why I don't
> > consider this such a serious issue personally.
> >
> > It is mitigated if timestamps are enabled, because that becomes
> > another number you have to guess.
> > 
> > It is mitigated also by randomized ephemeral port selection, which
> > OpenBSD implements and we could easily implement as well.
> 
> What about the techniques mentioned in
> http://www.ietf.org/internet-drafts/draft-ietf-tcpm-tcpsecure-00.txt ?

They might break the net rather than fix it, they don't seem to consider
every aspect. Imagine installed stateful firewalls, NAT boxes, load balancers,
etc... All those boxes which won't speak RFCXXXX will block the return ACK
once they see the forward RST, and the server behind the firewall will keep
ESTABLISHED sessions for hours, days, ... or up to the session time-out
dictated by the application. RSTs are very common on the internet from dialup
networks because there are lots of people without any clue about networking,
who hang up their modem while they fill a form on a site or read a long page,
ignoring that their MSIE does HTTP keep-alive and has not yet closed the
session. Some also experiment hard lockups or BSODs during FTP transfers, ...
And when they release the line, someone else on the same ISP connects and
gets the same address. And what does he do with all the ACKs the server sends
him ? RST !

It seems that this RST is covered by their draft, but instead of enumerating
every possibility to get an RST and check how they can cover it, they focus
on changing the RFC, regardless of already deployed implementations. Well,
I'm already waiting for the fight between RFCxxxx compliant OSes vs RFCyyyy
with yyyy > xxxx. It will be a bit like rfc1337: an entry in /proc for us,
a sysctl for BSD users, ndd for solaris and a registry key for many others.

At least their draft needs to be validated in every condition, and consequences
must be evaluated, with perhaps work-arounds (eg: fall back to old behaviour
after a certain number of particular RSTs, ...).

> Curiously there is no mention of port guessing or timestamps there.

They don't even explain why RSTs are generated and why we need them.

Regards,
Willy

