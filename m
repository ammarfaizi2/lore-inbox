Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317292AbSFCGew>; Mon, 3 Jun 2002 02:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317293AbSFCGev>; Mon, 3 Jun 2002 02:34:51 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:14529 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317292AbSFCGet>;
	Mon, 3 Jun 2002 02:34:49 -0400
Date: Mon, 3 Jun 2002 16:24:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 orinoco.c __orinoco_ev_rx question
Message-ID: <20020603062418.GG6765@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020528160135.D24097@bigmac.e-technik.uni-dortmund.de> <20020529032822.GA16537@zax> <20020529090613.B28699@bigmac.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 09:06:13AM +0200, Wolfgang Wegner wrote:
> Hi David,
> On Wed, May 29, 2002 at 01:28:22PM +1000, David Gibson wrote:
> > No it doesn't have to be done in the interrupt handler, it could be
> > done in a bottom half.  However essentially every other network driver
> > does all the Rx work (up to netif_rx()) in the hard irq, so I'm
> > disinclined to do it otherwise.
> well, you have a point here.
> However, my observation shows that this blocks interrupts for quite a
> long time (800us, compared to the 700us which i remember being shouted
> at in another discussion some days ago), which is quite a lot. (IMHO)
> Furthermore, airo.c either has a faster way of doing so or the Cisco
> PCM-352 are faster by themselves. (Did not look into airo.c as close
> as orinoco.c...)

Yes, that is quite a long time.  How long does it take in the airo
driver?  If it's possible to speed up the orinoco.c interrupt handler,
rather than moving stuff into a BH I'd prefer to do that.

It's possible the Cisco cards are just faster, although I would have
thought it a bit unlikely, since I beleive the recent Cisco's are
based on the same MAC controller as the Lucent and Intersil cards (but
different firmware).

> It was just a question if it could be done.
> 
> I would like to try it, so another question (the rxfid stuff...):
> 
> Could I leave just getting the rxfid (rxfid = hermes_read_regn(hw, RXFID);)
> in the interrupt handler and let the bottom half process something like
> a list of FIDs filled by the interrupt handler, or is there any caveat
> in doing so? Would it be better (if at all possible) to leave reading
> in the head in the interrupt handler, such that the status could be
> evaluated and do just the copying of data (which i suspect to be the most
> time-consuming) from the bottom half?

Yes, it's possible.  It adds significant complexity though, so I'd
really prefer not to.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
