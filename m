Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVBFQkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVBFQkz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 11:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVBFQkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 11:40:55 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:45279 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261208AbVBFQk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 11:40:27 -0500
Date: Sun, 6 Feb 2005 17:40:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Larry McVoy <lm@bitmover.com>
cc: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
In-Reply-To: <20050204160631.GB26748@bitmover.com>
Message-ID: <Pine.LNX.4.61.0502060025020.6118@scrub.home>
References: <20050202155403.GE3117@crusoe.alcove-fr>
 <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com>
 <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com>
 <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com>
 <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-336443363-1107662603=:6118"
Content-ID: <Pine.LNX.4.61.0502060503320.6118@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-336443363-1107662603=:6118
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.61.0502060503321.6118@scrub.home>

Hi,

On Fri, 4 Feb 2005, Larry McVoy wrote:

> > > > > 		CVS		BitKeeper [*]
> > > > > 	Deltas	235,956		280,212
> 
> You need to rethink your math, you are way off.  I'll explain it so that
> the rest of the people can see this is just pure FUD.  
> 
> To make sure this was apples to apples I went to the BK and CVS trees
> which are in lock step and reran the numbers:
> 
> 			CVS		BitKeeper	% in CVS
> 	file deltas	210,609		218,742		96%
> 	changsets	26,603		59,220		44%
> 
> You are not factoring out the ChangeSet deltas, which are BK metadata, 
> they aren't part of the source tree.  If you remove those then the
> difference between CVS and BK revision history is 209K deltas vs
> 221K deltas.  
> 
> In other words, the CVS tree is missing no more than 4% of the deltas
> to the source files.
> 
> READ THAT AGAIN, PLEASE.
> 
> The CVS tree has 96% of all the deltas to all your source files.  96%.  

Before you start shouting, how about you get your numbers right? Your 
first numbers were wrong and the second numbers are still wrong:

$ find -name \*,v -a ! -path ./BitKeeper\* -a ! -name ChangeSet,v | xargs rlog | egrep -e '^[0-9]{4}(/[0-9]{2}){2} [0-9]{2}(:[0-9]{2}){2}' -e '\(Logical change 1.[0-9]+\)' | wc -l
219242
$ find -name \*,v -a ! -path ./BitKeeper\* -a ! -name ChangeSet,v | xargs rlog | egrep '\(Logical change 1.[0-9]+\)' | wc -l
187576

That would bring us back to 85% and I leave it to you to find the bug.

> My good friend Stelian would have you believe that you are missing 50%
> of your data when in fact you are missing NONE of your data, you have 
> ALL of your data in an almost the identical form.

The 44% number deserves an explanation, which our good friend Larry would 
have you believe is completely unimportant and thinking otherwise is just 
"FUD". Actually on the contrary it is the more important number.
The 85% number means that the history of a _single_ file can be restored 
with a precision of 85% via bkcvs. If one is only interested in the 
history of a single file, that 85% might be sufficient. OTOH a change to 
the kernel is rarely just a change to a single file. A patch can consist 
of changes to multiple files and this relationship between multiple single 
file changes can only be restored with a precision of 44% via bkcvs.
IOW if one wants to not just look at some random file history, but 
actually restore and use some of it, one can only get 44% of the 59220 
snapshots of kernel history.

> What Stelian is complaining about is the patch set which is easily 
> extractable from CVS is at a coarser granularity than the patch set
> extractable from BK.  That's true but so what?  Before BK you only
> a handful of patches between releases, now you have thousands.

Hmm, that argument is not exactly original anymore. If Linus would say, 
that kernel history has to be exclusively recorded via bk and that the 
history available via bkcvs is the maximum that must be made available to 
other users, you would have a point.
So it's quite legitimate to at least ask occasionally how the 44% 
granularity can be improved. CVS is obviously not really capable of it, 
but RCS on which CVS is based on is. I attached an example script which 
can convert the history of a bk file into RCS. The only thing that is 
missing is to 1) generate a list revisions with their parents, 2) checkout 
a given revision, 3) generate the log for a given revision. (*) I'm quite 
sure that's trivial to do for you and this only took me a few hours 
including testing and cleanup, it only takes a little more work to make 
CVS happy and allow incremental updates, so your "3 month" number is 
absolutely ridiculous.
Any bk user can now easily prove or disprove this by completing my example 
script, I think the "bk prs" man page should be very helpful here. If you 
want to complete it into your very own bk2cvs script, I'd be happy to 
help.

bye, Roman

(*) In case anyone thinks this is simple without bk, try to find the 
parents for this changeset 
http://linux.bkbits.net:8080/linux-2.6/cset@1.403.122.1
---1463811837-336443363-1107662603=:6118
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="conv.rb"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0502061740220.6118@scrub.home>
Content-Description: 
Content-Disposition: attachment; filename="conv.rb"

IyEvdXNyL2Jpbi9ydWJ5DQoNCmNsYXNzIFJjc0ZpbGUNCiAgICBhdHRyX3Jl
YWRlciA6cGF0aA0KDQogICAgZGVmIGluaXRpYWxpemUocGF0aCkNCglAcGF0
aCA9IHBhdGgNCiAgICBlbmQNCiAgICBkZWYgY2hlY2tvdXQocmV2KQ0KCXN5
c3RlbSgiY28gLXEgLWtvIC1yI3tyZXZ9ICN7QHBhdGh9IikNCiAgICBlbmQN
CiAgICBkZWYgY2hlY2tpbihyZXYsIGxvZykNCglpZiByZXYgPT0gIjEuMSIN
CgkgICAgb3BlbigifHJjcyAtcSAtVSAtaSAta2IgI3tAcGF0aH0iLCAidyIp
IHsgfHB8IH0NCgkgICAgc3lzdGVtKCJjaSAtcSAtZjEuMSAje3BhdGh9IikN
CgkgICAgb3BlbigifC0iKSBkbyB8cHwNCgkJZXhlYygicmNzIiwgIi1xIiwg
Ii1tMS4xOiN7bG9nfSIsIEBwYXRoKSBpZiAhcA0KCQlwcmludCBwLnJlYWQN
CgkgICAgZW5kDQoJZWxzZQ0KCSAgICBvcGVuKCJ8Y2kgLXEgLWYje3Jldn0g
I3tAcGF0aH0iLCAidyIpIGRvIHxwfA0KCQlwLndyaXRlIGxvZw0KCSAgICBl
bmQNCgllbmQNCiAgICBlbmQNCmVuZA0KDQpjbGFzcyBSY3NTcmMgPCBSY3NG
aWxlDQogICAgZGVmIGluaXRpYWxpemUocGF0aCkNCglzdXBlcihwYXRoKQ0K
ICAgIGVuZA0KDQogICAgZGVmIHJldl9saXN0DQoJb3BlbigiI3tAcGF0aH0s
bSIpIGRvIHxmfA0KCSAgICBAcmV2X2xpc3QgPSBmLnJlYWRsaW5lcw0KCSAg
ICBAcmV2X2xpc3QuY29sbGVjdCEgZG8gfGx8DQoJCWwuc3BsaXQNCgkgICAg
ZW5kDQoJZW5kDQogICAgZW5kDQoNCiAgICBkZWYgY2hlY2tpbihyZXYsICpw
YXIpDQoJb3BlbihAcGF0aCwgInciKSBkbyB8ZnwNCgkgICAgZi53cml0ZSAi
ZGF0YSAje3Jldn1cbiINCgllbmQNCglzdXBlcihyZXYsIGxvZyhyZXYpKQ0K
CW9wZW4oIiN7QHBhdGh9LG0iLCAiYSIpIGRvIHxmfA0KCSAgICBmLndyaXRl
ICIje3Jldn0gI3twYXIuam9pbigiICIpfVxuIg0KCWVuZA0KICAgIGVuZA0K
DQogICAgZGVmIGxvZyhyZXYpDQoJImNoZWNraW4gI3tyZXZ9Ig0KICAgIGVu
ZA0KZW5kDQoNCmNsYXNzIFJjc0NvbnYgPCBSY3NGaWxlDQogICAgYXR0cl9y
ZWFkZXIgOnNyYywgOnJldl9tYXAsIDptZXJnZV9tYXANCg0KICAgIGRlZiBp
bml0aWFsaXplKHBhdGgsIHNyYykNCglzdXBlcihwYXRoKQ0KCUBzcmMgPSBz
cmMNCglAcmV2X21hcCA9IHt9DQoJQG1lcmdlX21hcCA9IHt9DQoJaWYgdGVz
dCg/ZiwgIiN7cGF0aH0sbSIpDQoJICAgIG9wZW4oIiN7cGF0aH0sbSIpIGRv
IHxmfA0KCQlmLmVhY2ggZG8gfGx8DQoJCSAgICBhID0gbC5zcGxpdA0KCQkg
ICAgQHJldl9tYXBbYVswXV0gPSBhWzFdDQoJCSAgICBAbWVyZ2VfbWFwW2Fb
MV1dID0gYVsyXSBpZiBhWzJdDQoJCWVuZA0KCSAgICBlbmQNCgllbmQNCiAg
ICBlbmQNCiAgICBkZWYgZmluaXNoDQoJb3BlbigiI3twYXRofSxtIiwgInci
KSBkbyB8ZnwNCgkgICAgQHJldl9tYXAuZWFjaCBkbyB8ayx2fA0KCQlmLnBy
aW50KCIje2t9ICN7dn0gI3tAbWVyZ2VfbWFwW3ZdfVxuIikNCgkgICAgZW5k
DQoJZW5kDQogICAgZW5kDQogICAgZGVmIGNoZWNrb3V0KHJldikNCglzcmMu
Y2hlY2tvdXQocmV2KQ0KCUZpbGUucmVuYW1lKEBzcmMucGF0aCwgQHBhdGgp
DQogICAgZW5kDQogICAgZGVmIGNoZWNraW4ocGFyLCBrZXkpDQoJaWYgIXBh
cg0KCSAgICByZXYgPSAiMS4xIg0KCWVsc2UNCgkgICAgcmV2ID0gcGFyLnN1
YigvXGQqJC8pIHsgfHZ8IHYuc3VjYyB9DQoJICAgIGlmIEByZXZfbWFwLmhh
c192YWx1ZT8ocmV2KQ0KCQlpID0gIjAiDQoJCWJlZ2luDQoJCSAgICByZXYg
PSAiI3twYXJ9LiN7aS5zdWNjIX0uMSINCgkJZW5kIHVudGlsICFAcmV2X21h
cC5oYXNfdmFsdWU/KHJldikNCgkgICAgZW5kDQoJZW5kDQoJc3VwZXIocmV2
LCBzcmMubG9nKGtleSkpDQoJcHJpbnQgIiN7a2V5fSAtPiAje3Jldn1cbiIN
CglAcmV2X21hcFtrZXldID0gcmV2DQogICAgZW5kDQoNCiAgICBkZWYgaW1w
b3J0KGtleSwgKnBhcikNCglyZXR1cm4gdHJ1ZSBpZiBAcmV2X21hcC5oYXNf
a2V5PyhrZXkpDQoJaWYgIXBhclswXQ0KCSAgICBjaGVja291dChrZXkpDQoJ
ICAgIGNoZWNraW4obmlsLCBrZXkpDQoJICAgIHJldHVybiB0cnVlDQoJZW5k
DQoJcmV0dXJuIGZhbHNlIGlmICFAcmV2X21hcC5oYXNfa2V5PyhwYXJbMF0p
DQoJaWYgIXBhclsxXQ0KCSAgICBjaGVja291dChrZXkpDQoJICAgIGNoZWNr
aW4oQHJldl9tYXBbcGFyWzBdXSwga2V5KQ0KCSAgICByZXR1cm4gdHJ1ZQ0K
CWVuZA0KCXJldHVybiBmYWxzZSBpZiAhQHJldl9tYXAuaGFzX2tleT8ocGFy
WzFdKQ0KCWNoZWNrb3V0KGtleSkNCglwYXIxID0gQHJldl9tYXBbcGFyWzBd
XQ0KCXBhcjIgPSBAcmV2X21hcFtwYXJbMV1dDQoJcGFyMSwgcGFyMiA9IHBh
cjIsIHBhcjEgaWYgcGFyMS5jb3VudCgiLiIpID4gcGFyMi5jb3VudCgiLiIp
DQoJQG1lcmdlX21hcFtjaGVja2luKHBhcjEsIGtleSldID0gcGFyMg0KCXJl
dHVybiB0cnVlDQogICAgZW5kDQplbmQNCg0Kc3lzdGVtKCJybSAtZiB0ZXN0
LD8gdGVzdDIsPyIpDQpzcmMgPSBSY3NTcmMubmV3KCJ0ZXN0IikNCnNyYy5j
aGVja2luICIxLjEiDQpzcmMuY2hlY2tpbiAiMS4yIiwJCSIxLjEiDQpzcmMu
Y2hlY2tpbiAiMS4zIiwJCSIxLjIiDQpzcmMuY2hlY2tpbiAiMS4zLjEuMSIs
CQkiMS4zIg0Kc3JjLmNoZWNraW4gIjEuMy4xLjIiLAkJIjEuMy4xLjEiDQpz
cmMuY2hlY2tpbiAiMS4zLjIuMSIsCQkiMS4zIg0Kc3JjLmNoZWNraW4gIjEu
My4yLjIiLAkJIjEuMy4yLjEiDQpzcmMuY2hlY2tpbiAiMS40IiwJCSIxLjMi
DQpzcmMuY2hlY2tpbiAiMS41IiwJCSIxLjQiLAkJIjEuMy4xLjIiDQpzcmMu
Y2hlY2tpbiAiMS41LjEuMSIsCQkiMS41Ig0Kc3JjLmNoZWNraW4gIjEuNS4x
LjIiLAkJIjEuNS4xLjEiDQpzcmMuY2hlY2tpbiAiMS41LjIuMSIsCQkiMS41
Ig0Kc3JjLmNoZWNraW4gIjEuNS4yLjIiLAkJIjEuNS4yLjEiDQpzcmMuY2hl
Y2tpbiAiMS42IiwJCSIxLjUiLAkJIjEuMy4yLjIiDQpzcmMuY2hlY2tpbiAi
MS43IiwJCSIxLjYiDQpzcmMuY2hlY2tpbiAiMS44IiwJCSIxLjciLAkJIjEu
NS4xLjIiDQpzcmMuY2hlY2tpbiAiMS44LjEuMSIsCQkiMS44IiwJCSIxLjUu
Mi4yIg0Kc3JjLmNoZWNraW4gIjEuOC4xLjIiLAkJIjEuOC4xLjEiDQpzcmMu
Y2hlY2tpbiAiMS45IiwJCSIxLjgiDQpzcmMuY2hlY2tpbiAiMS4xMCIsCQki
MS45IiwJCSIxLjguMS4yIg0KDQpyY3MgPSBSY3NDb252Lm5ldygidGVzdDIi
LCBzcmMpDQphID0gc3JjLnJldl9saXN0LmR1cA0KIyBqdXN0IGZvciBmdW4g
d2UgZG8gaXQgaW4gcmFuZG9tIG9yZGVyDQp3aGlsZSAhYS5lbXB0eT8NCiAg
ICBpID0gcmFuZChhLnNpemUpDQogICAgYS5kZWxldGVfYXQoaSkgaWYgcmNz
LmltcG9ydCgqYVtpXSkNCmVuZA0KcmNzLmZpbmlzaA0KDQpzcmMgPSBSY3NT
cmMubmV3KCJ0ZXN0IikNCnNyYy5jaGVja2luICIxLjguMi4xIiwJCSIxLjgi
DQpzcmMuY2hlY2tpbiAiMS44LjIuMiIsCQkiMS44LjIuMSINCnNyYy5jaGVj
a2luICIxLjExIiwJCSIxLjEwIg0Kc3JjLmNoZWNraW4gIjEuMTIiLAkJIjEu
MTEiLAkJIjEuOC4yLjIiDQpzcmMuY2hlY2tpbiAiMS4xMyIsCQkiMS4xMiIN
CnNyYy5jaGVja2luICIxLjguMi4xLjEuMSIsCSIxLjguMi4xIg0Kc3JjLmNo
ZWNraW4gIjEuOC4yLjEuMS4yIiwJIjEuOC4yLjEuMS4xIg0Kc3JjLmNoZWNr
aW4gIjEuMTEuMS4xIiwJCSIxLjExIiwJCSIxLjguMi4xLjEuMiINCnNyYy5j
aGVja2luICIxLjE0IiwJCSIxLjEzIiwJCSIxLjExLjEuMSINCg0KcmNzID0g
UmNzQ29udi5uZXcoInRlc3QyIiwgc3JjKQ0KYSA9IHNyYy5yZXZfbGlzdC5k
dXANCndoaWxlICFhLmVtcHR5Pw0KICAgIGkgPSByYW5kKGEuc2l6ZSkNCiAg
ICBhLmRlbGV0ZV9hdChpKSBpZiByY3MuaW1wb3J0KCphW2ldKQ0KZW5kDQpy
Y3MuZmluaXNoDQo=

---1463811837-336443363-1107662603=:6118--
