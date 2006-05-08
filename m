Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWEHRBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWEHRBl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWEHRBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:01:41 -0400
Received: from [83.101.156.236] ([83.101.156.236]:24580 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932481AbWEHRBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:01:40 -0400
From: Al Boldi <a1426z@gawab.com>
To: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 009 of 11] md: Support stripe/offset mode in raid10
Date: Mon, 8 May 2006 19:59:26 +0300
User-Agent: KMail/1.5
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060501152229.18367.patches@notabene> <200605030700.23515.a1426z@gawab.com> <17502.61577.874881.753541@cse.unsw.edu.au>
In-Reply-To: <17502.61577.874881.753541@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605081959.26470.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Wednesday May 3, a1426z@gawab.com wrote:
> > Neil Brown wrote:
> > > On Tuesday May 2, a1426z@gawab.com wrote:
> > > > NeilBrown wrote:
> > > > > The "industry standard" DDF format allows for a stripe/offset
> > > > > layout where data is duplicated on different stripes. e.g.
> > > > >
> > > > >   A  B  C  D
> > > > >   D  A  B  C
> > > > >   E  F  G  H
> > > > >   H  E  F  G
> > > > >
> > > > > (columns are drives, rows are stripes, LETTERS are chunks of
> > > > > data).
> > > >
> > > > Presumably, this is the case for --layout=f2 ?
> > >
> > > Almost.  mdadm doesn't support this layout yet.
> > > 'f2' is a similar layout, but the offset stripes are a lot further
> > > down the drives.
> > > It will possibly be called 'o2' or 'offset2'.
> > >
> > > > If so, would --layout=f4 result in a 4-mirror/striped array?
> > >
> > > o4 on a 4 drive array would be
> > >
> > >    A  B  C  D
> > >    D  A  B  C
> > >    C  D  A  B
> > >    B  C  D  A
> > >    E  F  G  H
> > >    ....
> >
> > Yes, so would this give us 4 physically duplicate mirrors?
>
> It would give 4 devices each containing the same data, but in a
> different layout - much as the picture shows....
>
> > If not, would it be possible to add a far-offset mode to yield such
> > a layout?
>
> Exactly what sort of layout do you want?

Something like this:

o1	A1 B1 C1 D1

o2	A1 A2 B1 B2
	C2 C1 D2 D1
	
o3	A1 A2 A3 B1
	B2 B3 C1 C2
	C3 D1 D2 D3

o4	A1 A2 A3 A4
	B2 B3 B4 B1
	C3 C4 C1 C2
	D4 D1 D2 D3

(columns are drives, numbers are stripes, LETTERS are chunks of data).

> > > > Also, would it be possible to have a staged write-back mechanism
> > > > across multiple stripes?
> > >
> > > What exactly would that mean?
> >
> > Write the first stripe, then write subsequent duplicate stripes based on
> > idle with a max delay for each delayed stripe.
> >
> > > And what would be the advantage?
> >
> > Faster burst writes, probably.
>
> I still don't get what you are after.
> You always need to wait for writes of all copies to complete before
> acknowledging the write to the filesystem, otherwise you risk
> corruption if there is a crash and a device failure.

Yes, some people can not stomach running degraded at any time, so they could 
set the delay for the first duplicate stripe to 0, and subsequent stripes at 
leasure.

Thanks!

--
Al

