Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWDGSsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWDGSsj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWDGSsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:48:38 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:1424
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S964872AbWDGSsg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:48:36 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: sds@tycho.nsa.gov
Subject: Re: [RFC] packet/socket owner match (fireflier) using skfilter
Date: Fri, 7 Apr 2006 20:34:20 +0300
User-Agent: KMail/1.9.1
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
References: <200604021240.21290.edwin@gurde.com> <200604031839.38590.edwin@gurde.com> <1144249591.25790.56.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1144249591.25790.56.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604072034.20972.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 April 2006 18:06, Stephen Smalley wrote:
> On Mon, 2006-04-03 at 18:39 +0300, Török Edwin wrote:
> > - the security labels of processes be assigned based on their
> > executable's inode+mountpoint.
>
> Not sure what you mean by inode+mountpoint here. 
I meant security labels generated automatically based on the inode and 
mountpoint of executable, without having to apply extended attributes to 
them.
> > Is there a way to do auto-labeling with SELinux? I mean having a security
> > context applied based on the inode, without me having to run 'make
> > relabel', setfiles, and so on....
>
> Attributes have to be bound to the actual objects, which means that
> something has to set those attributes.
Obviously.
> This is no different than normal 
> Linux DAC attributes like file owner/group/mode (aside from the need to
> use extended attributes for storage).
I don't want to store the attribute.
>
> > (From my very limited understanding of SELinux, this would mean creating
> > a context for each executable, 
>
> If you truly need to distinguish each such program, then yes, they would
> need separate contexts, although you likely can organize them into
> equivalence classes. 
I thought of equivalence classes like: class_ports_all_access, 
class_port_80_access, class_port_25_access, etc. But can a program have 
multiple classess associated? (or multiple contexts?) If not, I should also 
create some sort of group classes (class_port_80_443: 
class_port_80,class_port_443)
> You could generate a policy module in userspace 
> and feed it to semodule to be linked into the base policy and loaded,
> although the details are not entirely clear as to what you would need to
> put into the policy module (e.g. you seem to just want to define the
> domain and type and then make the domain identical to the caller's
> domain since you aren't trying to restrict it any further, just use it
> for labeling purposes).
Thanks, this is very usefull.I didn't know about the modular policy support. 
It is great, as it will allow easier installation :)
Let me see if I got it right:
- I can generate a policy from userspace
- compile it into a module package
- load that using semodule
- generating the policy will be indepedent of the base policy
- the user can change the base policy, and the my policy module will still 
work (without recompiling it)


I am not sure what should be in the policy either, I thought of this:
- when a new rule is added to fireflier the policy module is updated
- domain&type is generated, that is unique to each program
- "labels" the program with the generated domain&type (is this possible 
without storing the context on disk?)
- "labels" each socket created by the program with the program's label
- when a domain transition occurs, all sockets that are open, are relabeled, 
to show that 2 domains have access to it (relabeled with an auto-generated 
context, that is some sort of a group, i.e. I can later retrieve what the 
members of that group was)
- the policy doesn't have to restrict anything, only label

Since I have already written a LSM that accomplishes what I want, can 
somebody "guide" me how to "convert" the LSM to an SELinux policy? I'd 
appreciate if you can give me ideas how to implement the parts that would 
be "translated" to a "non-standard"(unusual, features not used in the 
reference policy,...) policy file (are there such parts?).

To get started I have the following  (fundamental) question: can a program 
have multiple contexts? If not, how I can let the user use whatever context 
he wants for the program, and still apply my label to it?

If I get an answer to that question above, I'll start learning, and 
experimenting, and come back later with more questions.

If such a policy module is written, can that be used as base policy, if the 
user doesn't (yet) have a base policy? For example he boots with selinux=1, 
but he didn't set up his policy....
>
> > It doesn't have to have a security label applied by its inode, but that
> > is unique, I don't know how secure would it be to identify processes by
> > path...
>
> It isn't.  Path-based access control considered harmful.
Agreed. The fireflier LSM I've written does filtering based on inode.
Fireflier currently does (userspace) filtering based on the path, but I'll 
change that, and put the inode in the rule file too. And in case the path no 
longer matches the inode, the user is asked if he wants to update the 
rules.... but this is the userspace part of it.
> You aren't likely to get much review of your actual LSM without breaking
> it up into manageable chunks and posting with patches inline for review
> to linux-security-module@vger.kernel.org.
I will do that, I'll post them as replies to this mail. Thanks for pointing me 
to the proper list.

The fireflier LSM will be used only if the user has selinux disabled. This is 
my plan:

- if selinux is enabled: use the userspace policy module generator (not yet 
written)
- if selinux is disabled: use fireflier LSM (already written)

Please note that I am not trying to reinvent SELinux, I just want to provide a 
way of doing this application filtering, when the user has selinux disabled.

The actual packet filtering will be done:
 - userspace (using nf_queue, and getxattr)
 - using skfilter patches (as soon as they are merged in mainline)


In the end I want to thank all of you for helping me develop fireflier.

Cheers,
Edwin
