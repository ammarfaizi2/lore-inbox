Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753754AbWKGWVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbWKGWVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756AbWKGWVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:21:36 -0500
Received: from smtp-out.google.com ([216.239.33.17]:18893 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1753745AbWKGWVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:21:35 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=E+PiDD4LmCd9/25ly7OIhQFDKVBWlAz27NBtxD89+MBQuj01ThiCNGIuuBTkRznoR
	wrP322kAYFLheZ5DI6vLA==
Message-ID: <6599ad830611071421s7792bbb1qd9c7b1fc840dfa50@mail.gmail.com>
Date: Tue, 7 Nov 2006 14:21:19 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030031531.8c671815.pj@sgi.com>
	 <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	 <20061031115342.GB9588@in.ibm.com>
	 <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	 <20061101172540.GA8904@in.ibm.com>
	 <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	 <20061106124948.GA3027@in.ibm.com>
	 <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	 <20061107104118.f02a1114.pj@sgi.com>
	 <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Paul Menage <menage@google.com> wrote:
> > Perhaps the interface to binding multiple controllers to a single container
> > hierarchy is via multiple mount commands, each of type 'container', with
> > different options specifying which controller(s) to bind.  Then the
> > command 'mount -t cpuset cpuset /dev/cpuset' gets remapped to the command
> > 'mount -t container -o controller=cpuset /dev/cpuset'.
>
> Yes, that's the aproach that I'm thinking of currently. It should
> require pretty reasonably robotic changes to the existing code.

One drawback to this that I can see is the following:

- suppose you mount a containerfs with controllers cpuset and cpu, and
create some nodes, and then unmount it, what happens? do the resource
nodes stick around still?

- suppose you then try to mount a containers with controllers cpuset
and diskio, but the resource nodes are still around, what happens
then?

Is there any way to prevent unmounting (at the dentry level) a busy filesystem?

If we enforced a completely separate hierarchy for each resource
controller (i.e. one resource controller per mount), then it wouldn't
be too hard to hang the node structure off the controller itself, and
there would never be a problem with mounting two controllers with
existing inconsistent hierarchies on the same mount. But that would
rule out being able to hook several resource controllers together in
the same container node.

One alternative to this would be to have a fixed number of container
hierarchies; at mount time you'd mount hierarchy N, and optionally
bind a set of resource controllers to it, or else use the existing
set. Then the hierarchy can be hung off the appropriate entry in the
hierarchy array even when the fs isn't mounted.

Paul
