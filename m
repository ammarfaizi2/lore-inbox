Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWDQSVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWDQSVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 14:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWDQSVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 14:21:54 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:44471
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S1751203AbWDQSVx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 14:21:53 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Date: Mon, 17 Apr 2006 21:20:51 +0300
User-Agent: KMail/1.9.1
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net,
       marius@cs.utt.ro
References: <200604021240.21290.edwin@gurde.com> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604172120.52193.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 April 2006 19:06, Stephen Smalley wrote:
> On Fri, 2006-04-14 at 23:01 +0300, Török Edwin wrote:
> > Would there be a reason to implement floating labels in SELinux?
>
> Unclear.  CMWs and the Posix.1e draft had floating information labels,
> but they were separate from the access control label.  So if implemented
> in SELinux, they would be a separate field of the incore security
> structures and, if required to persist, they would be a separate xattr
> name/value pair.  They wouldn't be used for access control checking by
> SELinux internally.  One would have to define the meaning of floating
> for TE (or your scheme), as they aren't hierarchical. 
> Traditional 
> hierarchical floating labels track reads and writes, e.g. process
> information label floats up upon reads to dominate the information label
> of the object, and the object information label floats up upon writes to
> dominate the information label of the writing process, so that if P 
> copies from object A to object B, object B ends up with an information
> label at least as high as object A.  Whether or not this is useful has
> been a subject of debate.
I'll have to read more on this, I'll come back later with an answer to this.
>
> > How can I substitute floating labels (i.e. what would be its closest
> > approximation)?
>
> Ideally, you would just predefine your control requirements, as below,
> and enforce that via SELinux policy rather than trying to separately
> track the data flow via LSM and enforce some kind of restriction via
> your userspace component+netfilter module.  

On a second thought a fireflier LSM wasn't such a good idea after all. 
One reason for the kernelspace+userspace mix was that to allow interactivity, 
i.e. ask the user about a packet that would get denied per current policy, 
and if the user so wishes, he can create a new rule on the fly. Doing this 
with selinux isn't possible. But using the security marking, that in my POV 
combines selinux, and iptables, will allow me to ask these kinds of questions 
(by using a nfqueue target). See below for more details.

> Also see the Security 
> marking RFC posted by James Morris to netdev.
 Thanks a lot for telling me about it, this is exactly what I need (I wasn't 
subscribed to netdev, now I am :D)


>
> > Functional requirement:
> <snip>
>
> Hmmm...well, the control requirements above can be met by SELinux, just
> not in the manner you are trying to meet them, as SELinux already labels
> and controls use of sockets and access to ports, nodes (hosts), and
> network interfaces.
Hmmm
>
> > -- plan for fireflier SELinux integration (fireflier target version
> > 2.1)---
> >
> > Possible approaches I thought of:
> > 1)  put programs needing to share a socket in the same domain, and match
> > based on the domain of the socket. But what happens if a program would
> > need to be in 2  or more domains (xinetd comes to mind)
>
> The processes don't have to be in the same domain to share the socket;
> SELinux policy already allows you to permit one domain to
> inherit/receive and use sockets created by another domain if so
> configured.
I'll try to keep this in mind when writing a policy.
>
> > But a problem remains: if there is a base policy that sets a context on a
> > program, and  my module would try to set a domain for it too, won't they
> > conflict?
>
> You could extend the definition of the existing domain via your module
> if that fits your needs.  
I didn't know this is possible , how do I extend its definition?
> As the base policy becomes more modularized, 
> you could replace the particular module entirely with your own if that
> is necessary.
Ok.
>
> > 2) each program has its own domain, and xinetd is in a domain of its own,
> > but it has access to all the sockets of its childs (domains). The same
> > for postfix
> > Also run selinux in non-enforcing mode, with avc logging turned off. I
> > only need labeling, not restrictions.
>
> But you do need restrictions (on network access); you just want to
> implement them yourself for some reason rather than using the existing
> SELinux controls.  Not clear why.
Reason: selinux applies the policy immediately, you can't "queue" them for 
userspace. In iptables you can queue packets for userspace decisions.
Of course, on a server, or a secured desktop such on-the-fly changes are not 
good, but when setting up a the rules (policy) they _are_ usefull.

------------------ New fireflier plans -----------------
Using the security mark interactivity can still be achieved:
- add iptables secmark rules
- add at the end a queue target

Now, when a packet comes, and matches a secmark rule, it gets marked (and 
accepted as far as netfilter is concerned?), and SELinux will take care of 
allow/deny based on policy. This policy can be generated by fireflier.

If no secmark rule (and no "ordinary" iptables rule) matches, the packet will 
arrive at the queue target, and fireflier userspace will ask the user what he 
wants to do. If he wants to create a rule, a new iptables  secmark rule is 
inserted, and an selinux policy generated if needed. 

So "on-the-fly" policy generation is still possible.

Possible issues:
- program gains access to socket, after rule was created, and selinux rules 
deny access => program gets access denied, without user being asked
- program A uses port X, later B uses port X and gets access denied

Fireflier could also watch avc access denied logs, and ask the user if he 
wants to adjust the rules. 

In this case the user doesn't get the opportunity to create a rule "just 
before" the packet would get denied, but this is not such a big problem. The 
packet might be old/timed out already; and besides the program should try 
again if packets don't go through.
Maybe if a packet gets denied due to SELinux policy, it could be reinserted in 
the netfilter chain? Would writing such a policy make sense? 

Something like this (I know this isn't correct selinux syntax):
allow httpd_t http_packet_t:packet { recv }
reinject !httpd_t http_packet_t:packet { recv }
or:
allow httpd_t http_packet_t:packet { recv }
reinject notmachted http_packet_t:packet { recv }
; where notmactced would get applied, if no other domain matched; and reinject 
means to reinject in netfilter chain

--------------------------------------------------------------------------------

>
><snip>
> > - if selinux is enabled, fireflier won't do shared socket checks,
> > assuming that the policy will limit the sharing of sockets
>
> Depends on whether you want your tool to continue to be useful for
> systems using SELinux.
Yes. But I don't want to _require_ the user to have selinux set up.
I am willing to accept for fireflier a  _require selinux support in kernel_, 
and the requirement for a minimal policy for networking only (generated by 
fireflier).
>
> > Important question: can a file's context be set from the policy?
> > (without using setfiles, to relabel the file, the user might want to
> > enable selinux later, I don't want to mess up his labeling)
> > (this might sound silly: can a define a default auto-transition to a
> > context?)
>
> Certain defaults are provided from policy, but the per-file labeling
> comes from the xattrs.  Newly created files are assigned an initial
> label by the kernel (both incore and xattr) based on policy by default,
Good, so I can control the default label.
> or optionally overridden by application request (still subject to policy
> control).
>
> > To have all tasks assigned a security structure, fireflier lsm needs to
> > be compiled into the kernel.
>
> Yes.  So?
That needs patching the kernel, something I wanted to avoid. If I wanted to 
patch the kernel, I would have used the skfilter patches, and there would 
have been no need for fireflier lsm.
>
> > I thought of this, see label_all_processes. Unfortunately I found no way
> > of actually doing this. I would need to iterate through the tasklist
> > structure, but the task_lock export is going to be removed from the
> > kernel.
>
> So, if built-in isn't an option, propose an interface to the core
> security framework to allow security modules to perform such
> initialization without needing to directly touch the lock themselves
> (i.e. they just call the function provided by the security framework,
> and let it deal with taking the lock if that is appropriate).  Not the
> same as exporting the lock directly to all modules for arbitrary misuse.
I'd rather not propose that.
>
> > Locking added. I use a lock every time the inode's sid is modified.
>
> Except that your lock does no good.  See below.
Should have done that spin_lock  earlier, before compute_sid, but I got a
"sleeping function called in atomic context" warning, because I used debugfs 
inside compute_inode_sid. Ok that debugfs would have been removed anyway, so 
I should move the lock earlier.

Doesn't matter anymore, as I found an alternative to fireflier LSM. So 
fireflier LSM is likely to be dropped soon.


Thanks a lot for the comments, ideas you provided, I won't bother you with 
fireflier LSM anymore.

If I have further questions/comments about security mark, selinux+secmark, or 
I need some features in secmark, or I have a patch for secmark,selinux - is 
it ok if I use the Cc: of this mail? (besides linux-security-module)

Thank you again for the feedback provided,

Cheers,
Edwin
