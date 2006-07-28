Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWG1CdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWG1CdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 22:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWG1CdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 22:33:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:62147 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751286AbWG1CdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 22:33:09 -0400
From: Neil Brown <neilb@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Date: Fri, 28 Jul 2006 12:32:13 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17609.30509.387670.585340@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, Steve Dickson <SteveD@redhat.com>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 005 of 9] knfsd: Be more selective in which
	sockets lockd listens on.
In-Reply-To: message from J. Bruce Fields on Wednesday July 26
References: <20060725114207.21779.patches@notabene>
	<1060725015447.21957@suse.de>
	<20060726191714.GE31172@fieldses.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday July 26, bfields@fieldses.org wrote:
> On Tue, Jul 25, 2006 at 11:54:47AM +1000, NeilBrown wrote:
> > @@ -112,6 +114,7 @@ lockd(struct svc_rqst *rqstp)
> >  	 * Let our maker know we're running.
> >  	 */
> >  	nlmsvc_pid = current->pid;
> > +	nlmsvc_serv = serv;
> 
> Nitpick: any reason not to just get rid of the local variable "serv"
> after that?

Well... it is used two more times in that function.... but in both
those cases it isn't really needed because we pass it to a function that
also gets rqstp, serv is always rqstp->rq_server.  So there is room
for cleaning up there ... patch to follow.

> 
> > @@ -224,8 +259,10 @@ lockd_up(void)
> >  	/*
> >  	 * Check whether we're already up and running.
> >  	 */
> > -	if (nlmsvc_pid)
> > +	if (nlmsvc_pid) {
> > +		error = make_socks(nlmsvc_serv, proto);
> >  		goto out;
> 
> ...
> 
> > +	if ((error = make_socks(serv, proto)) < 0) {
> >  		if (warned++ == 0) 
> >  			printk(KERN_WARNING
> >  				"lockd_up: makesock failed, error=%d\n", error);
> 
> The warning is printk'ed a little inconsistently.  (If we care, maybe it
> should just go inside make_socks?)

So.  Do we care?  That's a hard one...  I guess we do.  I'll move the
message into make_socks.

> 
> By the way, why don't most callers use the error returned from
> lockd_up()?

Most?  I could 2 out of 5.
One of those is just getting an extra ref-count so it cannot fail.
The other - in nfsctl - is simply carelessness on my part.
I should fix that.... patch to follow.

However...
 One would expect that if lockd_up fails, a matching lockd_down
wouldn't be needed.  However nlmsvc_users is unconditionally
increased by lockd_up.  That's a worry.

 - The nfs client will only call lockd_down if lockd_up succeeded.
 - NFSD currently will call lockd_down either way.
 - The lockd reclaimer ignores the return value and always calls
    lockd_down.

So the most common usage is to always call lockd_down, but I cannot
help feeling that is wrong.  And 'fixing' the client code to do it
that way would make it very ugly....

Patch to follow :-)

> 
> > diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
> > --- .prev/fs/nfsd/nfssvc.c	2006-07-24 15:14:31.000000000 +1000
> > +++ ./fs/nfsd/nfssvc.c	2006-07-24 15:15:04.000000000 +1000
> > @@ -134,6 +134,9 @@ static int killsig = 0; /* signal that w
> >  static void nfsd_last_thread(struct svc_serv *serv)
> >  {
> >  	/* When last nfsd thread exits we need to do some clean-up */
> > +	struct svc_sock *svsk;
> > +	list_for_each_entry(svsk, &serv->sv_permsocks, sk_list)
> > +		lockd_down();
> 
> So I guess it's a minor point, but: we take the trouble to only open tcp
> or udp sockets as necessary, but then won't close them down till all the
> mounts and nfsd's go away at which point we close them all down.

I thought about making that cleaner but couldn't quite motivate myself
to do it.... and it can always be done later (?).

> 
> Would it be that bad just to always listen on both?

Some people seem to want to only listen on one.
Why?  Maybe a security thing?  
So once you have opened a protocol once, the "horse has bolted" and
closing it is no big deal?

dunno... any else go opinions on this?

Steve?

NeilBrown
