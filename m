Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSEQUYU>; Fri, 17 May 2002 16:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSEQUYU>; Fri, 17 May 2002 16:24:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:613 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316677AbSEQUYS>;
	Fri, 17 May 2002 16:24:18 -0400
Message-ID: <3CE558E1.3319E3E8@gmx.net>
Date: Fri, 17 May 2002 21:24:17 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE PIO write Fix #2
In-Reply-To: <3CE0795B.62C956F0@cinet.co.jp> <3CE0D6DE.8090407@evision-ventures.com> <abroiv$ifs$1@penguin.transmeta.com> <3CE22EA8.60905@evision-ventures.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:

> U¿ytkownik Linus Torvalds napisa³:
> > In article <3CE0D6DE.8090407@evision-ventures.com>,
> > Martin Dalecki  <dalecki@evision-ventures.com> wrote:
> >
> >>>--- linux-2.5.15/drivers/ide/ide-taskfile.c.orig     Fri May 10 11:49:35 2002
> >>>+++ linux-2.5.15/drivers/ide/ide-taskfile.c  Tue May 14 10:40:43 2002
> >>>@@ -606,7 +606,7 @@
> >>>             if (!ide_end_request(drive, rq, 1))
> >>>                     return ide_stopped;
> >>>
> >>>-    if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
> >>>+    if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
> >>
> >
> > Well, that's definitely an improvement - the original code makes no
> > sense at all, since it's doing a bitwise xor on two bits that are not
> > the same, and then uses that as a boolean value.
> >
> > Your change at least makes it use the bitwise xor on properly logical
> > values, making the bitwise xor work as a _logical_ xor.
> >
> > Although at that point I'd just get rid of the xor, and replace it by
> > the "!=" operation - which is equivalent on logical ops.
> >
> >
> >>>             pBuf = ide_map_rq(rq, &flags);
> >>>             DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
> >>
> >>
> >>Hmm. There is something else that smells in the above, since the XOR operator
> >>doesn't seem to be proper. Why shouldn't we get DRQ_STAT at all on short
> >>request? Could you perhaps just try to replace it with an OR?
> >
> >
> > The XOR operation is a valid op, if you just use it on valid values,
> > which the patch does seem to make it do.
> >
> > I don't know whether the logic is _correct_ after that, but at least
> > there is some remote chance that it might make sense.
> >
> >               Linus
>
> As far as I can see the patch makes sense. It is just exposing a problem
> which was hidden before.

The original code:
 a)    if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
is being compared to these expressions:
 b) logical equ. if ((rq->current_nr_sectors==1) || ((stat & DRQ_STAT)!=0)) {   (me)
 c) not eqival.  if ((rq->current_nr_sectors==1) ^  ((stat & DRQ_STAT)!=0)) {  (tomita)
 d) same as c    if ((rq->current_nr_sectors==1) != ((stat & DRQ_STAT)!=0)) {  (linus)

Note: DRQ_STAT will be set when this routine is entered per "PIO Out protocol spec".

c+d will deadlock.
    (it will _not_ send the last sector)

a+b will send the last sector to the drive when it isn't ready to receive.
    (Although most of the time it _will_ be ready when we enter this routine)

So:
   if( (stat & DRQ_STAT) && !(stat & BSY_STAT)) {
should be correct.

The original intent for a) was probably:
check DRQ only on the _first_ sector we transfer as
shown in "ATA-4 PIO data out command protocol", which would translate to:
e) if ( !(rq->are_we_transferring_the_first_sector_just_now) || ((stat & DRQ_STAT)!=0)) {

-
Gunther

