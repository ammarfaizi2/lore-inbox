Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270158AbRHGJ0p>; Tue, 7 Aug 2001 05:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270160AbRHGJ0f>; Tue, 7 Aug 2001 05:26:35 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:45327 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S270158AbRHGJ0W>; Tue, 7 Aug 2001 05:26:22 -0400
Date: Tue, 7 Aug 2001 10:26:13 +0100
From: Bob Dunlop <Bob.Dunlop@farsite.co.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Matt Schulkind <mschulkind@sbs.com>, linux-ppp@vger.kernel.org,
        paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: Syncppp
Message-ID: <20010807102613.A18724@farsite.co.uk>
In-Reply-To: <3810755D5165D2118F4400104B36917AC4FD34@normandy> <002f01c11eca$1db590f0$8119fea9@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002f01c11eca$1db590f0$8119fea9@diemos>; from paulkf@microgate.com on Mon, Aug 06, 2001 at 11:41:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug  6,  Paul Fulghum wrote:
> > In the 2.2.16 kernel, it seems that the ppp_device structure was changed to
> > use a pointer to the net device instead of haveing the structure contained
> > within, and the if_down procedure was changed accordingly to use the sppp_of
> > macro. But, if I take a look at the 2.4.x kernel sources, it seems only the
> > first change, the pointer vs. struct change was made, but the if_down
> > procedure was not changed. I believe this is a bug and the if_down procedure
> > in the 2.4.x kernel must be changed to match 2.2.16+. Could anyone confirm
> > this?
> > -Matt Schulkind
> 
> It looks like you are right. The current 2.4 code
> appears to scribble into the net_device structure
> someplace (yuck) when if_down() is called.

I agree it's a bug.
Well spotted!  How many times have I scrolled past that line?

On Intel (i386) it looks like it clobbers last_rx which is probably harmless,
but it's close to some hairy pointers so who knows on other architectures.
The fact that pp_link_state is not being reset could well explain how I was
getting into that negotiation loop problem earlier in the year.  The loop
fix is still a valid safety however.

> I'm going to change this and test it tomorrow to be
> for sure.

Well I've applied the obvious fix (below) and tested it on Intel with the
Farsync driver and all looks good.  Don't have access to other architectures
for any other testing.


--- linux/drivers/net/wan/syncppp.c.orig	Thu Jun 28 01:10:55 2001
+++ linux/drivers/net/wan/syncppp.c	Tue Aug  7 08:14:43 2001
@@ -156,7 +156,7 @@
 
 static void if_down(struct net_device *dev)
 {
-	struct sppp *sp = &((struct ppp_device *)dev)->sppp;
+	struct sppp *sp = (struct sppp *)sppp_of(dev);
 
 	sp->pp_link_state=SPPP_LINK_DOWN;
 }



-- 
        Bob Dunlop
        FarSite Communications Ltd.
        http://www.farsite.co.uk/
