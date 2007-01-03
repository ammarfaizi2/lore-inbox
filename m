Return-Path: <linux-kernel-owner+w=401wt.eu-S1750793AbXACOBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbXACOBA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbXACOBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:01:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33429 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbXACOA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:00:59 -0500
Date: Wed, 3 Jan 2007 08:58:08 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Grzegorz Kulewski <kangur@polcom.net>,
       Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       torvalds@osdl.org, 76306.1226@compuserve.com, akpm@osdl.org,
       bunk@stusta.de, greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
Message-ID: <20070103135808.GS29911@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200701030212.l032CDXe015365@harpo.it.uu.se> <20070103102944.09e81786@localhost.localdomain> <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net> <20070103124410.4cb191dd@localhost.localdomain> <1167831136.3095.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167831136.3095.8.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 05:32:16AM -0800, Arjan van de Ven wrote:
> On Wed, 2007-01-03 at 12:44 +0000, Alan wrote:
> > > > fixed. At that point an i686 kernel would contain i686 instructions and
> > > > actually run on all i686 processors ending all the i586 pain for most
> > > > users and distributions.
> > > 
> > > Could you explain why CMOV is pointless now? Are there any benchmarks 
> > > proving that?
> > 
> > Take a look at the recent ffmpeg bits on the mplayer list for one example
> > I have to hand - P4 cmov is pretty slow. The crypto folks find the same
> > things.
> 
> cmov is effectively the same cost as a compare and jump, in both cases
> the cpu needs to do a prediction, and on a mispredict, restart.
> 
> the reason cmov can make sense is because it's smaller code...

BTW, from GCC POV availability of CMOV is the only difference between
-march=i586 -mtune=something and -march=i686 -mtune=something.  So this is
just a naming thing, it could be called -march=i686cmov to make it more
obvious but it is too late (and too unimportant) to change it now.
Perhaps adding a note to info gcc/man gcc ought to be enough?
If you don't want CMOV being emitted, compile with -march=i586 -mtune=generic
(or whatever other tuning you pick up), with -march=i686 -mtune=generic
you tell GCC you have CMOV.  Whether CMOV is actually used in generated
code is another matter, which should be decided based on the selected
-mtune.  For -Os CMOV should be used whenever available, as that means
usually smaller code, otherwise if on some particular chip CMOV is actually
slower than compare, jump and assignment, then CMOV should not be selected
for that particular tuning (say if Pentium4 has slower CMOV than
compare+jump+assignment, -mtune=pentium4 should not emit CMOV, at least not
often), if you have examples of that, please file a bug to
http://gcc.gnu.org/bugzilla/.  -mtune=generic should emit resp. not emit
CMOV depending on whether it is a win on the currently common CPUs.

	Jakub
