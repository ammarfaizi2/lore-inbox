Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268085AbTBRX3D>; Tue, 18 Feb 2003 18:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268092AbTBRX3D>; Tue, 18 Feb 2003 18:29:03 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:52912 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268085AbTBRX3B>; Tue, 18 Feb 2003 18:29:01 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: kuznet@ms2.inr.ac.ru
Date: Wed, 19 Feb 2003 10:35:14 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15954.49970.860809.75554@notabene.cse.unsw.edu.au>
Cc: davem@redhat.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org
Subject: Re: sendmsg and IP_PKTINFO
In-Reply-To: message from kuznet@ms2.inr.ac.ru on Tuesday February 18
References: <15954.4693.893707.471216@notabene.cse.unsw.edu.au>
	<200302181606.TAA03838@sex.inr.ac.ru>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 18, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > So yes, the current behaviour seems to match part of the
> > documentation.
> 
> Good. :-)
> 
> >  "the outgoing packet will be sent over the interface specified in
> >  ipi_ifindex if that interface has a valid route to the packets
> >  destination.  Otherwise normal rouing rules apply".
> > 
> > I further argue that this is not only more rational, but is actually
> > more useful (which is a more telling point).
> 
> Either you rely on routing tables, or you do not, which is used
> when routing tables are still not set up, or setup ambiguously,
> or use of them just do not make sense which happens for multicasts/
> limited/broadcasts/link local addresses. It is the thing which ifi_ifindex
> does.
> 

Presumably in these "don't rely on routing" cases the application
would set SO_DONTROUTE or MSG_DONTROUTE.
If this flag were set, I wouldn't argue with insisting that the
message goes out the interface specified in ifi_ifindex.

But if not, what then...

There remains the fact that the only documentation I can find about
this(*) describes ifi_ifindex as the interface that a message
*arrived* on, and when specified in a sendmsg call, it is information
about the message that we are replying to.  Interpreting this to mean
that the reply *must* go out that interface still seems wrong to me.

Do you agree which that definition of IP_PKTINFO?  If not, can you
show me some documentation which supports your position?

(*) I looked in the Single Unix Specification and it doesn't mention
PKTINFO at all.  I looked in the RFC's mentioned at the bottom of
 "man 7 ip"
(RPC1122 and 1812) and they don't say anything about specifying an
interface for outgoing messages - only specifying a source address.


> I do no see how it is possible to classify a middle way as "rational".
> Well, and frankly speaking I do not see how it could be useful.

The "middle way" is that we do want to rely on routing tables (as we
have not set MSG_DONTROUTE) but that the routing tables do not give a
unique route to some addresses - as is certainly possible and even
encouraged by RFC1122 (end of discussion of Strong ES model in
section 3.3.4.2).

With reliable routing that provides multiple routes in some cases, it
seems reasonable, even rational, to accept hints from the application
as to which interface to use.

As for "useful", it is more that I cannot see how the current
behaviour is useful - i.e. how can be used meaningfully by an
application.

The particular behaviour is:
  If MSG_DONTROUTE is not set, but a non-zero ifi_ifindex is given
  then:
    If there is a known route to the destination address through that
       interface, then use that route.
    If there is no route through that interface to the destination
       address, then treat it as a link-local address.

 When would an application actually want that behaviour?

My current approach to 'fixing' what I perceive as the 'problem' would
be one of:

 1/ if no route is found out the interface, return ENETUNREACH (not
 that ENETUNREACH is listed in the man page for sendmsg :-( )
   Also change to documentation to make the intent more explicit.  
   This would make my current problem clearly an application error and
   I could take it to the maintainers of glibc.

 2/ If MSG_DONTROUTE is not set, then ignore the value passed in
    ifi_ifindex.   
    This would slightly weaken the applications options for
    controlling routing, but I don't think the weakening would be
    significant. 

 3/ Treat the ifi_ifindex as a hint if MSG_DONTROUTE isn't set.   This
    would be much more invasive to the code, and it is not clear that
    the extra control it provides is needed in practice.


Thank you for your frankness,

NeilBrown
