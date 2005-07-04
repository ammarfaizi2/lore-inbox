Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVGHBWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVGHBWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 21:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVGHBWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 21:22:12 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:2359 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261180AbVGHBWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 21:22:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=M2gfF5YUnZsS5NVY9/UZQTf3JYU7a5XAkK1lIFu0mxbjI7lck0NFwhvIHml82LMR5YCyluzDeO4+7CYKUsWOB7Z3zaSDK9teYfvWft5bATmEnm1D9EmCq2npw3xgu92PYTBUG8QV4QoYN7Jo0+ixZVNHeI40QNfXJa/Vz3bxp5o=
Date: Mon, 4 Jul 2005 15:27:58 +0100
From: Nicholas Hans Simmonds <nhstux@gmail.com>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, "Andrew G. Morgan" <morgan@transmeta.com>
Subject: Re: [PATCH] Filesystem capabilities support
Message-ID: <20050704142758.GA24851@laptop>
References: <20050702214108.GA755@laptop> <20050706045652.GB1773@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706045652.GB1773@frodo>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 02:56:52PM +1000, Nathan Scott wrote:
> Hi Nicholas,
> 
> On Sat, Jul 02, 2005 at 10:41:08PM +0100, Nicholas Hans Simmonds wrote:
> > This is a simple attempt at providing capability support through extended
> > attributes.
> > ...
> > +#define XATTR_CAP_SET XATTR_SECURITY_PREFIX "cap_set"
> > ...
> > +	ret = bprm_getxattr(bprm_dentry,XATTR_CAP_SET,&caps,sizeof(caps));
> > +	if(ret == sizeof(caps)) {
> > +		if(caps.version == _LINUX_CAPABILITY_VERSION) {
> > +			cap_t(bprm->cap_effective) &= caps.mask_effective;
> > ...
> 
> Since this is being stored on-disk, you may want to consider
> endianness issues.  I guess for binaries this isn't really a
> problem (since they're unlikely to be run on other platforms),
> though perhaps it is for shell scripts and the like.  Storing
> values in native endianness poses problems for backup/restore
> programs, NFS, etc.
> 
> IIRC, the other LSM security attribute values are stored as
> ASCII strings on-disk to avoid this sort of issue.
> 
> cheers.
> 
> -- 
> Nathan

Indeed. I've been thinking about this for some time, trying to determine
whether it's worth worrying about (if it's byte swapped then the version
code won't match) however you rightly point out the issue off shell
scripts. To that end I've cooked up a tiny patch which applies on top of
the previous one and will detect a byte swapped version code. My
preference for this over just using (for example) a big endian structure
is that it keeps the userspace side of things simple (no need to worry
about endianness there) however as I say I'm still not sure whether this
is the right way to deal with the problem.

diff --git a/security/commoncap.c b/security/commoncap.c
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -153,6 +153,15 @@ int cap_bprm_set_security (struct linux_
 	down(&bprm_dentry->d_inode->i_sem);
 	ret = bprm_getxattr(bprm_dentry,XATTR_CAP_SET,&caps,sizeof(caps));
 	if(ret == sizeof(caps)) {
+		if(caps.version = swab32(_LINUX_CAPABILITY_VERSION)) {
+			swab32s(&caps.version);
+			swab32s(&caps.effective);
+			swab32s(&caps.mask_effective);
+			swab32s(&caps.permitted);
+			swab32s(&caps.mask_permitted);
+			swab32s(&caps.inheritable);
+			swab32s(&caps.mask_inheritable);
+		}
 		if(caps.version == _LINUX_CAPABILITY_VERSION) {
 			cap_t(bprm->cap_effective) &= caps.mask_effective;
 			cap_t(bprm->cap_effective) |= caps.effective;
