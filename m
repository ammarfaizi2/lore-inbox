Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbTH1BLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 21:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTH1BLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 21:11:44 -0400
Received: from [61.34.11.200] ([61.34.11.200]:22225 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S262814AbTH1BLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 21:11:39 -0400
Date: Thu, 28 Aug 2003 10:13:41 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: Ville Herva <vherva@niksula.cs.hut.fi>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030828011341.GA19622@atj.dyndns.org>
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi> <20030827064301.GF150921@niksula.cs.hut.fi> <20030827071259.GV83336@niksula.cs.hut.fi> <20030827092139.4d75ef4a.skraw@ithnet.com> <20030827073758.GW83336@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827073758.GW83336@niksula.cs.hut.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 10:37:58AM +0300, Ville Herva wrote:
> On Wed, Aug 27, 2003 at 09:21:39AM +0200, you [Stephan von Krawczynski] wrote:
> > 
> > Sorry, then you have to look for another explanation. 
> 
> Yep, but I don't have any reasonable suspects.
> 
> > Did you already try to exchange everything but the harddisks ?
> 
> No. Do you suspect faulty hardware?
> 
> Apart from perhaps Adaptec 2940 (Adaptecs always give me trouble), I
> believe the hw is pretty solid. It had no problems with 2.2 kernels.  Based
> on my experience, the i815 chipset is not that shaky (unlike the Via dung),
> and I would expect the Intel motherboard to be on the better side as well.
> 
> I can't completely rule faulty hw out, though.
> 
> Exchanging hw will be quite difficult, as the hangs take as much as three
> weeks to trigger (sometimes they happen withing a day after reboot), the box
> is a production server, and I don't have much spare hardware atm.
> 
> What I had hoped for is to be able to get some information on where it hangs.
> But sysrq and nmi watchdog don't cut it...
> 

 Hello Ville.  Hello Stephan. :-)

 Your problem sounds very simlar to the problem we were suffering.
The problem was a spinlock deadlock inside drivers/char/random.c which
is used by tcp to generate random initial sequence number.  The bug
fix was checked into 2.4 tree on 28th July after the release of pre8
at 14th July.

ChangeSet@1.1019.1.7, 2003-07-24 14:21:29-03:00, marcelo@freak.distro.conectiva
    Changed EXTRAVERSION to -pre8
  TAG: v2.4.22-pre8

ChangeSet@1.1019.3.10, 2003-07-28 17:25:49-07:00, olof@austin.ibm.com
  [RANDOM]: Fix SMP deadlock in __check_and_rekey().

 This problem can happen on UP machine if the kernel is compiled with
CONFIG_SMP.  Because the offending routine is called only every five
minutes and it should receive a SYN packet while it's connecting, it
occurs rarely, but it happens when it happens.

 Please try 2.4.22.

P.S. This bug is a real headache.  We had many servers deployed and
they all randomly locked up about every two or four weeks.  I believe
people should be warned about this one.

-- 
tejun

