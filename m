Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131141AbRBMXoY>; Tue, 13 Feb 2001 18:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131126AbRBMXoO>; Tue, 13 Feb 2001 18:44:14 -0500
Received: from unthought.net ([212.97.129.24]:42680 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S131419AbRBMXn4>;
	Tue, 13 Feb 2001 18:43:56 -0500
Date: Wed, 14 Feb 2001 00:43:55 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stale NFS handles on 2.4.1
Message-ID: <20010214004355.C11906@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010214002750.B11906@unthought.net> <E14SovJ-0003H1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <E14SovJ-0003H1-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 13, 2001 at 11:31:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 11:31:50PM +0000, Alan Cox wrote:
> > The NFS clients are getting
> >  "Stale NFS handle"
> > messages every once in a while which will make a "touch somefile.o"
> > fail.
> 
> If they have the previous .o handle cached and it was removed on another
> client thats quite reasonable behaviour. NFS isnt coherent

So a solution would be to
 <local node>  rm -f output.o
 <remote node> g++ .... -o output.o
 <local node>  touch output.o

I do the touch in the first place because a subsequent link job on
another remote node used to fail if I didn't.   NFS caching magic I guess...

> 
> > It's quite annoying and I didn't see it on 2.2 even after the NFS
> > patches were integrated.
> 
> I wonder if its because 2.4 runs faster and caches better 8). You can
> tune the attribute cache times that may help. Are we talking 30 second
> intervals here or stuff being cached for far too long (which would imply a bug)

It runs faster indeed, and it makes the work more fun and makes the
internet go faster !   (uhhh...  or maybe the internet speedup is because
of the Intel CPUs - I forgot...)

Usually how a compile goes is:

a make -j10 spawns concurrent compile jobs. Each job consists of
  "spawn on remote node"  g++ ... -o somefile.o
  "on local node"  touch somefile.o

After a truckload of .o files have been generated, it will start
up link jobs, on other remote nodes.  I haven't tried this without
the touch trick for a long time.

Each g++ job takes from a few seconds to several minutes depending
on the file and optimization options etc.  I think I mainly see this
with the fast jobs...  Most .o files are ~1-4 MB and I have about 200
of them.

~200 compilers and ~12 linkers take about 4-5 minutes to complete on
the cluster of three dual machines and two-three single cpus.  Producing
about 1.5G of object code in total  (yes C++ symbols are HUGE).

So, the touch is _immediately_ after a compile completion.  But the
.o file has not been in use on any other machine than the one running
the compiler for hours or at least many minutes (a different compile).

I'll try this without the touch trick and see how things fare...

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
