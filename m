Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267429AbUG2H1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267429AbUG2H1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 03:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267456AbUG2H1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 03:27:10 -0400
Received: from mail024.syd.optusnet.com.au ([211.29.132.242]:61396 "EHLO
	mail024.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267429AbUG2H1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 03:27:01 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16648.42669.907048.112765@wombat.chubb.wattle.id.au>
Date: Thu, 29 Jul 2004 17:26:37 +1000
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: "David S. Miller" <davem@redhat.com>, Chris Wedgwood <cw@f00f.org>,
       peter@chubb.wattle.id.au, linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
In-Reply-To: <20040729002924.GK12308@parcelfarce.linux.theplanet.co.uk>
References: <233602095@toto.iv>
	<16648.10711.200049.616183@wombat.chubb.wattle.id.au>
	<20040728154523.20713ef1.davem@redhat.com>
	<20040729000837.GA24956@taniwha.stupidest.org>
	<20040728171414.5de8da96.davem@redhat.com>
	<20040729002924.GK12308@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "viro" == viro  <viro@parcelfarce.linux.theplanet.co.uk> writes:

>> On Wed, 28 Jul 2004 17:08:37 -0700 Chris Wedgwood <cw@f00f.org>
>> wrote:
>> 
>> > Just How bad is it for you?  I just tested stat on my crapbox and
>> for > a short path 1M stats takes 0.5s and for a longer path (30
>> bytes or > so) 2.8s.
>> 
>> Run "time find . -type f" on the kernel tree, both before and after
>> removing the third unnecessary copy.

viro> ... with hot cache, otherwise IO time will dominate.  I don't
viro> disagree with you, but in all realistic cases I can think of
viro> it's going to be noise (e.g. this find over kernel tree is
viro> almost certainly followed by xargs grep, etc.).

With hot cache the system time is really small.

On a 2GHz Pentium 4, Compare
	find .-type f -mtime -2000 >/dev/null
with
	find . -type f -mtime -2000
in a freshly checked out 2.8 kernel tree.

(the -mtime test is to force a stat, otherwise, as Ulrich says, almost
no stat system calls will take place)

	to xterm     	>/dev/null	| xargs grep foo
sys	0.34		0.103		0.35
user    0.29		0.08		0.104
real    18.551		0.204		220.25

Using strace reveals that around 60% of the system time in the
redirected to /dev/null case is lstat64 --- 41465 calls, 1.5usec per
call.  Where it's in a pipe that uses the files, the time is swamped
by the time to process the files, and the time spent in write() ---
lstat64 drops to around 16% of the time in find.

The nice thing about the current three-copy implementation is that
it's simple and obviously correct.  Personally, I don't think that the
increased complexity of arhcitecture-specific callbacks, etc., is
worth the small performance gain.


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
