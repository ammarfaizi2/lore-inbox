Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131207AbRCUGk5>; Wed, 21 Mar 2001 01:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131209AbRCUGks>; Wed, 21 Mar 2001 01:40:48 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:11435 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131207AbRCUGkl>; Wed, 21 Mar 2001 01:40:41 -0500
Message-ID: <3AB84DEC.ED651FD2@redhat.com>
Date: Wed, 21 Mar 2001 01:45:00 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@blue-labs.org>
CC: Peter Lund <firefly@netgroup.dk>, Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: esound (esd), 2.4.[12] chopped up sound -- solved
In-Reply-To: <Pine.GSO.4.30.0103201832260.15849-100000@balu> <3AB7A2CB.64ED61F3@netgroup.dk> <3AB7B477.2A740CE0@blue-labs.org> <3AB7BB59.9513514C@redhat.com> <3AB821AD.6F545468@blue-labs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> a) not all drivers are created equal
> b) esd should check the return value anyway

In as much as several people did point out that a write is not guaranteed to
be complete and may be short, even when in blocking mode, you are perfectly
correct.  In as much as this usually is a result of an error condition or
inability of the write to be completed, and not a result of a driver refusing
to block and complete the write as the caller has requested (which would be
the case in a sound driver since the output should be draining, the only
exception being if the program had call the SETTRIGGER ioctl to disable the
output starting with the first write of a complete oss frag, which esd doesn't
do so it isn't a plausible condition) I think drivers that do this are
"inferior" (since I can't call them buggy any longer).  Amongst other things,
it increases the number of traversals through the syscall heirarchy
needlessly, wastes both kernel and user space CPU cycles, and negates the
whole purpose of having the file opened in blocking mode anyway.  So, yes esd
should check these conditions to be complete and compliant with specs.  Given
a decent sound driver though, it shouldn't have to.

> -d
> 
> Doug Ledford wrote:
> 
> > David Ford wrote:
> > >
> > > Actually you probably upgraded to a non-broken version of esd.  Stock esd -still-
> > > writes to the socket without regard to return value.  If the write only accepted
> > > 2098 of 4096 bytes, the residual bytes are lost, esd will write the next packet at
> > > 4097, not 2099.  esd is incredibly bad about err checking as is old e stuff.
> > >
> > > I posted my last patch for esd here and to other places in June of 2000.  All it
> > > does is check for return value and adjust the writes accordingly.  For reference,
> > > the patch is at http://stuph.org/esound-audio.c.patch.
> >
> > Why would esd get a short write() unless it is opening the file in non
> > blocking mode (which I didn't see when I was working on the i810 sound
> > driver)?  If esd is writing to a file in blocking mode and that write is
> > returning short, then that sounds like a driver bug to me.


-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
