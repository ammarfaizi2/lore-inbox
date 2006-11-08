Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754304AbWKHFcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbWKHFcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754306AbWKHFcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:32:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:56788 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1754297AbWKHFcc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:32:32 -0500
Date: Tue, 7 Nov 2006 23:32:29 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       chris friedhoff <chris@friedhoff.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] security: introduce file posix caps
Message-ID: <20061108053229.GA23210@sergelap.austin.ibm.com>
References: <20061107034550.GA13693@sergelap.austin.ibm.com> <20061107215444.GO30208@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061107215444.GO30208@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Seth Arnold (seth.arnold@suse.de):
> On Mon, Nov 06, 2006 at 09:45:50PM -0600, Serge E. Hallyn wrote:
> >  #define CAP_AUDIT_CONTROL    30
> >  
> > +#define CAP_NUMCAPS	     31
> 
> [...]
> 
> > +struct vfs_cap_data_struct {
> > +	__u32 version;
> > +	__u32 effective;
> > +	__u32 permitted;
> > +	__u32 inheritable;
> > +};
> 
> [...]
> 
> > +static int check_cap_sanity(struct vfs_cap_data_struct *cap)
> > +{
> > +	int i;
> > +
> > +	if (cap->version != _LINUX_CAPABILITY_VERSION)
> > +		return -EPERM;
> > +
> > +	for (i=CAP_NUMCAPS; i<sizeof(cap->effective); i++) {
> > +		if (cap->effective & CAP_TO_MASK(i))
> > +			return -EPERM;
> > +	}
> > +	for (i=CAP_NUMCAPS; i<sizeof(cap->permitted); i++) {
> > +		if (cap->permitted & CAP_TO_MASK(i))
> > +			return -EPERM;
> > +	}
> > +	for (i=CAP_NUMCAPS; i<sizeof(cap->inheritable); i++) {
> > +		if (cap->inheritable & CAP_TO_MASK(i))
> > +			return -EPERM;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> for (i=31; i<4; i++) ...
> 
> I'm not sure this checks what you think it checks? :)

Thanks again for catching this.  Here is the obvious patch.  Hopefully
I have it right this time.

>From b91c46589b13bab78ddf431245a7ecbd59bcf2fd Mon Sep 17 00:00:00 2001
From: Serge E. Hallyn <serue@us.ibm.com>
Date: Tue, 7 Nov 2006 23:16:06 -0600
Subject: [PATCH 1/1] fscaps: fix cap sanity check

When checking for valid capabilities on files, we want to
make sure that unused bits are not set.  Fix the calculation
of the highest bit checked.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 security/commoncap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 6a0d033..6f5e46c 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -133,15 +133,15 @@ static int check_cap_sanity(struct vfs_c
 	if (cap->version != _LINUX_CAPABILITY_VERSION)
 		return -EPERM;
 
-	for (i=CAP_NUMCAPS; i<sizeof(cap->effective); i++) {
+	for (i=CAP_NUMCAPS; i<8*sizeof(cap->effective); i++) {
 		if (cap->effective & CAP_TO_MASK(i))
 			return -EPERM;
 	}
-	for (i=CAP_NUMCAPS; i<sizeof(cap->permitted); i++) {
+	for (i=CAP_NUMCAPS; i<8*sizeof(cap->permitted); i++) {
 		if (cap->permitted & CAP_TO_MASK(i))
 			return -EPERM;
 	}
-	for (i=CAP_NUMCAPS; i<sizeof(cap->inheritable); i++) {
+	for (i=CAP_NUMCAPS; i<8*sizeof(cap->inheritable); i++) {
 		if (cap->inheritable & CAP_TO_MASK(i))
 			return -EPERM;
 	}
-- 
1.4.3.3

