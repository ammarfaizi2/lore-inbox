Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVFUVAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVFUVAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVFUU7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:59:03 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:64166 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262344AbVFUUwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:52:43 -0400
Date: Tue, 21 Jun 2005 14:52:38 -0600 (MDT)
From: "Ronald G. Minnich" <rminnich@lanl.gov>
To: linux-kernel@vger.kernel.org
cc: Eric Van Hensbergen <ericvh@gmail.com>
Subject: Re: Fwd: v9fs (-mm -> 2.6.13 merge status)
In-Reply-To: <a4e6962a05062112206e823c0a@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0506211352060.21978@enigma.lanl.gov>
References: <20050620235458.5b437274.akpm@osdl.org>  <a4e6962a05062106515757849d@mail.gmail.com>
 <a4e6962a05062112206e823c0a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Jun 2005, Eric Van Hensbergen wrote:

> On 6/21/05, Andrew Morton <akpm@osdl.org> wrote:
> >
> > v9fs
> >
> >     I'm not sure that this has a sufficiently high
> >     usefulness-to-maintenance-cost ratio.
> >

I got pointed at this discussion. Here are my $.02 on why we at LANL are
interested in v9fs.

We build clusters on the order of 2000 machines at present, with larger 
systems coming along. The system which we use to run these clusters is 
bproc. While bproc has proven to be very powerful to date, it does have 
its limits:
- requires homogenous system
- the network protocols it uses, while simple, are somewhat ad-hoc 
  (as is common in this type of system)
- if you are on a bproc system as user x, using 25% of the system, 
  you still see 100% of the processes. This is a bit of a security issue. 

We have a desire to build single-system-image looking clusters along the 
bproc model, but at the same time compose those clusters of, e.g., 
Opterons and G5s. This mixing is highly desirable for compoutations that 
have phases, some of which belong on one type of a machine, and some on 
another. 

We are going to use v9fs as the glue for our next-generation cluster 
software, called 'xcpu'. Xcpu has been implemented on Plan 9 and works 
there. I have ported xcpu to Linux, using v9fs as the client side and Russ 
Cox's plan9ports server to write servers. 

xcpu presents a remote execution service as a 9p server. xcpu has been
tested across architectures and it works very well. By summer 2006, we
hope to have cut over our bproc systems to xcpu.

That's one use for v9fs. We also plan to use v9fs to provide us with 
servers for global /proc, monitoring, and control systems for our 
clusters. 

The global /proc is interesting. bproc provides a global /proc, but it is 
incomplete; entries for, e.g., exe and maps are not filled in. bproc also 
caches part of the /proc, but the rules about what is cached and what the 
timeouts are, are set in the kernel module and not easily changed. We are 
going to have an "aggregating" user level 9p server based on 
Mirtchovskis's aggrfs, which will both aggregate all the cluster nodes, 
and have caching rules that make sense in clusters of 1000s of node (for 
example, it is ok to cache /proc/x/status; there is no need to cache 
/proc/x/maps, and you probably don't want to anyway). 

A neat capability is that if we give a user, e.g., 25% of the cluster, we
can tailor that user's name space so that they only see their procs and
the 25% of the cluster they own. This is good for security, but also good
for convenience: most users don't really care that some other user is on
75% of the cluster. Global pid spaces are neat in theory, messy in
practice at large scale. I want my global pid space to be global to *me*,
meaning I see the global space of the nodes I care about.  The sysadmin,
of course, wants to see everything. All this is possible. V9fs, along with
Linux private name spaces, will allow us to provide this model: users can 
see some or all of the global pid space, depending on need; users can be 
constrained to only see part of the global pid space, depending on other 
issues. 

9p will also replace the Supermon protocol, allowing people to easily view 
status information in a file system. 

In addition to the cluster usage, there is also grid usage. The 9grid, 
composed of plan 9 systems, is connected by 9p servers. Linux systems can 
join the 9grid with no problem, once Linux has v9fs. 

Were v9fs just a file system, I would not really be interested in it one 
way or another; we have NFS, after all. But v9fs is really the key piece 
of a new model of cluster services we are building at LANL. 9p will be the 
glue, and v9fs will be the needed client side for hooking 9p servers into 
the file system name space. 

I'm hoping we can see v9fs in the kernel someday.

thanks

ron
