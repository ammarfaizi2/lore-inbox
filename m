Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWCQCWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWCQCWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 21:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWCQCWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 21:22:18 -0500
Received: from ns2.suse.de ([195.135.220.15]:40576 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750826AbWCQCWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 21:22:18 -0500
From: Neil Brown <neilb@suse.de>
To: "Bret Towe" <magnade@gmail.com>
Date: Fri, 17 Mar 2006 13:20:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17434.7434.626268.71114@cse.unsw.edu.au>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs udp 1000/100baseT issue
In-Reply-To: message from Bret Towe on Thursday March 16
References: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>
	<Pine.LNX.4.61.0603162139450.11776@yvahk01.tjqt.qr>
	<dda83e780603161733o10a3c330kddf96a726f162fa7@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 16, magnade@gmail.com wrote:
> On 3/16/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> > >
> > >a while ago i noticed a issue when one has a nfs server that has
> > >gigabit connection
> > >to a network and a client that connects to that network instead via 100baseT
> > >that udp connection from client to server fails the client gets a
> > >server not responding
> > >message when trying to access a file, interesting bit is you can get a directory
> > >listing without issue
> > >work around i found for this is adding proto=tcp to the client side
> > >and all works
> > >without error
> >
> > UDP has its implications, like silently dropping packets when the link
> > is full, by design. Try tcpdump on both systems and compare what packets
> > are sent and which do arrive. The error message is then probably because
> > the client is confused of not receiving some packets.
> 
> after compairing a working and not working client i found that
> packets containing offset 19240, 20720, 22200 are missing
> and the 100baseT client had an extra offset of 32560
> on the working client it ends at 31080
> 
> the missing ones are mostly constantly missing 22200 appears every so often
> on retransmission and 23680 also disappears every so often
> 
> i hope that isnt too confusing i dont use tcpdump type stuff much
> (well i did give up on tcpdump and had to use ethereal...)

This is all to be expected.  I remember having this issue with a
server on 100M and clients in 10M...

There is no flow control in UDP.  If anything gets lots, the client
has to resend the request, and the server then has to respond again.
If the respond is large (e.g. a read) and gets fragmented (if > 1500bytes)
then there is a good chance that one or more fragments of a reply will
get lots in the switch stepping down from 1G to 100M.  Every time.

Your options include:

  - use tcp
  - get a switch with a (much) bigger packet buffer
  - drop the server down to 100M
  - drop the nfs rsize down to 1024 to you don't get fragments.

NeilBrown
