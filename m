Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWBTRl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWBTRl3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWBTRl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:41:29 -0500
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:60629
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S1161075AbWBTRl2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:41:28 -0500
From: =?iso-8859-2?q?T=F6r=F6k_Edwin?= <edwin.torok@level7.ro>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting both incoming and outgoing packets
Date: Mon, 20 Feb 2006 19:40:40 +0200
User-Agent: KMail/1.9.1
Cc: netfilter-devel@lists.netfilter.org, fireflier-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, martinmaurer@gmx.at,
       Patrick McHardy <kaber@trash.net>
References: <200602181410.59757.edwin.torok@level7.ro> <Pine.LNX.4.64.0602201122330.21034@excalibur.intercode>
In-Reply-To: <Pine.LNX.4.64.0602201122330.21034@excalibur.intercode>
Organization: Level 7 Software
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602201940.40504.edwin.torok@level7.ro>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - level7.ro
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 18:26, James Morris wrote:
> On Sat, 18 Feb 2006, Török Edwin wrote:
> > This is a patch based on Luke Kenneth Casson Leighton's patch [1]
> > One problem with that patch was that it couldn't be used for filtering
> > incoming packets, due to the fact that more than one process can listen
> > on the same socket ([2],[3]).
>
> Have a look at my skfilter patches:
> http://people.redhat.com/jmorris/selinux/skfilter/kernel/
I already looked at them yesterday evening,(I found a link in a lwn.net 
article).  Nice work :-)
Having your patches applied to mainline kernel would solve many of my 
problems.
 >
> These implement a scheme for matching incoming packets against sockets by
> adding a new hook in the socket layer.

AFAICT this solves the "incoming packets" problem and will I also be able to 
filter data sent through raw sockets?

If selinux is enabled and available then the skfilter patch solves all of 
fireflier's problems. Nice.

In the following I will be referring to 16-skfilter-ipt_owner-ctx.patch:

However I'd like to do filtering based on owner (process) even when selinux is 
not available. Your context match explicitly requires selinux to be enabled, 
and a policy loaded. Is there a way to do context matching, when booting with 
selinux=0, i.e. is there a way to enable just a minimal subset of selinux, 
that would do this:
 - (auto)label processes based on its inode/mount-point
- (auto)label all sockets that a process has access to with the process's 
label (or better: its domain)
- do context matching based on these labels (if I understood correctly this is 
what your patch does)

Could you please use LSM hooks (like inode_getsecurity) instead of directly 
using selinux? I'd want to provide my own implementation of labeling (a 
very,very simple labeling, a very small subset of what selinux does, but 
which wouldn't require much configuration). In other words, I want to write a 
LSM, and then mod_register_security() my module.

Or if the above is not possible, could you provide some hooks, where I could 
register my hooks to provide these:
- int available()
- int ctx_to_id(char*,u32*)
- int socket_to_ctxid(struct sock*,u32*)

(Of course I could create another match that would use my module to do the 
matching on the SOCKET  chain. But this would uselessly duplicate 
functionality&code, an additional hook would be a much cleaner solution).

What is your opinion on what I said above? I am open to suggestions, 
criticism, advice....

Thanks,
Edwin
>
> For upstream merge, the issues are:
> - should the new socket hook be used for all incoming packets?
> - ensure IP queuing still works
>
> Patrick: any other issues?
>
>
>
> - James
