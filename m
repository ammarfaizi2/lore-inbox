Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWBFUmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWBFUmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWBFUmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:42:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47283 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964810AbWBFUmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:42:49 -0500
Date: Mon, 6 Feb 2006 21:41:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Paul Jackson <pj@sgi.com>, ak@suse.de, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206204111.GA20495@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602061811.49113.ak@suse.de> <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com> <200602061936.27322.ak@suse.de> <20060206184330.GA22275@elte.hu> <20060206120109.0738d6a2.pj@sgi.com> <20060206200506.GA13466@elte.hu> <Pine.LNX.4.62.0602061221200.18348@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0602061221200.18348@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Lameter <clameter@engr.sgi.com> wrote:

> On Mon, 6 Feb 2006, Ingo Molnar wrote:
> 
> > yes. And it seems that for the workloads you cited, the most natural 
> > direction to drive the 'spreading' of resources is from the VFS side.  
> > That would also avoid the problem Andrew observed: the ugliness of a 
> > sysadmin configuring the placement strategy of kernel-internal slab 
> > caches. It also feels a much more robust choice from the conceptual POV.
> 
> A sysadmin currently simply configures the memory policy or cpuset 
> policy.  He has no knowledge of the underlying slab.
> 
> Moving this to the VFS will give rise to all sorts of weird effects. 
> F.e.  doing a grep on a file will spread the pages all over the 
> system.  Performance will drop for simple single thread processes.

it's a feature, not a weird effect! Under the VFS-driven scheme, if two 
projects (one 'local' and one 'global') can access the same (presumably 
big) file, then the sysadmin has to make up his mind and determine which 
policy to use for that file. The file will either be local, or global - 
consistently.

[ I dont think most policies would be set on the file level though - 
  directory level seems sufficient. E.g. /usr and /tmp would probably 
  default to 'local', while /home/bigproject1/ would default to 
  'global', while /home/bigproject2/ would default to 'local' [depending 
  on the project's need]. Single-file would be used if there is an 
  exception: e.g. if /home/bigproject3/ defaults to 'local', it could 
  still mark /home/bigproject3/big-shared-db/ as 'global'. ]

with the per-cpuset policy approach on the other hand it would be 
non-deterministic which policy the file gets allocated under: whichever 
cpuset first manages to touch that file. That is what i'd call a weird 
and undesirable effect. This weirdness comes from the conceptual hickup 
of attaching the object-allocation policy to the workload, not to the 
file objects of the workload - hence conflicts can arise if two 
workloads share file objects.

> What happens if a filesystem is exported? Is the spreading also 
> exported?

what do you mean? The policy matters at the import point, so i doubt 
knfsd would have to be taught to pass policies around. But it could do 
it, if the need arises. Alternatively, the sysadmin on the importing 
side can/should set the policy based on the needs of the application 
using the imported file objects. It is that box that is doing the 
allocations after all, not the server. In fact the same filesystem could 
easily be 'global' on the serving system, and 'local' on the importing 
system.

	Ingo
