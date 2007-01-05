Return-Path: <linux-kernel-owner+w=401wt.eu-S964820AbXAEA0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbXAEA0K (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 19:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbXAEA0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 19:26:10 -0500
Received: from smtp-out.google.com ([216.239.45.13]:61850 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964820AbXAEA0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 19:26:09 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=GPDpYVEoM+YSUTsVmWFBS456BBmzZROZsF+RlIH/AfMMICZms4jsVkwWZRh/kPrqp
	ixgT7UuVqC1zmpqMp49lQ==
Message-ID: <6599ad830701041625o165379c7y226095c6fe22a0b@mail.gmail.com>
Date: Thu, 4 Jan 2007 16:25:59 -0800
From: "Paul Menage" <menage@google.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH 0/6] containers: Generic Process Containers (V6)
Cc: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, devel@openvz.org,
       containers@lists.osdl.org, mbligh@google.com, winget@google.com,
       rohitseth@google.com, "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20070103144330.GA31951@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222141442.753211763@menage.corp.google.com>
	 <20070103144330.GA31951@sergelap.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On 1/3/07, Serge E. Hallyn <serue@us.ibm.com> wrote:
> From: Serge E. Hallyn <serue@us.ibm.com>
> Subject: [RFC] [PATCH 1/1] container: define a namespace container subsystem
>
> Here's a stab at a namespace container subsystem based on
> Paul Menage's containers patch, just to experiment with
> how semantics suit what we want.

Thanks for looking at this.

What you have here is the basic boilerplate for any generic container
subsystem. I realise that my current containers patch has some
incompatibilities with the way that nsproxy wants to work.

>
> A few things we'll want to address:
>
>         1. We'll want to be able to hook things like
>            rmdir, so that we can rm -rf /containers/vserver1
>            to kill all processes in that container and all
>            child containers.

The current model is that rmdir fails if there are any processes still
in the container; so you'd have to kill processes by looking for pids
in the "tasks" info file. This was behaviour inherited from the
cpusets code; I'd be open to making this more configurable (e.g.
specifying that rmdir should try to kill any remaining tasks).

>
>         2. We need a semantic difference between attaching
>            to a container, and being the first to join the
>            container you just created.

Right - the way to do this would probably be some kind of
"container_clone()" function that duplicates the properties of the
current container in a child, and immediately moves the current
process into that container.

>
>         3. We will want to be able to give the container
>            attach function more info, so that we can ask to
>            attach to just the network namespace, but none of
>            the others, in the container we're attaching to.

If you want to be able to attach to different namespaces separately,
then possibly they should be separate container subsystems?

Paul
