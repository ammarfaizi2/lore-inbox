Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932370AbWFEBRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWFEBRo (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWFEBRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:17:44 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:132 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932370AbWFEBRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:17:43 -0400
Date: Mon, 5 Jun 2006 03:17:20 +0200
From: Voluspa <lista1@comhem.se>
To: wfg@mail.ustc.edu.cn
Cc: akpm@osdl.org, arjan@infradead.org, Valdis.Kletnieks@vt.edu,
        diegocg@gmail.com, lista1@comhem.se, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readahead: initial method - expected read size - fix
 fastcall
Message-Id: <20060605031720.0017ae5e.lista1@comhem.se>
In-Reply-To: <1149413103.3109.90.camel@laptopd505.fenrus.org>
References: <349406446.10828@ustc.edu.cn>
	<20060604020738.31f43cb0.akpm@osdl.org>
	<1149413103.3109.90.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Jun 2006 11:25:03 +0200 Arjan van de Ven wrote:
> On Sun, 2006-06-04 at 02:07 -0700, Andrew Morton wrote:
> > On Sun, 4 Jun 2006 15:34:15 +0800
> > Fengguang Wu wrote:
> > 
> > > Remove 'fastcall' directive for function readahead_close().
> > > 
> > > It has drawn concerns from Andrew Morton.
> > 
> > Well.  I think fastcall is ugly and vaguely silly.  Now if we has a
> > really_really_fastcall then I'd like to use that!
> > 
> > 
> > > Now I have some benchmarks
> > > on it, and proved it as a _false_ optimization.
> > 
> > Sorry, I don't believe this will be measurable (and with CONFIG_REGPARM
> > it'll be a no-op).
> 
> we should just make CONFIG_REGPARM be "it" always (and thus make it go
> away as config option) and then just remove all "fastcall" from the
> kernel...

Wu, I don't know anything about REGPARM, which my x86_64 config doesn't have,
(only the never kernel-updated i686 machine) but your last 2 patches - I
didn't apply the, to me, seemingly unrelated radixtree thing - sure is
measurable. In a most negative way regarding READ/WRITE and a completely
unchanged READ.

Patch:
http://web.comhem.se/~u46139355/storetmp/adaptive-readahead-v14-linux-2.6.17-rc5-git-updated-june-04-2006.patch

Kernel config:
http://web.comhem.se/~u46139355/storetmp/voluspa-2.6.17-rc5-git10-ar-.config

Hard/soft-ware and testing procedure:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114911241320301&w=2

I should add that CFQ is the IO scheduler used and what I mean by default
adaptive readahead options is just that, minus the debug stuff (not compiled).
Also, I've verified that the CFQ updates in -git10 didn't regress plain
-rc5.

_Massive READ_

[/usr had some 166000 files]

By routing screen writes to /dev/null, this test became so stable that a
one-shot would have sufficed, but I did two for those who crave pudding.

"cd /usr; time find . -type f -exec md5sum {} \; >/dev/null"

2.6.17-rc5-git10 ---------- 2.6.17-rc5-git10-ar

real 7m15.525s 7m15.425s -- 7m19.720s 7m19.065s
user 1m11.596s 1m11.894s -- 1m12.111s 1m11.585s
sys  1m49.211s 1m48.068s -- 1m46.223s 1m46.887s

When the target had 490000 files (and wrote to screen) the difference was
16.5 seconds, so the 4s here is in line (time hovered at 7m34s for -git10
and 7m39s for -git10-ar when writing to screen, +/- 1-2s).

_READ/WRITE_

[255 .tga files, each is 1244178 bytes]
[1 .wav file which is 1587644 bytes]
[movie becomes 573298 bytes ~9s long]

This is also extremely accurate _between runs_. Time varies depending on
file order and placement on disk, but the actual runs are 'klockrena'
('dead accurate'?)

time mencoder -ovc lavc -lavcopts aspect=16/9 mf://picsave/kreation/03-logo-joined/*.tga -oac lavc -audiofile kreation-files/kreation-logo-final.wav -o logo-final-widescreen-speedtest.avi

2.6.17-rc5-git10 ---------- 2.6.17-rc5-git10-ar

real 0m12.892s 0m12.903s -- 0m16.555s 0m16.611s
user 0m3.289s  0m3.314s  -- 0m3.315s  0m3.307s
sys  0m1.124s  0m1.085s  -- 0m1.096s  0m1.121s

Without the 2 new patches, the difference was 0.6s, still bad on a 9s movie,
but these 3.5s are flabbergasting!

And, no. I don't know which of the 2 that caused this. I am prepared to hand
out a link to a .bz2 archive of all the files involved. Just send a private
message. You only need mplayer [mencoder] installed, and then a one-shot tells
it all.

Mvh
Mats Johannesson
--
