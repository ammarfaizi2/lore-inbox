Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWD0IR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWD0IR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWD0IR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:17:58 -0400
Received: from mailhost.tue.nl ([131.155.3.8]:39113 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S964974AbWD0IR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:17:57 -0400
Message-ID: <44507E2E.90101@etpmod.phys.tue.nl>
Date: Thu, 27 Apr 2006 10:17:50 +0200
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain> <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com> <1146038324.5956.0.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI> <1146040038.7016.0.camel@laptopd505.fenrus.org> <20060426100559.GC29108@wohnheim.fh-wedel.de> <1146046118.7016.5.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI> <1146049414.7016.9.camel@laptopd505.fenrus.org> <20060426110656.GD29108@wohnheim.fh-wedel.de> <444F5B74.60809@etpmod.phys.tue.nl> <444F6FDD.7040000@etpmod.phys.tue.nl> <CB27C57D-BABF-4900-9299-F342861CF1E0@mac.com>
In-Reply-To: <CB27C57D-BABF-4900-9299-F342861CF1E0@mac.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> Here's code that I've found works as well as can be expected under both
> GCC 3 and GCC 4.  If xp is a known-NULL constant the whole function will
> be optimized out completely.  If xp is known-not-NULL, then it will
> optimize to a kfree function without the null check.  Otherwise it
> optimizes to call the out-of-line version.
> 
> Cheers,
> Kyle Moffett
> 
> static inline void kfree(void *ptr)
> {
>     if (__builtin_constant_p((ptr == NULL))) {
>         if (ptr)
>             kfree_nonnull(ptr);
>     } else {
>         kfree_unknown(ptr);
>     }
> }
> 
> void kfree_nonnull(void *ptr)
> {
>     /* kfree code here, no null check */
> }
> 
> void kfree_unknown(void *ptr)
> {
>     if (ptr)
>         kfree_nonnull(ptr);
> }

I still think there is an inconsistency in gcc. If I call your kfree
with the following:

void test( char *ptr )
{
        char *null = NULL;
        kfree(ptr);	/* unknown */
        *ptr = 'a';
        kfree(ptr);	/* nonnull */
        kfree(null);	/* should be optimised away */
}

,the compiler (4.1) generates two calls to kfree_unknown instead of one
to kfree_nonnull and one to kfree_unknown. It seems that the
__builtin_constant_p((ptr==NULL)) check does not always trigger, even if
the compiler 'knows' ptr to be equal to NULL. I posted a nasty hack
around this problem yesterday.

Groeten,
Bart

-- 
Bart Hartgers - TUE Eindhoven - http://plasimo.phys.tue.nl/bart/contact/
