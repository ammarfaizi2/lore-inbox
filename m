Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757387AbWKWPCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387AbWKWPCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 10:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757388AbWKWPCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 10:02:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51589 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757387AbWKWPCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 10:02:32 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061122132008.2691bd9d.akpm@osdl.org> 
References: <20061122132008.2691bd9d.akpm@osdl.org>  <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] WorkStruct: Shrink work_struct by two thirds 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 23 Nov 2006 14:59:32 +0000
Message-ID: <10039.1164293972@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> waaaaaaaay too many rejects for me, sorry.  This is quite the worst time in
> the kernel cycle to be preparing patches like this.  Especially when they're
> against mainline when everyone has so much material pending.

Actually... there is a way to do this sort of incrementally, I think:

 (1) Turn this sort of thing:

	do_work(struct x *x)
	{
		...
	}

	queue_x(struct x *x)
	{
		INIT_WORK(&x->work, do_work, x);
		schedule_work(&x->work)
	}

    Into this sort of thing:

	#define DECLARE_IMMEDIATE_WORK(w, f) DECLARE_WORK((w), (f), (w))
	#define DECLARE_DELAYED_WORK(w, f) DECLARE_WORK((w), (f), (w))
	#define INIT_IMMEDIATE_WORK(w, f) INIT_WORK((w), (f), (w))
	#define INIT_DELAYED_WORK(w, f) INIT_WORK((w), (f), (w))

	do_work(struct work_struct *work)
	{
		struct x *x = container_of(work, struct x, work);
		...
	}

	queue_x(struct x *x)
	{
		INIT_IMMEDIATE_WORK(&x->work, do_work); //or
		INIT_DELAYED_WORK(&x->work, do_work);
		schedule_work(&x->work)
	}

 (2) Make delayed_work equivalent to work_struct:

	#define delayed_work work_struct

 (3) Then apply the rest of the patches such that they remove the #defines as
     appropriate.

Might that help?

David
