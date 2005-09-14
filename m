Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbVINLMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbVINLMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 07:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbVINLMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 07:12:14 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:17844 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932723AbVINLMO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 07:12:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ForjrSb+kE+6gYzjg7XZPKllHiR6UqVSDeAy8fIzsH9Ykl5Y3fesasydNc3bRmAkEb+gO8K97Bm63X1F0DmuDU3+fqVN5gnrr+YlsIOy2tN+l0IdtCRlf/vSu5iv9hPoDjPFRoGEDXPvburwMJ3/WfHzX8f8ZVOeam6LZH/6jn4=
Message-ID: <5a4c581d050914041222b033cb@mail.gmail.com>
Date: Wed, 14 Sep 2005 13:12:11 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: alessandro.suardi@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13 brings buffer underruns when recording DVDs in 16x (was Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1)
Cc: Mathieu Fluhr <mfluhr@nero.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050914035840.3fbd6b95.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
	 <1126608030.3455.23.camel@localhost.localdomain>
	 <1126630878.2066.6.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0509131010010.3351@g5.osdl.org>
	 <1126635160.2183.6.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0509131210090.3351@g5.osdl.org>
	 <1126685479.2010.14.camel@localhost.localdomain>
	 <20050914013053.0c2b302c.akpm@osdl.org>
	 <1126693960.2061.8.camel@localhost.localdomain>
	 <20050914035840.3fbd6b95.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/05, Andrew Morton <akpm@osdl.org> wrote:
> Mathieu Fluhr <mfluhr@nero.com> wrote:
> >
> > On Wed, 2005-09-14 at 01:30 -0700, Andrew Morton wrote:
> > > Mathieu Fluhr <mfluhr@nero.com> wrote:
> > > >
> > > > According to the MMC documentation, you can thoeriticaly send at most
> > > >  65535 (16 bits int) blocks in one WRITE(10) CDB. This would means
> > > >  sending a buffer of ~127 MB on case of writing a mode 1 data track (2048
> > > >  bytes per block)...
> > > >
> > > >  Now, practically, it is really not safe to send more than 64 KB per CDB
> > > >  (Mostly device related). And with such values, you have the following:
> > > >   - at 100 Hz  -> 64 KB * 100  = 6400 KB/s  <=> ~4.62x  DVD
> > > >   - at 250 Hz  -> 64 KB * 250  = 16000 KB/s <=> ~11.55x DVD
> > > >   - at 1000 Hz -> 64 KB * 1000 = 64000 KB/s <=> ~46.20x DVD
> > >
> > > But that implies that there's some piece of code somewhere (could be
> > > userspace, could be kernel) which is doing a timer-based sleep() in between
> > > each CDB.  It shouldn't do that - it should be using the disk
> > > controller's completion interrupt for synchronisation.
> > >
> >
> > Hummm... you are definitly right. So forget my calculations. I does not
> > mean anything. Honestly, I was just trying to find an explanation why it
> > was working with HZ set to 1000 and not with HZ set to 250 or 100.
> >
> > > What userspace application are you using to write the DVDs, and is it
> > > possible to test a different one?
> >
> > I am using NeroLINUX to make my tests. I also tried out
> > cdrecord/growisofs, but I was not even able to burn at 16x (I get some
> > error message that max speed is 10x... and nothing more).
> >
> > But there seems to be somehow some I/O limitation: I configured a pure
> > 2.6.13.1 to have HZ set to 100. I then made a 3 GB compilation with
> > small files (about 3 to 5 MB each).
> >  - If you burn this directly without creating a temp ISO image in 4x
> > (5440 KB/s), you will get buffer underruns soon or later... (about 2%)
> >  - If you create an ISO image out of the compilation (using mkisofs or
> > other tool), and then burn this image, then no buffer underruns occurs.
> >
> > After that, you speed up your recorder with this image (for example at
> > 8x), you will have these buffer underruns back again.
> > And as I tell you, no such stuff is happening when HZ is set to 1000.
> >
> 
> OK, so you get underruns with NeroLINUX at 8x, and it should be possible to
> test cdrecord at 8x, yes?  If that works then it's time to take a look at
> what NeroLINUX is doing..
> 
> erp, it's payware.   strace, maybe?

Data point... recent 2.6.13 (possibly after 2.6.13-final) allow
 my puny K7-800 256MB RAM to burn DVDs with growisofs
 at 8x, whereas earlier releases would peak at 8x then step
 back to 4x. Currently burn starts at 5x and goes up steadily
 to 8x in a couple of minutes, then stays there until the DVD
 is done. I never tested 16x - actually I haven't yet owned a
 16x capable DVD disc... but I doubt my system could burn
 that fast - 8x is already a blessing ;)

--alessandro

 "All it takes is one decision
  A lot of guts, a little vision to wave
  Your worries, and cares goodbye"

   (Placebo - "Slave To The Wage")
