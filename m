Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVD0UBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVD0UBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 16:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVD0UBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 16:01:08 -0400
Received: from smtp.istop.com ([66.11.167.126]:22671 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261991AbVD0UAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 16:00:34 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 0/7] dlm: overview
Date: Wed, 27 Apr 2005 16:00:57 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20050425151136.GA6826@redhat.com> <200504260130.17016.phillips@istop.com> <20050427135635.GA4431@marowsky-bree.de>
In-Reply-To: <20050427135635.GA4431@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504271600.57993.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 April 2005 09:56, Lars Marowsky-Bree wrote:
> An 11-parameter function, frankly, more often than not indicates that
> the interface is wrong. I know it's inherited from VMS, which is a
> perfectly legitimate reason, but I assume it might get cleaned / broken
> up in the future.

To put things in concrete terms, here it is:

int dlm_ls_lock( 
   /*1*/  dlm_lshandle_t lockspace,
   /*2*/  uint32_t mode,
   /*3*/  struct dlm_lksb *lksb,
   /*4*/  uint32_t flags,
   /*5*/  void *name,
   /*6*/  unsigned int namelen,
   /*7*/  uint32_t parent,
   /*8*/  void (*ast) (void *astarg),
   /*9*/  void *astarg,
   /*10*/ void (*bast) (void *astarg),
   /*11*/ struct dlm_range *range);

> Questions which need to be settled, or which the API at least needs to
> export so we know what is expected from us:
>
> - How do the node ids look like? Are they sparse integers, continuous
>   ints, uuids, IPv4 or IPv6 address of the 'primary' IP of a node,
>   hostnames...?

32 bit integers at the moment.  I hope it stays that way.

> - How are the communication links configured? How to tell it which
>   interfaces to use for IP, for example?

CMAN provides a PF_CLUSTER.  This facility seems cool, but I haven't got much 
experience with it, and certainly not enough to know if PF_CLUSTER is really 
necessary, or should be put forth as a required component of the common 
infrastructure.  It is not clear to me that SCTP can't be used directly, 
perhaps with some library support.

> - How do we actually deliver the membership events -
>   echo "current node list" >/sys/cluster/gfs/membership
>   or...?

This is rather nice: event messages are delivered over a socket.  The specific 
form of the messages sucks somewhat, as do the wrappers provided.  These need 
some public pondering.

> - What kind of semantics are expected: Can we deliver the membership
>   events as they come, do we need to introduce suspend/resume barriers
>   etc?

Suspend/resume barriers take the form of a simple message protocol, 
administered by CMAN.

> - How to security credentials play into this, and where are they
>   enforced - so that a user-space app doesn't mess with kernel locks?

Security?  What is that?  (Too late for me to win that dinner now...)
Security is currently provided by restricting socket access to root.

> Maybe initially we'll end up with those being "exported" in
> Documentation/{OCFS2,GFS}-DLM/ files, but ultimately it'd be nice if
> user-space could auto-discover them and do the right thing w/a minimum
> amount of configuration.

Yes.  For the next month or two it should be ambitious enough just to ensure 
that the interfaces are simple, sane, and known to satisfy the base 
requirements of everybody with existing cluster code to contribute.  And 
automagic aspects are also worth discussing, just to be sure we don't set up 
roadblocks to that kind of improvement in the future.  I don't think we need 
too much automagic just now, though.

> Or maybe these will be abstracted by user-space wrapper libraries, and
> everybody does in the kernel what they deem best.

I _hope_ that we can arrive at a base membership infrastructure that is 
convenient to use either from kernel or user space.  User space libraries 
already exist, but with warts of various sizes.

Regards,

Daniel
