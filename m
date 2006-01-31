Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWAaPuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWAaPuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWAaPuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:50:16 -0500
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:36586 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750771AbWAaPuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:50:14 -0500
Date: Tue, 31 Jan 2006 10:50:12 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>,
       Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Fw: [PATCH 2.6.16-rc1-git4] accessfs: a permission managing
 filesystem
In-Reply-To: <20060130135315.47d08a28.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0601311013490.21823@excalibur.intercode>
References: <20060130135315.47d08a28.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can you please include this patch in -mm, to give it wider testing?
> 
> Accessfs is a permission managing filesystem. It allows to control
> access to system resources, based on file permissions.  It also
> includes two modules.  One module allows granting capabilities based
> on user-/groupid. The second module allows to grant access to lower
> numbered IP ports based on user-/groupid.

I don't think this code is suitable for mainline inclusion.

The kernel already a mechanism for implementing extended security 
models for networking in SELinux,  which is far more general and also 
provides a system-wide approach where all security-relevant objects and 
subjects and the interactions between them are controlled.

Also, I think capabilities are inherently problematic in that here, they 
introduce a mechanism for unbounded privilege escalation.  Your security 
model is granting privileges to non-root processes, but not then providing 
any means to contain these privileges.

There are also a lot of hard-coded uid==0 assumptions in userspace which 
will break badly once you start handing out privileges to uid!=0 
processes.  With SELinux we see a lot of these userspace assumptions, 
although, because SELinux is restrictive (i.e. only further restricts 
access), they do not lead to privilege escalation.

This scheme does not integrate well with SELinux, which will be able to 
reject access requests before accessfs sees them; while accessfs will be 
able to reject access requests that SELinux has already granted.  These 
mechanism are also not aware of each other from a policy point of view.

Rather than proliferating new security models in the kernel such as these, 
which tend to be fairly narrowly focused, I think it would be better to 
look at how SELinux (which itself is a general purpose security framework) 
can be adapted to the same or similar purpose.

In this case, aside from the permissive nature of your security model 
(i.e. granting permissions instead of just restricting them), it seems 
that accessfs is primarily a policy interface.   It may be possible to 
achieve something very similar by creating a highly abstracted interface 
to SELinux policy.  Most or even all of which I think could be done in 
userspace.


- James
-- 
James Morris
<jmorris@namei.org>
