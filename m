Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292336AbSCEVtx>; Tue, 5 Mar 2002 16:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291753AbSCEVto>; Tue, 5 Mar 2002 16:49:44 -0500
Received: from h006008986325.ne.mediaone.net ([24.61.201.13]:784 "EHLO
	workingcode.com") by vger.kernel.org with ESMTP id <S291074AbSCEVtZ>;
	Tue, 5 Mar 2002 16:49:25 -0500
From: James Carlson <carlson@workingcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15493.15705.875971.284849@h006008986325.ne.mediaone.net>
Date: Tue, 5 Mar 2002 16:49:13 -0500 (EST)
To: jt@hpl.hp.com
Cc: Maksim Krasnyanskiy <maxk@qualcomm.com>, Paul Mackerras <paulus@samba.org>,
        linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
In-Reply-To: Jean Tourrilhes's message of 5 March 2002 11:27:22
In-Reply-To: <15492.21937.402798.688693@argo.ozlabs.ibm.com>
	<20020304144200.A32397@bougret.hpl.hp.com>
	<15492.13788.572953.6546@argo.ozlabs.ibm.com>
	<20020304191947.A32730@bougret.hpl.hp.com>
	<20020305094535.A792@bougret.hpl.hp.com>
	<5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com>
	<20020305102835.B847@bougret.hpl.hp.com>
	<15493.6511.657146.472391@h006008986325.ne.mediaone.net>
	<20020305112722.D898@bougret.hpl.hp.com>
X-Mailer: VM 6.75 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes writes:
> > No.  Decreasing the buffering below PPP is the right path.
> 
> 	Yes, that's what I want to do it. But with regards to TCP,
> there is no difference if packets are buffered within PPP or below
> PPP. So, reducing buffering in PPP is also a win.

True.  Actually, except for MP reassembly, there should be *no*
buffering in PPP at all.  If there is on your platform (I'm much more
familiar with Solaris than with Linux), then that's certainly an odd
design problem.

I've seen the deep buffering problem before in other contexts: older
BSD stacks had all output ifq_len values set to 50, even if the links
were really slow (<9600bps), and this often triggered retransmits.
TCP congestion detection *depends* on packet loss.  Loss is a good
thing.

> > Running one retransmit-based reliable protocol atop another is usually
> > a recipe for disaster (as you've found; as others have found by trying
> > to run PPP over TELNET over the general Internet).
> 
> 	Not true. It all depend of the timeframe of those
> retransmissions, and how they are triggered. That's why TCP works
> properly on 802.11b. Of course, this assume that the link
> retransmissions are designed properly.

That's still exactly what I said in that message, just restated a
different way:

	In general, if you have link-layer ARQ, you need to have the
	time constant be *much* shorter than any RTT estimate that TCP
	is likely to see, or you get oscillatory behavior out of TCP.

In other words, link layer ARQ should be minimally persistent and done
only if the retransmit interval is much shorter than TCP's RTT
estimate.  If it's not, then you have a controlled disaster.  This has
been demonstrated before with PPP-over-TCP hacks.

> > The transport layer (most often TCP) assumes that the network layer
> > (IP) has minimal (and slowly varying) latency, but is lossy, and thus
> > that it has minimal buffering and little error control.
> 
> 	Not true. Try running TCP on links with 20% packet losses.
> 	Also, any ethernet driver flow control the stack through
> netif_stop/start_queue() to avoid local overruns.

I said "lossy," not "high error rate."  There's quite a difference
between the two.  TCP finds the one (by definition) bottleneck in the
path by finding the point where packets drop and optimizing around
that.  It just won't do that if there aren't losses, and the window
will open until the link-layer queue becomes a serious stability
problem.

(If the link can push back in Linux with local flow control, then the
question becomes: why doesn't that work with this application?  Is
something missing from the IrDA interface or the PPP kernel bits that
prevent this from working right?  And if it's the latter, why don't
regular serial users see the problem?)

(You can do better by dropping packets *earlier* -- see RED.)

> 	Already read those. Guess what, my name is event in the
> acknowledgments ! How bizzare ;-)

*Blush* I somehow forgot about your postings among the flood of draft
updates from Phil and odd flame-wars.  :-/

-- 
James Carlson                                  <carlson@workingcode.com>
