Return-Path: <linux-kernel-owner+w=401wt.eu-S932809AbXAKWyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932809AbXAKWyQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 17:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932812AbXAKWyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 17:54:15 -0500
Received: from smtp-out.google.com ([216.239.45.13]:29208 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932809AbXAKWyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 17:54:15 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=ocKMBkwCY2fbsXGCMQG9fUwFMidcWR4eKIj2IsN5IXabDJtH3ybAoNuQ7uDFX/2h0
	8sOzKHT69EG4YFEKcU7UQ==
Message-ID: <6599ad830701111453t62bec38cl9534263002f48a15@mail.gmail.com>
Date: Thu, 11 Jan 2007 14:53:55 -0800
From: "Paul Menage" <menage@google.com>
To: balbir@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 3/6] containers: Add generic multi-subsystem API to containers
Cc: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       serue@us.ibm.com, vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, mbligh@google.com,
       winget@google.com, containers@lists.osdl.org, devel@openvz.org
In-Reply-To: <45A50CA5.6070101@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222141442.753211763@menage.corp.google.com>
	 <20061222145216.574346828@menage.corp.google.com>
	 <45A50CA5.6070101@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/07, Balbir Singh <balbir@in.ibm.com> wrote:
> Paul Menage wrote:
> > +/* The set of hierarchies in use. Hierarchy 0 is the "dummy
> > + * container", reserved for the subsystems that are otherwise
> > + * unattached - it never has more than a single container, and all
> > + * tasks are part of that container. */
> > +
> > +static struct containerfs_root rootnode[CONFIG_MAX_CONTAINER_HIERARCHIES];
> > +
> > +/* dummytop is a shorthand for the dummy hierarchy's top container */
> > +#define dummytop (&rootnode[0].top_container)
> > +
>
> With these changes, is there a generic way to determine the root container
> for the hierarchy the subsystem is in? Calls to ->create() pass the dummytop
> container.

There are two places that the subsystem create() function is called -
the first is during the subsystem registration, to create the
subsystem state for the root container. That one passes in dummytop
since that is the container that all subsystems start attached to.

For clarification, the default (dummy) hierarchy is a placeholder for
subsystems that aren't bound to a hierarchy. It always contains
exactly one container (dummytop) and all processes are members of that
container. It isn't reference-counted, since it can never go away, and
it can never have any subcontainers.

When a real subcontainer is created (which must be after a subsystem
has been bound to a hierarchy via a filesystem mount), the new
subcontainer is passed in. From there you can follow the top_container
field in the subcontainer, which leads to the root of the hierarchy.

Andrew has suggested that I need to document this better :-)

Paul
