Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283871AbRLITsi>; Sun, 9 Dec 2001 14:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283902AbRLITs3>; Sun, 9 Dec 2001 14:48:29 -0500
Received: from inje.iskon.hr ([213.191.128.16]:48789 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S283871AbRLITsL>;
	Sun, 9 Dec 2001 14:48:11 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: sct@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: ext3 writeback mode slower than ordered mode?
In-Reply-To: <871yi5wh93.fsf@atlas.iskon.hr> <3C12C57C.FF93FAC0@zip.com.au>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 09 Dec 2001 20:46:02 +0100
In-Reply-To: <3C12C57C.FF93FAC0@zip.com.au> (Andrew Morton's message of "Sat, 08 Dec 2001 17:59:24 -0800")
Message-ID: <877krwch39.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> Zlatko Calusic wrote:
> > 
> > Hi!
> > 
> > My apologies if this is an FAQ, and I'm still catching up with
> > the linux-kernel list.
> > 
> > Today I decided to convert my /tmp partition to be mounted in
> > writeback mode, as I noticed that ext3 in ordered mode syncs every 5
> > seconds and that is something defenitely not needed for /tmp, IMHO.
> > 
> > Then I did some tests in order to prove my theory. :)
> > 
> > But, alas, writeback is slower.
> > 
> 
> I cannot reproduce this.  Using http://www.zip.com.au/~akpm/writer.c
> 
> ext2:            0.03s user 1.43s system 97% cpu 1.501 total
> ext3 writeback:  0.02s user 2.33s system 96% cpu 2.431 total
> ext3 ordered:    0.02s user 2.52s system 98% cpu 2.574 total
> 

Hm, at first I got exactly the same results for writeback/ordered
cases, as you did above, so my theory fell on the ground.
Later, bloody thing resurected again. Something really fishy is goin'
on here...


 {atlas} [/mnt]# time ~zcalusic/try/awriter
 ~zcalusic/try/awriter  0.07s user 3.50s system 99% cpu 3.594 total
 {atlas} [/mnt]# cd /tmp
 {atlas} [/tmp]# time ~zcalusic/try/awriter
 ~zcalusic/try/awriter  0.00s user 6.05s system 98% cpu 6.129 total
 {atlas} [/tmp]# mount | egrep '/tmp|/mnt'
 /dev/hde2 on /tmp type ext3 (rw,data=writeback)
 /dev/hde3 on /mnt type ext3 (rw)


So /tmp is writeback and /mnt is ordered (doublechecked!). See for
yourself how ext3 is slower in writeback mode. awriter is your
small program, of course.

Just for the record, I mke2fs-ed /dev/hde3 again and made it pure
ext2.


 {atlas} [~]# mount | grep '/mnt'      
 /dev/hde3 on /mnt type ext2 (rw)
 {atlas} [~]# cd /mnt
 {atlas} [/mnt]# time ~zcalusic/try/awriter
 ~zcalusic/try/awriter  0.01s user 1.86s system 98% cpu 1.893 total


To sumarize:

ext2            0.01s user 1.86s system 98% cpu 1.893 total
ext3/ordered    0.07s user 3.50s system 99% cpu 3.594 total
ext3/writeback  0.00s user 6.05s system 98% cpu 6.129 total

What is strange is that not always I've been able to get different
results for writeback case (comparing to ordered), but when I get it,
it is repeatable.

This is a SMP machine, if that makes any difference.

Regards,
-- 
Zlatko
