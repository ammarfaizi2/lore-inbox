Return-Path: <linux-kernel-owner+w=401wt.eu-S1751533AbXALAd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbXALAd5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 19:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbXALAd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 19:33:57 -0500
Received: from smtp-out.google.com ([216.239.45.13]:35544 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXALAd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 19:33:56 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=AZRiJcwIRDQoUIe6XUOBlgfFLuGmKwVecb7X3NZsbzJMOIWc1shP5SXmihDRijFvT
	gSkuUJN+sI02X6GXbRB7w==
Message-ID: <6599ad830701111633j2ae65807sad393d2dad44a260@mail.gmail.com>
Date: Thu, 11 Jan 2007 16:33:48 -0800
From: "Paul Menage" <menage@google.com>
To: balbir@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 4/6] containers: Simple CPU accounting container subsystem
Cc: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       serue@us.ibm.com, vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, mbligh@google.com,
       winget@google.com, containers@lists.osdl.org, devel@openvz.org
In-Reply-To: <45A4F675.3080503@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222141442.753211763@menage.corp.google.com>
	 <20061222145216.755437205@menage.corp.google.com>
	 <45A4F675.3080503@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/07, Balbir Singh <balbir@in.ibm.com> wrote:
>
> I have run into a problem running this patch on a powerpc box. Basically,
> the machine panics as soon as I mount the container filesystem with

This is a multi-processor system?

My guess is that it's a race in the subsystem API that I've been
meaning to deal with for some time - basically I've been using
(<foo>_subsys.subsys_id != -1) to indicate that <foo> is ready for
use, but there's a brief window during subsystem registration where
that's not actually true.

I'll add an "active" field in the container_subsys structure, which
isn't set until registration is completed, and subsystems should use
that instead. container_register_subsys() will set it just prior to
releasing callback_mutex, and cpu_acct.c (and other subsystems) will
check <foo>_subsys.active rather than (<foo>_subsys.subsys_id != -1)

> I am trying to figure out the reason for the panic and trying to find
> a fix. Since the introduction of whole hierarchy system, the debugging
> has gotten a bit harder and taking longer, hence I was wondering if you
> had any clues about the problem
>

Yes, the multi-hierarchy support does make the whole code a little
more complex - but people presented reasonable scenarios where a
single container tree for all resource controllers just wasn't
flexible enough.

Paul
