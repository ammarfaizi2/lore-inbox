Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTLDDOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 22:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTLDDOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 22:14:33 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:23231 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261775AbTLDDO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 22:14:26 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Fredrik Tolf <fredrik@dolda2000.com>
Date: Thu, 4 Dec 2003 14:14:15 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16334.42631.400677.325907@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 nfsd troubles - stale filehandles
In-Reply-To: message from Fredrik Tolf on Wednesday December 3
References: <16325.11418.646482.223946@pc7.dolda2000.com>
	<16325.14967.248703.483363@notabene.cse.unsw.edu.au>
	<16326.253.163939.9953@pc7.dolda2000.com>
	<16333.11722.151279.490037@pc7.dolda2000.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday December 3, fredrik@dolda2000.com wrote:
> 
> So, I managed to do it now. The strange thing is, I had created an
> extra share of the home dirs for this test (I had "mount --bind"'ed it
> on /var/lib/nfs/nfstest), and only set subtree_check back on the test
> export, in an attempt to keep the normal parts of the system reliable
> while testing, but just doing that made the real export behave bad as
> well. It seems to run amok as soon as I have subtree_checking on only
> one export.

"mount --bind" certainly has a good chance of confusing nfsd.
If you --bind mount the root of the filesystem somewhere else and
export that, then the filehandles generated will be exactly the same
and nfsd cannot know whether a request is indented for one mountpoint
or the other.
When using --bind, it is best to give an 'fsid=' option in
/etc/exports so that nfsd can use that to differentiate the mount
points.

> 
> nfsd_dispatch: vers 3 proc 1 
> nfsd: GETATTR(3)  36: 06000001 0000fe00 00000002 00023b44 00023957 00000000 
> nfsd: fh_verify(36: 06000001 0000fe00 00000002 00023b44 00023957 00000000) 
> nfsd_acceptable failed at c669a5c0 dc 

This strongly suggests that nfsd thought that the user making the
request didn't have 'x' access to the parent of 'dc'. i.e. to /hannes.

> 
> Some more info: I was root while causing this error, and the dir arch
> looks like this (from this filesystem's point of view, it is really my
> home dirs):
> 
> rwxr-xr-x  root   root  /
> rwx--x---+ hannes users /hannes
> rwxr-xr-x  hannes users /hannes/dc

And if you are not exporting with no_root_squash, then the user does
not have 'x' access to hannes.

So if you haven't exported with 'no_root_squash', then this completely
makes sense. The nfs client is allowing root access (based on cached
data that some other local users recently accessed) but the server is
not allowing root access. 
Arguably you should be getting "permission denied" rather than
"stale", but you certainly shouldn't expect it to work.

If, on the other hand, you have specified no_root_squash, then this is
still very strange.

What export options are you using?

NeilBrown

