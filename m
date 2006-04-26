Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWDZTIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWDZTIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWDZTIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:08:50 -0400
Received: from smtpout.mac.com ([17.250.248.174]:4077 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964834AbWDZTIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:08:48 -0400
In-Reply-To: <444F6FDD.7040000@etpmod.phys.tue.nl>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain> <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com> <1146038324.5956.0.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI> <1146040038.7016.0.camel@laptopd505.fenrus.org> <20060426100559.GC29108@wohnheim.fh-wedel.de> <1146046118.7016.5.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI> <1146049414.7016.9.camel@laptopd505.fenrus.org> <20060426110656.GD29108@wohnheim.fh-wedel.de> <444F5B74.60809@etpmod.phys.tue.nl> <444F6FDD.7040000@etpmod.phys.tue.nl>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CB27C57D-BABF-4900-9299-F342861CF1E0@mac.com>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
Date: Wed, 26 Apr 2006 15:07:28 -0400
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's code that I've found works as well as can be expected under  
both GCC 3 and GCC 4.  If xp is a known-NULL constant the whole  
function will be optimized out completely.  If xp is known-not-NULL,  
then it will optimize to a kfree function without the null check.   
Otherwise it optimizes to call the out-of-line version.

Cheers,
Kyle Moffett

static inline void kfree(void *ptr)
{
	if (__builtin_constant_p((ptr == NULL))) {
		if (ptr)
			kfree_nonnull(ptr);
	} else {
		kfree_unknown(ptr);
	}
}

void kfree_nonnull(void *ptr)
{
	/* kfree code here, no null check */
}

void kfree_unknown(void *ptr)
{
	if (ptr)
		kfree_nonnull(ptr);
}

