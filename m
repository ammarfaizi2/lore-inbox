Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVGMGbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVGMGbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 02:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVGMGbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 02:31:16 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:11412 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262505AbVGMGbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 02:31:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=h7QrAR6vIjuR3bNSjtniPzJa8U5/4/zUhkYbilRP1UoAB2o17dO9d+kwYw6xuYtNR2qFVUBY5elimAqdoyZkIDULEFzTLfRubpyUOOC+nlw+xOWSSLutK9XIwVIc8PUAFsbxz8Lza6gHXydQeIml+syC1M6CMzzCAPs1lzpZquo=
Date: Wed, 13 Jul 2005 07:29:55 +0100
From: Nicholas Hans Simmonds <nhstux@gmail.com>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, "Andrew G. Morgan" <morgan@transmeta.com>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Filesystem capabilities support
Message-ID: <20050713062955.GA1609@laptop>
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

Sorry, my earlier reply seems to have gotten lost somewhere. I've been
pondering this issue for some time and am still not sure what's the best
answer. I've attached a small patch which handles this by detecting byte
swapping of the version code. I'm not convinced it's necessary but
shouldn't hurt.

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
