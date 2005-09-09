Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbVIIEMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbVIIEMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 00:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbVIIEMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 00:12:13 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:30168 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965248AbVIIEML convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 00:12:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BwETPN7edvxcQcqr7vxPE+msu318u29Z+7XZbA6dYKBAbgnA9M51NGSsSsqmDNAanUlDYbBKCe7YY9hIK4uCVhKUAPYqiSyVqaHnBMdj+vFu/hyvonGs+4DxcUsCIT2Vfgh8I8RpJufocAFl23n2KOdbwpg3DqbB1CRgDSi8t40=
Message-ID: <aec7e5c305090821126cea6b57@mail.gmail.com>
Date: Fri, 9 Sep 2005 13:12:08 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: magnus.damm@gmail.com
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using CPUSETS
Cc: Paul Jackson <pj@sgi.com>, dino@in.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050909013804.1B64B70037@sv1.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050908053912.1352770031@sv1.valinux.co.jp>
	 <20050908002323.181fd7d5.pj@sgi.com>
	 <20050908081819.2EA4E70031@sv1.valinux.co.jp>
	 <20050908050232.3681cf0c.pj@sgi.com>
	 <20050909013804.1B64B70037@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, KUROSAWA Takahiro <kurosawa@valinux.co.jp> wrote:
> On Thu, 8 Sep 2005 05:02:32 -0700
> Paul Jackson <pj@sgi.com> wrote:
> > One of my passions is to avoid special cases across API boundaries.
> >
> > I am proposing that you don't do subcpusets like this.
> >
> > Consider the following alternative I will call 'cpuset meters'.
> >
> > For each resource named 'R' (cpu and mem, for instance):
> >  * Add a boolean flag 'meter_R' to each cpuset.  If set, that R is
> >    metered, for the tasks in that cpuset or any descendent cpuset.
> >  * If a cpuset is metered, then files named meter_R_guar, meter_R_lim
> >    and meter_R_cur appear in that cpuset to manage R's usage by tasks
> >    in that cpuset and descendents.
> >  * There are no additional rules that restrict the ability to change
> >    various other cpuset properties such as cpus, mems, cpu_exclusive,
> >    mem_exclusive, or notify_on_release, when a cpuset is metered.
> >  * It might be that some (or by design all) resource controllers do
> >    not allow nesting metered cpusets.  I don't know.  But one should
> >    (if one has permission) be able to make child cpusets of a metered
> >    cpuset, just like one can of any other cpuset.
> >  * A metered cpuset might well have cpus or mems that are not the
> >    same as its parent, just like an unmetered cpuset ordinarly does.
> 
> Jackson-san's idea looks good for me because users don't need
> to create special cpusets (parents of subcpusets or subcpusets).
> From the point of users, maybe they wouldn't like to create
> special cpusets.

Yes, from the user POV it must be good to keep the hierarchical model.
Ckrm and cpusets both provide a tree with descendents, children and
parents. This hierarchical model is very nice IMO and provides a
powerful API for the user.

> As for the resource controller that I've posted, it assumes
> that there are groups of tasks that share the same cpumasks/nodemasks,
> and that there are no hierarchy in that groups in order to make
> things easier.  I'll investigate how I can attach the resource
> controller to the cpuset meters.

Subcpusets, compared to cpusets and ckrm, gives the user a flat model.
No hierarchy. Limited functionality compared to the hierachical model.

But what I think is important to keep in mind here is that cpusets and
subcpusets do very different things. If I understand cpusets
correctly, each cpuset may share processors or memory nodes with other
cpusets. One task running on a shared processor may starve other
cpusets using the same processor. This design works well with cpusets,
but for resource controllers that must provide some kind of guarantee,
this starvation is unsuitable.

And we already have an hierarchical alternative: ckrm. But look at the
complexity and the amount of code. I believe that the complexity in
ckrm mainly comes from the hierarchical model.

Maybe it is possible to have an hierarchical model and keep the
framework simple and easy to understand while providing guarantees,
I'm not sure. But until that happens, I'm quite happy with a simple,
limited flat model.

/ magnus
