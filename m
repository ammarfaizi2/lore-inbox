Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTLDDbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 22:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTLDDbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 22:31:13 -0500
Received: from c06284a.rny.bostream.se ([217.215.27.171]:37390 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S261837AbTLDDbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 22:31:10 -0500
From: Fredrik Tolf <fredrik@dolda2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16334.43636.708395.686430@pc7.dolda2000.com>
Date: Thu, 4 Dec 2003 04:31:00 +0100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Fredrik Tolf <fredrik@dolda2000.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 nfsd troubles - stale filehandles
In-Reply-To: <16334.42631.400677.325907@notabene.cse.unsw.edu.au>
References: <16325.11418.646482.223946@pc7.dolda2000.com>
	<16325.14967.248703.483363@notabene.cse.unsw.edu.au>
	<16326.253.163939.9953@pc7.dolda2000.com>
	<16333.11722.151279.490037@pc7.dolda2000.com>
	<16334.42631.400677.325907@notabene.cse.unsw.edu.au>
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
 > On Wednesday December 3, fredrik@dolda2000.com wrote:
 > > 
 > > So, I managed to do it now. The strange thing is, I had created an
 > > extra share of the home dirs for this test (I had "mount --bind"'ed it
 > > on /var/lib/nfs/nfstest), and only set subtree_check back on the test
 > > export, in an attempt to keep the normal parts of the system reliable
 > > while testing, but just doing that made the real export behave bad as
 > > well. It seems to run amok as soon as I have subtree_checking on only
 > > one export.
 > 
 > "mount --bind" certainly has a good chance of confusing nfsd.
 > If you --bind mount the root of the filesystem somewhere else and
 > export that, then the filehandles generated will be exactly the same
 > and nfsd cannot know whether a request is indented for one mountpoint
 > or the other.
 > When using --bind, it is best to give an 'fsid=' option in
 > /etc/exports so that nfsd can use that to differentiate the mount
 > points.

Oh, I see. Now that you mention it, it does quite much make sense, I
have to admit.

 > > 
 > > nfsd_dispatch: vers 3 proc 1 
 > > nfsd: GETATTR(3)  36: 06000001 0000fe00 00000002 00023b44 00023957 00000000 
 > > nfsd: fh_verify(36: 06000001 0000fe00 00000002 00023b44 00023957 00000000) 
 > > nfsd_acceptable failed at c669a5c0 dc 
 > 
 > This strongly suggests that nfsd thought that the user making the
 > request didn't have 'x' access to the parent of 'dc'. i.e. to /hannes.

That's what I thought too, but I could not figure out why.

 > > 
 > > Some more info: I was root while causing this error, and the dir arch
 > > looks like this (from this filesystem's point of view, it is really my
 > > home dirs):
 > > 
 > > rwxr-xr-x  root   root  /
 > > rwx--x---+ hannes users /hannes
 > > rwxr-xr-x  hannes users /hannes/dc
 > 
 > And if you are not exporting with no_root_squash, then the user does
 > not have 'x' access to hannes.
 > 
 > So if you haven't exported with 'no_root_squash', then this completely
 > makes sense. The nfs client is allowing root access (based on cached
 > data that some other local users recently accessed) but the server is
 > not allowing root access. 
 > Arguably you should be getting "permission denied" rather than
 > "stale", but you certainly shouldn't expect it to work.
 >
 > If, on the other hand, you have specified no_root_squash, then this is
 > still very strange.
 > 
 > What export options are you using?

I'm sorry for not clarifying that immediately. The entire export line
goes like this:

/home 192.168.0.0/16(sync,rw,no_root_squash,subtree_check)

So as you can see, I am indeed using no_root_squash, which is exactly
why I thought it was so strange. I did take a look at nfsd_acceptable,
and I just couldn't understand it (I understood the code, but I
couldn't understand how it could fail).

FYI, I'm currently using ReiserFS with ACL patches on this filesystem,
but before that I was using ReiserFS without ACL, and before that I
was using XFS, and these errors have been there all the time. At first
I thought the errors were because of XFS, and therefore I switched to
ReiserFS, but that didn't stop it from happening.

Fredrik Tolf

