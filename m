Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275214AbTHAMo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 08:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275216AbTHAMo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 08:44:26 -0400
Received: from host-64-179-20-100.man.choiceone.net ([64.179.20.100]:2565 "EHLO
	Odyssey.Home.4Dicksons.Org") by vger.kernel.org with ESMTP
	id S275214AbTHAMoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 08:44:22 -0400
Message-ID: <3F2A6087.3060801@RedHat.com>
Date: Fri, 01 Aug 2003 08:43:51 -0400
From: Steve Dickson <SteveD@RedHat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>,
       Chip Salzenberg <chip@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@RedHat.com>
Subject: Re: nfs-utils-1.0.5 is not backwards compatible with 2.4
References: <3F294DE3.9020304@RedHat.com> <16169.54918.472349.928145@gargle.gargle.HOWL>
In-Reply-To: <16169.54918.472349.928145@gargle.gargle.HOWL>
Content-Type: multipart/mixed;
 boundary="------------090601090606060000030302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090601090606060000030302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Neil Brown wrote:

>On Thursday July 31, SteveD@redhat.com wrote:
>  
>
>>Hey Neil,
>>
>>It seems in nfs-utils-1.05 (actually it happen in 1.0.4)
>>the NFSEXP_CROSSMNT define was changed to 0x4000 and the
>>NFSEXP_NOHIDE define (which is not supported in 2.4) took
>>over the 0x0200 bit.. This breaks backwards compatibly with
>>1.0.3 and the 2.4 kernels...
>>
>>So could please add this patch that simply switchs the bits
>>so NFSEXP_CROSSMNT stays the same and the new NFSEXP_NOHIDE define
>>gets the higher bit?
>>    
>>
>
>I'll tell you the full story and let you suggest what, if any, source
>code changes are really needed.
>
>Once upon a time (2.2 era) there was this export flag called
>NFSEXP_CROSSMNT and "crossmnt" which was un-implemented.  I guess it
>was a hang over from the user-space nfsd and was probably meant to say
>"mount points in this filesystem can be crossed".   But as there was
>no code and no documentation, one couldn't be sure. 
>
>In the kernel nfs server at the time, the concept of "crossmnt" was
>effectively unimplementable (due the the way the export table was set
>up and the way file handles were managed).
>A closely related concept was implementable.  This concept is given
>the name "nohide" in Irix and possibly others.  This is a flag set on
>the child filesystem (rather than the parent) and says that the child
>should not be 'hiden' when the mountpoint in the parent is accessed.
>
>So, I used the NFSEXP_CROSSMNT flag to implement nohide (it was one of
>my earliest nfsd patches I think) and told nfs-utils that it could use
>the name "nohide" to refer to this new flag.
>
>So for sometime, NFSEXP_CROSSMNT, "nohide", 0x0200 meant
>"this child filesystem should be visible from the parent".
>
>Possibly this was a mistake.  Possibly I should have used a different
>flag or at least changed the name, but I didn't.
>
>As part of the substatial rewrite that went into 2.6, it is possible
>to implement "crossmnt" type semantics sensibly.  When a mountpoint is
>'crossed' (by a LOOKUP operation) the kernel can ask user-space to
>provide export information for that filesystem and act according to
>the response. (This is not completely implemented in nfs-utils 1.0.5,
>though it should work to some extent.  I hope to figure out the
>remaining details and get it working before 1.1.0).
>
>So I needed a new flag, and chose 0x4000.  This flag can be set on the
>parent and says that all mount points should be crossed (if possible).
>
>The most obvious name for this flag was NFSEXP_CROSSMNT which was
>currently inuse as a misnomer for the nohide option.
>So I renamed the old NFSEXP_CROSSMNT to NFSEXP_NOHIDE, both in
>nfs-utils and in the kernel.
>I then added the new flags 0x4000 named NFSEXP_CROSSMNT with the
>textual representation "crossmnt".
>
>As far as I can tell, the only incompatability that this will cause is
>if some code outside of the kernel and outside of nfs-utils uses the
>header files from either the kernel or nfs-utils.  Such code will get
>a new value for NFSEXP_CROSSMNT if it changes it's header files.   I
>don't know if there is any such code, but if there is  I apoligise for
>breaking it and suggest that the best fix is to not use the header
>file it was using but it explicitly include the values for NFSEXP_* in
>that code.
>
>Let me know if there is some issue that this does not sufficiently
>clear up.
>
I see your point...  I guess I didn't realize that  the "nohide" option  
(that the user
sees) has been using the NFSEXP_CROSSMNT define this whole time....

And I also agree with you if somebody is directly using the bits instead of
the "nohide" ascii representation they are on there own since there is no
real export API per say....

But just to make the clean up complete, wouldn't the attached patch be
needed in the 2.4 kernel if  nfs-utils-1.0.5 was going to be used?

SteveD





--------------090601090606060000030302
Content-Type: text/plain;
 name="linux-2.4-nfsd-nohide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4-nfsd-nohide.patch"

--- linux-2.4/fs/nfsd/vfs.c.diff	2003-07-31 10:35:27.000000000 -0400
+++ linux-2.4/fs/nfsd/vfs.c	2003-08-01 08:32:06.000000000 -0400
@@ -82,7 +82,7 @@ static struct raparms *		raparm_cache;
  * N.B. After this call _both_ fhp and resfh need an fh_put
  *
  * If the lookup would cross a mountpoint, and the mounted filesystem
- * is exported to the client with NFSEXP_CROSSMNT, then the lookup is
+ * is exported to the client with NFSEXP_NOHIDE, then the lookup is
  * accepted as it stands and the mounted directory is
  * returned. Otherwise the covered directory is returned.
  * NOTE: this mountpoint crossing is not supported properly by all
@@ -116,7 +116,7 @@ nfsd_lookup(struct svc_rqst *rqstp, stru
 			dentry = dget(dparent);
 		else if (dparent != exp->ex_dentry)
 			dentry = dget(dparent->d_parent);
-		else if (!EX_CROSSMNT(exp))
+		else if (!EX_NOHIDE(exp))
 			dentry = dget(dparent); /* .. == . just like at / */
 		else {
 			/* checking mountpoint crossing is very different when stepping up */
--- linux-2.4/fs/nfsd/export.c.diff	2003-07-31 10:35:27.000000000 -0400
+++ linux-2.4/fs/nfsd/export.c	2003-08-01 08:27:27.000000000 -0400
@@ -640,7 +640,7 @@ struct flags {
 	{ NFSEXP_UIDMAP, {"uidmap", ""}},
 	{ NFSEXP_KERBEROS, { "kerberos", ""}},
 	{ NFSEXP_SUNSECURE, { "sunsecure", ""}},
-	{ NFSEXP_CROSSMNT, {"nohide", ""}},
+	{ NFSEXP_NOHIDE, {"nohide", ""}},
 	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
 	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
 #ifdef MSNFS
--- linux-2.4/include/linux/nfsd/export.h.diff	2003-07-31 10:36:23.000000000 -0400
+++ linux-2.4/include/linux/nfsd/export.h	2003-08-01 08:31:15.000000000 -0400
@@ -35,7 +35,7 @@
 #define NFSEXP_UIDMAP		0x0040
 #define NFSEXP_KERBEROS		0x0080		/* not available */
 #define NFSEXP_SUNSECURE	0x0100
-#define NFSEXP_CROSSMNT		0x0200
+#define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
 #define NFSEXP_MSNFS		0x1000	/* do silly things that MS clients expect */
@@ -80,7 +80,7 @@ struct svc_export {
 #define EX_SECURE(exp)		(!((exp)->ex_flags & NFSEXP_INSECURE_PORT))
 #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
 #define EX_RDONLY(exp)		((exp)->ex_flags & NFSEXP_READONLY)
-#define EX_CROSSMNT(exp)	((exp)->ex_flags & NFSEXP_CROSSMNT)
+#define EX_NOHIDE(exp)	((exp)->ex_flags & NFSEXP_NOHIDE)
 #define EX_SUNSECURE(exp)	((exp)->ex_flags & NFSEXP_SUNSECURE)
 #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
 

--------------090601090606060000030302--

