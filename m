Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVCBWJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVCBWJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVCBWHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:07:39 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:46682 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262468AbVCBWAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:00:02 -0500
Date: Thu, 3 Mar 2005 00:01:13 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Andrew Morton <akpm@osdl.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       myeatman@vale-housing.co.uk, linux-kernel@vger.kernel.org,
       gene.heskett@verizon.net
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29
In-Reply-To: <20050302132512.5853cd3b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0503022334280.9132@kai.makisara.local>
References: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B886@ratbert.vale-housing.co.uk>
 <20050302120332.GA27882@logos.cnet> <Pine.LNX.4.61.0503022253360.9132@kai.makisara.local>
 <20050302132512.5853cd3b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Andrew Morton wrote:

> Kai Makisara <Kai.Makisara@kolumbus.fi> wrote:
> >
> > > 
> >  > v2.6 also contains the same problem BTW.
> >  > 
> >  > Try this:
> >  > 
> >  > --- a/drivers/scsi/st.c.orig	2005-03-02 09:02:13.637158144 -0300
> >  > +++ b/drivers/scsi/st.c	2005-03-02 09:02:20.208159200 -0300
> >  > @@ -3778,7 +3778,6 @@
> >  >  	read:		st_read,
> >  >  	write:		st_write,
> >  >  	ioctl:		st_ioctl,
> >  > -	llseek:		no_llseek,
> >  >  	open:		st_open,
> >  >  	flush:		st_flush,
> >  >  	release:	st_release,
> > 
> >  This change covers up the problem. The real bug is in tar.
> 
> In that case we're kinda screwed, and should change the kernel to make tar
> work again.  We can send a bug report to the tar folks (good luck) and wait
> a few years.
> 
> >  The first BSF did position the tape correctly although it did fail.
> 
> (what's a BSF?)
> 
> If it positioned the tape successfully, why did it claim that it failed? 

BSF moves the tape backwards over filemarks. tar tries to move over one 
filemark. It does not find it because it ends to the beginning of the 
tape. This is why the operation fails. However, the tape is at the 
beginning and this is the correct place with regard to what is done next.

> If we were to fix that up, would tar then be happy?

It is not fixable in the kernel. The beginning of the tape is a special 
case because there is no filemark. Any application should take this into 
account. We could fake a filemark there but this would lead to problems 
because then we could "skip" backwards indefinitely even when the tape 
moves nowhere. This could confuse other applications.

If seek with tape is changed back to returning success, this would enable 
correct tar --verify at the beginning of the tape. However, I am not sure 
what happens if we are not at the beginning. I will investigate this and 
suggest a long term fix to the tar people (a fix that should be compatible 
with all Unix tape semantics I know) and also suggest possible fixes to st 
(this may include automatic writing of a filemark when BSF is used after 
writes).

If you think want to make st return success for seeks even if nothing 
happens (as it did earlier), I don't have anything against that. It would 
solve the practical problem several people have reported recently. (My 
recommendation for the people seeing this problem is to do verification 
separately with 'tar -d'.)

-- 
Kai
