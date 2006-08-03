Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWHCBWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWHCBWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 21:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWHCBWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 21:22:36 -0400
Received: from mail.suse.de ([195.135.220.2]:26316 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932123AbWHCBWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 21:22:35 -0400
From: Neil Brown <neilb@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Date: Thu, 3 Aug 2006 11:22:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17617.20431.425742.221648@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 000 of 4] knfsd: Introduction
In-Reply-To: message from J. Bruce Fields on Friday July 28
References: <20060728150606.29533.patches@notabene>
	<20060728211000.GA19563@fieldses.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 28, bfields@fieldses.org wrote:
> On Fri, Jul 28, 2006 at 03:09:40PM +1000, NeilBrown wrote:
> > Following are 4 patches for knfsd in 2.6-mm-latest.  They address some
> > issues found by Bruce Fields greatly appreciated patch review.  Thanks Bruce.
> > They (like the patches they build on) are *not* 2.6.18 material.
> 
> By the way, the one thing that looked to me like a real bug was the
> failure to do a lockd_down() when the user deletes a socket (comments
> resent below), which these patches don't seem to deal with.  Of course,
> it's entirely possible I just didn't understand something....
> 

Ofcourse, it is also entirely possible that you understand perfectly,
and that seems to be the case here.  If the svc_sock_names call in
write_ports returns success, we should do a 'lockd_down' - and make
sure it does return success only if the close succeeded.


> --b.
> 
> 
> On Tue, Jul 25, 2006 at 11:55:08AM +1000, NeilBrown wrote:
> > +		err = nfsd_create_serv();
> > +		if (!err) {
> > +			int proto = 0;
> > +			err = svc_addsock(nfsd_serv, fd, buf, &proto);
> > +			/* Decrease the count, but don't shutdown the
> > +			 * the service
> > +			 */
> > +			if (err >= 0)
> > +				lockd_up(proto);
> > +			nfsd_serv->sv_nrthreads--;
> ....
> > @@ -211,8 +211,6 @@ static inline int nfsd_create_serv(void)
> >  			       nfsd_last_thread);
> >  	if (nfsd_serv == NULL)
> >  		err = -ENOMEM;
> > -	else
> > -		nfsd_serv->sv_nrthreads++;
> 
> I don't understand these sv_nrthreads changes.
> 

The first is simply to counter the reference that was gained in
nfsd_create_serv. 

The second chunk (removing sv_nrthread++) is fixing a bug in an
earlier patch.  We never should have had that ++ there, as
'svc_create' created the object with a reference already.

Thanks,
NeilBrown
